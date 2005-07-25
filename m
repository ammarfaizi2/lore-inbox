Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVGYGjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVGYGjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVGYFzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:55:07 -0400
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:41597 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261630AbVGYFxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:24 -0400
Message-Id: <20050725054532.938813000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:06 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 17/24] HID: Add a quirk for Aashima gamepad
Content-Disposition: inline; filename=aashima-trust-hid-quirk.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Luca T." <luca@lt-software.com>

Input: HID - add a quirk for Aashima Trust (06d6:0025) gamepad

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/hid-core.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: work/drivers/usb/input/hid-core.c
===================================================================
--- work.orig/drivers/usb/input/hid-core.c
+++ work/drivers/usb/input/hid-core.c
@@ -1372,6 +1372,9 @@ void hid_init_reports(struct hid_device 
 #define USB_VENDOR_ID_A4TECH		0x09da
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 
+#define USB_VENDOR_ID_AASHIMA		0x06D6
+#define USB_DEVICE_ID_AASHIMA_GAMEPAD	0x0025
+
 #define USB_VENDOR_ID_CYPRESS		0x04b4
 #define USB_DEVICE_ID_CYPRESS_MOUSE	0x0001
 #define USB_DEVICE_ID_CYPRESS_HIDCOM	0x5500
@@ -1524,6 +1527,7 @@ static struct hid_blacklist {
 	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MOUSE_HACK_7 },
 	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE, HID_QUIRK_2WHEEL_MOUSE_HACK_5 },
 
+	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },

