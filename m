Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWDDS6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWDDS6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 14:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWDDS6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 14:58:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37903 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750806AbWDDS6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 14:58:14 -0400
Date: Tue, 4 Apr 2006 20:58:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] video/bt8xx/bttv-cards.c: fix off-by-one errors
Message-ID: <20060404185813.GY6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two off-by-one errors spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/bt8xx/bttv-cards.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc1-mm1-full/drivers/media/video/bt8xx/bttv-cards.c.old	2006-04-04 20:27:10.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/media/video/bt8xx/bttv-cards.c	2006-04-04 20:28:24.000000000 +0200
@@ -2991,13 +2991,13 @@ void __devinit bttv_idcard(struct bttv *
 
 	if (UNSET != audiomux[0]) {
 		gpiobits = 0;
-		for (i = 0; i < 5; i++) {
+		for (i = 0; i < 4; i++) {
 			bttv_tvcards[btv->c.type].gpiomux[i] = audiomux[i];
 			gpiobits |= audiomux[i];
 		}
 	} else {
 		gpiobits = audioall;
-		for (i = 0; i < 5; i++) {
+		for (i = 0; i < 4; i++) {
 			bttv_tvcards[btv->c.type].gpiomux[i] = audioall;
 		}
 	}

