Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTHTIDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbTHTIC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:02:59 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:36045 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261764AbTHTIBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:01:18 -0400
Date: Wed, 20 Aug 2003 18:02:26 +1000
Message-Id: <200308200802.h7K82QqU011702@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 8/16] C99: 2.6.0-t3-bk7/arch/mips
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/arch/mips/au1000/common/dma.c linux/arch/mips/au1000/common/dma.c
--- linux.backup/arch/mips/au1000/common/dma.c	Mon Jul 21 23:34:51 2003
+++ linux/arch/mips/au1000/common/dma.c	Wed Aug 20 16:40:22 2003
@@ -62,14 +62,14 @@
 spinlock_t au1000_dma_spin_lock = SPIN_LOCK_UNLOCKED;
 
 struct dma_chan au1000_dma_table[NUM_AU1000_DMA_CHANNELS] = {
-      {dev_id:-1,},
-      {dev_id:-1,},
-      {dev_id:-1,},
-      {dev_id:-1,},
-      {dev_id:-1,},
-      {dev_id:-1,},
-      {dev_id:-1,},
-      {dev_id:-1,}
+      {.dev_id = -1,},
+      {.dev_id = -1,},
+      {.dev_id = -1,},
+      {.dev_id = -1,},
+      {.dev_id = -1,},
+      {.dev_id = -1,},
+      {.dev_id = -1,},
+      {.dev_id = -1,}
 };
 
 // Device FIFO addresses and default DMA modes
diff -aur linux.backup/arch/mips/sibyte/cfe/console.c linux/arch/mips/sibyte/cfe/console.c
--- linux.backup/arch/mips/sibyte/cfe/console.c	Sat Aug 16 15:02:40 2003
+++ linux/arch/mips/sibyte/cfe/console.c	Wed Aug 20 16:40:22 2003
@@ -74,12 +74,12 @@
 }
 
 static struct console sb1250_cfe_cons = {
-	name:		"cfe",
-	write:		cfe_console_write,
-	device:		cfe_console_device,
-	setup:		cfe_console_setup,
-	flags:		CON_PRINTBUFFER,
-	index:		-1,
+	.name		= "cfe",
+	.write		= cfe_console_write,
+	.device		= cfe_console_device,
+	.setup		= cfe_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 };
 
 static int __init sb1250_cfe_console_init(void)
diff -aur linux.backup/arch/mips/tx4927/common/tx4927_irq.c linux/arch/mips/tx4927/common/tx4927_irq.c
--- linux.backup/arch/mips/tx4927/common/tx4927_irq.c	Mon Jul 21 23:34:53 2003
+++ linux/arch/mips/tx4927/common/tx4927_irq.c	Wed Aug 20 16:40:22 2003
@@ -149,26 +149,26 @@
 
 #define TX4927_CP0_NAME "TX4927-CP0"
 static struct hw_interrupt_type tx4927_irq_cp0_type = {
-	typename:	TX4927_CP0_NAME,
-	startup:	tx4927_irq_cp0_startup,
-	shutdown:	tx4927_irq_cp0_shutdown,
-	enable:		tx4927_irq_cp0_enable,
-	disable:	tx4927_irq_cp0_disable,
-	ack:		tx4927_irq_cp0_mask_and_ack,
-	end:		tx4927_irq_cp0_end,
-	set_affinity:	NULL
+	.typename	= TX4927_CP0_NAME,
+	.startup	= tx4927_irq_cp0_startup,
+	.shutdown	= tx4927_irq_cp0_shutdown,
+	.enable		= tx4927_irq_cp0_enable,
+	.disable	= tx4927_irq_cp0_disable,
+	.ack		= tx4927_irq_cp0_mask_and_ack,
+	.end		= tx4927_irq_cp0_end,
+	.set_affinity	= NULL
 };
 
 #define TX4927_PIC_NAME "TX4927-PIC"
 static struct hw_interrupt_type tx4927_irq_pic_type = {
-	typename:	TX4927_PIC_NAME,
-	startup:	tx4927_irq_pic_startup,
-	shutdown:	tx4927_irq_pic_shutdown,
-	enable:		tx4927_irq_pic_enable,
-	disable:	tx4927_irq_pic_disable,
-	ack:		tx4927_irq_pic_mask_and_ack,
-	end:		tx4927_irq_pic_end,
-	set_affinity:	NULL
+	.typename	= TX4927_PIC_NAME,
+	.startup	= tx4927_irq_pic_startup,
+	.shutdown	= tx4927_irq_pic_shutdown,
+	.enable		= tx4927_irq_pic_enable,
+	.disable	= tx4927_irq_pic_disable,
+	.ack		= tx4927_irq_pic_mask_and_ack,
+	.end		= tx4927_irq_pic_end,
+	.set_affinity	= NULL
 };
 
 #define TX4927_PIC_ACTION(s) { no_action, 0, 0, s, NULL, NULL }
