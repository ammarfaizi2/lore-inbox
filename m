Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVJFT0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVJFT0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVJFT0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:26:08 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:11537 "EHLO
	smtp-vbr15.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751329AbVJFT0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:26:06 -0400
Date: Thu, 6 Oct 2005 21:26:14 +0200
From: Dick Streefland <dick@streefland.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] enable ac97_quirk hp_only for Acer Aspire 3003LCi
Message-ID: <20051006192614.GA3300@streefland.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my Acer Aspire 3003LCi laptop, the speaker volume is not controlled
by the master control, but by the headphone control. Enabling the
"hp_only" quirk corrects this. The patch below adds this device to the
list of known quirks.

Signed-off-by: Dick Streefland <dick@streefland.net>

--- linux-2.6.13.2/sound/pci/intel8x0.c.orig	2005-09-29 21:44:46.000000000 +0200
+++ linux-2.6.13.2/sound/pci/intel8x0.c	2005-10-06 02:06:58.000000000 +0200
@@ -1750,6 +1750,12 @@ static struct ac97_quirk ac97_quirks[] _
 		.type = AC97_TUNE_ALC_JACK
 	},
 	{
+		.subvendor = 0x1025,
+		.subdevice = 0x0083,
+		.name = "Acer Aspire 3003LCi",
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
 		.subvendor = 0x1028,
 		.subdevice = 0x00d8,
 		.name = "Dell Precision 530",	/* AD1885 */
