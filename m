Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVAEPwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVAEPwF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVAEPv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:51:26 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:22278 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262085AbVAEPjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:39:52 -0500
Date: Wed, 5 Jan 2005 10:40:45 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [patch] snd-intel8x0: ac97 quirk entries for HP xw6200 & xw8000
Message-ID: <20050105154043.GB28626@tuxdriver.com>
Mail-Followup-To: perex@suse.cz, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add AC97 quick list entries to snd-intel8x0 for HP xw6200 and xw8000.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 sound/pci/intel8x0.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

--- ac97_quirk/sound/pci/intel8x0.c.orig	2005-01-04 16:42:48.978078335 -0500
+++ ac97_quirk/sound/pci/intel8x0.c	2005-01-04 16:46:40.698137218 -0500
@@ -1756,7 +1756,13 @@
 	{	/* FIXME: which codec? */
 		.vendor = 0x103c,
 		.device = 0x00c3,
-		.name = "Hewlett-Packard onboard",
+		.name = "HP xw6000",
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x103c,
+		.device = 0x129d,
+		.name = "HP xw8000",
 		.type = AC97_TUNE_HP_ONLY
 	},
 	{
@@ -1767,6 +1773,12 @@
 	},
 	{
 		.vendor = 0x103c,
+		.device = 0x12f2,
+		.name = "HP xw6200",
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x103c,
 		.device = 0x3008,
 		.name = "HP xw4200",	/* AD1981B*/
 		.type = AC97_TUNE_HP_ONLY
