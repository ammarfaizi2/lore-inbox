Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132479AbRANMQo>; Sun, 14 Jan 2001 07:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbRANMQe>; Sun, 14 Jan 2001 07:16:34 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:59250
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132479AbRANMQR>; Sun, 14 Jan 2001 07:16:17 -0500
Date: Sun, 14 Jan 2001 13:16:09 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/yellowfin.c zero initialization cleanup (2.4.0p3)
Message-ID: <20010114131609.A604@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following trivial patch cleans up some unneeded zero initializations in
drivers/net/yellowfix.c. Applies cleanly against 2.4.0p3 and with a bit of
fuzz against ac9 too.


--- linux-240-t12-pre8-clean/drivers/net/yellowfin.c	Sat May 13 17:19:21 2000
+++ linux/drivers/net/yellowfin.c	Tue Dec 12 21:17:32 2000
@@ -24,10 +24,10 @@
 
 static int debug = 1;
 static int max_interrupt_work = 20;
-static int mtu = 0;
+static int mtu;
 #ifdef YF_PROTOTYPE			/* Support for prototype hardware errata. */
 /* System-wide count of bogus-rx frames. */
-static int bogus_rx = 0;
+static int bogus_rx;
 static int dma_ctrl = 0x004A0263; 			/* Constrained by errata */
 static int fifo_cfg = 0x0020;				/* Bypass external Tx FIFO. */
 #elif YF_NEW					/* A future perfect board :->.  */
@@ -40,7 +40,7 @@
 
 /* Set the copy breakpoint for the copy-only-tiny-frames scheme.
    Setting to > 1514 effectively disables this feature. */
-static int rx_copybreak = 0;
+static int rx_copybreak;
 
 /* Used to pass the media type, etc.
    No media types are currently defined.  These exist for driver
@@ -51,7 +51,7 @@
 static int full_duplex[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 
 /* Do ugly workaround for GX server chipset errata. */
-static int gx_fix = 0;
+static int gx_fix;
 
 /* Operational parameters that are set at compile time. */
 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Question: If you could live forever, would you and why?  
Answer: I would not live forever, because we should not live forever,
because if we were supposed to live forever, then we would live forever,
but we cannot live forever, which is why I would not live forever.  
-Miss Alabama in the 1994 Miss Universe contest
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
