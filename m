Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272533AbTGZOlU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272550AbTGZOkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:40:55 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:64315 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272532AbTGZOcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:51 -0400
Date: Sat, 26 Jul 2003 16:51:58 +0200
Message-Id: <200307261451.h6QEpw3e002460@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k irq_cpustat_t
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Kill obsolete members of irq_cpustat_t

--- linux-2.6.x/arch/m68k/kernel/m68k_defs.c	Fri Jan 17 12:25:26 2003
+++ linux-m68k-2.6.x/arch/m68k/kernel/m68k_defs.c	Fri Jul  4 15:06:09 2003
@@ -76,7 +76,6 @@
 
 	/* offsets into the irq_cpustat_t struct */
 	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t, __softirq_pending));
-	DEFINE(CPUSTAT_SYSCALL_COUNT, offsetof(irq_cpustat_t, __syscall_count));
 
 	/* offsets into the bi_record struct */
 	DEFINE(BIR_TAG, offsetof(struct bi_record, tag));
--- linux-2.6.x/include/asm-m68k/hardirq.h	Tue May 27 19:03:41 2003
+++ linux-m68k-2.6.x/include/asm-m68k/hardirq.h	Fri Jul 11 13:54:47 2003
@@ -7,8 +7,6 @@
 /* entry.S is sensitive to the offsets of these fields */
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int __syscall_count;
-        struct task_struct * __ksoftirqd_task;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
