Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVGaPKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVGaPKH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 11:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVGaPKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 11:10:06 -0400
Received: from 69.36.162.216.west-datacenter.net ([69.36.162.216]:35729 "EHLO
	schau.com") by vger.kernel.org with ESMTP id S261775AbVGaPKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 11:10:04 -0400
Message-ID: <42ECE9F5.2010108@schau.com>
Date: Sun, 31 Jul 2005 17:10:45 +0200
From: Brian Schau <brian@schau.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] hid-core.c, 2.6.13-rc4. (Was: [PATCH] Wireless Security Lock
 driver).
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I stand corrected.   The WSL driver is _not_ needed as it actually is possible
to use libusb.   However, you need this little patch to hid-core.c:

diff -urN linux-2.6.13-rc4.orig/drivers/usb/input/hid-core.c linux-2.6.13-rc4/drivers/usb/input/hid-core.c
--- linux-2.6.13-rc4.orig/drivers/usb/input/hid-core.c	2005-07-29 00:44:44.000000000 +0200
+++ linux-2.6.13-rc4/drivers/usb/input/hid-core.c	2005-07-29 23:21:19.000000000 +0200
@@ -1375,6 +1375,7 @@
  #define USB_VENDOR_ID_CYPRESS		0x04b4
  #define USB_DEVICE_ID_CYPRESS_MOUSE	0x0001
  #define USB_DEVICE_ID_CYPRESS_HIDCOM	0x5500
+#define USB_DEVICE_ID_CYPRES_ULTRAMOUSE	0x7417

  #define USB_VENDOR_ID_BERKSHIRE		0x0c98
  #define USB_DEVICE_ID_BERKSHIRE_PCWD	0x1140
@@ -1465,6 +1466,7 @@
  	{ USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW48, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW28, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_HIDCOM, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRES_ULTRAMOUSE, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },


Thanks to Pavel et al for pointing out the obvious!   And, I am sorry for
creating noise on the list (the driver, however, was fun to write, so :-/)

/brian
