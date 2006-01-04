Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWADWBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWADWBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWADWBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:01:13 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:26613 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S932562AbWADWBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:01:11 -0500
Date: Wed, 04 Jan 2006 17:00:49 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 09/15] wistron_btns: Add Acer TravelMate 240 key mappings.
To: linux-kernel@vger.kernel.org
Message-id: <0ISL00ELB95T6A@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 drivers/input/misc/wistron_btns.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

c8521d17183d2ac5eff08d765bb4ee3bea1bf4d4
diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index bac3085..b77e269 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
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
 
-- 
1.0.5
