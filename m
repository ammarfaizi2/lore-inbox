Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVCTXKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVCTXKk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVCTXIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:08:41 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:38611 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261343AbVCTXGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:06:33 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050320223840.25305.64661.89766@clementine.local>
In-Reply-To: <20050320223814.25305.52695.65404@clementine.local>
References: <20050320223814.25305.52695.65404@clementine.local>
Subject: [PATCH 5/5] autoparam: various fixes
Date: Mon, 21 Mar 2005 00:06:32 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some module parameter fixes, errors reported by section2text.rb. 

Signed-off-by: Magnus Damm <damm@opensource.se>

diff -urN linux-2.6.12-rc1/drivers/net/8139cp.c linux-2.6.12-rc1-autoparam/drivers/net/8139cp.c
--- linux-2.6.12-rc1/drivers/net/8139cp.c	2005-03-20 18:09:14.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/net/8139cp.c	2005-03-20 22:47:41.504538496 +0100
@@ -94,13 +94,13 @@
 MODULE_LICENSE("GPL");
 
 static int debug = -1;
-MODULE_PARM (debug, "i");
+module_param (debug, int, 0);
 MODULE_PARM_DESC (debug, "8139cp: bitmapped message enable number");
 
 /* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
    The RTL chips use a 64 element hash table based on the Ethernet CRC.  */
 static int multicast_filter_limit = 32;
-MODULE_PARM (multicast_filter_limit, "i");
+module_param (multicast_filter_limit, int, 0);
 MODULE_PARM_DESC (multicast_filter_limit, "8139cp: maximum number of filtered multicast addresses");
 
 #define PFX			DRV_NAME ": "
diff -urN linux-2.6.12-rc1/drivers/net/eepro100.c linux-2.6.12-rc1-autoparam/drivers/net/eepro100.c
--- linux-2.6.12-rc1/drivers/net/eepro100.c	2005-03-20 18:20:16.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/net/eepro100.c	2005-03-20 22:46:12.176118480 +0100
@@ -144,8 +144,8 @@
 MODULE_PARM_DESC(congenb, "Enable congestion control (1)");
 MODULE_PARM_DESC(txfifo, "Tx FIFO threshold in 4 byte units, (0-15)");
 MODULE_PARM_DESC(rxfifo, "Rx FIFO threshold in 4 byte units, (0-15)");
-MODULE_PARM_DESC(txdmaccount, "Tx DMA burst length; 128 - disable (0-128)");
-MODULE_PARM_DESC(rxdmaccount, "Rx DMA burst length; 128 - disable (0-128)");
+MODULE_PARM_DESC(txdmacount, "Tx DMA burst length; 128 - disable (0-128)");
+MODULE_PARM_DESC(rxdmacount, "Rx DMA burst length; 128 - disable (0-128)");
 MODULE_PARM_DESC(rx_copybreak, "copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(max_interrupt_work, "maximum events handled per interrupt");
 MODULE_PARM_DESC(multicast_filter_limit, "maximum number of filtered multicast addresses");
