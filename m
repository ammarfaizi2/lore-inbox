Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263676AbTCUSJV>; Fri, 21 Mar 2003 13:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263662AbTCUSIk>; Fri, 21 Mar 2003 13:08:40 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34435
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263346AbTCUSG6>; Fri, 21 Mar 2003 13:06:58 -0500
Date: Fri, 21 Mar 2003 19:22:12 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211922.h2LJMCGu025717@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix bogus C in ite_gpio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/ite_gpio.c linux-2.5.65-ac2/drivers/char/ite_gpio.c
--- linux-2.5.65/drivers/char/ite_gpio.c	2003-02-10 18:38:45.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/ite_gpio.c	2003-03-06 22:03:51.000000000 +0000
@@ -140,7 +140,7 @@
 {
 	int ret=-1;
 
-	if (MAX_GPIO_LINE > *data >= 0) 
+	if ((MAX_GPIO_LINE > *data) && (*data >= 0)) 
 		ret=ite_gpio_irq_pending[*data];
  
 	DEB(printk("ite_gpio_in_status %d ret=%d\n",*data, ret));
