Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbUCPOej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUCPObW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:31:22 -0500
Received: from styx.suse.cz ([82.208.2.94]:1922 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261939AbUCPOTq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:46 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446777851@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 29/44] HID quirk (badpad) for NEC gamepad
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <10794467771611@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.61.2, 2004-03-04 09:21:42+01:00, john@fremlin.de
  input: Add a NEC USB gamepad to badpad blacklist.


 hid-core.c |    4 ++++
 1 files changed, 4 insertions(+)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Tue Mar 16 13:18:18 2004
+++ b/drivers/usb/input/hid-core.c	Tue Mar 16 13:18:18 2004
@@ -1374,6 +1374,9 @@
 #define USB_VENDOR_ID_SAITEK		0x06a3
 #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
 
+#define USB_VENDOR_ID_NEC		0x073e
+#define USB_DEVICE_ID_NEC_USB_GAME_PAD	0x0301
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1432,6 +1435,7 @@
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_NEC, USB_DEVICE_ID_NEC_USB_GAME_PAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
 

