Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWCAO7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWCAO7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWCAO7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:59:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22948 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932370AbWCAO7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:59:02 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 13/13] ELSA EX-VISION 500TV: fix incorrect PCI subsystem ID
Date: Wed, 01 Mar 2006 09:05:40 -0300
Message-id: <20060301120540.PS60358900013@infradead.org>
In-Reply-To: <20060301120529.PS80375900000@infradead.org>
References: <20060301120529.PS80375900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1141064569 \-0300

- ELSA EX-VISION 500TV was incorrectly programmed to have the same
  subsystem ID as ELSA EX-VISION 300TV, (1048:226b)
- This changeset replaces the incorrect subsystem ID (1048:226b)
  with the correct one (1048:226a) for the ELSA EX-VISION 500TV.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 Documentation/video4linux/CARDLIST.saa7134  |    2 +-
 drivers/media/video/saa7134/saa7134-cards.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index 9d48fb3..da4fb89 100644
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
index cd37880..479b010 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2749,7 +2749,7 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
 		.subvendor    = 0x1048,
-		.subdevice    = 0x226b,
+		.subdevice    = 0x226a,
 		.driver_data  = SAA7134_BOARD_ELSA_500TV,
 	},{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,

