Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUHYJPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUHYJPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHYJOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:14:55 -0400
Received: from [212.209.10.220] ([212.209.10.220]:34013 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264246AbUHYJNv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:13:51 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6 [PATCH 4/6] CRIS architecture update
Date: Wed, 25 Aug 2004 11:13:49 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F517@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains changes related to drivers

diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/arch-v10/drivers/i2c.c
lx25/arch/cris/arch-v10/drivers/i2c.c
--- ../linux/arch/cris/arch-v10/drivers/i2c.c	Sat Aug 14 07:36:14 2004
+++ lx25/arch/cris/arch-v10/drivers/i2c.c	Tue Aug 24 08:49:14 2004
@@ -12,6 +12,12 @@
 *!                                 don't use PB_I2C if DS1302 uses same
bits,
 *!                                 use PB.
 *! $Log: i2c.c,v $
+*! Revision 1.9  2004/08/24 06:49:14  starvik
+*! Whitespace cleanup
+*!
+*! Revision 1.8  2004/06/08 08:48:26  starvik
+*! Removed unused code
+*!
 *! Revision 1.7  2004/05/28 09:26:59  starvik
 *! Modified I2C initialization to work in 2.6.
 *!
@@ -69,7 +75,7 @@
 *! (C) Copyright 1999-2002 Axis Communications AB, LUND, SWEDEN
 *!
 
*!**************************************************************************
*/
-/* $Id: i2c.c,v 1.7 2004/05/28 09:26:59 starvik Exp $ */
+/* $Id: i2c.c,v 1.9 2004/08/24 06:49:14 starvik Exp $ */
 
 /****************** INCLUDE FILES SECTION
***********************************/
 
@@ -110,14 +116,6 @@
 #define I2C_DATA_HIGH 1
 #define I2C_DATA_LOW 0
 
-#if 0
-/* TODO: fix this so the CONFIG_ETRAX_I2C_USES... is set in Config.in
instead */
-#if defined(CONFIG_DS1302) && (CONFIG_DS1302_SDABIT==0) && \
-           (CONFIG_DS1302_SCLBIT == 1)
-#define CONFIG_ETRAX_I2C_USES_PB_NOT_PB_I2C
-#endif
-#endif
-
 #ifdef CONFIG_ETRAX_I2C_USES_PB_NOT_PB_I2C
 /* Use PB and not PB_I2C */
 #ifndef CONFIG_ETRAX_I2C_DATA_PORT

