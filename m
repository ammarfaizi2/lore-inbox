Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbVJGNZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVJGNZL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 09:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbVJGNZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 09:25:11 -0400
Received: from f16.mail.ru ([194.67.57.46]:27915 "EHLO f16.mail.ru")
	by vger.kernel.org with ESMTP id S932548AbVJGNZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 09:25:10 -0400
From: Serge Goodenko <s_goodenko@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] UML + High-Res-Timers on 2.4.25 kernel
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.70.42]
Date: Fri, 07 Oct 2005 17:24:58 +0400
Reply-To: Serge Goodenko <s_goodenko@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1ENsDa-0008Y1-00.s_goodenko-mail-ru@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am trying to compile 2.4.25 UML kernel together with High Resolution Timers patch and it fails to compile saying the following during linking:

gcc -Wl,-T,arch/um/link.ld -static -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc \
        -o linux arch/um/main.o vmlinux.o -L/usr/lib -lutil
vmlinux.o(.text+0x2688): In function `schedule_timeout':
/usr/src/linux-2.4.25/kernel/sched.c:443: undefined reference to `jiffies'
vmlinux.o(.text+0x26cd):/usr/src/linux-2.4.25/kernel/sched.c:454: undefined reference to `jiffies'
vmlinux.o(.text+0x27a4): In function `schedule':
/usr/src/linux-2.4.25/include/linux/sched.h:929: undefined reference to `jiffies'
vmlinux.o(.text+0x489e): In function `do_fork':
/usr/src/linux-2.4.25/kernel/fork.c:740: undefined reference to `jiffies'
vmlinux.o(.text+0xabd5): In function `do_getitimer':
/usr/src/linux-2.4.25/kernel/itimer.c:55: undefined reference to `jiffies'
vmlinux.o(.text+0xacd3):/usr/src/linux-2.4.25/kernel/itimer.c:103: more undefined references to `jiffies' follow
collect2: ld returned 1 exit status
make: *** [linux] Error 1

is there any solution to this problem?
or HRT patch is not supposed to work under UML at all?

thanks in advance,
Serge, MIPT
Russia
