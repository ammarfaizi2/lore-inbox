Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVIDXbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVIDXbQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVIDXbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:31:14 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:39553 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932126AbVIDXa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:29 -0400
Message-Id: <20050904232325.348470000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:23 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-kworld-xpert-dvb-t.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 24/54] usb: dibusb: Kworld Xpert DVB-T USB2.0 support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Add USB IDs of the Kworld Xpert DVB-T USB2.0 (clone of the ADStech box).
Thanks to Marcus Hagn for testing.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dibusb-mb.c   |   14 ++++++++++----
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h |    1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-09-04 22:28:16.000000000 +0200
@@ -126,10 +126,12 @@ static struct usb_device_id dibusb_dib30
 /* 25 */	{ USB_DEVICE(USB_VID_KYE,			USB_PID_KYE_DVB_T_COLD) },
 /* 26 */	{ USB_DEVICE(USB_VID_KYE,			USB_PID_KYE_DVB_T_WARM) },
 
+/* 27 */	{ USB_DEVICE(USB_VID_KWORLD,		USB_PID_KWORLD_VSTREAM_COLD) },
+
 // #define DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
 
 #ifdef DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
-/* 27 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
+/* 28 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
 #endif
 			{ }		/* Terminating entry */
 };
@@ -262,7 +264,7 @@ static struct dvb_usb_properties dibusb1
 		},
 #ifdef DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
 		{	"Artec T1 USB1.1 TVBOX with AN2235 (faulty USB IDs)",
-			{ &dibusb_dib3000mb_table[27], NULL },
+			{ &dibusb_dib3000mb_table[28], NULL },
 			{ NULL },
 		},
 #endif
@@ -306,12 +308,16 @@ static struct dvb_usb_properties dibusb2
 		}
 	},
 
-	.num_device_descs = 1,
+	.num_device_descs = 2,
 	.devices = {
-		{	"KWorld/ADSTech Instant DVB-T USB 2.0",
+		{	"KWorld/ADSTech Instant DVB-T USB2.0",
 			{ &dibusb_dib3000mb_table[23], NULL },
 			{ &dibusb_dib3000mb_table[24], NULL },
 		},
+		{	"KWorld Xpert DVB-T USB2.0",
+			{ &dibusb_dib3000mb_table[27], NULL },
+			{ NULL }
+		},
 	}
 };
 
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-09-04 22:28:15.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-09-04 22:28:16.000000000 +0200
@@ -24,6 +24,7 @@
 #define USB_VID_HANFTEK						0x15f4
 #define USB_VID_HAUPPAUGE					0x2040
 #define USB_VID_HYPER_PALTEK				0x1025
+#define USB_VID_KWORLD						0xeb2a
 #define USB_VID_KYE							0x0458
 #define USB_VID_MEDION						0x1660
 #define USB_VID_VISIONPLUS					0x13d3

--

