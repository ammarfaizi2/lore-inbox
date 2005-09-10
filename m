Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVIJWei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVIJWei (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVIJWec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:32 -0400
Received: from styx.suse.cz ([82.119.242.94]:40868 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932362AbVIJWdw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:52 -0400
Subject: [PATCH 23/26] HID - add Wireless Security Lock to HID blacklist
In-Reply-To: <11263916543599@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:14 +0200
Message-Id: <1126391654374@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: HID - add Wireless Security Lock to HID blacklist
From: Brian Schau <brian@schau.com>
Date: 1125903461 -0500

The device is a Wireless Security Lock (WSL).  The device identifies itself
as a Cypress Ultra Mouse.  It is, however, not a mouse at all and as such,
shouldn't be handled as one.

Signed-off-by: Brian Schau <brian@schau.com>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/usb/input/hid-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

7d25258f69cedc2f2e55eb25ba2e2078060b44f4
diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1377,6 +1377,7 @@ void hid_init_reports(struct hid_device 
 #define USB_VENDOR_ID_CYPRESS		0x04b4
 #define USB_DEVICE_ID_CYPRESS_MOUSE	0x0001
 #define USB_DEVICE_ID_CYPRESS_HIDCOM	0x5500
+#define USB_DEVICE_ID_CYPRESS_ULTRAMOUSE	0x7417
 
 #define USB_VENDOR_ID_BERKSHIRE		0x0c98
 #define USB_DEVICE_ID_BERKSHIRE_PCWD	0x1140
@@ -1469,6 +1470,7 @@ static struct hid_blacklist {
 	{ USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW48, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW28, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_HIDCOM, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_ULTRAMOUSE, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },

