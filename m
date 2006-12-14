Return-Path: <linux-kernel-owner+w=401wt.eu-S1752035AbWLNHfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbWLNHfZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 02:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbWLNHfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 02:35:25 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:34607 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbWLNHfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 02:35:24 -0500
X-Originating-Ip: 74.109.98.100
Date: Thu, 14 Dec 2006 02:30:55 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] sound: Fix last two instances of "kcalloc(1,...)" ->
 "kzalloc()"
Message-ID: <Pine.LNX.4.64.0612140221440.11794@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.541, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Change the remaining two instances of "kcalloc(1,...)" to
"kzalloc()".

Signed-off-by:  Robert P. J. Day <rpjday@mindspring.com>

---

  Now that that general change has been merged into Linus' tree, I've
added a check for that to an ongoing "coding style" script of mine
that scans the tree on a regular basis to detect stuff that shouldn't
be there anymore.  Having subjected everyone to the unspeakable grief
of getting that patch in in the first place, I'm going to make sure
stuff like that never comes back.

  As Barney Fife would say, "Nip it!  Nip it in the bud!"



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

