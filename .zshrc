# location of history
export HISTFILE=~/.zsh_history
# number of lines kept in history
export HISTSIZE=10000
# number of lines saved in the history after logout
export SAVEHIST=10000

# emacs style key binding
bindkey -e
# backward delete
bindkey "\e[3~" delete-char

# chars as part of filename
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# Auto-complete feature
setopt AUTO_LIST
setopt AUTO_MENU
setopt MENU_COMPLETE

# "Power Options"
setopt autocd
setopt appendhistory
setopt extended_glob

unsetopt beep 
unsetopt notify


autoload -zU compinit
compinit

# Completion caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path .zcache
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' special-dirs true

#Completion Options
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate
zstyle ':completion:*' matcher-list '' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*' 'm:{[:lower:]}={[:upper:]}'

# Path Expansion
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*:*:*:default' menu yes select
zstyle ':completion:*:*:default' force-list always

# The GNU Colors need the / etc / DIR_COLORS file or automatically fill full-time in the selected menu option can not be color display
[ -f /etc/DIR_COLORS ] && eval $(dircolors -b /etc/DIR_COLORS)
export ZLSCOLORS="${LS_COLORS}"
zmodload  zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:processes' command 'ps -au$USER'

# Group matches and Describe
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'

# command alias
alias ls='ls -F --color=auto'
alias ll='ls -lh'
alias grep='grep --color=auto'
alias ec='emacsclient -n -a emacs'
alias history='cat ~/.zsh_history | grep -i '
alias webshare='python -m SimpleHTTPServer'

#show git branch info

#setopt prompt_subst
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' actionformats \
#    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
#zstyle ':vcs_info:*' formats       \
#    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
#zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

#zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
#vcs_info_wrapper() {
#  vcs_info
#  if [ -n "$vcs_info_msg_0_" ]; then
#    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
#  fi
#}

autoload -U colors && colors

# Allow for functions in the prompt.
setopt PROMPT_SUBST
 
# Autoload zsh functions.
#fpath=(~/.zsh/functions $fpath)
#autoload -U ~/.zsh/functions/*(:t)
 
# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions
 
# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'
 
# Set the prompt.
source ~/.zsh/git-prompt/zshrc.sh

# an example prompt
RPROMPT='$(git_super_status)'

PROMPT="%{%(#~$fg[red]~$fg[cyan])%}%n%{$fg[default]%}%{$reset_color%}%{$fg[cyan]%}@%{$reset_color%}%{$fg[cyan]%}%m:%{$reset_color%}%{$fg[brightgreen]%}%~%{$reset_color%}%(#~#~$)%{$reset_color%} "


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

alias vless=/usr/share/vim/vim73/macros/less.sh
