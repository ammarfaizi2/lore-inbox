Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVGJVvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVGJVvk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVGJVtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 17:49:13 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:5571
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261847AbVGJVrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 17:47:25 -0400
Message-ID: <20050710235040.4.patchmail@tglx.tec.linutronix.de>
References: <1121031634.26713.243.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: uclinux-v850@lsi.nec.co.jp
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] V850:  [PATCH resend] C99 initializers for hw_interrupt_type structures
Date: Sun, 10 Jul 2005 23:47:26 +0200 (CEST)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 irq.c   |   14 +++++++-------
 setup.c |   14 +++++++-------
 sim.c   |   14 +++++++-------
 3 files changed, 21 insertions(+), 21 deletions(-)
---
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/v850/kernel/irq.c linux-2.6.13-rc2-armirq/arch/v850/kernel/irq.c
--- linux-2.6.13-rc2/arch/v850/kernel/irq.c	2005-07-09 13:04:28.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/v850/kernel/irq.c	2005-07-09 13:10:42.000000000 +0200
@@ -67,13 +67,13 @@
 #define end_none	enable_none
 
 struct hw_interrupt_type no_irq_type = {
-	"none",
-	startup_none,
-	shutdown_none,
-	enable_none,
-	disable_none,
-	ack_none,
-	end_none
+	.typename = "none",
+	.startup = startup_none,
+	.shutdown = shutdown_none,
+	.enable = enable_none,
+	.disable = disable_none,
+	.ack = ack_none,
+	.end = end_none
 };
 
 volatile unsigned long irq_err_count, spurious_count;
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/v850/kernel/setup.c linux-2.6.13-rc2-armirq/arch/v850/kernel/setup.c
--- linux-2.6.13-rc2/arch/v850/kernel/setup.c	2005-07-09 13:04:28.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/v850/kernel/setup.c	2005-07-09 13:10:42.000000000 +0200
@@ -128,13 +128,13 @@
 }
 
 static struct hw_interrupt_type nmi_irq_type = {
-	"NMI",
-	irq_zero,		/* startup */
-	irq_nop,		/* shutdown */
-	irq_nop,		/* enable */
-	irq_nop,		/* disable */
-	irq_nop,		/* ack */
-	nmi_end,		/* end */
+	.typename = "NMI",
+	.startup = irq_zero,		/* startup */
+	.shutdown = irq_nop,		/* shutdown */
+	.enable = irq_nop,		/* enable */
+	.disable = irq_nop,		/* disable */
+	.ack = irq_nop,		/* ack */
+	.end = nmi_end,		/* end */
 };
 
 void __init init_IRQ (void)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/v850/kernel/sim.c linux-2.6.13-rc2-armirq/arch/v850/kernel/sim.c
--- linux-2.6.13-rc2/arch/v850/kernel/sim.c	2005-07-09 13:04:28.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/v850/kernel/sim.c	2005-07-09 13:10:42.000000000 +0200
@@ -73,13 +73,13 @@
 static unsigned irq_zero (unsigned irq) { return 0; }
 
 static struct hw_interrupt_type sim_irq_type = {
-	"IRQ",
-	irq_zero,		/* startup */
-	irq_nop,		/* shutdown */
-	irq_nop,		/* enable */
-	irq_nop,		/* disable */
-	irq_nop,		/* ack */
-	irq_nop,		/* end */
+	.typename = "IRQ",
+	.startup = irq_zero,		/* startup */
+	.shutdown = irq_nop,		/* shutdown */
+	.enable = irq_nop,		/* enable */
+	.disable = irq_nop,		/* disable */
+	.ack = irq_nop,		/* ack */
+	.end = irq_nop,		/* end */
 };
 
 void __init mach_init_irqs (void)
