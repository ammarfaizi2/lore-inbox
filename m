Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965805AbWCTQJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965805AbWCTQJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965803AbWCTQJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:09:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21144 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966308AbWCTPO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:14:29 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Marco Manenti <marco_manenti@colman.it>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 053/141] V4L/DVB (3297): Add IR support to KWorld DVB-T
	(cx22702-based)
Date: Mon, 20 Mar 2006 12:08:45 -0300
Message-id: <20060320150845.PS819456000053@infradead.org>
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

From: Marco Manenti <marco_manenti@colman.it>
Date: 1139301933 -0200

add IR support to KWorld DVB-T (cx22702-based)

Signed-off-by: Marco Manenti <marco_manenti@colman.it>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx88/cx88-input.c b/drivers/media/video/cx88/cx88-input.c
diff --git a/drivers/media/video/cx88/cx88-input.c b/drivers/media/video/cx88/cx88-input.c
index 800e2b3..f2fba57 100644
--- a/drivers/media/video/cx88/cx88-input.c
+++ b/drivers/media/video/cx88/cx88-input.c
@@ -151,6 +151,7 @@ int cx88_ir_init(struct cx88_core *core,
 	switch (core->board) {
 	case CX88_BOARD_DNTV_LIVE_DVB_T:
 	case CX88_BOARD_KWORLD_DVB_T:
+	case CX88_BOARD_KWORLD_DVB_T_CX22702:
 		ir_codes = ir_codes_dntv_live_dvb_t;
 		ir->gpio_addr = MO_GP1_IO;
 		ir->mask_keycode = 0x1f;

