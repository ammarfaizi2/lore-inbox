Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWGQQpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWGQQpB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWGQQcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:27322 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750936AbWGQQbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:31:50 -0400
Date: Mon, 17 Jul 2006 09:29:10 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Takashi Iwai <tiwai@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 39/45] ALSA: Fix model for HP dc7600
Message-ID: <20060717162910.GN4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alsa-fix-model-for-hp-dc7600.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: Fix model for HP dc7600

Changed the assigned model for HP dc7600 with ALC260 codec
to match better with the actual I/O assignment.
Patch taken from ALSA bug#2157.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.6.orig/sound/pci/hda/patch_realtek.c
+++ linux-2.6.17.6/sound/pci/hda/patch_realtek.c
@@ -3827,7 +3827,7 @@ static struct hda_board_config alc260_cf
 	{ .modelname = "hp", .config = ALC260_HP },
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3010, .config = ALC260_HP },
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3011, .config = ALC260_HP },
-	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3012, .config = ALC260_HP },
+	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3012, .config = ALC260_HP_3013 },
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3013, .config = ALC260_HP_3013 },
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3014, .config = ALC260_HP },
 	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3015, .config = ALC260_HP },

--
