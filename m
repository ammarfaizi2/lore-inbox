Return-Path: <linux-kernel-owner+w=401wt.eu-S932879AbWLSS0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879AbWLSS0a (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 13:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932881AbWLSS0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 13:26:30 -0500
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:51245 "EHLO
	aeryn.fluff.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932879AbWLSS0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 13:26:30 -0500
Date: Tue, 19 Dec 2006 18:26:08 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: spi-devel-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fix s3c24xx gpio driver (include linux/workqueue.h)
Message-ID: <20061219182608.GA7895@home.fluff.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The general gpio driver includes seem to
now depend on having <linux/workqueue.h>
included before they are.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urpN -X ../dontdiff linux-2.6.20-rc1/drivers/spi/spi_s3c24xx_gpio.c linux-2.6.20-rc1-tes2/drivers/spi/spi_s3c24xx_gpio.c
--- linux-2.6.20-rc1/drivers/spi/spi_s3c24xx_gpio.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.20-rc1-tes2/drivers/spi/spi_s3c24xx_gpio.c	2006-12-19 18:20:26.000000000 +0000
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 #include <linux/platform_device.h>
 
 #include <linux/spi/spi.h>

--cNdxnHkX5QqsyA0e
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="2620-rc1-s3c24xx-spi-workqueue.patch"

diff -urpN -X ../dontdiff linux-2.6.20-rc1/drivers/spi/spi_s3c24xx_gpio.c linux-2.6.20-rc1-tes2/drivers/spi/spi_s3c24xx_gpio.c
--- linux-2.6.20-rc1/drivers/spi/spi_s3c24xx_gpio.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.20-rc1-tes2/drivers/spi/spi_s3c24xx_gpio.c	2006-12-19 18:20:26.000000000 +0000
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 #include <linux/platform_device.h>
 
 #include <linux/spi/spi.h>

--cNdxnHkX5QqsyA0e--
