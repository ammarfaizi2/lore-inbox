Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVGYGeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVGYGeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVGYF5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:57:11 -0400
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:9854 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261717AbVGYFzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:55:51 -0400
Message-Id: <20050725054532.520508000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:02 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 13/24] i8042 - add Fujitsu T3010 to NOMUX blacklist
Content-Disposition: inline; filename=i8042-nomux-fsc-t3010.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Input: i8042 - add Fujitsu T3010 to NOMUX blacklist.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 files changed, 7 insertions(+)

Index: work/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- work.orig/drivers/input/serio/i8042-x86ia64io.h
+++ work/drivers/input/serio/i8042-x86ia64io.h
@@ -131,6 +131,13 @@ static struct dmi_system_id __initdata i
 		},
 	},
 	{
+		.ident = "Fujitsu-Siemens Lifebook T3010",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T3010"),
+		},
+	},
+	{
 		.ident = "Toshiba P10",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),

