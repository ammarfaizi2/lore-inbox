Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbUL0XfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUL0XfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 18:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbUL0XfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 18:35:14 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:23910 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261998AbUL0XfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 18:35:07 -0500
Date: Tue, 28 Dec 2004 00:36:24 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Mark Williams (MWP)" <mwp@internode.on.net>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.10 make script problems
Message-ID: <20041227233624.GB9251@mars.ravnborg.org>
Mail-Followup-To: "Mark Williams (MWP)" <mwp@internode.on.net>,
	linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
References: <20041227030142.GA3321@linux.comp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227030142.GA3321@linux.comp>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 01:31:42PM +1030, Mark Williams (MWP) wrote:
> 
> On a cleanly extracted 2.6.10 kernel, when i run "make menuconfig" i get the following:
> 
> [root@linux linux-2.6.10]# make menuconfig
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/split-include
>   HOSTCC  scripts/basic/docproc
>   GEN    /usr/src/linux-2.6.10-ck1/Makefile
>   SHIPPED scripts/kconfig/zconf.tab.h
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/mconf.o
>   SHIPPED scripts/kconfig/zconf.tab.c
>   SHIPPED scripts/kconfig/lex.zconf.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/mconf
>   HOSTCC  scripts/lxdialog/checklist.o
>   HOSTCC  scripts/lxdialog/inputbox.o
>   HOSTCC  scripts/lxdialog/lxdialog.o
>   HOSTCC  scripts/lxdialog/menubox.o
>   HOSTCC  scripts/lxdialog/msgbox.o
>   HOSTCC  scripts/lxdialog/textbox.o
>   HOSTCC  scripts/lxdialog/util.o
>   HOSTCC  scripts/lxdialog/yesno.o
>   HOSTLD  scripts/lxdialog/lxdialog
> 
> Note the "GEN /usr/src/linux-2.6.10-ck1/Makefile".
> Is this the problem?

Looks like you are using either make O= or have set KBUILD_OUTPUT to
/usr/src/linux-2.6.10-ck1.

But that does not explain it.

Where does the path "/usr/src/linux-2.6.10-ck1" come into the picture?

	Sam
