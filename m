Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966324AbWCTPOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966324AbWCTPOv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966339AbWCTPOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:14:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23960 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966325AbWCTPOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:14:41 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       TAMUKI Shoichi <tamuki@linet.gr.jp>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 125/141] V4L/DVB (3398): ELSA EX-VISION 700TV: fix
	incorrect PCI subsystem ID
Date: Mon, 20 Mar 2006 12:08:58 -0300
Message-id: <20060320150857.PS905529000125@infradead.org>
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
Date: 1141061897 -0300

- Corrected autodetection for saa7130 card:
  subsystem: 1048:226c, board: ELSA EX-VISION 700TV

Signed-off-by: TAMUKI Shoichi <tamuki@linet.gr.jp>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index e1484df..8435a21 100644
--- a/Documentation/video4linux/CARDLIST.saa7134
+++ b/Documentation/video4linux/CARDLIST.saa7134
@@ -87,5 +87,5 @@
  86 -> LifeView FlyDVB-T                        [5168:0301]
  87 -> ADS Instant TV Duo Cardbus PTV331        [0331:1421]
  88 -> Tevion DVB-T 220RF                       [17de:7201]
- 89 -> ELSA EX-VISION 700TV                     [1131:7130]
+ 89 -> ELSA EX-VISION 700TV                     [1048:226c]
  90 -> Kworld ATSC110                           [17de:7350]
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 288d1f8..384f6f2 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2887,8 +2887,8 @@ struct pci_device_id saa7134_pci_tbl[] =
 	},{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
-		.subvendor    = 0x1131,
-		.subdevice    = 0x7130,
+		.subvendor    = 0x1048,
+		.subdevice    = 0x226c,
 		.driver_data  = SAA7134_BOARD_ELSA_700TV,
 	},{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,

