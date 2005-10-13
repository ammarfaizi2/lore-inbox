Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVJMH4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVJMH4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 03:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbVJMH4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 03:56:05 -0400
Received: from f24.mail.ru ([194.67.57.160]:45325 "EHLO f24.mail.ru")
	by vger.kernel.org with ESMTP id S1750786AbVJMH4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 03:56:04 -0400
From: Serge Goodenko <s_goodenko@mail.ru>
To: George Anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net
Subject: Re: Re: [PATCH] UML + High-Res-Timers on 2.4.25 kernel
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.70.42]
Date: Thu, 13 Oct 2005 11:55:57 +0400
In-Reply-To: <4346A0A4.4090303@mvista.com>
Reply-To: Serge Goodenko <s_goodenko@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1EPxwT-0009q3-00.s_goodenko-mail-ru@f24.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> Serge Goodenko wrote:
> > Hello!
> > 
> > I am trying to compile 2.4.25 UML kernel together with High Resolution Timers patch and it fails to compile saying the following during linking:
> > 
> > gcc -Wl,-T,arch/um/link.ld -static -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc \
> >         -o linux arch/um/main.o vmlinux.o -L/usr/lib -lutil
> > vmlinux.o(.text+0x2688): In function `schedule_timeout':
> > /usr/src/linux-2.4.25/kernel/sched.c:443: undefined reference to `jiffies'
> > vmlinux.o(.text+0x26cd):/usr/src/linux-2.4.25/kernel/sched.c:454: undefined reference to `jiffies'
> > vmlinux.o(.text+0x27a4): In function `schedule':
> > /usr/src/linux-2.4.25/include/linux/sched.h:929: undefined reference to `jiffies'
> > vmlinux.o(.text+0x489e): In function `do_fork':
> > /usr/src/linux-2.4.25/kernel/fork.c:740: undefined reference to `jiffies'
> > vmlinux.o(.text+0xabd5): In function `do_getitimer':
> > /usr/src/linux-2.4.25/kernel/itimer.c:55: undefined reference to `jiffies'
> > vmlinux.o(.text+0xacd3):/usr/src/linux-2.4.25/kernel/itimer.c:103: more undefined references to `jiffies' follow
> > collect2: ld returned 1 exit status
> > make: *** [linux] Error 1
> > 
> > is there any solution to this problem?
> > or HRT patch is not supposed to work under UML at all?
> >
> You might do better on the HRT list (cc'ed).
> 
> I don't know what UML needs.  I would have thought that jiffies would be defined...  especially for 
> things like do_fork.  Which patch are you using?

Well, as far as I understood recently HRT patch is not what I exactly need. It provides just API for using in user space applications and I need to use High-Resolution timer in kernel (particulary in TCP/IP stack)...
therefore my problem now is to find suitable hi-res timer patch for use in 2.4 kernel...
and I would be pleased if you could recommend me something...

thanks,

Serge, MIPT,
Russia


