Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUHPSYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUHPSYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUHPSYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:24:06 -0400
Received: from apollo.tuxdriver.com ([24.172.12.4]:18957 "EHLO
	ra.tuxdriver.com") by vger.kernel.org with ESMTP id S266149AbUHPSYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:24:02 -0400
Date: Mon, 16 Aug 2004 13:19:34 -0400
From: "John W. Linville" <linville@tuxdriver.com>
Message-Id: <200408161719.i7GHJYJ06048@ra.tuxdriver.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.6 -- add to snd-intel8x0 AC97 quirk list
Cc: alsa-devel@alsa-project.org, perex@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some additions to the AC97 quirk list for the snd-intel8x0 driver.

"It works for me!" -- pretty simple patch...

John

diff -urNp linux-2.6.8.orig/sound/pci/intel8x0.c linux-2.6.8/sound/pci/intel8x0.c
--- linux-2.6.8.orig/sound/pci/intel8x0.c	2004-08-14 01:37:15.000000000 -0400
+++ linux-2.6.8/sound/pci/intel8x0.c	2004-08-16 10:45:22.018793582 -0400
@@ -1823,6 +1823,24 @@ static struct ac97_quirk ac97_quirks[] _
 		.type = AC97_TUNE_HP_ONLY
 	},
 #endif
+	{
+		.vendor = 0x1028,
+		.device = 0x012d,
+		.name = "Dell Precision 450",	/* AD1981B*/
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x103c,
+		.device = 0x3008,
+		.name = "HP xw4200",	/* AD1981B*/
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x103c,
+		.device = 0x12f1,
+		.name = "HP xw8200",	/* AD1981B*/
+		.type = AC97_TUNE_HP_ONLY
+	},
 	{ } /* terminator */
 };
 
