Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVIJWmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVIJWmq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVIJWme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:42:34 -0400
Received: from styx.suse.cz ([82.119.242.94]:26532 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932351AbVIJWdv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:51 -0400
Subject: [PATCH 11/26] recognize and ignore Logitech vendor usages in HID
In-Reply-To: <11263916523302@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:12 +0200
Message-Id: <11263916521314@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Inpur: recognize and ignore Logitech vendor usages in HID
From: Vojtech Pavlik <vojtech@suse.cz>
Date: 1125896857 -0500

These get in our way with MX mice.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/usb/input/hid-input.c |    1 +
 drivers/usb/input/hid.h       |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

b8c9c642db4ab0811cc5bb0d8b90cc7819055c95
diff --git a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c
+++ b/drivers/usb/input/hid-input.c
@@ -296,6 +296,7 @@ static void hidinput_configure_usage(str
 			break;
 
 		case HID_UP_MSVENDOR:
+		case HID_UP_LOGIVENDOR:
 
 			goto ignore;
 
diff --git a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h
+++ b/drivers/usb/input/hid.h
@@ -182,6 +182,7 @@ struct hid_item {
 #define HID_UP_PID		0x000f0000
 #define HID_UP_HPVENDOR         0xff7f0000
 #define HID_UP_MSVENDOR		0xff000000
+#define HID_UP_LOGIVENDOR	0x00ff0000
 
 #define HID_USAGE		0x0000ffff
 

