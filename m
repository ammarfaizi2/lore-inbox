Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUIEMdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUIEMdj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUIEMdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:33:38 -0400
Received: from steffenspage.de ([213.9.79.102]:18091 "EHLO
	mail.steffenspage.de") by vger.kernel.org with ESMTP
	id S266566AbUIEMdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:33:36 -0400
From: Steffen Zieger <lkml@steffenspage.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Codemercs IO-Warrior support
Date: Sun, 5 Sep 2004 14:33:34 +0200
User-Agent: KMail/1.7
References: <200409032114.08743.lkml@steffenspage.de> <20040903234208.380eeb64.akpm@osdl.org>
In-Reply-To: <20040903234208.380eeb64.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409051433.37210.lkml@steffenspage.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 September 2004 08:42, Andrew Morton wrote:
> It's wordwrapped by your email client.
Sorry for this.
Here it is again. This time it's hopefully functional.

HAND,
Steffen



--- /usr/src/linux/drivers/usb/input/hid-core.c.orig    2004-09-03 20:53:49.124191720 +0200
+++ /usr/src/linux/drivers/usb/input/hid-core.c 2004-09-03 20:59:14.728692312 +0200
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
        { USB_VENDOR_ID_NEC, USB_DEVICE_ID_NEC_USB_GAME_PAD, HID_QUIRK_BADPAD },
        { USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
        { USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
+
+       { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW40, HID_QUIRK_IGNORE },
+       { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW24, HID_QUIRK_IGNORE },
+       { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW48, HID_QUIRK_IGNORE },
+       { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW28, HID_QUIRK_IGNORE },

        { 0, 0 }
 };
