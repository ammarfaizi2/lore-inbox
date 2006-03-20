Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965282AbWCTPZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965282AbWCTPZy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbWCTPZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:25:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19128 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965282AbWCTPYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:24:32 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Curt Meyers <cmeyers@boilerbots.com>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 098/141] V4L/DVB (3363): Kworld ATSC110: enable composite
	and svideo inputs
Date: Mon, 20 Mar 2006 12:08:53 -0300
Message-id: <20060320150853.PS343710000098@infradead.org>
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

From: Curt Meyers <cmeyers@boilerbots.com>
Date: 1141009712 -0300

- corrected composite input.
- verified s-video input.

Signed-off-by: Curt Meyers <cmeyers@boilerbots.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 6ce9c08..0cc171e 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2745,6 +2745,14 @@ struct saa7134_board saa7134_boards[] = 
 			.vmux = 1,
 			.amux = TV,
 			.tv   = 1,
+		},{
+			.name = name_comp1,
+			.vmux = 3,
+			.amux = LINE2,
+		},{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE2,
 		}},
 	},
 };

