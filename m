Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030546AbWAGTIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030546AbWAGTIt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbWAGTI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:08:27 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:59759 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030550AbWAGTIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:22 -0500
Message-Id: <20060107172100.559329000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:08 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 09/24] i8042: disable MUX mode for Sharp MM20
Content-Disposition: inline; filename=i8042-sharp-mm20-nomux.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: i8042 - disable MUX mode for Sharp MM20

Add yet another entry to the ever-growing list of boxes with
non-working MUX implementation.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- linux.orig/drivers/input/serio/i8042-x86ia64io.h
+++ linux/drivers/input/serio/i8042-x86ia64io.h
@@ -158,6 +158,13 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_PRODUCT_NAME, "Sentia"),
 		},
 	},
+	{
+		.ident = "Sharp Actius MM20",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PC-MM20 Series"),
+		},
+	},
 	{ }
 };
 

