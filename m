Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWIJRJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWIJRJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWIJRJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:09:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50918 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932313AbWIJRJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:09:18 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 3/6] V4L/DVB (4520): Fix an error when loading bttv driver
	on PV M4900.
Date: Sun, 10 Sep 2006 14:06:45 -0300
Message-id: <20060910170645.PS5992350003@infradead.org>
In-Reply-To: <20060910170419.PS3030230000@infradead.org>
References: <20060910170419.PS3030230000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

Previously, this were reported:
	Ooops: IR config error [card=139]

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/bt8xx/bttv-input.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/bt8xx/bttv-input.c b/drivers/media/video/bt8xx/bttv-input.c
index b41f81d..933d6db 100644
--- a/drivers/media/video/bt8xx/bttv-input.c
+++ b/drivers/media/video/bt8xx/bttv-input.c
@@ -303,6 +303,7 @@ int bttv_input_init(struct bttv *btv)
 		ir->mask_keyup   = 0x010000;
 		ir->polling      = 50; // ms
 		break;
+	case BTTV_BOARD_PV_M4900:
 	case BTTV_BOARD_PV_BT878P_9B:
 	case BTTV_BOARD_PV_BT878P_PLUS:
 		ir_codes         = ir_codes_pixelview;

