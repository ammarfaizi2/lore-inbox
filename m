Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbUL0Apm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbUL0Apm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 19:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUL0Apm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 19:45:42 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38298 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261360AbUL0Apg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 19:45:36 -0500
Subject: PATCH: 2.6.10: i810 more AC97 tunings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104104497.16487.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 23:41:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some more funky AC97 knowledge to the intel8x0 driver. These come
from Red Hat and its partners and are included in our shipping code.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/sound/pci/intel8x0.c linux-2.6.10/sound/pci/intel8x0.c
--- linux.vanilla-2.6.10/sound/pci/intel8x0.c	2004-12-25 21:15:54.000000000 +0000
+++ linux-2.6.10/sound/pci/intel8x0.c	2004-12-26 16:56:04.660850232 +0000
@@ -1880,6 +1880,24 @@
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
 

