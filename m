Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269748AbUICTPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269748AbUICTPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269761AbUICTPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:15:15 -0400
Received: from steffenspage.de ([213.9.79.102]:53672 "EHLO
	mail.steffenspage.de") by vger.kernel.org with ESMTP
	id S269748AbUICTOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:14:06 -0400
From: Steffen Zieger <lkml@steffenspage.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Codemercs IO-Warrior support
Date: Fri, 3 Sep 2004 21:14:06 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409032114.08743.lkml@steffenspage.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

here is a patch to get the kernel module from Codemerces to work.
The module is available in source for the 2.4 and 2.6 series except the needed 
changes in hid-core.c. Codemercs distribute the needed changes as a complete 
file (version 2.6.4). This isn't working with 2.6.8.1.

Is there any possibility to get Codemerces driver for the IO-Warrior in the 
kernel?
The complete code is under the GPL licensed.

If you need any more information have a look at http://www.codemercs.com or
consider of contacting me. Will help as much as possible.

Greetz,
Steffen


My Kernel Version: 2.6.8-gentoo-r3

--- /usr/src/linux/drivers/usb/input/hid-core.c.orig    2004-09-03 
20:53:49.124191720 +0200
+++ /usr/src/linux/drivers/usb/input/hid-core.c 2004-09-03 20:59:14.728692312 
+0200
@@ -1439,6 +1439,13 @@
 #define USB_DEVICE_ID_1_PHIDGETSERVO_20        0x8101
 #define USB_DEVICE_ID_4_PHIDGETSERVO_20        0x8104

+#define USB_VENDOR_ID_CODEMERCS        0x07c0
+#define USB_DEVICE_ID_CODEMERCS_IOW40  0x1500
+#define USB_DEVICE_ID_CODEMERCS_IOW24  0x1501
+#define USB_DEVICE_ID_CODEMERCS_IOW48  0x1502
+#define USB_DEVICE_ID_CODEMERCS_IOW28  0x1503
+
 static struct hid_blacklist {
        __u16 idVendor;
        __u16 idProduct;
@@ -1520,6 +1527,11 @@
        { USB_VENDOR_ID_NEC, USB_DEVICE_ID_NEC_USB_GAME_PAD, 
HID_QUIRK_BADPAD },
        { USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, 
HID_QUIRK_BADPAD },
        { USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, 
HID_QUIRK_BADPAD },
+
+       { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW40, 
HID_QUIRK_IGNORE },
+       { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW24, 
HID_QUIRK_IGNORE },
+       { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW48, 
HID_QUIRK_IGNORE },
+       { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW28, 
HID_QUIRK_IGNORE },

        { 0, 0 }
 };
