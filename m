Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263844AbTIEVnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbTIEVnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:43:43 -0400
Received: from palrel11.hp.com ([156.153.255.246]:46485 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263844AbTIEVmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:42:46 -0400
Date: Fri, 5 Sep 2003 14:42:45 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] irtty cleanup
Message-ID: <20030905214245.GD14233@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir2604_irtty_cleanup-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Finish removing traces of old irtty driver


diff -u -p linux/net/irda/timer.d2.c linux/net/irda/timer.c
--- linux/net/irda/timer.d2.c	Thu Sep  4 15:48:59 2003
+++ linux/net/irda/timer.c	Thu Sep  4 15:50:04 2003
@@ -30,7 +30,7 @@
 
 #include <net/irda/timer.h>
 #include <net/irda/irda.h>
-#include <net/irda/irtty.h>
+#include <net/irda/irda_device.h>
 #include <net/irda/irlap.h>
 #include <net/irda/irlmp.h>
 
diff -u -p linux/net/irda/wrapper.d2.c linux/net/irda/wrapper.c
--- linux/net/irda/wrapper.d2.c	Thu Sep  4 15:50:30 2003
+++ linux/net/irda/wrapper.c	Thu Sep  4 15:50:47 2003
@@ -32,7 +32,6 @@
 
 #include <net/irda/irda.h>
 #include <net/irda/wrapper.h>
-#include <net/irda/irtty.h>
 #include <net/irda/crc.h>
 #include <net/irda/irlap.h>
 #include <net/irda/irlap_frame.h>
diff -u -p linux/drivers/net/irda/act200l.d2.c linux/drivers/net/irda/act200l.c
--- linux/drivers/net/irda/act200l.d2.c	Thu Sep  4 15:42:24 2003
+++ linux/drivers/net/irda/act200l.c	Thu Sep  4 15:42:55 2003
@@ -25,7 +25,6 @@
 
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
-#include <net/irda/irtty.h>
 
 static int  act200l_reset(struct irda_task *task);
 static void act200l_open(dongle_t *self, struct qos_info *qos);
diff -u -p linux/drivers/net/irda/girbil.d2.c linux/drivers/net/irda/girbil.c
--- linux/drivers/net/irda/girbil.d2.c	Thu Sep  4 15:41:36 2003
+++ linux/drivers/net/irda/girbil.c	Thu Sep  4 15:41:47 2003
@@ -29,7 +29,6 @@
 
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
-#include <net/irda/irtty.h>
 
 static int  girbil_reset(struct irda_task *task);
 static void girbil_open(dongle_t *self, struct qos_info *qos);
diff -u -p linux/drivers/net/irda/ma600.d2.c linux/drivers/net/irda/ma600.c
--- linux/drivers/net/irda/ma600.d2.c	Thu Sep  4 15:42:32 2003
+++ linux/drivers/net/irda/ma600.c	Thu Sep  4 15:42:44 2003
@@ -41,7 +41,6 @@
 
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
-#include <net/irda/irtty.h>
 
 #ifndef NDEBUG
 	#undef IRDA_DEBUG
diff -u -p linux/drivers/net/irda/mcp2120.d2.c linux/drivers/net/irda/mcp2120.c
--- linux/drivers/net/irda/mcp2120.d2.c	Thu Sep  4 15:42:17 2003
+++ linux/drivers/net/irda/mcp2120.c	Thu Sep  4 15:43:08 2003
@@ -25,7 +25,6 @@
 
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
-#include <net/irda/irtty.h>
 
 static int  mcp2120_reset(struct irda_task *task);
 static void mcp2120_open(dongle_t *self, struct qos_info *qos);
diff -u -p linux/drivers/net/irda/tekram.d2.c linux/drivers/net/irda/tekram.c
--- linux/drivers/net/irda/tekram.d2.c	Thu Sep  4 15:40:55 2003
+++ linux/drivers/net/irda/tekram.c	Thu Sep  4 15:41:05 2003
@@ -29,7 +29,6 @@
 
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
-#include <net/irda/irtty.h>
 
 static void tekram_open(dongle_t *self, struct qos_info *qos);
 static void tekram_close(dongle_t *self);
diff -u -p --new-file linux/include/net/irda.d2/irtty.h linux/include/net/irda/irtty.h
--- linux/include/net/irda.d2/irtty.h	Tue Sep  2 19:01:23 2003
+++ linux/include/net/irda/irtty.h	Wed Dec 31 16:00:00 1969
@@ -1,80 +0,0 @@
-/*********************************************************************
- *                
- * Filename:      irtty.h
- * Version:       1.0
- * Description:   
- * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
- * Created at:    Tue Dec  9 21:13:12 1997
- * Modified at:   Tue Jan 25 09:10:18 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
- *  
- *     Copyright (c) 1997, 1999-2000 Dag Brattli, All Rights Reserved.
- *      
- *     This program is free software; you can redistribute it and/or 
- *     modify it under the terms of the GNU General Public License as 
- *     published by the Free Software Foundation; either version 2 of 
- *     the License, or (at your option) any later version.
- *  
- *     Neither Dag Brattli nor University of Tromsø admit liability nor
- *     provide warranty for any of this software. This material is 
- *     provided "AS-IS" and at no charge.
- *     
- ********************************************************************/
-
-#ifndef IRTTY_H
-#define IRTTY_H
-
-#include <linux/if.h>
-#include <linux/skbuff.h>
-#include <linux/termios.h>
-#include <linux/netdevice.h>
-
-#include <net/irda/irda.h>
-#include <net/irda/irda_device.h>
-
-/* Used by ioctl */
-struct irtty_info {
-	char name[6];
-};
-
-#define IRTTY_IOC_MAGIC 'e'
-#define IRTTY_IOCTDONGLE  _IO(IRTTY_IOC_MAGIC, 1)
-#define IRTTY_IOCGET     _IOR(IRTTY_IOC_MAGIC, 2, struct irtty_info)
-#define IRTTY_IOC_MAXNR   2
-
-struct irtty_cb {
-	magic_t magic;
-
-	struct net_device *netdev; /* Yes! we are some kind of netdevice */
-	struct irda_task *task;
-	struct net_device_stats stats;
-
-	struct tty_struct  *tty;
-	struct irlap_cb    *irlap; /* The link layer we are binded to */
-
-	chipio_t io;               /* IrDA controller information */
-	iobuff_t tx_buff;          /* Transmit buffer */
-	iobuff_t rx_buff;          /* Receive buffer */
-
-	struct qos_info qos;       /* QoS capabilities for this device */
-	dongle_t *dongle;          /* Dongle driver */
-
-
-	spinlock_t lock;           /* For serializing operations */
-
-	__u32 new_speed;
- 	__u32 flags;               /* Interface flags */
-
-	INFRARED_MODE mode;
-};
- 
-int irtty_register_dongle(struct dongle_reg *dongle);
-void irtty_unregister_dongle(struct dongle_reg *dongle);
-
-#endif
-
-
-
-
-
