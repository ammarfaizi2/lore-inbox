Return-Path: <linux-kernel-owner+w=401wt.eu-S932993AbWL0RMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932993AbWL0RMG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932997AbWL0RMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:12:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41464 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932983AbWL0RLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:11:37 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 11/28] V4L/DVB (4973): Dvb-core: fix printk type warning
Date: Wed, 27 Dec 2006 14:57:29 -0200
Message-id: <20061227165729.PS16803000011@infradead.org>
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


From: Michael Krufky <mkrufky@linuxtv.org>

dvb_net.c: In function 'dvb_net_ule':
dvb_net.c:628: warning: format '%#lx' expects type 'long unsigned int', but argument 3 has type 'u32'
dvb_net.c:628: warning: format '%#lx' expects type 'long unsigned int', but argument 4 has type 'u32'

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-core/dvb_net.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/dvb-core/dvb_net.c b/drivers/media/dvb/dvb-core/dvb_net.c
index 8138b37..76e9c36 100644
--- a/drivers/media/dvb/dvb-core/dvb_net.c
+++ b/drivers/media/dvb/dvb-core/dvb_net.c
@@ -618,7 +618,7 @@ #endif
 				       *((u8 *)priv->ule_skb->tail - 2) << 8 |
 				       *((u8 *)priv->ule_skb->tail - 1);
 			if (ule_crc != expected_crc) {
-				printk(KERN_WARNING "%lu: CRC32 check FAILED: %#lx / %#lx, SNDU len %d type %#x, ts_remain %d, next 2: %x.\n",
+				printk(KERN_WARNING "%lu: CRC32 check FAILED: %08x / %08x, SNDU len %d type %#x, ts_remain %d, next 2: %x.\n",
 				       priv->ts_count, ule_crc, expected_crc, priv->ule_sndu_len, priv->ule_sndu_type, ts_remain, ts_remain > 2 ? *(unsigned short *)from_where : 0);
 
 #ifdef ULE_DEBUG

