Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVGJVvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVGJVvj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVGJVtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 17:49:36 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:4547
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262117AbVGJVrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 17:47:22 -0400
Message-ID: <20050710235034.2.patchmail@tglx.tec.linutronix.de>
References: <1121031634.26713.243.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: lethal@linux-sh.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] SH:  [PATCH resend] C99 initializers for hw_interrupt_type structures
Date: Sun, 10 Jul 2005 23:47:22 +0200 (CEST)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 boards/adx/irq_maskreg.c         |   14 +++++++-------
 boards/bigsur/irq.c              |   28 ++++++++++++++--------------
 boards/cqreek/irq.c              |   14 +++++++-------
 boards/harp/irq.c                |   14 +++++++-------
 boards/overdrive/irq.c           |   14 +++++++-------
 boards/renesas/hs7751rvoip/irq.c |   14 +++++++-------
 boards/renesas/rts7751r2d/irq.c  |   14 +++++++-------
 boards/renesas/systemh/irq.c     |   14 +++++++-------
 boards/superh/microdev/irq.c     |   14 +++++++-------
 cchips/voyagergx/irq.c           |   14 +++++++-------
 kernel/cpu/irq_imask.c           |   14 +++++++-------
 kernel/cpu/irq_ipr.c             |   28 ++++++++++++++--------------
 kernel/cpu/sh4/irq_intc2.c       |   14 +++++++-------
 13 files changed, 105 insertions(+), 105 deletions(-)
---
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/boards/adx/irq_maskreg.c linux-2.6.13-rc2-armirq/arch/sh/boards/adx/irq_maskreg.c
--- linux-2.6.13-rc2/arch/sh/boards/adx/irq_maskreg.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/boards/adx/irq_maskreg.c	2005-07-09 13:10:42.000000000 +0200
@@ -37,13 +37,13 @@
 
 /* hw_interrupt_type */
 static struct hw_interrupt_type maskreg_irq_type = {
-	" Mask Register",
-	startup_maskreg_irq,
-	shutdown_maskreg_irq,
-	enable_maskreg_irq,
-	disable_maskreg_irq,
-	mask_and_ack_maskreg,
-	end_maskreg_irq
+	.typename = " Mask Register",
+	.startup = startup_maskreg_irq,
+	.shutdown = shutdown_maskreg_irq,
+	.enable = enable_maskreg_irq,
+	.disable = disable_maskreg_irq,
+	.ack = mask_and_ack_maskreg,
+	.end = end_maskreg_irq
 };
 
 /* actual implementatin */
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/boards/bigsur/irq.c linux-2.6.13-rc2-armirq/arch/sh/boards/bigsur/irq.c
--- linux-2.6.13-rc2/arch/sh/boards/bigsur/irq.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/boards/bigsur/irq.c	2005-07-09 13:10:42.000000000 +0200
@@ -228,23 +228,23 @@
 
 /* Define the IRQ structures for the L1 and L2 IRQ types */
 static struct hw_interrupt_type bigsur_l1irq_type = {
-        "BigSur-CPLD-Level1-IRQ",
-        startup_bigsur_irq,
-        shutdown_bigsur_irq,
-        enable_bigsur_l1irq,
-        disable_bigsur_l1irq,
-        mask_and_ack_bigsur,
-        end_bigsur_irq
+	.typename  = "BigSur-CPLD-Level1-IRQ",
+	.startup = startup_bigsur_irq,
+	.shutdown = shutdown_bigsur_irq,
+	.enable = enable_bigsur_l1irq,
+	.disable = disable_bigsur_l1irq,
+	.ack = mask_and_ack_bigsur,
+	.end = end_bigsur_irq
 };
 
 static struct hw_interrupt_type bigsur_l2irq_type = {
-        "BigSur-CPLD-Level2-IRQ",
-        startup_bigsur_irq,
-        shutdown_bigsur_irq,
-        enable_bigsur_l2irq,
-        disable_bigsur_l2irq,
-        mask_and_ack_bigsur,
-        end_bigsur_irq
+	.typename  = "BigSur-CPLD-Level2-IRQ",
+	.startup = startup_bigsur_irq,
+	.shutdown  =shutdown_bigsur_irq,
+	.enable = enable_bigsur_l2irq,
+	.disable = disable_bigsur_l2irq,
+	.ack = mask_and_ack_bigsur,
+	.end = end_bigsur_irq
 };
 
 
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/boards/cqreek/irq.c linux-2.6.13-rc2-armirq/arch/sh/boards/cqreek/irq.c
--- linux-2.6.13-rc2/arch/sh/boards/cqreek/irq.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/boards/cqreek/irq.c	2005-07-09 13:10:42.000000000 +0200
@@ -83,13 +83,13 @@
 }
 
 static struct hw_interrupt_type cqreek_irq_type = {
-	"CqREEK-IRQ",
-	startup_cqreek_irq,
-	shutdown_cqreek_irq,
-	enable_cqreek_irq,
-	disable_cqreek_irq,
-	mask_and_ack_cqreek,
-	end_cqreek_irq
+	.typename = "CqREEK-IRQ",
+	.startup = startup_cqreek_irq,
+	.shutdown = shutdown_cqreek_irq,
+	.enable = enable_cqreek_irq,
+	.disable = disable_cqreek_irq,
+	.ack = mask_and_ack_cqreek,
+	.end = end_cqreek_irq
 };
 
 int cqreek_has_ide, cqreek_has_isa;
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/boards/harp/irq.c linux-2.6.13-rc2-armirq/arch/sh/boards/harp/irq.c
--- linux-2.6.13-rc2/arch/sh/boards/harp/irq.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/boards/harp/irq.c	2005-07-09 13:10:42.000000000 +0200
@@ -39,13 +39,13 @@
 }
 
 static struct hw_interrupt_type harp_irq_type = {
-	"Harp-IRQ",
-	startup_harp_irq,
-	shutdown_harp_irq,
-	enable_harp_irq,
-	disable_harp_irq,
-	mask_and_ack_harp,
-	end_harp_irq
+	.typename = "Harp-IRQ",
+	.startup = startup_harp_irq,
+	.shutdown = shutdown_harp_irq,
+	.enable = enable_harp_irq,
+	.disable = disable_harp_irq,
+	.ack = mask_and_ack_harp,
+	.end = end_harp_irq
 };
 
 static void disable_harp_irq(unsigned int irq)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/boards/overdrive/irq.c linux-2.6.13-rc2-armirq/arch/sh/boards/overdrive/irq.c
