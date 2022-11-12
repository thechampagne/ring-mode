;;; ring-mode.el --- A major mode for the Ring programming language -*- lexical-binding: t -*-

;; Version: 0.0.1
;; Author: XXIV
;; Keywords: files, ring
;; Package-Requires: ((emacs "24.3"))
;; Homepage: https://github.com/thechampagne/ring-mode

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; A major mode for the Ring programming language.

;;;; Installation

;; You can use built-in package manager (package.el) or do everything by your hands.

;;;;; Using package manager

;; Add the following to your Emacs config file

;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)
;; (package-initialize)

;; Then use `M-x package-install RET ring-mode RET` to install the mode.
;; Use `M-x ring-mode` to change your current mode.

;;;;; Manual

;; Download the mode to your local directory.  You can do it through `git clone` command:

;; git clone git://github.com/thechampagne/ring-mode.git

;; Then add path to ring-mode to load-path list — add the following to your Emacs config file

;; (add-to-list 'load-path
;; 	     "/path/to/ring-mode/")
;; (require 'ring-mode)

;; Use `M-x ring-mode` to change your current mode.

;;; Code:

(defvar ring-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?/ ". 124b" table)
    (modify-syntax-entry ?* ". 23" table)
    (modify-syntax-entry ?\n "> b" table)
    (modify-syntax-entry ?\' "\"" table)
    (modify-syntax-entry ?\" "\"" table)
    table))


;;(defun ring-keywords()
;;  '("again" "and" "but" "bye" "call" "case" "catch" "changeringkeyword"
;;    "changeringoperator" "class" "def" "do" "done" "else" "elseif" "end"
;;    "exit" "for" "from" "func" "get" "give" "if" "import" "in" "load"
;;    "loadsyntax" "loop" "new" "next" "not" "off" "ok" "on" "or" "other"
;;    "package" "private" "put" "return" "see" "step" "switch" "to" "try"
;;    "while" "endfunc" "endclass" "endpackage" "endif" "endfor" "endwhile"
;;    "endswitch" "endtry" "function" "endfunction" "break" "continue"))


