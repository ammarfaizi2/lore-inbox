Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUEKMD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUEKMD4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUEKMD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:03:56 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:16275 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S262932AbUEKMDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:03:54 -0400
From: cr7@os.inf.tu-dresden.de
To: linux-kernel@vger.kernel.org
Subject: [PATCH] USB-HID: IOWarrior added to blacklist
Date: Tue, 11 May 2004 14:04:24 +0200
User-Agent: KMail/1.6.2
Cc: vojtech@suse.cz
MIME-Version: 1.0
Content-Disposition: inline
Organization: TU Dresden - Operating System Group 
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IFMoA5Ps4/eiWgn"
Message-Id: <200405111404.24061.cr7@os.inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_IFMoA5Ps4/eiWgn
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

this is a simple patch of USB's hid-core.c to add Codemercs' IOWarrior 24 and  
IOWarrior 40 to the blacklist as it's not a "real" HID device.
It should be used via Codemercs' driver or via libusb.

The datasheet for IOwarrior can be found here:
http://www.codemercs.com/Downloads/IOWarriorDatasheet.pdf

Regards,
Carsten

--Boundary-00=_IFMoA5Ps4/eiWgn
Content-Type: text/x-diff;
  charset="us-ascii";
  name="hid-iowarrior.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hid-iowarrior.patch"

--- /drivers/usb/input/hid-core.c-orig	2004-04-04 05:37:23.000000000 +0200
+++ /drivers/usb/input/hid-core.c	2004-05-11 13:50:11.877974264 +0200
@@ -1412,6 +1412,11 @@
 #define USB_VENDOR_ID_CHIC		0x05fe
 #define USB_DEVICE_ID_CHIC_GAMEPAD	0x0014
 
+#define USB_VENDOR_ID_CODEMERCS         0x07c0
+#define USB_DEVICE_ID_CODEMERCS_IOW40   0x1500
+#define USB_DEVICE_ID_CODEMERCS_IOW24   0x1501
+
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1479,6 +1484,9 @@
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
 
+	{ USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW40, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW24, HID_QUIRK_IGNORE },
+
 	{ 0, 0 }
 };
 

--Boundary-00=_IFMoA5Ps4/eiWgn--