--- linux-2.6.13-rc2/arch/sh/boards/overdrive/irq.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/boards/overdrive/irq.c	2005-07-09 13:10:42.000000000 +0200
@@ -86,13 +86,13 @@
 }
 
 static struct hw_interrupt_type od_irq_type = {
-	"Overdrive-IRQ",
-	startup_od_irq,
-	shutdown_od_irq,
-	enable_od_irq,
-	disable_od_irq,
-	mask_and_ack_od,
-	end_od_irq
+	.typename = "Overdrive-IRQ",
+	.startup = startup_od_irq,
+	.shutdown = shutdown_od_irq,
+	.enable = enable_od_irq,
+	.disable = disable_od_irq,
+	.ack = mask_and_ack_od,
+	.end = end_od_irq
 };
 
 static void disable_od_irq(unsigned int irq)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/boards/renesas/hs7751rvoip/irq.c linux-2.6.13-rc2-armirq/arch/sh/boards/renesas/hs7751rvoip/irq.c
--- linux-2.6.13-rc2/arch/sh/boards/renesas/hs7751rvoip/irq.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/boards/renesas/hs7751rvoip/irq.c	2005-07-09 13:10:42.000000000 +0200
@@ -74,13 +74,13 @@
 }
 
 static struct hw_interrupt_type hs7751rvoip_irq_type = {
-	"HS7751RVoIP IRQ",
-	startup_hs7751rvoip_irq,
-	shutdown_hs7751rvoip_irq,
-	enable_hs7751rvoip_irq,
-	disable_hs7751rvoip_irq,
-	ack_hs7751rvoip_irq,
-	end_hs7751rvoip_irq,
+	.typename =  "HS7751RVoIP IRQ",
+	.startup = startup_hs7751rvoip_irq,
+	.shutdown = shutdown_hs7751rvoip_irq,
+	.enable = enable_hs7751rvoip_irq,
+	.disable = disable_hs7751rvoip_irq,
+	.ack = ack_hs7751rvoip_irq,
+	.end = end_hs7751rvoip_irq,
 };
 
 static void make_hs7751rvoip_irq(unsigned int irq)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/boards/renesas/rts7751r2d/irq.c linux-2.6.13-rc2-armirq/arch/sh/boards/renesas/rts7751r2d/irq.c
