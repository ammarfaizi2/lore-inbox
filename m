Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWCTPaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWCTPaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWCTP2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:28:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50616 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964837AbWCTP1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:27:41 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 088/141] V4L/DVB (3343): KWorld HardwareMpegTV XPert: Add
	radio support
Date: Mon, 20 Mar 2006 12:08:51 -0300
Message-id: <20060320150851.PS702955000088@infradead.org>
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
Date: 1141009678 -0300

- add radio support for KWorld HardwareMpegTV XPert
- fix GPIO settings for tv and radio

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index f2ae047..8617b08 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1064,8 +1064,12 @@ struct cx88_board cx88_boards[] = {
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
-			.gpio0  = 0x07fa,
+			.gpio0  = 0x3de2,
 		}},
+		.radio = {
+			.type   = CX88_RADIO,
+			.gpio0  = 0x3de6,
+		},
 	},
 
 };

