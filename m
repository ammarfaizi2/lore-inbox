Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbWCTPNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWCTPNI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966231AbWCTPNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:13:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63714 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965152AbWCTPNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:13:07 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Rudo Thomas <rudo@matfyz.cz>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 102/141] V4L/DVB (3369): LifeView FlyDVB-T Duo: add support
	for remote control
Date: Mon, 20 Mar 2006 12:08:54 -0300
Message-id: <20060320150853.PS993285000102@infradead.org>
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

From: Rudo Thomas <rudo@matfyz.cz>
Date: 1141009726 -0300

The remote controller on the LifeView FlyDVB-T Duo card work flawlessly
with the same settings as the LifeView FlyDVB-T LR301 card.

Signed-off-by: Rudo Thomas <rudo@matfyz.cz>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index e1145a8..ca90a73 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -3362,6 +3362,7 @@ int saa7134_board_init1(struct saa7134_d
 	case SAA7134_BOARD_KWORLD_TERMINATOR:
 	case SAA7134_BOARD_SEDNA_PC_TV_CARDBUS:
 	case SAA7134_BOARD_FLYDVBT_LR301:
+	case SAA7134_BOARD_FLYDVBTDUO:
 		dev->has_remote = SAA7134_REMOTE_GPIO;
 		break;
 	case SAA7134_BOARD_MD5044:
diff --git a/drivers/media/video/saa7134/saa7134-input.c b/drivers/media/video/saa7134/saa7134-input.c
diff --git a/drivers/media/video/saa7134/saa7134-input.c b/drivers/media/video/saa7134/saa7134-input.c
index 6970334..1426e4c 100644
--- a/drivers/media/video/saa7134/saa7134-input.c
+++ b/drivers/media/video/saa7134/saa7134-input.c
@@ -231,6 +231,7 @@ int saa7134_input_init1(struct saa7134_d
 		mask_keyup   = 0x040000;
 		break;
 	case SAA7134_BOARD_FLYDVBT_LR301:
+	case SAA7134_BOARD_FLYDVBTDUO:
 		ir_codes     = ir_codes_flydvb;
 		mask_keycode = 0x0001F00;
 		mask_keydown = 0x0040000;

