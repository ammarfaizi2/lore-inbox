Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbSI2TBU>; Sun, 29 Sep 2002 15:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbSI2TBT>; Sun, 29 Sep 2002 15:01:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45493 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261737AbSI2TBS>;
	Sun, 29 Sep 2002 15:01:18 -0400
Date: Sun, 29 Sep 2002 21:16:02 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
In-Reply-To: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209292115010.25309-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch is against BK-curr, it removes some more old symbols
from ksyms.c. This makes the kernel compile with modules enabled.

	Ingo

--- linux/kernel/ksyms.c.orig	Sun Sep 29 21:12:50 2002
+++ linux/kernel/ksyms.c	Sun Sep 29 21:13:24 2002
@@ -420,7 +420,6 @@
 EXPORT_SYMBOL(del_timer_sync);
 #endif
 EXPORT_SYMBOL(mod_timer);
-EXPORT_SYMBOL(tvec_bases);
 
 #ifdef CONFIG_SMP
 
@@ -589,12 +588,8 @@
 EXPORT_SYMBOL(strsep);
 
 /* software interrupts */
-EXPORT_SYMBOL(bh_task_vec);
-EXPORT_SYMBOL(init_bh);
-EXPORT_SYMBOL(remove_bh);
 EXPORT_SYMBOL(tasklet_init);
 EXPORT_SYMBOL(tasklet_kill);
-EXPORT_SYMBOL(__run_task_queue);
 EXPORT_SYMBOL(do_softirq);
 EXPORT_SYMBOL(raise_softirq);
 EXPORT_SYMBOL(open_softirq);

