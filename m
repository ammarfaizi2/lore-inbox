Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbTBGRAs>; Fri, 7 Feb 2003 12:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbTBGRAs>; Fri, 7 Feb 2003 12:00:48 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:37599 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266643AbTBGRAq>; Fri, 7 Feb 2003 12:00:46 -0500
Date: Fri, 7 Feb 2003 12:19:51 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59 : drivers/char/ite_gpio.c
Message-ID: <Pine.LNX.4.44.0302071217520.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 321, and removes a double 
logical issue. Please review for inclusion.

Regards,
Frank


--- linux/drivers/char/ite_gpio.c.old	2003-01-16 21:22:23.000000000 -0500
+++ linux/drivers/char/ite_gpio.c	2003-02-07 02:04:43.000000000 -0500
@@ -140,7 +140,7 @@
 {
 	int ret=-1;
 
-	if (MAX_GPIO_LINE > *data >= 0) 
+	if ((MAX_GPIO_LINE > *data) && (*data >= 0)) 
 		ret=ite_gpio_irq_pending[*data];
  
 	DEB(printk("ite_gpio_in_status %d ret=%d\n",*data, ret));

