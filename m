Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUAAUOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264574AbUAAUFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:05:40 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:18458 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S264608AbUAAUB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:58 -0500
Date: Thu, 1 Jan 2004 21:01:55 +0100
Message-Id: <200401012001.i01K1tWW031763@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 353] Q40 interrupts C99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Q40 interrupts: Use C99 struct initializers

--- linux-2.6.0/arch/m68k/q40/q40ints.c	Wed Sep 10 21:20:12 2003
+++ linux-m68k-2.6.0/arch/m68k/q40/q40ints.c	Sun Oct  5 12:37:53 2003
@@ -281,21 +281,17 @@
   {Q40_IRQ_KEYB_MASK,Q40_IRQ_KEYBOARD},
   {0,0}};
 #endif
-static struct IRQ_TABLE eirqs[]={
-  {Q40_IRQ3_MASK,3},                   /* ser 1 */
-  {Q40_IRQ4_MASK,4},                   /* ser 2 */
-  {Q40_IRQ14_MASK,14},                 /* IDE 1 */
-  {Q40_IRQ15_MASK,15},                 /* IDE 2 */
-  {Q40_IRQ6_MASK,6},                   /* floppy, handled elsewhere */
-  {Q40_IRQ7_MASK,7},                   /* par */
-
-  {Q40_IRQ5_MASK,5},
-  {Q40_IRQ10_MASK,10},
-
-
-
-
-  {0,0}};
+static struct IRQ_TABLE eirqs[] = {
+  { .mask = Q40_IRQ3_MASK,	.irq = 3 },	/* ser 1 */
+  { .mask = Q40_IRQ4_MASK,	.irq = 4 },	/* ser 2 */
+  { .mask = Q40_IRQ14_MASK,	.irq = 14 },	/* IDE 1 */
+  { .mask = Q40_IRQ15_MASK,	.irq = 15 },	/* IDE 2 */
+  { .mask = Q40_IRQ6_MASK,	.irq = 6 },	/* floppy, handled elsewhere */
+  { .mask = Q40_IRQ7_MASK,	.irq = 7 },	/* par */
+  { .mask = Q40_IRQ5_MASK,	.irq = 5 },
+  { .mask = Q40_IRQ10_MASK,	.irq = 10 },
+  {0,0}
+};
 
 /* complain only this many times about spurious ints : */
 static int ccleirq=60;    /* ISA dev IRQ's*/

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
