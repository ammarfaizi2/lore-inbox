Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUG2O3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUG2O3m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUG2O2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:28:55 -0400
Received: from styx.suse.cz ([82.119.242.94]:26774 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264960AbUG2OIL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:11 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 30/47] Add CodeMercs IOWarrior to hid-core device blacklist
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101951075@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <109111019551@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1757.28.15, 2004-06-24 15:44:37+02:00, cr7@os.inf.tu-dresden.de
  input: Add CodeMercs IOWarrior to hid-core device blacklist.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hid-core.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Thu Jul 29 14:39:51 2004
+++ b/drivers/usb/input/hid-core.c	Thu Jul 29 14:39:51 2004
@@ -1430,6 +1430,11 @@
 #define USB_DEVICE_ID_1_PHIDGETSERVO_20	0x8101
 #define USB_DEVICE_ID_4_PHIDGETSERVO_20	0x8104
 
+#define USB_VENDOR_ID_CODEMERCS		0x07c0
+#define USB_DEVICE_ID_CODEMERCS_IOW40	0x1500
+#define USB_DEVICE_ID_CODEMERCS_IOW24	0x1501
+
+
 static struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1444,20 +1449,20 @@
 	{ USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_23, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_24, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW40, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW24, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_KBGEAR, USB_DEVICE_ID_KBGEAR_JAMSTUDIO, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_POWERMATE, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_SOUNDKNOB, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS1, HID_QUIRK_IGNORE },
-
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 100, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 200, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 300, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 400, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 500, HID_QUIRK_IGNORE },
-
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PENPARTNER, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 1, HID_QUIRK_IGNORE },