--- linux-2.6.13-rc2/arch/sh/boards/renesas/rts7751r2d/irq.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/boards/renesas/rts7751r2d/irq.c	2005-07-09 13:10:42.000000000 +0200
@@ -88,13 +88,13 @@
 }
 
 static struct hw_interrupt_type rts7751r2d_irq_type = {
-	"RTS7751R2D IRQ",
-	startup_rts7751r2d_irq,
-	shutdown_rts7751r2d_irq,
-	enable_rts7751r2d_irq,
-	disable_rts7751r2d_irq,
-	ack_rts7751r2d_irq,
-	end_rts7751r2d_irq,
+	.typename = "RTS7751R2D IRQ",
+	.startup = startup_rts7751r2d_irq,
+	.shutdown = shutdown_rts7751r2d_irq,
+	.enable = enable_rts7751r2d_irq,
+	.disable = disable_rts7751r2d_irq,
+	.ack = ack_rts7751r2d_irq,
+	.end = end_rts7751r2d_irq,
 };
 
 static void make_rts7751r2d_irq(unsigned int irq)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/boards/renesas/systemh/irq.c linux-2.6.13-rc2-armirq/arch/sh/boards/renesas/systemh/irq.c
--- linux-2.6.13-rc2/arch/sh/boards/renesas/systemh/irq.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/boards/renesas/systemh/irq.c	2005-07-09 13:10:42.000000000 +0200
@@ -35,13 +35,13 @@
 
 /* hw_interrupt_type */
 static struct hw_interrupt_type systemh_irq_type = {
-	" SystemH Register",
-	startup_systemh_irq,
-	shutdown_systemh_irq,
-	enable_systemh_irq,
-	disable_systemh_irq,
-	mask_and_ack_systemh,
-	end_systemh_irq
+	.typename = " SystemH Register",
+	.startup = startup_systemh_irq,
+	.shutdown = shutdown_systemh_irq,
+	.enable = enable_systemh_irq,
+	.disable = disable_systemh_irq,
+	.ack = mask_and_ack_systemh,
+	.end = end_systemh_irq
 };
 
 static unsigned int startup_systemh_irq(unsigned int irq)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/boards/superh/microdev/irq.c linux-2.6.13-rc2-armirq/arch/sh/boards/superh/microdev/irq.c
--- linux-2.6.13-rc2/arch/sh/boards/superh/microdev/irq.c	2005-07-09 13:04:24.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/boards/superh/microdev/irq.c	2005-07-09 13:10:42.000000000 +0200
@@ -83,13 +83,13 @@
 }
 
 static struct hw_interrupt_type microdev_irq_type = {
-	"MicroDev-IRQ",
-	startup_microdev_irq,
-	shutdown_microdev_irq,
-	enable_microdev_irq,
-	disable_microdev_irq,
-	mask_and_ack_microdev,
-	end_microdev_irq
+	.typename = "MicroDev-IRQ",
+	.startup = startup_microdev_irq,
+	.shutdown = shutdown_microdev_irq,
+	.enable = enable_microdev_irq,
+	.disable = disable_microdev_irq,
+	.ack = mask_and_ack_microdev,
+	.end = end_microdev_irq
 };
 
 static void disable_microdev_irq(unsigned int irq)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/cchips/voyagergx/irq.c linux-2.6.13-rc2-armirq/arch/sh/cchips/voyagergx/irq.c
--- linux-2.6.13-rc2/arch/sh/cchips/voyagergx/irq.c	2005-07-09 13:04:23.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/cchips/voyagergx/irq.c	2005-07-09 13:10:42.000000000 +0200
@@ -87,13 +87,13 @@
 }
 
 static struct hw_interrupt_type voyagergx_irq_type = {
-	"VOYAGERGX-IRQ",
-	startup_voyagergx_irq,
-	shutdown_voyagergx_irq,
-	enable_voyagergx_irq,
-	disable_voyagergx_irq,
-	mask_and_ack_voyagergx,
-	end_voyagergx_irq,
+	.typename = "VOYAGERGX-IRQ",
+	.startup = startup_voyagergx_irq,
+	.shutdown = shutdown_voyagergx_irq,
+	.enable = enable_voyagergx_irq,
+	.disable = disable_voyagergx_irq,
+	.ack = mask_and_ack_voyagergx,
+	.end = end_voyagergx_irq,
 };
 
 static irqreturn_t voyagergx_interrupt(int irq, void *dev_id, struct pt_regs *regs)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/kernel/cpu/irq_imask.c linux-2.6.13-rc2-armirq/arch/sh/kernel/cpu/irq_imask.c
