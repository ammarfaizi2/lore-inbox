Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTI2Ilb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbTI2IkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:40:10 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:53271 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S262902AbTI2Ihz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:37:55 -0400
Date: Mon, 29 Sep 2003 10:39:12 +0200
Message-Id: <200309290839.h8T8dCJd003706@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 335] M68k sched_clock()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add sched_clock() (introduced in 2.6.0-test6)

--- linux-2.6.0-test6/arch/m68k/kernel/time.c	Mon Jul 14 13:15:58 2003
+++ linux-m68k-2.6.0-test6/arch/m68k/kernel/time.c	Sun Sep 28 10:50:36 2003
@@ -171,3 +171,12 @@
 	write_sequnlock_irq(&xtime_lock);
 	return 0;
 }
+
+/*
+ * Scheduler clock - returns current time in ns units.
+ */
+unsigned long long sched_clock(void)
+{
+       return (unsigned long long)jiffies*(1000000000/HZ);
+}
+

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
