Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVCVCSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVCVCSh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVCVCRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:17:16 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:60810 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262312AbVCVBet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:34:49 -0500
Message-Id: <20050322013456.060429000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:46 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibcom-dev-naming.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 13/48] dib3000: corrected device naming
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

corrected device naming (Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 Kconfig          |    4 ++--
 dib3000-common.c |    2 +-
 dib3000-common.h |    8 ++++----
 dib3000.h        |    2 +-
 dib3000mb.c      |    6 +++---
 dib3000mc.c      |   10 +++++-----
 dib3000mc_priv.h |    2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/Kconfig
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/Kconfig	2005-03-22 00:15:13.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/Kconfig	2005-03-22 00:15:24.000000000 +0100
@@ -108,14 +108,14 @@ config DVB_MT352
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
 config DVB_DIB3000MB
-	tristate "DiBcom 3000-MB"
+	tristate "DiBcom 3000M-B"
 	depends on DVB_CORE
 	help
 	  A DVB-T tuner module. Designed for mobile usage. Say Y when you want
 	  to support this frontend.
 
 config DVB_DIB3000MC
-	tristate "DiBcom 3000-MC/P"
+	tristate "DiBcom 3000P/M-C"
 	depends on DVB_CORE
 	help
 	  A DVB-T tuner module. Designed for mobile usage. Say Y when you want
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000-common.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000-common.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000-common.c	2005-03-22 00:15:24.000000000 +0100
@@ -73,7 +73,7 @@ u16 dib3000_seq[2][2][2] =     /* fft,gu
 	};
 
 MODULE_AUTHOR("Patrick Boettcher <patrick.boettcher@desy.de");
-MODULE_DESCRIPTION("Common functions for the dib3000mb/dib3000mc dvb frontend drivers");
+MODULE_DESCRIPTION("Common functions for the dib3000mb/dib3000mc dvb-frontend drivers");
 MODULE_LICENSE("GPL");
 
 EXPORT_SYMBOL(dib3000_seq);
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000-common.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000-common.h	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000-common.h	2005-03-22 00:15:24.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  * .h-files for the common use of the frontend drivers made by DiBcom
- * DiBcom 3000-MB/MC/P
+ * DiBcom 3000M-B/C, 3000P
  *
  * DiBcom (http://www.dibcom.fr/)
  *
@@ -30,9 +30,9 @@
 #include "dib3000.h"
 
 /* info and err, taken from usb.h, if there is anything available like by default. */
-#define err(format, arg...) printk(KERN_ERR "dib3000mX: " format "\n" , ## arg)
-#define info(format, arg...) printk(KERN_INFO "dib3000mX: " format "\n" , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "dib3000mX: " format "\n" , ## arg)
+#define err(format, arg...)  printk(KERN_ERR     "dib3000: " format "\n" , ## arg)
+#define info(format, arg...) printk(KERN_INFO    "dib3000: " format "\n" , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "dib3000: " format "\n" , ## arg)
 
 /* frontend state */
 struct dib3000_state {
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000.h	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000.h	2005-03-22 00:15:24.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  * public header file of the frontend drivers for mobile DVB-T demodulators
- * DiBcom 3000-MB and DiBcom 3000-MC/P (http://www.dibcom.fr/)
+ * DiBcom 3000M-B and DiBcom 3000P/M-C (http://www.dibcom.fr/)
  *
  * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
  *
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000mb.c	2005-03-22 00:14:30.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mb.c	2005-03-22 00:15:24.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * Frontend driver for mobile DVB-T demodulator DiBcom 3000-MB
+ * Frontend driver for mobile DVB-T demodulator DiBcom 3000M-B
  * DiBcom (http://www.dibcom.fr/)
  *
  * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
@@ -35,7 +35,7 @@
 
 /* Version information */
 #define DRIVER_VERSION "0.1"
-#define DRIVER_DESC "DiBcom 3000M-B DVB-T demodulator driver"
+#define DRIVER_DESC "DiBcom 3000M-B DVB-T demodulator"
 #define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
 
 #ifdef CONFIG_DVB_DIBCOM_DEBUG
@@ -745,7 +745,7 @@ error:
 static struct dvb_frontend_ops dib3000mb_ops = {
 
 	.info = {
-		.name			= "DiBcom 3000-MB DVB-T",
+		.name			= "DiBcom 3000M-B DVB-T",
 		.type			= FE_OFDM,
 		.frequency_min		= 44250000,
 		.frequency_max		= 867250000,
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mc.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000mc.c	2005-03-22 00:14:30.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mc.c	2005-03-22 00:15:24.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * Frontend driver for mobile DVB-T demodulator DiBcom 3000-MC/P
+ * Frontend driver for mobile DVB-T demodulator DiBcom 3000P/M-C
  * DiBcom (http://www.dibcom.fr/)
  *
  * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
@@ -34,7 +34,7 @@
 
 /* Version information */
 #define DRIVER_VERSION "0.1"
-#define DRIVER_DESC "DiBcom 3000M-C DVB-T demodulator driver"
+#define DRIVER_DESC "DiBcom 3000M-C DVB-T demodulator"
 #define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
 
 #ifdef CONFIG_DVB_DIBCOM_DEBUG
@@ -865,10 +865,10 @@ struct dvb_frontend* dib3000mc_attach(co
 
 	switch (devid) {
 		case DIB3000MC_DEVICE_ID:
-			info("Found a DiBcom 3000-MC, interesting...");
+			info("Found a DiBcom 3000M-C, interesting...");
 			break;
 		case DIB3000P_DEVICE_ID:
-			info("Found a DiBcom 3000-P.");
+			info("Found a DiBcom 3000P.");
 			break;
 	}
 
@@ -895,7 +895,7 @@ error:
 static struct dvb_frontend_ops dib3000mc_ops = {
 
 	.info = {
-		.name			= "DiBcom 3000-MC/P DVB-T",
+		.name			= "DiBcom 3000P/M-C DVB-T",
 		.type			= FE_OFDM,
 		.frequency_min		= 44250000,
 		.frequency_max		= 867250000,
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mc_priv.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000mc_priv.h	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mc_priv.h	2005-03-22 00:15:24.000000000 +0100
@@ -320,7 +320,7 @@ static u16 dib3000mc_mobile_mode[][5] = 
  * pidfilter
  * it is not a hardware pidfilter but a filter which drops all pids
  * except the ones set. When connected to USB1.1 bandwidth this is important.
- * DiB3000-MC/P can filter up to 32 PIDs
+ * DiB3000P/M-C can filter up to 32 PIDs
  */
 #define DIB3000MC_REG_FIRST_PID			(   212)
 #define DIB3000MC_NUM_PIDS				(    32)

--

