Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUKIFyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUKIFyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbUKIFxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:53:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:7839 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261395AbUKIFZE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:25:04 -0500
Subject: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <20041109052229.GA5117@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:14 -0800
Message-Id: <10999778541107@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.1, 2004/10/22 12:51:52-07:00, ben@fluff.org

[PATCH] I2C: Fix compile of drivers/i2c/busses/i2c-s3c2410.c

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-s3c2410.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
--- a/drivers/i2c/busses/i2c-s3c2410.c	2004-11-08 18:56:26 -08:00
+++ b/drivers/i2c/busses/i2c-s3c2410.c	2004-11-08 18:56:26 -08:00
@@ -36,6 +36,7 @@
 
 #include <asm/hardware.h>
 #include <asm/irq.h>
+#include <asm/io.h>
 
 #include <asm/hardware/clock.h>
 #include <asm/arch/regs-gpio.h>
@@ -534,7 +535,6 @@
 
 static struct i2c_algorithm s3c24xx_i2c_algorithm = {
 	.name			= "S3C2410-I2C-Algorithm",
-	.id			= I2C_ALGO_S3C2410,
 	.master_xfer		= s3c24xx_i2c_xfer,
 };
 
@@ -543,7 +543,6 @@
 	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER(s3c24xx_i2c.wait),
 	.adap	= {
 		.name			= "s3c2410-i2c",
-		.id			= I2C_ALGO_S3C2410,
 		.algo			= &s3c24xx_i2c_algorithm,
 		.retries		= 2,
 	},

