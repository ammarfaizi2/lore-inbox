Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268116AbTAKTgL>; Sat, 11 Jan 2003 14:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268130AbTAKTgK>; Sat, 11 Jan 2003 14:36:10 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:58066 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268116AbTAKTgE>; Sat, 11 Jan 2003 14:36:04 -0500
Date: Sat, 11 Jan 2003 20:44:43 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove kernel 2.0 #if's from aironet4500
Message-ID: <20030111194443.GC21826@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the trivial patch below removes two #if's for kernel 2.0.

I've tested the compilation with 2.5.56.

Please apply
Adrian

--- linux-2.5.56/drivers/net/aironet4500_core.c.old	2003-01-11 20:38:05.000000000 +0100
+++ linux-2.5.56/drivers/net/aironet4500_core.c	2003-01-11 20:39:24.000000000 +0100
@@ -2561,8 +2561,6 @@
 int awc_simple_bridge;
 // int debug =0;
 
-#if LINUX_VERSION_CODE >= 0x20100
-
 MODULE_PARM(awc_debug,"i");
 MODULE_PARM(tx_rate,"i");
 MODULE_PARM(channel,"i");
@@ -2581,7 +2579,7 @@
 MODULE_PARM_DESC(master,"Aironet is Adhoc master (creates network sync) (0-1)");
 MODULE_PARM_DESC(slave,"Aironet is Adhoc slave (0-1)");
 MODULE_PARM_DESC(max_mtu,"Aironet MTU limit (256-2312)");
-#endif
+
 MODULE_LICENSE("GPL");
 
 
--- linux-2.5.56/drivers/net/pcmcia/aironet4500_cs.c.old	2003-01-11 20:39:11.000000000 +0100
+++ linux-2.5.56/drivers/net/pcmcia/aironet4500_cs.c	2003-01-11 20:39:38.000000000 +0100
@@ -50,10 +50,8 @@
 
 static u_int irq_mask = 0x5eF8;
 static int 	awc_ports[] = {0x140,0x100,0xc0, 0x80 };
-#if LINUX_VERSION_CODE > 0x20100
-MODULE_PARM(irq_mask, "i");
 
-#endif
+MODULE_PARM(irq_mask, "i");
 
 
 #define RUN_AT(x)               (jiffies+(x))

