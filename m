Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVE2FDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVE2FDU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVE2FCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:02:53 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:38795 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261248AbVE2FBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:01:09 -0400
Message-Id: <20050529045847.967218000.dtor_core@ameritech.net>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:25 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 12/13] i8042: dont activate MUX mode on Fujitsu Lifebook S6230
Content-Disposition: inline; filename=fujitsu-more-nomux.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: yet another model that does not play nicely when i8042 is
       put in MUX mode - Fujitsu Lifebook S6230

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 files changed, 7 insertions(+)

Index: work/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- work.orig/drivers/input/serio/i8042-x86ia64io.h
+++ work/drivers/input/serio/i8042-x86ia64io.h
@@ -117,6 +117,13 @@ static struct dmi_system_id __initdata i
 		},
 	},
 	{
+		.ident = "Fujitsu Lifebook S6230",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S6230"),
+		},
+	},
+	{
 		.ident = "Fujitsu T70H",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),

