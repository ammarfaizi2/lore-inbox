Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966282AbWCTPOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966282AbWCTPOF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966280AbWCTPN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:13:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64738 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966239AbWCTPNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:13:18 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 111/141] V4L/DVB (3380): TUV1236d: declare buffer as static
	const
Date: Mon, 20 Mar 2006 12:08:55 -0300
Message-id: <20060320150855.PS513982000111@infradead.org>
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
Date: 1141009754 -0300

Make buffer a static const

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index cc9d660..44e27dc 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1487,7 +1487,7 @@ void cx88_card_setup(struct cx88_core *c
 		if (0 == core->i2c_rc) {
 			/* enable tuner */
 			int i;
-			u8 buffer [] = { 0x10,0x12,0x13,0x04,0x16,0x00,0x14,0x04,0x017,0x00 };
+			static const u8 buffer [] = { 0x10,0x12,0x13,0x04,0x16,0x00,0x14,0x04,0x017,0x00 };
 			core->i2c_client.addr = 0x0a;
 
 			for (i = 0; i < 5; i++)
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index eaf32b8..ccf7231 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -3554,7 +3554,7 @@ int saa7134_board_init2(struct saa7134_d
 		{
 			/* enable tuner */
 			int i;
-			u8 buffer [] = { 0x10,0x12,0x13,0x04,0x16,0x00,0x14,0x04,0x017,0x00 };
+			static const u8 buffer [] = { 0x10,0x12,0x13,0x04,0x16,0x00,0x14,0x04,0x017,0x00 };
 			dev->i2c_client.addr = 0x0a;
 			for (i = 0; i < 5; i++)
 				if (2 != i2c_master_send(&dev->i2c_client,&buffer[i*2],2))

