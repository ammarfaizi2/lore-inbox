Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVAYKZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVAYKZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 05:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVAYKZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 05:25:21 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:10205 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261879AbVAYKZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 05:25:15 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 25 Jan 2005 11:20:36 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>
Cc: Christoph Bartelmus <lirc@bartelmus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] add i2c adapter id for the cx88 driver.
Message-ID: <20050125102036.GA1696@bytesex>
References: <9PM$6kT6B9B@bartelmus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9PM$6kT6B9B@bartelmus.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

$subject says all.  Please apply,

  Gerd

Index: linux-2.6.11-rc2/include/linux/i2c-id.h
===================================================================
--- linux-2.6.11-rc2.orig/include/linux/i2c-id.h	2005-01-24 09:11:12.000000000 +0100
+++ linux-2.6.11-rc2/include/linux/i2c-id.h	2005-01-24 15:09:14.000000000 +0100
@@ -239,6 +239,7 @@
 #define I2C_HW_B_IXP4XX 0x17	/* GPIO on IXP4XX systems		*/
 #define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
 #define I2C_HW_B_ZR36067 0x19	/* Zoran-36057/36067 based boards	*/
+#define I2C_HW_B_CX2388x 0x1a	/* connexant 2388x based tv cards	*/
 
 /* --- PCF 8584 based algorithms					*/
 #define I2C_HW_P_LP	0x00	/* Parallel port interface		*/
Index: linux-2.6.11-rc2/drivers/media/video/cx88/cx88-i2c.c
===================================================================
--- linux-2.6.11-rc2.orig/drivers/media/video/cx88/cx88-i2c.c	2005-01-24 14:54:35.000000000 +0100
+++ linux-2.6.11-rc2/drivers/media/video/cx88/cx88-i2c.c	2005-01-24 15:09:41.000000000 +0100
@@ -135,7 +135,7 @@ static struct i2c_algo_bit_data cx8800_i
 static struct i2c_adapter cx8800_i2c_adap_template = {
 	I2C_DEVNAME("cx2388x"),
 	.owner             = THIS_MODULE,
-	.id                = I2C_HW_B_BT848,
+	.id                = I2C_HW_B_CX2388x,
 	.client_register   = attach_inform,
 	.client_unregister = detach_inform,
 };
