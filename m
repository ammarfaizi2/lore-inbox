Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVCVCQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVCVCQk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVCVCPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:15:43 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:61578 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262313AbVCVBeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:34:50 -0500
Message-Id: <20050322013456.336102000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:48 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibcom-urbcount.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 15/48] dibusb: increased the number of urbs for usb1.1 devices
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

increased the number of urbs for usb1.1 devices (Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvb-dibusb-core.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:15:09.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:15:45.000000000 +0100
@@ -204,7 +204,7 @@ static struct dibusb_device_class dibusb
 	{ .id = DIBUSB1_1, .usb_ctrl = &dibusb_usb_ctrl[0],
 	  .firmware = "dvb-dibusb-5.0.0.11.fw",
 	  .pipe_cmd = 0x01, .pipe_data = 0x02, 
-	  .urb_count = 3, .urb_buffer_size = 4096,
+	  .urb_count = 5, .urb_buffer_size = 4096,
 	  DIBUSB_RC_NEC_PROTOCOL,
 	  &dibusb_demod[DIBUSB_DIB3000MB],
 	  &dibusb_tuner[DIBUSB_TUNER_CABLE_THOMSON],
@@ -212,7 +212,7 @@ static struct dibusb_device_class dibusb
 	{ DIBUSB1_1_AN2235, &dibusb_usb_ctrl[1],
 	  "dvb-dibusb-an2235-1.fw",
 	  0x01, 0x02, 
-	  3, 4096,
+	  5, 4096,
 	  DIBUSB_RC_NEC_PROTOCOL,
 	  &dibusb_demod[DIBUSB_DIB3000MB],
 	  &dibusb_tuner[DIBUSB_TUNER_CABLE_THOMSON],
@@ -231,7 +231,6 @@ static struct dibusb_device_class dibusb
 	  15, 188*21,
 	  DIBUSB_RC_NO,
 	  &dibusb_demod[DIBUSB_MT352],
-//	  &dibusb_tuner[DIBUSB_TUNER_COFDM_PANASONIC_ENV77H11D5],
 	  &dibusb_tuner[DIBUSB_TUNER_CABLE_LG_TDTP_E102P],
 	},
 };

--

