Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267044AbSL3UXU>; Mon, 30 Dec 2002 15:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbSL3UXU>; Mon, 30 Dec 2002 15:23:20 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:38351 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267044AbSL3UXR> convert rfc822-to-8bit; Mon, 30 Dec 2002 15:23:17 -0500
Message-Id: <4.3.2.7.2.20021230212528.00b5fc80@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 30 Dec 2002 21:32:08 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCHSET] 2.4.21-pre2-jp15
Cc: joergprante@netcologne.de
In-Reply-To: <200212301955.29912.joergprante@netcologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörg,
         Sorry, the patch doesn't change anything.
         I am compiling with PREEMPT off.
         Looking at sysrq.c , I would say that a couple of
         #ifdef's are missing. The code in the handle_preempt
         function, I think should be ifdef'd on CONFIG_PREEMPT_LOG

         Margit

At 19:56 30.12.02 +0100, you wrote:
> >drivers/char/char.o: In function `sysrq_handle_preempt_log':
> >drivers/char/char.o(.text+0x1c79e): undefined reference to 
> `show_preempt_log'
>
>Please apply
>
>http://infolinux.de/jp15/076_sysrq-preempt-log-fix
>
>Patchset .bz2 archive will be updated.
>
>Jörg
>
>--- linux-jp15/drivers/char/sysrq.c.orig        2002-12-30 
>19:48:15.000000000 +0100
>+++ linux-jp15/drivers/char/sysrq.c     2002-12-30 19:48:35.000000000 +0100
>@@ -27,7 +27,7 @@
>  #include <linux/quotaops.h>
>  #include <linux/smp_lock.h>
>  #include <linux/module.h>
>-
>+#include <linux/sched.h>
>  #include <linux/spinlock.h>
>
>  #include <asm/ptrace.h>

