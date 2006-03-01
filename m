Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWCAPBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWCAPBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWCAPAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:00:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32420 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030209AbWCAPAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 10:00:12 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Karsten Suehring <ksuehring@gmx.net>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 05/13] Pinnacle PCTV 40i: add filtered Composite2 input
Date: Wed, 01 Mar 2006 09:05:38 -0300
Message-id: <20060301120538.PS09583300005@infradead.org>
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


From: Karsten Suehring <ksuehring@gmx.net>
Date: 1141009688 \-0300

This patch adds another composite input to the Pinnacle PCTV 100i
definition which filters the chrominace signal from the luma input. This
improves video quality for Composite signals on the S-Video connector of
the card.
In addition the name string of the card is changed to include PCTV 40i
and 50i since these cards are identical.

Signed-off-by: Karsten Suehring <ksuehring@gmx.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 Documentation/video4linux/CARDLIST.saa7134  |    2 +-
 drivers/media/video/saa7134/saa7134-cards.c |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index 8a35259..9d48fb3 100644
--- a/Documentation/video4linux/CARDLIST.saa7134
+++ b/Documentation/video4linux/CARDLIST.saa7134
@@ -75,7 +75,7 @@
  74 -> LifeView FlyTV Platinum Mini2            [14c0:1212]
  75 -> AVerMedia AVerTVHD MCE A180              [1461:1044]
  76 -> SKNet MonsterTV Mobile                   [1131:4ee9]
- 77 -> Pinnacle PCTV 110i (saa7133)             [11bd:002e]
+ 77 -> Pinnacle PCTV 40i/50i/110i (saa7133)     [11bd:002e]
  78 -> ASUSTeK P7131 Dual                       [1043:4862]
  79 -> Sedna/MuchTV PC TV Cardbus TV/Radio (ITO25 Rev:2B)
  80 -> ASUS Digimatrix TV                       [1043:0210]
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 5a35d3b..dcffd8c 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2392,7 +2392,7 @@ struct saa7134_board saa7134_boards[] = 
 		}},
 	},
 	[SAA7134_BOARD_PINNACLE_PCTV_110i] = {
-		.name           = "Pinnacle PCTV 110i (saa7133)",
+	       .name           = "Pinnacle PCTV 40i/50i/110i (saa7133)",
 		.audio_clock    = 0x00187de7,
 		.tuner_type     = TUNER_PHILIPS_TDA8290,
 		.radio_type     = UNSET,
@@ -2407,6 +2407,10 @@ struct saa7134_board saa7134_boards[] = 
 		},{
 			  .name = name_comp1,
 			  .vmux = 1,
+			 .amux = LINE2,
+	       },{
+			 .name = name_comp2,
+			 .vmux = 0,
 			  .amux = LINE2,
 		},{
 			  .name = name_svideo,

