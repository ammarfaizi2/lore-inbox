Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263096AbTCSSJz>; Wed, 19 Mar 2003 13:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbTCSSJz>; Wed, 19 Mar 2003 13:09:55 -0500
Received: from pa-vallet1b-153.pit.adelphia.net ([24.50.181.153]:63120 "EHLO
	client100.evillabs.net") by vger.kernel.org with ESMTP
	id <S263096AbTCSSJx>; Wed, 19 Mar 2003 13:09:53 -0500
Date: Wed, 19 Mar 2003 13:20:46 -0500
From: Jason McMullan <jmcmullan@linuxcare.com>
To: linux-kernel@vger.kernel.org
Subject: HID Patch for Essential Reality P5 Glove
Message-ID: <20030319182046.GA32527@client100.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  This patch adds the Essential Reality P5 data glove to the HID
blacklist. It's yet another device that advertises itself as a HID,
and doesn't comply with the HID specs.

  The P5 is an inexpensive ($99 USD) data glove, with 5 finger flexion
sensors and 8 IR location sensors.

  A user-space library to access the P5 is available at
  http://www.evillabs.net/~jmcc/p5/

--- linux-2.4/drivers/usb/hid-core.c	2003-02-27 13:40:26.000000000 -0500
+++ linux-2.4.new/drivers/usb/hid-core.c	2003-03-16 14:50:36.000000000 -0500
@@ -1093,8 +1113,10 @@
 #define USB_VENDOR_ID_TANGTOP		0x0d3d
 #define USB_DEVICE_ID_TANGTOP_USBPS2	0x0001

+#define USB_VENDOR_ID_ESSENTIAL_REALITY 0x0d7f
+#define USB_DEVICE_ID_ESSENTIAL_REALITY_P5 0x0100
 
 struct hid_blacklist {
 	__u16 idVendor;
@@ -1133,7 +1153,8 @@
  	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 300, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 400, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 500, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_TANGTOP, USB_DEVICE_ID_TANGTOP_USBPS2, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
 	{ 0, 0 }
 };
 
-- 
Jason McMullan, Senior Linux Consultant, Linuxcare, Inc.
412.422.8077 tel, 412.656.3519 cell, 208.694.9206 fax
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Support for the revolution.
