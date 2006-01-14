Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWANQBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWANQBL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWANQBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:01:11 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:4542 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932294AbWANQBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:01:09 -0500
Message-Id: <20060114154832.646692000.dtor_core@ameritech.net>
References: <20060114151645.035957000.dtor_core@ameritech.net>
Date: Sat, 14 Jan 2006 10:16:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [git pull 1/7] Add Sony Vaio FSC-115b to i8042 MUX blacklist
Content-Disposition: inline; filename=i8042-sony-fs-115b-nomux.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Input: i8042 - add Sony Vaio FSC-115b to MUX blacklist

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 files changed, 7 insertions(+)

Index: work/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- work.orig/drivers/input/serio/i8042-x86ia64io.h
+++ work/drivers/input/serio/i8042-x86ia64io.h
@@ -173,6 +173,13 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_PRODUCT_NAME, "PC-MM20 Series"),
 		},
 	},
+	{
+		.ident = "Sony Vaio FS-115b",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FS115B"),
+		},
+	},
 	{ }
 };
 

