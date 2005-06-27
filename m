Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVF0Nby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVF0Nby (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVF0Nag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:30:36 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:21477 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262069AbVF0MQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:45 -0400
Message-Id: <20050627121419.440265000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:49 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-cleanups-comments.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 49/51] usb: fix WideView USB ids
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

o Steve Chang reported the real name behind 0x14aa: WideView,
  changed USB IDs accordingly.
o fixed an assignment

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/Kconfig       |    4 ++--
 drivers/media/dvb/dvb-usb/dibusb-mb.c   |    4 ++--
 drivers/media/dvb/dvb-usb/dtt200u-fe.c  |    4 ++--
 drivers/media/dvb/dvb-usb/dtt200u.c     |   16 ++++++++--------
 drivers/media/dvb/dvb-usb/dtt200u.h     |    4 ++--
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h |    2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/Kconfig
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/Kconfig	2005-06-27 13:26:19.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/Kconfig	2005-06-27 13:27:08.000000000 +0200
@@ -109,9 +109,9 @@ config DVB_USB_NOVA_T_USB2
 	  Say Y here to support the Hauppauge WinTV-NOVA-T usb2 DVB-T USB2.0 receiver.
 
 config DVB_USB_DTT200U
-	tristate "Yakumo/Hama/Typhoon/Yuan DVB-T USB2.0 support"
+	tristate "WideView/Yakumo/Hama/Typhoon/Yuan DVB-T USB2.0 support"
 	depends on DVB_USB
 	help
-	  Say Y here to support the Yakumo/Hama/Typhoon/Yuan DVB-T USB2.0 receiver.
+	  Say Y here to support the WideView/Yakumo/Hama/Typhoon/Yuan DVB-T USB2.0 receiver.
 
 	  The receivers are also known as DTT200U (Yakumo) and UB300 (Yuan).
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dibusb-mb.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-06-27 13:26:16.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-06-27 13:27:08.000000000 +0200
@@ -96,8 +96,8 @@ static int dibusb_probe(struct usb_inter
 
 /* do not change the order of the ID table */
 static struct usb_device_id dibusb_dib3000mb_table [] = {
-/* 00 */	{ USB_DEVICE(USB_VID_AVERMEDIA_UNK,	USB_PID_AVERMEDIA_DVBT_USB_COLD)},
-/* 01 */	{ USB_DEVICE(USB_VID_AVERMEDIA_UNK,	USB_PID_AVERMEDIA_DVBT_USB_WARM)},
+/* 00 */	{ USB_DEVICE(USB_VID_WIDEVIEW,		USB_PID_AVERMEDIA_DVBT_USB_COLD)},
+/* 01 */	{ USB_DEVICE(USB_VID_WIDEVIEW,		USB_PID_AVERMEDIA_DVBT_USB_WARM)},
 /* 02 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_COLD) },
 /* 03 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_WARM) },
 /* 04 */	{ USB_DEVICE(USB_VID_COMPRO_UNK,	USB_PID_COMPRO_DVBU2000_UNK_COLD) },
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dtt200u-fe.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dtt200u-fe.c	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dtt200u-fe.c	2005-06-27 13:27:08.000000000 +0200
@@ -1,5 +1,5 @@
-/* Frontend part of the Linux driver for the Yakumo/Hama/Typhoon DVB-T
- * USB2.0 receiver.
+/* Frontend part of the Linux driver for the WideView/ Yakumo/ Hama/
+ * Typhoon/ Yuan DVB-T USB2.0 receiver.
  *
  * Copyright (C) 2005 Patrick Boettcher <patrick.boettcher@desy.de>
  *
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dtt200u.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dtt200u.c	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dtt200u.c	2005-06-27 13:27:08.000000000 +0200
@@ -1,5 +1,5 @@
-/* DVB USB library compliant Linux driver for the Yakumo/Hama/Typhoon DVB-T
- * USB2.0 receiver.
+/* DVB USB library compliant Linux driver for the WideView/ Yakumo/ Hama/
+ * Typhoon/ Yuan DVB-T USB2.0 receiver.
  *
  * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
  *
@@ -89,8 +89,8 @@ static int dtt200u_usb_probe(struct usb_
 }
 
 static struct usb_device_id dtt200u_usb_table [] = {
-	    { USB_DEVICE(USB_VID_AVERMEDIA_UNK, USB_PID_DTT200U_COLD) },
-	    { USB_DEVICE(USB_VID_AVERMEDIA_UNK, USB_PID_DTT200U_WARM) },
+	    { USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_DTT200U_COLD) },
+	    { USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_DTT200U_WARM) },
 	    { 0 },
 };
 MODULE_DEVICE_TABLE(usb, dtt200u_usb_table);
@@ -127,8 +127,8 @@ static struct dvb_usb_properties dtt200u
 
 	.num_device_descs = 1,
 	.devices = {
-		{ .name = "Yakumo/Hama/Typhoon DVB-T USB2.0)",
-		  .cold_ids = { &dtt200u_usb_table[0], &dtt200u_usb_table[2] },
+		{ .name = "WideView/Yakumo/Hama/Typhoon DVB-T USB2.0)",
+		  .cold_ids = { &dtt200u_usb_table[0], NULL },
 		  .warm_ids = { &dtt200u_usb_table[1], NULL },
 		},
 		{ 0 },
@@ -138,7 +138,7 @@ static struct dvb_usb_properties dtt200u
 /* usb specific object needed to register this driver with the usb subsystem */
 static struct usb_driver dtt200u_usb_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "Yakumo/Hama/Typhoon DVB-T USB2.0",
+	.name		= "dtt200u",
 	.probe 		= dtt200u_usb_probe,
 	.disconnect = dvb_usb_device_exit,
 	.id_table 	= dtt200u_usb_table,
@@ -166,6 +166,6 @@ module_init(dtt200u_usb_module_init);
 module_exit(dtt200u_usb_module_exit);
 
 MODULE_AUTHOR("Patrick Boettcher <patrick.boettcher@desy.de>");
-MODULE_DESCRIPTION("Driver for the Yakumo/Hama/Typhoon DVB-T USB2.0 device");
+MODULE_DESCRIPTION("Driver for the WideView/Yakumo/Hama/Typhoon DVB-T USB2.0 device");
 MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL");
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dtt200u.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dtt200u.h	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dtt200u.h	2005-06-27 13:27:08.000000000 +0200
@@ -1,5 +1,5 @@
-/* Common header file of Linux driver for the Yakumo/Hama/Typhoon DVB-T
- * USB2.0 receiver.
+/* Common header file of Linux driver for the WideView/ Yakumo/ Hama/
+ * Typhoon/ Yuan DVB-T USB2.0 receiver.
  *
  * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
  *
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-ids.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-06-27 13:26:16.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-06-27 13:27:08.000000000 +0200
@@ -12,7 +12,7 @@
 /* Vendor IDs */
 #define USB_VID_ADSTECH						0x06e1
 #define USB_VID_ANCHOR						0x0547
-#define USB_VID_AVERMEDIA_UNK				0x14aa
+#define USB_VID_WIDEVIEW					0x14aa
 #define USB_VID_AVERMEDIA					0x07ca
 #define USB_VID_COMPRO						0x185b
 #define USB_VID_COMPRO_UNK					0x145f

--

