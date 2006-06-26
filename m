Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWFZU4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWFZU4X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWFZU4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:56:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58637 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932117AbWFZU4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:56:22 -0400
Date: Mon, 26 Jun 2006 22:56:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] typo fixes: bandwith -> bandwidth
Message-ID: <20060626205618.GC23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

 arch/cris/arch-v32/kernel/arbiter.c               |    8 ++++----
 arch/cris/arch-v32/kernel/dma.c                   |    4 ++--
 drivers/media/common/saa7146_hlp.c                |    2 +-
 drivers/media/dvb/frontends/lgdt330x.c            |    2 +-
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    2 +-
 drivers/net/skfp/h/sba.h                          |    2 +-
 drivers/video/sis/init301.c                       |    4 ++--
 include/asm-cris/arch-v32/arbiter.h               |    4 ++--
 8 files changed, 14 insertions(+), 14 deletions(-)

--- linux-2.6.17-mm2-full/arch/cris/arch-v32/kernel/arbiter.c.old	2006-06-26 22:21:10.000000000 +0200
+++ linux-2.6.17-mm2-full/arch/cris/arch-v32/kernel/arbiter.c	2006-06-26 22:24:09.000000000 +0200
@@ -1,9 +1,9 @@
 /*
- * Memory arbiter functions. Allocates bandwith through the
+ * Memory arbiter functions. Allocates bandwidth through the
  * arbiter and sets up arbiter breakpoints.
  *
  * The algorithm first assigns slots to the clients that has specified
- * bandwith (e.g. ethernet) and then the remaining slots are divided
+ * bandwidth (e.g. ethernet) and then the remaining slots are divided
  * on all the active clients.
  *
  * Copyright (c) 2004, 2005 Axis Communications AB.
@@ -133,8 +133,8 @@
 
 
 
-int crisv32_arbiter_allocate_bandwith(int client, int region,
-	                              unsigned long bandwidth)
+int crisv32_arbiter_allocate_bandwidth(int client, int region,
+				       unsigned long bandwidth)
 {
 	int i;
 	int total_assigned = 0;
--- linux-2.6.17-mm2-full/arch/cris/arch-v32/kernel/dma.c.old	2006-06-26 22:21:46.000000000 +0200
+++ linux-2.6.17-mm2-full/arch/cris/arch-v32/kernel/dma.c	2006-06-26 22:24:51.000000000 +0200
@@ -25,8 +25,8 @@
 	reg_config_rw_clk_ctrl clk_ctrl;
 	reg_strmux_rw_cfg strmux_cfg;
 
-        if (crisv32_arbiter_allocate_bandwith(dmanr,
-                                              options & DMA_INT_MEM ? INT_REGION : EXT_REGION,
+        if (crisv32_arbiter_allocate_bandwidth(dmanr,
+					       options & DMA_INT_MEM ? INT_REGION : EXT_REGION,
                                               bandwidth))
           return -ENOMEM;
 
--- linux-2.6.17-mm2-full/drivers/media/common/saa7146_hlp.c.old	2006-06-26 22:22:06.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/media/common/saa7146_hlp.c	2006-06-26 22:22:10.000000000 +0200
@@ -158,7 +158,7 @@
 	}
 
 	/* the horizontal scaling increment controls the UV filter
-	   to reduce the bandwith to improve the display quality,
+	   to reduce the bandwidth to improve the display quality,
 	   so set it ... */
 	if ( xsci == 0x400)
 		pfuv = 0x00;
--- linux-2.6.17-mm2-full/drivers/media/dvb/frontends/lgdt330x.c.old	2006-06-26 22:22:21.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/media/dvb/frontends/lgdt330x.c	2006-06-26 22:22:28.000000000 +0200
@@ -216,7 +216,7 @@
 		AGC_DELAY0, 0x07,
 		AGC_DELAY2, 0xfe,
 		/* Change the value of IAGCBW[15:8]
-		   of inner AGC loop filter bandwith */
+		   of inner AGC loop filter bandwidth */
 		AGC_LOOP_BANDWIDTH0, 0x08,
 		AGC_LOOP_BANDWIDTH1, 0x9a
 	};
--- linux-2.6.17-mm2-full/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c.old	2006-06-26 22:22:35.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2006-06-26 22:22:39.000000000 +0200
@@ -43,7 +43,7 @@
     is a bit braindead (no matching channel masks or no matching filter mask),
     we won't support this - yet. it doesn't event support negative filters,
     so the best way is maybe to keep TTUSB_HWSECTIONS undef'd and just
-    parse TS data. USB bandwith will be a problem when having large
+    parse TS data. USB bandwidth will be a problem when having large
     datastreams, especially for dvb-net, but hey, that's not my problem.
 
   TTUSB_DISEQC, TTUSB_TONE:
--- linux-2.6.17-mm2-full/drivers/net/skfp/h/sba.h.old	2006-06-26 22:22:48.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/net/skfp/h/sba.h	2006-06-26 22:23:01.000000000 +0200
@@ -13,7 +13,7 @@
  ******************************************************************************/
 
 /*
- * Synchronous Bandwith Allocation (SBA) structs
+ * Synchronous Bandwidth Allocation (SBA) structs
  */
  
 #ifndef _SBA_
--- linux-2.6.17-mm2-full/drivers/video/sis/init301.c.old	2006-06-26 22:23:11.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/video/sis/init301.c	2006-06-26 22:23:16.000000000 +0200
@@ -8043,8 +8043,8 @@
       SiS_SetCH700x(SiS_Pr,0x01,0x28);
 
       /* Set video bandwidth
-            High bandwith Luma composite video filter(S0=1)
-            low bandwith Luma S-video filter (S2-1=00)
+            High bandwidth Luma composite video filter(S0=1)
+            low bandwidth Luma S-video filter (S2-1=00)
 	    disable peak filter in S-video channel (S3=0)
 	    high bandwidth Chroma Filter (S5-4=11)
 	    =00110001=0x31
--- linux-2.6.17-mm2-full/include/asm-cris/arch-v32/arbiter.h.old	2006-06-26 22:23:24.000000000 +0200
+++ linux-2.6.17-mm2-full/include/asm-cris/arch-v32/arbiter.h	2006-06-26 22:23:54.000000000 +0200
@@ -20,8 +20,8 @@
   arbiter_all_accesses = 0xff
 };
 
-int crisv32_arbiter_allocate_bandwith(int client, int region,
-                                      unsigned long bandwidth);
+int crisv32_arbiter_allocate_bandwidth(int client, int region,
+				       unsigned long bandwidth);
 int crisv32_arbiter_watch(unsigned long start, unsigned long size,
                           unsigned long clients, unsigned long accesses,
                           watch_callback* cb);

