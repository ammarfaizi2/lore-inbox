Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVIJWjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVIJWjX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVIJWeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:04 -0400
Received: from styx.suse.cz ([82.119.242.94]:25252 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932345AbVIJWdu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:50 -0400
Subject: [PATCH 10/26] i8042 - add Lifebook E4010 to MUX blacklist
In-Reply-To: <1126391652208@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:12 +0200
Message-Id: <11263916523302@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: i8042 - add Lifebook E4010 to MUX blacklist
From: Dmitry Torokhov <dtor_core@ameritech.net>
Date: 1125816130 -0500

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

7545c24c6a6ab62922266197a72119212280ea2a
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -138,6 +138,13 @@ static struct dmi_system_id __initdata i
 		},
 	},
 	{
+		.ident = "Fujitsu-Siemens Lifebook E4010",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E4010"),
+		},
+	},
+	{
 		.ident = "Toshiba P10",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),