(defun ring-keywords()
  "Ring programming language keywords."
  '("[a\\|A][g\\|G][a\\|A][i\\|I][n\\|N]\\|"                                                                                                        ;; again
    "[a\\|A][n\\|N][d\\|D]\\|"                                                                                                                      ;; and
    "[b\\|B][u\\|U][t\\|T]\\|"                                                                                                                      ;; but
    "[b\\|B][y\\|Y][e\\|E]\\|"                                                                                                                      ;; bye
    "[c\\|C][a\\|A][l\\|L][l\\|L]\\|"                                                                                                               ;; call
    "[c\\|C][a\\|A][s\\|S][e\\|E]\\|"                                                                                                               ;; case
    "[c\\|C][a\\|A][t\\|T][c\\|C][h\\|H]\\|"                                                                                                        ;; catch
    "[c\\|C][h\\|H][a\\|A][n\\|N][g\\|G][e\\|E][r\\|R][i\\|I][n\\|N][g\\|G][k\\|K][e\\|E][y\\|Y][w\\|W][o\\|O][r\\|R][d\\|D]\\|"                    ;; changeringkeyword
    "[c\\|C][h\\|H][a\\|A][n\\|N][g\\|G][e\\|E][r\\|R][i\\|I][n\\|N][g\\|G][o\\|O][p\\|P][e\\|E][r\\|R][a\\|A][t\\|T][o\\|O][r\\|R]\\|"             ;; changeringoperator
    "[c\\|C][l\\|L][a\\|A][s\\|S][s\\|S]\\|"                                                                                                        ;; class
    "[d\\|D][e\\|E][f\\|F]\\|"                                                                                                                      ;; def
    "[d\\|D][o\\|O]\\|"                                                                                                                             ;; do
    "[d\\|D][o\\|O][n\\|N][e\\|E]\\|"                                                                                                               ;; done
    "[e\\|E][l\\|L][s\\|S][e\\|E]\\|"                                                                                                               ;; else
    "[e\\|E][l\\|L][s\\|S][e\\|E][i\\|I][f\\|F]\\|"                                                                                                 ;; elseif
    "[e\\|E][n\\|N][d\\|D]\\|"                                                                                                                      ;; end
    "[e\\|E][x\\|X][i\\|I][t\\|T]\\|"                                                                                                               ;; exit
    "[f\\|F][o\\|O][r\\|R]\\|"                                                                                                                      ;; for
    "[f\\|F][r\\|R][o\\|O][m\\|M]\\|"                                                                                                               ;; from
    "[f\\|F][u\\|U][n\\|N][c\\|C]\\|"                                                                                                               ;; func
    "[g\\|G][e\\|E][t\\|T]\\|"                                                                                                                      ;; get
    "[g\\|G][i\\|I][v\\|V][e\\|E]\\|"                                                                                                               ;; give
    "[i\\|I][f\\|F]\\|"                                                                                                                             ;; if
    "[i\\|I][m\\|M][p\\|P][o\\|O][r\\|R][t\\|T]\\|"                                                                                                 ;; import
    "[i\\|I][n\\|N]\\|"                                                                                                                             ;; in
    "[l\\|L][o\\|O][a\\|A][d\\|D]\\|"                                                                                                               ;; load
    "[l\\|L][o\\|O][a\\|A][d\\|D][s\\|S][y\\|Y][n\\|N][t\\|T][a\\|A][x\\|X]\\|"                                                                     ;; loadsyntax
    "[l\\|L][o\\|O][o\\|O][p\\|P]\\|"                                                                                                               ;; loop
    "[n\\|N][e\\|E][w\\|W]\\|"                                                                                                                      ;; new
    "[n\\|N][e\\|E][x\\|X][t\\|T]\\|"                                                                                                               ;; next
    "[n\\|N][o\\|O][t\\|T]\\|"                                                                                                                      ;; not
    "[o\\|O][f\\|F][f\\|F]\\|"                                                                                                                      ;; off
    "[o\\|O][k\\|K]\\|"                                                                                                                             ;; ok
    "[o\\|O][n\\|N]\\|"                                                                                                                             ;; on
    "[o\\|O][r\\|R]\\|"                                                                                                                             ;; or
    "[o\\|O][t\\|T][h\\|H][e\\|E][r\\|R]\\|"                                                                                                        ;; other
    "[p\\|P][a\\|A][c\\|C][k\\|K][a\\|A][g\\|G][e\\|E]\\|"                                                                                          ;; package
    "[p\\|P][r\\|R][i\\|I][v\\|V][a\\|A][t\\|T][e\\|E]\\|"                                                                                          ;; private
    "[p\\|P][u\\|U][t\\|T]\\|"                                                                                                                      ;; put
    "[r\\|R][e\\|E][t\\|T][u\\|U][r\\|R][n\\|N]\\|"                                                                                                 ;; return
    "[s\\|S][e\\|E][e\\|E]\\|"                                                                                                                      ;; see
    "[s\\|S][t\\|T][e\\|E][p\\|P]\\|"                                                                                                               ;; step
    "[s\\|S][w\\|W][i\\|I][t\\|T][c\\|C][h\\|H]\\|"                                                                                                 ;; switch
    "[t\\|T][o\\|O]\\|"                                                                                                                             ;; to
    "[t\\|T][r\\|R][y\\|Y]\\|"                                                                                                                      ;; try
    "[w\\|W][h\\|H][i\\|I][l\\|L][e\\|E]\\|"                                                                                                        ;; while
    "[e\\|E][n\\|N][d\\|D][f\\|F][u\\|U][n\\|N][c\\|C]\\|"                                                                                          ;; endfunc
    "[e\\|E][n\\|N][d\\|D][c\\|C][l\\|L][a\\|A][s\\|S][s\\|S]\\|"                                                                                   ;; endclass
    "[e\\|E][n\\|N][d\\|D][p\\|P][a\\|A][c\\|C][k\\|K][a\\|A][g\\|G][e\\|E]\\|"                                                                     ;; endpackage
    "[e\\|E][n\\|N][d\\|D][i\\|I][f\\|F]\\|"                                                                                                        ;; endif
    "[e\\|E][n\\|N][d\\|D][f\\|F][o\\|O][r\\|R]\\|"                                                                                                 ;; endfor
    "[e\\|E][n\\|N][d\\|D][w\\|W][h\\|H][i\\|I][l\\|L][e\\|E]\\|"                                                                                   ;; endwhile
    "[e\\|E][n\\|N][d\\|D][s\\|S][w\\|W][i\\|I][t\\|T][c\\|C][h\\|H]\\|"                                                                            ;; endswitch
    "[e\\|E][n\\|N][d\\|D][t\\|T][r\\|R][y\\|Y]\\|"                                                                                                 ;; endtry
    "[f\\|F][u\\|U][n\\|N][c\\|C][t\\|T][i\\|I][o\\|O][n\\|N]\\|"                                                                                   ;; function
    "[e\\|E][n\\|N][d\\|D][f\\|F][u\\|U][n\\|N][c\\|C][t\\|T][i\\|I][o\\|O][n\\|N]\\|"                                                              ;; endfunction
    "[b\\|B][r\\|R][e\\|E][a\\|A][k\\|K]\\|"                                                                                                        ;; break
    "[c\\|C][o\\|O][n\\|N][t\\|T][i\\|I][n\\|N][u\\|U][e\\|E]"                                                                                      ;; continue
    ))

