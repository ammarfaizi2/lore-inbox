Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289270AbSBDXJL>; Mon, 4 Feb 2002 18:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSBDXJB>; Mon, 4 Feb 2002 18:09:01 -0500
Received: from jalon.able.es ([212.97.163.2]:64947 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S289270AbSBDXIv>;
	Mon, 4 Feb 2002 18:08:51 -0500
Date: Tue, 5 Feb 2002 00:08:42 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -K2
Message-ID: <20020205000842.A10594@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.33.0202040621400.22435-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0202040621400.22435-100000@localhost.localdomain>; from mingo@elte.hu on lun, feb 04, 2002 at 06:26:44 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020204 Ingo Molnar wrote:
>
>the -K2 O(1) scheduler patch for kernels 2.5.3, 2.4.18-pre7 and 2.4.17 is
>available at:
>
>    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.3-K2.patch
>    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-K2.patch
>    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.18-pre7-K2.patch
>
>the -K2 patch includes fixes, cleanups, performance improvements and
>interactivity improvements.
>
>Bug reports, comments, suggestions are welcome,
>

Not usre if its a bug or my fault.
To build bproc, I changed all

nice = current->nice   -----> nice = task_nice(current)

but...

werewolf:~# depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.4.18-pre7-slb/bproc/bproc.o
depmod:         task_nice

Perhaps a missing

 EXPORT_SYMBOL(set_user_nice);
+EXPORT_SYMBOL(task_nice);

in ksyms.c ??

TIA

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre7-slb #1 SMP Mon Feb 4 21:21:52 CET 2002 i686
