Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUCPObB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUCPO36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:29:58 -0500
Received: from styx.suse.cz ([82.208.2.94]:3458 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261952AbUCPOTt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:49 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467781493@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 35/44] HID quirk (badpad) for Chic gamepad
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:38 +0100
In-Reply-To: <1079446778395@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.78.9, 2004-03-08 13:16:03+01:00, vojtech@suse.cz
  input: Add a Chic gamepad into badpad quirk list.


 hid-core.c |    4 ++++
 1 files changed, 4 insertions(+)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Tue Mar 16 13:17:56 2004
+++ b/drivers/usb/input/hid-core.c	Tue Mar 16 13:17:56 2004
@@ -1390,6 +1390,9 @@
 #define USB_VENDOR_ID_NEC		0x073e
 #define USB_DEVICE_ID_NEC_USB_GAME_PAD	0x0301
 
+#define USB_VENDOR_ID_CHIC		0x05fe
+#define USB_DEVICE_ID_CHIC_GAMEPAD	0x0014
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1449,6 +1452,7 @@
 	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE, HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA },
 
 	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },

