Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVF0Nbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVF0Nbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVF0N1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:27:14 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:18661 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262064AbVF0MQk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:40 -0400
Message-Id: <20050627121418.410728000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:44 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-videowalker.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 44/51] usb: add VideoWalker DVB-T USB ids
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Add another USB ID pair for the VideoWalker USB DVB-T.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dibusb-mb.c   |   12 +++++++++---
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h |    3 +++
 drivers/media/dvb/dvb-usb/dvb-usb.h     |    2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dibusb-mb.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-06-27 13:26:14.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-06-27 13:26:16.000000000 +0200
@@ -123,11 +123,13 @@ static struct usb_device_id dibusb_dib30
 
 /* device ID with default DIBUSB2_0-firmware and with the hacked firmware */
 /* 24 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_WARM) },
+/* 25 */	{ USB_DEVICE(USB_VID_KYE,			USB_PID_KYE_DVB_T_COLD) },
+/* 26 */	{ USB_DEVICE(USB_VID_KYE,			USB_PID_KYE_DVB_T_WARM) },
 
 // #define DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
 
 #ifdef DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
-/* 25 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
+/* 27 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
 #endif
 			{ }		/* Terminating entry */
 };
@@ -170,7 +172,7 @@ static struct dvb_usb_properties dibusb1
 		}
 	},
 
-	.num_device_descs = 8,
+	.num_device_descs = 9,
 	.devices = {
 		{	"AVerMedia AverTV DVBT USB1.1",
 			{ &dibusb_dib3000mb_table[0],  NULL },
@@ -204,6 +206,10 @@ static struct dvb_usb_properties dibusb1
 			{ &dibusb_dib3000mb_table[19], NULL },
 			{ &dibusb_dib3000mb_table[20], NULL },
 		},
+		{	"VideoWalker DVB-T USB",
+			{ &dibusb_dib3000mb_table[25], NULL },
+			{ &dibusb_dib3000mb_table[26], NULL },
+		},
 	}
 };
 
@@ -256,7 +262,7 @@ static struct dvb_usb_properties dibusb1
 		},
 #ifdef DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
 		{	"Artec T1 USB1.1 TVBOX with AN2235 (faulty USB IDs)",
-			{ &dibusb_dib3000mb_table[25], NULL },
+			{ &dibusb_dib3000mb_table[27], NULL },
 			{ NULL },
 		},
 #endif
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-ids.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-06-27 13:26:10.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-06-27 13:26:16.000000000 +0200
@@ -24,6 +24,7 @@
 #define USB_VID_HANFTEK						0x15f4
 #define USB_VID_HAUPPAUGE					0x2040
 #define USB_VID_HYPER_PALTEK				0x1025
+#define USB_VID_KYE							0x0458
 #define USB_VID_MEDION						0x1660
 #define USB_VID_VISIONPLUS					0x13d3
 #define USB_VID_TWINHAN						0x1822
@@ -80,6 +81,8 @@
 #define USB_PID_DVICO_BLUEBIRD_LGZ201_1		0xdb01
 #define USB_PID_DVICO_BLUEBIRD_TH7579_2		0xdb11
 #define USB_PID_MEDION_MD95700				0x0932
+#define USB_PID_KYE_DVB_T_COLD				0x701e
+#define USB_PID_KYE_DVB_T_WARM				0x701f
 
 
 #endif
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dvb-usb.h	2005-06-27 13:26:05.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb.h	2005-06-27 13:26:16.000000000 +0200
@@ -195,7 +195,7 @@ struct dvb_usb_properties {
 	} urb;
 
 	int num_device_descs;
-	struct dvb_usb_device_description devices[8];
+	struct dvb_usb_device_description devices[9];
 };
 
 

--

