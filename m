Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVGJVvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVGJVvl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVGJVtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 17:49:08 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:6595
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262112AbVGJVr1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 17:47:27 -0400
Message-ID: <20050710235042.5.patchmail@tglx.tec.linutronix.de>
References: <1121031634.26713.243.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: lethal@linux-sh.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] SH64:  [PATCH resend] C99 initializers for hw_interrupt_type structures
Date: Sun, 10 Jul 2005 23:47:28 +0200 (CEST)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 irq_intc.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)
---
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh64/kernel/irq_intc.c linux-2.6.13-rc2-armirq/arch/sh64/kernel/irq_intc.c
--- linux-2.6.13-rc2/arch/sh64/kernel/irq_intc.c	2005-07-09 13:04:23.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh64/kernel/irq_intc.c	2005-07-09 13:10:42.000000000 +0200
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
