Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbUCPOrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbUCPOps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:45:48 -0500
Received: from styx.suse.cz ([82.208.2.94]:29569 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261904AbUCPOT3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:29 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467763549@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 3/44] HID quirk (badpad) for Saitek Rumblepad
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:36 +0100
In-Reply-To: <1079446776407@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.3, 2004-01-26 13:17:44+01:00, vojtech@suse.cz
  input: It looks like the Saitek RumblePad needs a BADPAD entry.


 hid-core.c |    4 ++++
 1 files changed, 4 insertions(+)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Tue Mar 16 13:20:08 2004
+++ b/drivers/usb/input/hid-core.c	Tue Mar 16 13:20:08 2004
@@ -1367,6 +1367,9 @@
 #define USB_VENDOR_ID_ALPS		0x0433
 #define USB_DEVICE_ID_IBM_GAMEPAD	0x1101
 
+#define USB_VENDOR_ID_SAITEK		0x06a3
+#define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1419,6 +1422,7 @@
 	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MOUSE_HACK },
 	{ USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ 0, 0 }
 };
 

