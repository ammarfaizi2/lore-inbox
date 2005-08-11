Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVHKVwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVHKVwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVHKVwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:52:04 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:62733 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932262AbVHKVwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:52:02 -0400
Date: Thu, 11 Aug 2005 23:52:35 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] (7/7) I2C: Kill i2c_algorithm.id
Message-Id: <20050811235235.2fdecf8b.khali@linux-fr.org>
In-Reply-To: <20050811231828.3e7f5837.khali@linux-fr.org>
References: <20050811231828.3e7f5837.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C_ALGO_* constants have no more users, delete them. Also update
the comments in i2c-id.h so that they reflect the current state of the
file.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 include/linux/i2c-id.h |   57 -------------------------------------------------
 1 files changed, 1 insertion(+), 56 deletions(-)

--- linux-2.6.13-rc5.orig/include/linux/i2c-id.h	2005-08-03 20:04:58.000000000 +0200
+++ linux-2.6.13-rc5/include/linux/i2c-id.h	2005-08-03 20:25:27.000000000 +0200
@@ -1,6 +1,6 @@
 /* ------------------------------------------------------------------------- */
 /* 									     */
-/* i2c.h - definitions for the i2c-bus interface			     */
+/* i2c-id.h - identifier values for i2c drivers and adapters		     */
 /* 									     */
 /* ------------------------------------------------------------------------- */
 /*   Copyright (C) 1995-1999 Simon G. Vogl
@@ -24,16 +24,6 @@
 #define LINUX_I2C_ID_H
 
 /*
- * This file is part of the i2c-bus package and contains the identifier
- * values for drivers, adapters and other folk populating these serial
- * worlds. 
- *
- * These will change often (i.e. additions) , therefore this has been 
- * separated from the functional interface definitions of the i2c api.
- *
- */
-
-/*
  * ---- Driver types -----------------------------------------------------
  *       device id name + number        function description, i2c address(es)
  *
@@ -170,51 +160,6 @@
 
 /*
  * ---- Adapter types ----------------------------------------------------
- *
- * First, we distinguish between several algorithms to access the hardware
- * interface types, as a PCF 8584 needs other care than a bit adapter.
- */
-
-#define I2C_ALGO_NONE	0x000000
-#define I2C_ALGO_BIT	0x010000	/* bit style adapters		*/
-#define I2C_ALGO_PCF	0x020000	/* PCF 8584 style adapters	*/
-#define I2C_ALGO_ATI	0x030000	/* ATI video card		*/
-#define I2C_ALGO_SMBUS	0x040000
-#define I2C_ALGO_ISA 	0x050000	/* lm_sensors ISA pseudo-adapter */
-#define I2C_ALGO_SAA7146 0x060000	/* SAA 7146 video decoder bus	*/
-#define I2C_ALGO_ACB 	0x070000	/* ACCESS.bus algorithm         */
-#define I2C_ALGO_IIC    0x080000 	/* ITE IIC bus */
-#define I2C_ALGO_SAA7134 0x090000
-#define I2C_ALGO_MPC824X 0x0a0000	/* Motorola 8240 / 8245         */
-#define I2C_ALGO_IPMI 	0x0b0000	/* IPMI dummy adapter */
-#define I2C_ALGO_IPMB 	0x0c0000	/* IPMB adapter */
-#define I2C_ALGO_MPC107 0x0d0000
-#define I2C_ALGO_EC     0x100000        /* ACPI embedded controller     */
-
-#define I2C_ALGO_MPC8XX 0x110000	/* MPC8xx PowerPC I2C algorithm */
-#define I2C_ALGO_OCP    0x120000	/* IBM or otherwise On-chip I2C algorithm */
-#define I2C_ALGO_BITHS	0x130000	/* enhanced bit style adapters	*/
-#define I2C_ALGO_IOP3XX	0x140000	/* XSCALE IOP3XX On-chip I2C alg */
-#define I2C_ALGO_SIBYTE 0x150000	/* Broadcom SiByte SOCs		*/
-#define I2C_ALGO_SGI	0x160000	/* SGI algorithm		*/
-
-#define I2C_ALGO_USB	0x170000	/* USB algorithm		*/
-#define I2C_ALGO_VIRT	0x180000	/* Virtual bus adapter		*/
-
-#define I2C_ALGO_MV64XXX 0x190000	/* Marvell mv64xxx i2c ctlr	*/
-#define I2C_ALGO_PCA	0x1a0000	/* PCA 9564 style adapters	*/
-#define I2C_ALGO_AU1550	0x1b0000        /* Au1550 PSC algorithm		*/
-
-#define I2C_ALGO_EXP	0x800000	/* experimental			*/
-
-#define I2C_ALGO_MASK	0xff0000	/* Mask for algorithms		*/
-#define I2C_ALGO_SHIFT	0x10	/* right shift to get index values 	*/
-
-#define I2C_HW_ADAPS	0x10000		/* # adapter types		*/
-#define I2C_HW_MASK	0xffff		
-
-
-/* hw specific modules that are defined per algorithm layer
  */
 
 /* --- Bit algorithm adapters 						*/

-- 
Jean Delvare
