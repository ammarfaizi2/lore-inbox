Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262059AbTCTTmG>; Thu, 20 Mar 2003 14:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262064AbTCTTmG>; Thu, 20 Mar 2003 14:42:06 -0500
Received: from pa-vallet1b-153.pit.adelphia.net ([24.50.181.153]:57762 "EHLO
	client100.evillabs.net") by vger.kernel.org with ESMTP
	id <S262059AbTCTTmF>; Thu, 20 Mar 2003 14:42:05 -0500
Date: Thu, 20 Mar 2003 14:53:05 -0500
From: Jason McMullan <jmcmullan@linuxcare.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] HID: Ignore P5 Data Glove (2.4 and 2.5 patches)
Message-ID: <20030320195305.GA3370@client100.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  As requested, here are the 2.4 (latest BK tree) and 2.5 (latest bk
  tree) patches to ignore the non-HID Essential Reality Data Glove

  (again, user-space lib to access this device via /proc/bus/usb
   is available at http://www.evillabs.net/~jmcc/p5)

-------------- 2.4 patch --------------------
--- linux-2.4/drivers/usb/hid-core.c	2003-03-20 14:42:49.000000000 -0500
+++ linux-2.4/drivers/usb/hid-core.c.new	2003-03-20 14:46:40.000000000 -0500
@@ -1102,6 +1102,9 @@
 #define USB_VENDOR_ID_OKI		0x070a
 #define USB_VENDOR_ID_OKI_MULITI	0x0007
 
+#define USB_VENDOR_ID_ESSENTIAL_REALITY	0x0d7f
+#define USB_DEVICE_ID_ESSENTIAL_REALITY_P5	0x0100
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1142,6 +1145,7 @@
  	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 500, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_TANGTOP, USB_DEVICE_ID_TANGTOP_USBPS2, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_OKI, USB_VENDOR_ID_OKI_MULITI, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
 	{ 0, 0 }
 };
 

---- end
----------- 2.5 patch -------------------
--- linux-2.5/drivers/usb/input/hid-core.c	2003-03-19 09:30:25.000000000 -0500
+++ linux-2.5/drivers/usb/input/hid-core.c.new	2003-03-20 14:48:42.000000000 -0500
@@ -1334,6 +1334,9 @@
 #define USB_VENDOR_ID_TANGTOP          0x0d3d
 #define USB_DEVICE_ID_TANGTOP_USBPS2   0x0001
 
+#define USB_VENDOR_ID_ESSENTIAL_REALITY	0x0d7f
+#define USB_DEVICE_ID_ESSENTIAL_REALITY_P5	0x0100
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1377,6 +1380,7 @@
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 400, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 500, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_TANGTOP, USB_DEVICE_ID_TANGTOP_USBPS2, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
 	{ 0, 0 }
 };
 
---- end
-- 
Jason McMullan, Senior Linux Consultant, Linuxcare, Inc.
412.422.8077 tel, 412.656.3519 cell, 208.694.9206 fax
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Support for the revolution.
