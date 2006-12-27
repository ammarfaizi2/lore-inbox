Return-Path: <linux-kernel-owner+w=401wt.eu-S933013AbWL0ROG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013AbWL0ROG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932997AbWL0RNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:13:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41538 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933013AbWL0RNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:13:35 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Stephan Berberig <s.berberig@arcor.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 20/28] V4L/DVB (4992): Fix typo in saa7134-dvb.c
Date: Wed, 27 Dec 2006 14:57:31 -0200
Message-id: <20061227165731.PS25572700020@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Stephan Berberig <s.berberig@arcor.de>

Fix a typo (use_frontent -> use_frontend) in saa7134-dvb.c.

Signed-off-by: Stephan Berberig <s.berberig@arcor.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7134/saa7134-dvb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
index fa83398..c33f6a6 100644
--- a/drivers/media/video/saa7134/saa7134-dvb.c
+++ b/drivers/media/video/saa7134/saa7134-dvb.c
@@ -50,9 +50,9 @@ static unsigned int antenna_pwr = 0;
 module_param(antenna_pwr, int, 0444);
 MODULE_PARM_DESC(antenna_pwr,"enable antenna power (Pinnacle 300i)");
 
-static int use_frontent = 0;
-module_param(use_frontent, int, 0644);
-MODULE_PARM_DESC(use_frontent,"for cards with multiple frontends (0: terrestrial, 1: satellite)");
+static int use_frontend = 0;
+module_param(use_frontend, int, 0644);
+MODULE_PARM_DESC(use_frontend,"for cards with multiple frontends (0: terrestrial, 1: satellite)");
 
 /* ------------------------------------------------------------------ */
 static int pinnacle_antenna_pwr(struct saa7134_dev *dev, int on)
@@ -1303,7 +1303,7 @@ static int dvb_init(struct saa7134_dev *
 		}
 		break;
 	case SAA7134_BOARD_FLYDVB_TRIO:
-		if(! use_frontent) {	//terrestrial
+		if(! use_frontend) {	//terrestrial
 			dev->dvb.frontend = dvb_attach(tda10046_attach,
 						       &lifeview_trio_config,
 						       &dev->i2c_adap);

