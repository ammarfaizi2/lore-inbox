Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751795AbWJILDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWJILDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWJILDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:03:32 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:37322 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751795AbWJILDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:03:31 -0400
Message-Id: <6.1.1.1.2.20061009125614.02a6e000@192.168.6.12>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Mon, 09 Oct 2006 13:03:07 +0200
To: Sam Ravnborg <sam@ravnborg.org>
From: Roger While <simrw@sim-basis.de>
Subject: Re: menuconfig bust in 2.6.19rc1-git5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061009094609.GA6703@uranus.ravnborg.org>
References: <6.1.1.1.2.20061009092219.02b0bec0@192.168.6.12>
 <20061009094609.GA6703@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-SIMBasis-MailScanner-Information: Please contact the ISP for more information
X-SIMBasis-MailScanner: Found to be clean
X-SIMBasis-MailScanner-From: simrw@sim-basis.de
X-ID: VUhwX+ZGgehp8l1vsaQnRqDhwE43HXg7UIy4aJ8dctuRkV7UqXQ16r@t-dialin.net
X-TOI-MSGID: 5b576a1a-825c-4918-aa8f-d7dd68ae95ea
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaagh, sorry, false alarm.
There was a dud (0 byte) /usr/include/ncurses/ncurses.h on the system :-(
(However /usr/include/ncurses.h is perfectly OK)
Maybe check-lxdialog.sh should 'test -s' the includes ?

Roger

>On Mon, Oct 09, 2006 at 09:30:06AM +0200, Roger While wrote:
> > > make menuconfig
> > HOSTCC  scripts/basic/fixdep
> > HOSTCC  scripts/basic/docproc
> > HOSTCC  scripts/kconfig/conf.o
> > HOSTCC  scripts/kconfig/kxgettext.o
> > HOSTCC  scripts/kconfig/lxdialog/checklist.o
> > In file included from scripts/kconfig/lxdialog/checklist.c:24:
> > scripts/kconfig/lxdialog/dialog.h:96: error: syntax error before "chtype"
> > scripts/kconfig/lxdialog/dialog.h:96: warning: no semicolon at end of
> > struct or union
>
>This looks like some type is missing.
>I do not expect to be within reach of my linux box the next week - du you have
>the possibility to try a few thing to sort it out?
>
>Take a look at line 96 (and one or two lines before) and check what type
>is used there. Then try to find out in which header file
>it is supposed to be defined and include this header file in dialog.h.
>
>This should keep you going again.
>
>It may also be that you need to install a later version of ncurses to get 
>it operational.
>
>         Sam



