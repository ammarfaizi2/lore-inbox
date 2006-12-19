Return-Path: <linux-kernel-owner+w=401wt.eu-S932708AbWLSJN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbWLSJN6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbWLSJN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:13:58 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:49947 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932708AbWLSJN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:13:57 -0500
X-Originating-Ip: 24.148.236.183
Date: Tue, 19 Dec 2006 04:08:29 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] sound: Change final two instances of kcalloc(1,...) to
 kzalloc().
Message-ID: <Pine.LNX.4.64.0612190406060.18099@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.495, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Change the two remaining instances in the tree of kcalloc(1,...) to
the corresponding kzalloc() call.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fb96144..5ebdd8a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5936,7 +5936,7 @@ static int patch_alc262(struct hda_codec *codec)
 	int board_config;
 	int err;

-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;

@@ -6795,7 +6795,7 @@ static int patch_alc861(struct hda_codec *codec)
 	int board_config;
 	int err;

-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;