diff -aur linux.backup/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
--- linux.backup/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	Sat Aug 16 15:02:17 2003
+++ linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	Wed Aug 20 16:40:22 2003
@@ -255,14 +255,14 @@
 
 #define TOSHIBA_RBTX4927_IOC_NAME "RBTX4927-IOC"
 static struct hw_interrupt_type toshiba_rbtx4927_irq_ioc_type = {
-	typename:TOSHIBA_RBTX4927_IOC_NAME,
-	startup:toshiba_rbtx4927_irq_ioc_startup,
-	shutdown:toshiba_rbtx4927_irq_ioc_shutdown,
-	enable:toshiba_rbtx4927_irq_ioc_enable,
-	disable:toshiba_rbtx4927_irq_ioc_disable,
-	ack:toshiba_rbtx4927_irq_ioc_mask_and_ack,
-	end:toshiba_rbtx4927_irq_ioc_end,
-	set_affinity:NULL
+	.typename = TOSHIBA_RBTX4927_IOC_NAME,
+	.startup = toshiba_rbtx4927_irq_ioc_startup,
+	.shutdown = toshiba_rbtx4927_irq_ioc_shutdown,
+	.enable = toshiba_rbtx4927_irq_ioc_enable,
+	.disable = toshiba_rbtx4927_irq_ioc_disable,
+	.ack = toshiba_rbtx4927_irq_ioc_mask_and_ack,
+	.end = toshiba_rbtx4927_irq_ioc_end,
+	.set_affinity = NULL
 };
 #define TOSHIBA_RBTX4927_IOC_INTR_ENAB 0xbc002000
 #define TOSHIBA_RBTX4927_IOC_INTR_STAT 0xbc002006
@@ -271,14 +271,14 @@
 #ifdef CONFIG_TOSHIBA_FPCIB0
 #define TOSHIBA_RBTX4927_ISA_NAME "RBTX4927-ISA"
 static struct hw_interrupt_type toshiba_rbtx4927_irq_isa_type = {
-	typename:TOSHIBA_RBTX4927_ISA_NAME,
-	startup:toshiba_rbtx4927_irq_isa_startup,
-	shutdown:toshiba_rbtx4927_irq_isa_shutdown,
-	enable:toshiba_rbtx4927_irq_isa_enable,
-	disable:toshiba_rbtx4927_irq_isa_disable,
-	ack:toshiba_rbtx4927_irq_isa_mask_and_ack,
-	end:toshiba_rbtx4927_irq_isa_end,
-	set_affinity:NULL
+	.typename = TOSHIBA_RBTX4927_ISA_NAME,
+	.startup = toshiba_rbtx4927_irq_isa_startup,
+	.shutdown = toshiba_rbtx4927_irq_isa_shutdown,
+	.enable = toshiba_rbtx4927_irq_isa_enable,
+	.disable = toshiba_rbtx4927_irq_isa_disable,
+	.ack = toshiba_rbtx4927_irq_isa_mask_and_ack,
+	.end = toshiba_rbtx4927_irq_isa_end,
+	.set_affinity = NULL
 };
 #endif
 
diff -aur linux.backup/arch/mips/vr41xx/common/vrc4173.c linux/arch/mips/vr41xx/common/vrc4173.c
--- linux.backup/arch/mips/vr41xx/common/vrc4173.c	Sat Aug 16 15:02:40 2003
+++ linux/arch/mips/vr41xx/common/vrc4173.c	Wed Aug 20 16:40:22 2003
@@ -250,10 +250,10 @@
 }
 
 static struct pci_driver vrc4173_driver = {
-	name:		"NEC VRC4173",
-	probe:		vrc4173_probe,
-	remove:		NULL,
-	id_table:	vrc4173_table,
+	.name		= "NEC VRC4173",
+	.probe		= vrc4173_probe,
+	.remove		= NULL,
+	.id_table	= vrc4173_table,
 };
 
 static int __devinit vrc4173_init(void)
