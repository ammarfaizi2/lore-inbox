Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262616AbRE3Fqb>; Wed, 30 May 2001 01:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbRE3FqW>; Wed, 30 May 2001 01:46:22 -0400
Received: from [203.143.19.4] ([203.143.19.4]:51730 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S262618AbRE3FqQ>;
	Wed, 30 May 2001 01:46:16 -0400
Date: Wed, 30 May 2001 01:28:39 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Robert Siemer <Robert.Siemer@gmx.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] compiler warning fix in aci.c
Message-ID: <Pine.LNX.4.21.0105300125420.424-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following patch fixes a compiler warning in aci.c.

Regards,

Anuradha

----------------------------------
http://www.bee.lk/people/anuradha/


diff -rua linux-2.4.5/drivers/sound/aci.c linux/drivers/sound/aci.c
--- linux-2.4.5/drivers/sound/aci.c	Tue May 29 23:42:11 2001
+++ linux/drivers/sound/aci.c	Wed May 30 01:21:14 2001
@@ -95,18 +95,6 @@
 MODULE_PARM_DESC(wss,"change between ACI/WSS-mixer; use 0 and 1 - untested"
 		 " default: do nothing; for PCM1-pro only");
 
-static void print_bits(unsigned char c)
-{
-	int j;
-	printk(KERN_DEBUG "aci: ");
-
-	for (j=7; j>=0; j--) {
-		printk(KERN_DEBUG "%d", (c >> j) & 0x1);
-	}
-
-	printk(KERN_DEBUG "\n");
-}
-
 /*
  * This busy wait code normally requires less than 15 loops and
  * practically always less than 100 loops on my i486/DX2 66 MHz.

