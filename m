Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVB0AKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVB0AKc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVB0AKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:10:20 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:2728
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261312AbVB0AA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:00:28 -0500
Message-ID: <20050227010026.8.patchmail@tglx>
References: <20050227005956.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: lethal@linux-sh.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/10] SH64:  C99 initializers for hw_interrupt_type structures
Date: Sun, 27 Feb 2005 00:56:38 +0100 (CET)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 irq.c      |   14 +++++++-------
 irq_intc.c |   14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)
---
diff -urN 2.6.11-rc5.orig/arch/sh64/kernel/irq.c 2.6.11-rc5/arch/sh64/kernel/irq.c
--- 2.6.11-rc5.orig/arch/sh64/kernel/irq.c	2004-12-24 22:34:01.000000000 +0100
+++ 2.6.11-rc5/arch/sh64/kernel/irq.c	2005-02-26 20:54:19.000000000 +0100
@@ -81,13 +81,13 @@
 #define end_none	enable_none
 
 struct hw_interrupt_type no_irq_type = {
-	"none",
-	startup_none,
-	shutdown_none,
-	enable_none,
-	disable_none,
-	ack_none,
-	end_none
+	.typename= "none",
+	.startup = startup_none,
+	.shutdown = shutdown_none,
+	.enable = enable_none,
+	.disable = disable_none,
+	.ack = ack_none,
+	.end = end_none
 };
 
 #if defined(CONFIG_PROC_FS)
diff -urN 2.6.11-rc5.orig/arch/sh64/kernel/irq_intc.c 2.6.11-rc5/arch/sh64/kernel/irq_intc.c
--- 2.6.11-rc5.orig/arch/sh64/kernel/irq_intc.c	2004-12-24 22:35:40.000000000 +0100
+++ 2.6.11-rc5/arch/sh64/kernel/irq_intc.c	2005-02-26 20:54:19.000000000 +0100
@@ -107,13 +107,13 @@
 static void end_intc_irq(unsigned int irq);
 
 static struct hw_interrupt_type intc_irq_type = {
-	"INTC",
-	startup_intc_irq,
-	shutdown_intc_irq,
-	enable_intc_irq,
-	disable_intc_irq,
-	mask_and_ack_intc,
-	end_intc_irq
+	.typename = "INTC",
+	.startup = startup_intc_irq,
+	.shutdown = shutdown_intc_irq,
+	.enable = enable_intc_irq,
+	.disable = disable_intc_irq,
+	.ack = mask_and_ack_intc,
+	.end = end_intc_irq
 };
 
 static int irlm;		/* IRL mode */
