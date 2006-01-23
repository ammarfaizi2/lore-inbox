Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWAWU0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWAWU0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWAWU0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:26:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16069 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932477AbWAWU0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:26:42 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 08/16] rename dvb_pll_tbmv30111in to dvb_pll_samsung_tbmv
Date: Mon, 23 Jan 2006 18:24:44 -0200
Message-id: <20060123202444.PS50233700008@infradead.org>
In-Reply-To: <20060123202404.PS66974000000@infradead.org>
References: <20060123202404.PS66974000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@m1k.net>

- rename dvb_pll_tbmv30111in to dvb_pll_samsung_tbmv

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/b2c2/flexcop-fe-tuner.c |    2 +-
 drivers/media/dvb/frontends/dvb-pll.c     |    6 +++---
 drivers/media/dvb/frontends/dvb-pll.h     |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb/b2c2/flexcop-fe-tuner.c b/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
index dbe6f6b..390cc3a 100644
--- a/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
+++ b/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
@@ -346,7 +346,7 @@ static struct lgdt330x_config air2pc_ats
 static struct nxt200x_config samsung_tbmv_config = {
 	.demod_address    = 0x0a,
 	.pll_address      = 0xc2,
-	.pll_desc         = &dvb_pll_tbmv30111in,
+	.pll_desc         = &dvb_pll_samsung_tbmv,
 };
 
 static struct bcm3510_config air2pc_atsc_first_gen_config = {
diff --git a/drivers/media/dvb/frontends/dvb-pll.c b/drivers/media/dvb/frontends/dvb-pll.c
index 9c9c12a..4dcb605 100644
--- a/drivers/media/dvb/frontends/dvb-pll.c
+++ b/drivers/media/dvb/frontends/dvb-pll.c
@@ -329,8 +329,8 @@ EXPORT_SYMBOL(dvb_pll_tuv1236d);
 /* Samsung TBMV30111IN / TBMV30712IN1
  * used in Air2PC ATSC - 2nd generation (nxt2002)
  */
-struct dvb_pll_desc dvb_pll_tbmv30111in = {
-	.name = "Samsung TBMV30111IN",
+struct dvb_pll_desc dvb_pll_samsung_tbmv = {
+	.name = "Samsung TBMV30111IN / TBMV30712IN1",
 	.min = 54000000,
 	.max = 860000000,
 	.count = 6,
@@ -343,7 +343,7 @@ struct dvb_pll_desc dvb_pll_tbmv30111in 
 		{ 999999999, 44000000, 166666, 0xfc, 0x02 },
 	}
 };
-EXPORT_SYMBOL(dvb_pll_tbmv30111in);
+EXPORT_SYMBOL(dvb_pll_samsung_tbmv);
 
 /*
  * Philips SD1878 Tuner.
diff --git a/drivers/media/dvb/frontends/dvb-pll.h b/drivers/media/dvb/frontends/dvb-pll.h
index f682c09..bb8d4b4 100644
--- a/drivers/media/dvb/frontends/dvb-pll.h
+++ b/drivers/media/dvb/frontends/dvb-pll.h
@@ -38,7 +38,7 @@ extern struct dvb_pll_desc dvb_pll_tded4
 
 extern struct dvb_pll_desc dvb_pll_tuv1236d;
 extern struct dvb_pll_desc dvb_pll_tdhu2;
-extern struct dvb_pll_desc dvb_pll_tbmv30111in;
+extern struct dvb_pll_desc dvb_pll_samsung_tbmv;
 extern struct dvb_pll_desc dvb_pll_philips_sd1878_tda8261;
 
 int dvb_pll_configure(struct dvb_pll_desc *desc, u8 *buf,

