Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUFXKk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUFXKk7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbUFXKk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:40:59 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:9937 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S264211AbUFXKk4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:40:56 -0400
From: cr7@os.inf.tu-dresden.de
To: linux-kernel@vger.kernel.org
Subject: [PATCH] USB-HID: blacklist update
Date: Tue, 11 May 2004 17:53:23 +0200
User-Agent: KMail/1.6.2
Cc: vojtech@suse.cz
MIME-Version: 1.0
Content-Disposition: inline
Organization: TU Dresden - Operating System Group 
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406241239.07514.cr7@os.inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry for resending this patch again. 
Is there any reason, why shouldn't be applied ?
Did I miss some answers ?

The old message below:

this is a simple patch of USB's hid-core.c to add Codemercs' IOWarrior 24 and  
IOWarrior 40 to the blacklist as they're no "real" HID devices.
It should be used via Codemercs' driver or via libusb.

The datasheet for IOwarrior can be found here:
http://www.codemercs.com/Downloads/IOWarriorDatasheet.pdf

Regards,
Carsten


Patch against 2.6.7:

--- /drivers/usb/input/hid-core.c-orig  2004-04-04 05:37:23.000000000 +0200
+++ /drivers/usb/input/hid-core.c       2004-05-11 13:50:11.877974264 +0200
@@ -1412,6 +1412,11 @@
 #define USB_DEVICE_ID_1_PHIDGETSERVO_20        0x8101
 #define USB_DEVICE_ID_4_PHIDGETSERVO_20        0x8104
 
+#define USB_VENDOR_ID_CODEMERCS         0x07c0
+#define USB_DEVICE_ID_CODEMERCS_IOW40   0x1500
+#define USB_DEVICE_ID_CODEMERCS_IOW24   0x1501
+
+
 static struct hid_blacklist {
        __u16 idVendor;
        __u16 idProduct;
@@ -1479,6 +1484,9 @@
        { USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, 
HID_QUIRK_BADPAD },
        { USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, 
HID_QUIRK_BADPAD },
 
+       { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW40, 
HID_QUIRK_IGNORE },
+       { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW24, 
HID_QUIRK_IGNORE },
+
        { 0, 0 }
 };
 
