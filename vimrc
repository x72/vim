version 6.0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"不兼容vi
set nocompatible
" 自动缩进
"set autoindent
" C语言方式缩进
"set cindent
" 设定行长
"set textwidth=79
" 格式选项
"set formatoptions=tcrq
" 单词换行
"set linebreak
" 使用space代替tab
set expandtab
" 一个tab是 4 个空格
set tabstop=4
" 设定<< 和>> 命令移动时的宽度为4
set shiftwidth=4
" 按退格键时可以一次删掉 4 个空格
set softtabstop=4
" 回退键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l

if &term=="xterm"
  set mouse=a
  if has("terminfo")
    set t_Co=8
    set t_Sf=[3%p1%dm
    set t_Sb=[4%p1%dm
  else
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
  endif
endif

" 选择主题
colorscheme darkblue
" 开启语法着色
syntax enable
" 开启插件
filetype plugin indent on

function! SetAltPrefs()
  setl tabstop=2
  setl softtabstop=2
  setl shiftwidth=2
endfunction

autocmd FileType xml,html,xhtml,smarty,vim,javascript call SetAltPrefs()


" 代码折叠
set foldmethod=indent
" 文件打开后所有折叠都自动展开
set foldlevelstart=99
" 设置代码折叠符号
set foldcolumn=4

" 搜索时忽略大小写，但在有一个或以上大写字母时仍大小写敏感
set ignorecase smartcase
" 禁止在搜索到文件两端时重新搜索
set nowrapscan
" 输入搜索内容时就显示搜索结果
set incsearch
" 搜索时高亮显示被找到的文本
set hlsearch
" 一直显示Tab栏
set showtabline=2
" 显示括号配对情况
set magic
" 显示行号
set number
" 设定命令行的行数为 2
set cmdheight=2
" 显示状态栏 (默认值为 1, 无法显示状态栏)
set laststatus=2
" 允许在有未保存的修改时切换缓冲区, 此时的修改由 vim 负责保存
set hidden
" 历史记录数
set history=1000
" 通过使用: commands命令, 告诉我们文件的哪一行被改变过
set report=0
" 显示符号
set list
" 替换Tab和行尾空格显示
set listchars=tab:>-,trail:-
" 显示状态栏 (默认值为 1, 无法显示状态栏)
set laststatus=2
" 设置在状态行显示的信息
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %c:%l/%L%)\

if has("gui_running")
  " 隐藏菜单栏
  set guioptions-=m
  " 隐藏工具栏
  set guioptions-=T
  " 隐藏左侧滚动条
  set guioptions-=L
  " 隐藏右侧滚动条
  set guioptions-=r
  " 隐藏底部滚动条
  set guioptions-=b
  " 隐藏Tab栏
  set showtabline=0

  " 设置中英文字体
  set guifont=Menlo:h10.5
  set guifontwide=YouYuan:h10.5

  if has("win32")
    " 窗口最大化
    " "au GUIEnter * simalt ~x
    winpos 0 0
    set lines=99 columns=108
  endif
endif


" 禁止备份
set nobackup
" 禁止生成临时文件
set noswapfile
" 关闭错误信息响铃
set noerrorbells
" 关闭使用可视响铃代替呼叫
set novisualbell
" 置空错误铃声的终端代码
set t_vb=
" 启动的时候不显示提示信息
set shortmess=atI

runtime macros/matchit.vim


if has("win32")
  "保存即生效
  autocmd! bufwritepost _vimrc source $VIM/_vimrc
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 配置多语言环境
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("multi_byte")
  set encoding=utf-8
  set termencoding=utf-8
  set formatoptions+=mM
  set fencs=utf-8,gbk

  if v:lang =~? '^(zh)|(ja)|(ko)'
    set ambiwidth=double
  endif
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 插件配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist setting
" 如果taglist窗口是最后一个窗口, 则退出vim
let Tlist_Exit_OnlyWindow=1
" 在右侧窗口中显示taglist窗口
let Tlist_Use_Right_Window = 1
" 只显示当前文件中的tag
let Tlist_Show_One_File = 1
" php设置只显示function
let tlist_php_settings='php;c:class;f:function'
"通过where ctags找到路径
if has("unix")
  let Tlist_Ctags_Cmd="/usr/bin/ctags"
endif
" tags文件定位
set tags+=tags;
" 自动路径, 文件所在目录
set autochdir
" 快捷键tl, 打开/关闭taglist窗口
map tl :Tlist <CR>


" fuzzyfinder
map fb :FufBuffer<CR>
map ff :FufFile<CR>
map fd :FufDir<CR>
map ft :FufTag<CR>

" emmet
let g:user_emmet_settings = {'indentation' : '  '}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 自动补全
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap <CR> <c-r>=Check()<CR>

function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endfunction

function! Check()
  if getline('.')[col('.') - 2] == '{'
    return "\<CR>}\<ESC>\k$\a\<CR>"
  else
    return "\<CR>"
  endif
endfunction

