Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVGMS6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVGMS6x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVGMS6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:58:47 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:54124 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262389AbVGMS5E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:57:04 -0400
Date: Wed, 13 Jul 2005 20:45:00 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Egry G?bor <gaboregry@t-online.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH 0/19] Kconfig I18N completion
Message-ID: <20050713204500.GA16284@mars.ravnborg.org>
References: <1121273456.2975.3.camel@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121273456.2975.3.camel@spirit>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 06:50:56PM +0200, Egry G?bor wrote:
> Hello,
> 
> The following patches complete the "Kconfig I18N support" patch by
> Arnaldo. 
> 
> The following parts are internationalised:
> - Kconfig prompt, help, comment and menu texts
> - full visible configuration interfaces
> - error messages if the user can correct the errors (ex. saving config
> file)
> - answering (Y/M/N)
> - option's value if it is a choice (viewing only)
> 
> Without I18N support:
> - symbol names (CONFIG_xxx)
> - Kconfig parsing errors in LKC
> - lxdialog's errors
> - content of the config file
> - disabled debug messages in the source code
> 
> Some incomplete language files are downloadable from the
> http://sourceforge.net/projects/tlktp/ page for testing (langpack).
> 
> Currently available:
> - Italian (98%)
> - Hungarian (67%)
> - French (37%)
> - Catalan (10%)
> - Russian (5%)
> 
> All patches are tested without any problems.

When I apply them to latest Linus tree I gett a few fuzz and a single
reject. After fixing this and compiling I get a number of warnings and
errors. I have not investigated the source of this.

	Sam

make menuconfig output:

Makefile:485: .config: No such file or directory
make[1]: Nothing to be done for `Makefile'.
  HOSTCC  scripts/lxdialog/checklist.o
scripts/lxdialog/checklist.c: In function `print_item':
scripts/lxdialog/checklist.c:63: warning: implicit declaration of function `mvwaddwstr'
scripts/lxdialog/checklist.c:65: warning: implicit declaration of function `waddwstr'
  HOSTCC  scripts/lxdialog/inputbox.o
scripts/lxdialog/inputbox.c: In function `dialog_inputbox':
scripts/lxdialog/inputbox.c:89: warning: implicit declaration of function `waddwstr'
  HOSTCC  scripts/lxdialog/lxdialog.o
  HOSTCC  scripts/lxdialog/menubox.o
scripts/lxdialog/menubox.c: In function `print_item':
scripts/lxdialog/menubox.c:99: warning: implicit declaration of function `mvwaddwstr'
scripts/lxdialog/menubox.c: In function `dialog_menu':
scripts/lxdialog/menubox.c:236: warning: implicit declaration of function `waddwstr'
scripts/lxdialog/menubox.c:549: warning: implicit declaration of function `_'
scripts/lxdialog/menubox.c:549: warning: passing arg 1 of `to_wchar' makes pointer from integer without a cast
scripts/lxdialog/menubox.c:550: warning: passing arg 1 of `to_wchar' makes pointer from integer without a cast
scripts/lxdialog/menubox.c:551: warning: passing arg 1 of `to_wchar' makes pointer from integer without a cast
scripts/lxdialog/menubox.c:552: warning: passing arg 1 of `to_wchar' makes pointer from integer without a cast
  HOSTCC  scripts/lxdialog/msgbox.o
scripts/lxdialog/msgbox.c: In function `dialog_msgbox':
scripts/lxdialog/msgbox.c:63: warning: implicit declaration of function `waddwstr'
  HOSTCC  scripts/lxdialog/textbox.o
scripts/lxdialog/textbox.c: In function `dialog_textbox':
scripts/lxdialog/textbox.c:126: warning: implicit declaration of function `waddwstr'
  HOSTCC  scripts/lxdialog/util.o
scripts/lxdialog/util.c: In function `print_autowrap':
scripts/lxdialog/util.c:217: warning: implicit declaration of function `waddwstr'
  HOSTCC  scripts/lxdialog/yesno.o
scripts/lxdialog/yesno.c: In function `dialog_yesno':
scripts/lxdialog/yesno.c:85: warning: implicit declaration of function `waddwstr'
scripts/lxdialog/yesno.c:113: warning: implicit declaration of function `_'
scripts/lxdialog/yesno.c:113: warning: passing arg 1 of `to_wchar' makes pointer from integer without a cast
scripts/lxdialog/yesno.c:114: warning: passing arg 1 of `to_wchar' makes pointer from integer without a cast
scripts/lxdialog/yesno.c:115: warning: passing arg 1 of `to_wchar' makes pointer from integer without a cast
scripts/lxdialog/yesno.c:116: warning: passing arg 1 of `to_wchar' makes pointer from integer without a cast
  HOSTLD  scripts/lxdialog/lxdialog
scripts/lxdialog/menubox.o(.text+0xe6b): In function `dialog_menu':
: undefined reference to `_'
scripts/lxdialog/menubox.o(.text+0xe83): In function `dialog_menu':
: undefined reference to `_'
scripts/lxdialog/menubox.o(.text+0xe99): In function `dialog_menu':
: undefined reference to `_'
scripts/lxdialog/menubox.o(.text+0xeaf): In function `dialog_menu':
: undefined reference to `_'
scripts/lxdialog/yesno.o(.text+0x2a9): In function `dialog_yesno':
: undefined reference to `_'
scripts/lxdialog/yesno.o(.text+0x2bf): more undefined references to `_' follow
collect2: ld returned 1 exit status
make[3]: *** [scripts/lxdialog/lxdialog] Error 1
make[2]: *** [menuconfig] Error 2
make[1]: *** [menuconfig] Error 2
make: *** [menuconfig] Error 2
