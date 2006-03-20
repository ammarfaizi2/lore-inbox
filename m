Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWCTQJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWCTQJE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWCTQJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:09:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26008 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966345AbWCTPO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:14:56 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 089/141] V4L/DVB (3344): KWorld HardwareMpegTV XPert must
	set gpio2
Date: Mon, 20 Mar 2006 12:08:51 -0300
Message-id: <20060320150851.PS866602000089@infradead.org>
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
Date: 1141009681 -0300

- KWorld HardwareMpegTV XPert must set gpio2

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index 8617b08..09f5739 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1065,10 +1065,12 @@ struct cx88_board cx88_boards[] = {
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
 			.gpio0  = 0x3de2,
+			.gpio2  = 0x00ff,
 		}},
 		.radio = {
 			.type   = CX88_RADIO,
 			.gpio0  = 0x3de6,
+			.gpio2  = 0x00ff,
 		},
 	},
 

