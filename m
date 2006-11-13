Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754572AbWKMMYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbWKMMYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754554AbWKMMXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:23:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19153 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754540AbWKMMXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:23:37 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, "pasky@ucw.cz" <pasky@ucw.cz>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 5/8] V4L/DVB (4815): Remote support for Avermedia A16AR
Date: Mon, 13 Nov 2006 10:18:44 -0200
Message-id: <20061113121844.PS1931050005@infradead.org>
In-Reply-To: <20061113121504.PS7687690000@infradead.org>
References: <20061113121504.PS7687690000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: pasky@ucw.cz <pasky@ucw.cz>

The remote as well as the GPIO interface is the same as what comes with 777.
For an example of mplayer lirc configuration, see
	http://pasky.or.cz/~pasky/dev/v4l/lircrc

Signed-off-by: Petr Baudis <pasky@ucw.cz>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7134/saa7134-cards.c |    2 +-
 drivers/media/video/saa7134/saa7134-input.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 94324b3..1a402e4 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -3735,6 +3735,7 @@ int saa7134_board_init1(struct saa7134_d
 	case SAA7134_BOARD_FLYDVBT_LR301:
 	case SAA7134_BOARD_FLYDVBTDUO:
 	case SAA7134_BOARD_PROTEUS_2309:
+	case SAA7134_BOARD_AVERMEDIA_A16AR:
 		dev->has_remote = SAA7134_REMOTE_GPIO;
 		break;
 	case SAA7134_BOARD_FLYDVBS_LR300:
@@ -3773,7 +3774,6 @@ int saa7134_board_init1(struct saa7134_d
 		saa_writeb(SAA7134_GPIO_GPMODE3, 0x08);
 		saa_writeb(SAA7134_GPIO_GPSTATUS3, 0x00);
 		break;
-	case SAA7134_BOARD_AVERMEDIA_A16AR:
 	case SAA7134_BOARD_AVERMEDIA_CARDBUS:
 		/* power-up tuner chip */
 		saa_andorl(SAA7134_GPIO_GPMODE0 >> 2,   0xffffffff, 0xffffffff);
diff --git a/drivers/media/video/saa7134/saa7134-input.c b/drivers/media/video/saa7134/saa7134-input.c
index e8dcb6f..7f62403 100644
--- a/drivers/media/video/saa7134/saa7134-input.c
+++ b/drivers/media/video/saa7134/saa7134-input.c
@@ -185,7 +185,6 @@ int saa7134_input_init1(struct saa7134_d
 	case SAA7134_BOARD_AVERMEDIA_STUDIO_305:
 	case SAA7134_BOARD_AVERMEDIA_STUDIO_307:
 	case SAA7134_BOARD_AVERMEDIA_GO_007_FM:
-	case SAA7134_BOARD_AVERMEDIA_A16AR:
 		ir_codes     = ir_codes_avermedia;
 		mask_keycode = 0x0007C8;
 		mask_keydown = 0x000010;
@@ -195,6 +194,7 @@ int saa7134_input_init1(struct saa7134_d
 		saa_setb(SAA7134_GPIO_GPSTATUS0, 0x4);
 		break;
 	case SAA7134_BOARD_AVERMEDIA_777:
+	case SAA7134_BOARD_AVERMEDIA_A16AR:
 		ir_codes     = ir_codes_avermedia;
 		mask_keycode = 0x02F200;
 		mask_keydown = 0x000400;

