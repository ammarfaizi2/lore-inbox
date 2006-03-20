Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965276AbWCTPWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbWCTPWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966833AbWCTPVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:21:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45026 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966834AbWCTPVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:21:23 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 126/141] V4L/DVB (3399): ELSA EX-VISION 500TV: fix
	incorrect PCI subsystem ID
Date: Mon, 20 Mar 2006 12:08:58 -0300
Message-id: <20060320150858.PS066588000126@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1141064569 -0300

- ELSA EX-VISION 500TV was incorrectly programmed to have the same
  subsystem ID as ELSA EX-VISION 300TV, (1048:226b)
- This changeset replaces the incorrect subsystem ID (1048:226b)
  with the correct one (1048:226a) for the ELSA EX-VISION 500TV.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index 8435a21..17ea5a0 100644
--- a/Documentation/video4linux/CARDLIST.saa7134
+++ b/Documentation/video4linux/CARDLIST.saa7134
@@ -13,7 +13,7 @@
  12 -> Medion 7134                              [16be:0003]
  13 -> Typhoon TV+Radio 90031
  14 -> ELSA EX-VISION 300TV                     [1048:226b]
- 15 -> ELSA EX-VISION 500TV                     [1048:226b]
+ 15 -> ELSA EX-VISION 500TV                     [1048:226a]
  16 -> ASUS TV-FM 7134                          [1043:4842,1043:4830,1043:4840]
  17 -> AOPEN VA1000 POWER                       [1131:7133]
  18 -> BMK MPEX No Tuner
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 384f6f2..f156650 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2882,7 +2882,7 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
 		.subvendor    = 0x1048,
-		.subdevice    = 0x226b,
+		.subdevice    = 0x226a,
 		.driver_data  = SAA7134_BOARD_ELSA_500TV,
 	},{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,