--- linux-2.6.13-rc2/arch/sh/kernel/cpu/irq_imask.c	2005-07-09 13:04:23.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/kernel/cpu/irq_imask.c	2005-07-09 13:10:42.000000000 +0200
@@ -46,13 +46,13 @@
 }
 
 static struct hw_interrupt_type imask_irq_type = {
-	"SR.IMASK",
-	startup_imask_irq,
-	shutdown_imask_irq,
-	enable_imask_irq,
-	disable_imask_irq,
-	mask_and_ack_imask,
-	end_imask_irq
+	.typename = "SR.IMASK",
+	.startup = startup_imask_irq,
+	.shutdown = shutdown_imask_irq,
+	.enable = enable_imask_irq,
+	.disable = disable_imask_irq,
+	.ack = mask_and_ack_imask,
+	.end = end_imask_irq
 };
 
 void static inline set_interrupt_registers(int ip)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/kernel/cpu/irq_ipr.c linux-2.6.13-rc2-armirq/arch/sh/kernel/cpu/irq_ipr.c
--- linux-2.6.13-rc2/arch/sh/kernel/cpu/irq_ipr.c	2005-07-09 13:04:23.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/kernel/cpu/irq_ipr.c	2005-07-09 13:10:42.000000000 +0200
@@ -48,13 +48,13 @@
 }
 
 static struct hw_interrupt_type ipr_irq_type = {
-	"IPR-IRQ",
-	startup_ipr_irq,
-	shutdown_ipr_irq,
-	enable_ipr_irq,
-	disable_ipr_irq,
-	mask_and_ack_ipr,
-	end_ipr_irq
+	.typename = "IPR-IRQ",
+	.startup = startup_ipr_irq,
+	.shutdown = shutdown_ipr_irq,
+	.enable = enable_ipr_irq,
+	.disable = disable_ipr_irq,
+	.ack = mask_and_ack_ipr,
+	.end = end_ipr_irq
 };
 
 static void disable_ipr_irq(unsigned int irq)
@@ -142,13 +142,13 @@
 }
 
 static struct hw_interrupt_type pint_irq_type = {
-	"PINT-IRQ",
-	startup_pint_irq,
-	shutdown_pint_irq,
-	enable_pint_irq,
-	disable_pint_irq,
-	mask_and_ack_pint,
-	end_pint_irq
+	.typename = "PINT-IRQ",
+	.startup = startup_pint_irq,
+	.shutdown = shutdown_pint_irq,
+	.enable = enable_pint_irq,
+	.disable = disable_pint_irq,
+	.ack = mask_and_ack_pint,
+	.end = end_pint_irq
 };
 
 static void disable_pint_irq(unsigned int irq)
diff -urN --exclude='*~' linux-2.6.13-rc2/arch/sh/kernel/cpu/sh4/irq_intc2.c linux-2.6.13-rc2-armirq/arch/sh/kernel/cpu/sh4/irq_intc2.c
--- linux-2.6.13-rc2/arch/sh/kernel/cpu/sh4/irq_intc2.c	2005-07-09 13:04:23.000000000 +0200
+++ linux-2.6.13-rc2-armirq/arch/sh/kernel/cpu/sh4/irq_intc2.c	2005-07-09 13:10:42.000000000 +0200
@@ -48,13 +48,13 @@
 }
 
 static struct hw_interrupt_type intc2_irq_type = {
-	"INTC2-IRQ",
-	startup_intc2_irq,
-	shutdown_intc2_irq,
-	enable_intc2_irq,
-	disable_intc2_irq,
-	mask_and_ack_intc2,
-	end_intc2_irq
+	.typename = "INTC2-IRQ",
+	.startup = startup_intc2_irq,
+	.shutdown = shutdown_intc2_irq,
+	.enable = enable_intc2_irq,
+	.disable = disable_intc2_irq,
+	.ack = mask_and_ack_intc2,
+	.end = end_intc2_irq
 };
 
 static void disable_intc2_irq(unsigned int irq)
