Return-Path: <linux-kernel-owner+w=401wt.eu-S1755247AbXAASKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247AbXAASKQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 13:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbXAASKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 13:10:16 -0500
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:53227 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755243AbXAASKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 13:10:14 -0500
X-Greylist: delayed 4148 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jan 2007 13:10:14 EST
Message-ID: <45993E46.7000904@refactor.fi>
Date: Mon, 01 Jan 2007 19:00:54 +0200
From: Leonard Norrgard <leonard.norrgard@refactor.fi>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: [PATCH] sound: hda: detect ALC883 on MSI K9A Platinum motherboards
 (MS-7280)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Norrgård <leonard.norrgard@refactor.fi>

Recognize the Realtek ALC883 chip on MSI K9A Platinum motherboards
(model no. MS-7280), enabling full sound capabilities.

Signed-off-by: Leonard Norrgård <leonard.norrgard@refactor.fi>

---
Error messages seen before this patch:

cannot find the slot for index 0 (range 0-0)
hda-intel: Error creating card!
HDA Intel: probe of 0000:00:14.2 failed with error -12
---

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 29e4c48..4e0c3c1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5070,6 +5070,8 @@ static struct hda_board_config alc883_cfg_tbl[] = {
     { .modelname = "6stack-dig", .config = ALC883_6ST_DIG },
     { .pci_subvendor = 0x1462, .pci_subdevice = 0x6668,
       .config = ALC883_6ST_DIG }, /* MSI  */
+    { .pci_subvendor = 0x1462, .pci_subdevice = 0x7280,
+      .config = ALC883_6ST_DIG }, /* MSI K9A Platinum (MS-7280) */
     { .pci_subvendor = 0x105b, .pci_subdevice = 0x6668,
       .config = ALC883_6ST_DIG }, /* Foxconn */
     { .modelname = "6stack-dig-demo", .config = ALC888_DEMO_BOARD },