(defun ring-builtins()
  "Ring programming language builtins."
  '("acos" "add" "addattribute" "adddays" "addmethod" "addsublistsbyfastcopy" "addsublistsbymove"
    "ascii" "asin" "assert" "atan" "atan2" "attributes" "binarysearch" "bytes2double"
    "bytes2float" "bytes2int" "callgarbagecollector" "callgc" "ceil" "cfunctions" "char" "chdir"
    "checkoverflow" "classes" "classname" "clearerr" "clock" "clockspersecond" "closelib" "copy"
    "cos" "cosh" "currentdir" "date" "dec" "decimals" "del" "diffdays" "dir" "direxists" "double2bytes"
    "eval" "exefilename" "exefolder" "exp" "fabs" "fclose" "feof" "ferror" "fexists" "fflush" "fgetc"
    "fgetpos" "fgets" "filename" "find" "float2bytes" "floor" "fopen" "fputc" "fputs"
    "fread" "freopen" "fseek" "fsetpos" "ftell" "functions" "fwrite" "getarch" "getattribute"
    "getchar" "getfilesize" "getnumber" "getpathtype" "getpointer" "getptr" "getstring"
    "globals" "hex" "hex2str" "input" "insert" "int2bytes" "intvalue" "isalnum" "isalpha"
    "isandroid" "isattribute" "iscfunction" "isclass" "iscntrl" "isdigit" "isfreebsd"
    "isfunction" "isglobal" "isgraph" "islinux" "islist" "islocal" "islower" "ismacosx"
    "ismethod" "ismsdos" "isnull" "isnumber" "isobject" "ispackage" "ispackageclass"
    "ispointer" "isprint" "isprivateattribute" "isprivatemethod" "ispunct" "isspace"
    "isstring" "isunix" "isupper" "iswindows" "iswindows64" "isxdigit" "left" "len"
    "lines" "list" "list2str" "loadlib" "locals" "log" "log10" "lower" "max"
    "memcpy" "memorycopy" "mergemethods" "methods" "min" "murmur3hash" "newlist"
    "nofprocessors" "nullpointer" "nullptr" "number" "obj2ptr" "object2pointer"
    "objectid" "packageclasses" "packagename" "packages" "perror" "pointer2object"
    "pointer2string" "pointercompare" "pow" "prevfilename" "print" "print2str" "ptr2obj"
    "ptr2str" "ptrcmp" "puts" "raise" "random" "randomize" "read" "remove" "rename" "reverse"
    "rewind" "right" "ring_give" "ring_see" "ring_state_delete" "ring_state_filetokens"
    "ring_state_findvar" "ring_state_init" "ring_state_main" "ring_state_mainfile"
    "ring_state_new" "ring_state_newvar" "ring_state_runcode" "ring_state_runfile"
    "ring_state_runobjectfile" "ring_state_scannererror" "ring_state_setvar"
    "ring_state_stringtokens" "ringvm_callfunc" "ringvm_calllist"
    "ringvm_cfunctionslist" "ringvm_classeslist" "ringvm_codelist" "ringvm_evalinscope"
    "ringvm_fileslist" "ringvm_functionslist" "ringvm_genarray" "ringvm_give" "ringvm_hideerrormsg"
    "ringvm_info" "ringvm_memorylist" "ringvm_packageslist" "ringvm_passerror" "ringvm_scopescount"
    "ringvm_see" "ringvm_settrace" "ringvm_tracedata" "ringvm_traceevent" "ringvm_tracefunc"
    "setattribute" "setpointer" "setptr" "shutdown" "sin" "sinh" "sort" "sort" "space" "sqrt" "srandom"
    "str2hex" "str2hexcstyle" "str2list" "strcmp" "string" "substr" "swap" "sysget" "sysset" "system"
    "sysunset" "tan" "tanh" "tempfile" "tempname" "time" "timelist" "trim" "type" "ungetc" "unsigned"
    "upper" "uptime" "variablepointer" "varptr" "version" "windowsnl" "write"))


(defun ring-operators()
  "Ring programming language operators."
  '(
    ;; Arithmetic operators
    "+" "-" "*" "/" "%" "++" "--"

    ;; Relational operators
    "=" "!=" ">" "<" ">=" "<="

    ;; Logical operators
    "and" "or" "not" "&&" "||" "!"
    "&" "|" "^" "~" "<<" ">>"

    ;; Bitwise operators
    "+=" "-=" "*=" "/=" "%=" "<<="
    ">>=" "&=" "|=" "^="

    ;; Other operators
    ":" "." "?"))

(defun ring-font-lock-keywords ()
  "Ring programming language font lock keywords."
  (list
   `("\\(#.*\\)" . font-lock-comment-face)
   `("\\<\\([T\\|t][R\\|r][U\\|u][E\\|e]\\|[F\\|f][A\\|a][L\\|l][S\\|s][E\\|e]\\)\\>" . font-lock-constant-face)
   `(,(concat "\\<\\(" (mapconcat 'identity (ring-keywords) "") "\\)\\>") . font-lock-keyword-face)
   `(,(concat (regexp-opt (ring-builtins) 'symbols)  "[[:space:]]*(") . (1 font-lock-builtin-face ))
   `(,(regexp-opt (ring-operators)) . font-lock-builtin-face)))

;;;###autoload
(define-derived-mode ring-mode prog-mode "Ring"
  "A major mode for the Ring programming language."
  :syntax-table ring-mode-syntax-table
  (setq-local font-lock-defaults '(ring-font-lock-keywords)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ring\\'" . ring-mode))

(provide 'ring-mode)

;;; ring-mode.el ends here
