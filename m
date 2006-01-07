Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbWAGTMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWAGTMc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbWAGTIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:08:23 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:22173 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030546AbWAGTIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:21 -0500
Message-Id: <20060107172059.958095000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:03 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 04/24] Wistron: add Acer TravelMate 240 to DMI table
Content-Disposition: inline; filename=wistron-add-acer-tm240.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashutosh Naik <ashutosh.naik@gmail.com>

Input: wistron - add Acer TravelMate 240 to DMI table

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/wistron_btns.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+)

Index: work/drivers/input/misc/wistron_btns.c
===================================================================
--- work.orig/drivers/input/misc/wistron_btns.c
+++ work/drivers/input/misc/wistron_btns.c
@@ -296,6 +296,16 @@ static struct key_entry keymap_acer_aspi
 	{ KE_END, 0 }
 };
 
+static struct key_entry keymap_acer_travelmate_240[] = {
+	{ KE_KEY, 0x31, KEY_MAIL },
+	{ KE_KEY, 0x36, KEY_WWW },
+	{ KE_KEY, 0x11, KEY_PROG1 },
+	{ KE_KEY, 0x12, KEY_PROG2 },
+	{ KE_BLUETOOTH, 0x44, 0 },
+	{ KE_WIFI, 0x30, 0 },
+	{ KE_END, 0 }
+};
+
 /*
  * If your machine is not here (which is currently rather likely), please send
  * a list of buttons and their key codes (reported when loading this module
@@ -320,6 +330,15 @@ static struct dmi_system_id dmi_ids[] = 
 		},
 		.driver_data = keymap_acer_aspire_1500
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer TravelMate 240",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 240"),
+		},
+		.driver_data = keymap_acer_travelmate_240
+	},
 	{ NULL, }
 };
 

