Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbVKQSJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVKQSJe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVKQSJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:09:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:28322 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932511AbVKQSEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:14 -0500
Date: Thu, 17 Nov 2005 09:46:33 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       pingc@wacom.com, dtor_core@ameritech.net, vojtech@suse.cz
Subject: [patch 03/22] USB: add new wacom devices to usb hid-core list
Message-ID: <20051117174633.GD11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="add-new-wacom-devices-to-usb-hid-core-list.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ping Cheng <pingc@wacom.com>

This patch adds support for Graphire4, Cintiq 710, Intuos3 6x11, etc.


Signed-off-by: Ping Cheng <pingc@wacom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/input/hid-core.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- usb-2.6.orig/drivers/usb/input/hid-core.c
+++ usb-2.6/drivers/usb/input/hid-core.c
@@ -1318,6 +1318,7 @@ void hid_init_reports(struct hid_device 
 #define USB_DEVICE_ID_WACOM_PTU		0x0003
 #define USB_DEVICE_ID_WACOM_INTUOS3	0x00B0
 #define USB_DEVICE_ID_WACOM_CINTIQ	0x003F
+#define USB_DEVICE_ID_WACOM_DTF         0x00C0
 
 #define USB_VENDOR_ID_ACECAD		0x0460
 #define USB_DEVICE_ID_ACECAD_FLAIR	0x0004
@@ -1524,6 +1525,9 @@ static struct hid_blacklist {
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 3, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 4, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 5, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 7, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 8, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 9, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 1, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 2, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 3, HID_QUIRK_IGNORE },
@@ -1531,11 +1535,19 @@ static struct hid_blacklist {
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 5, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 7, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_VOLITO, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_VOLITO + 1, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_VOLITO + 2, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_VOLITO + 3, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_VOLITO + 4, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 5, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 6, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PTU, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS3, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS3 + 1, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS3 + 2, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS3 + 5, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_CINTIQ, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_DTF, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_4_PHIDGETSERVO_20, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20, HID_QUIRK_IGNORE },
 

--
