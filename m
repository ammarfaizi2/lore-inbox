Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVIDXuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVIDXuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVIDXt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:49:56 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:41601 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932130AbVIDXaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:35 -0400
Message-Id: <20050904232329.989375000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:35 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Stuart Auchterlonie <stuarta@squashedfrog.net>
Content-Disposition: inline; filename=dvb-bt8xx-nebula-digitv-nxt600-fix.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 36/54] Nebula DigiTV nxt6000 fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Auchterlonie <stuarta@squashedfrog.net>

Fix bug in Nebula DigiTV frontend detection for nxt6000.

Signed-off-by: Stuart Auchterlonie <stuarta@squashedfrog.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dvb-bt8xx.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-09-04 22:28:29.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-09-04 22:28:30.000000000 +0200
@@ -574,8 +574,10 @@ static void frontend_init(struct dvb_bt8
 
 		/* Old Nebula (marked (c)2003 on high profile pci card) has nxt6000 demod */
 		card->fe = nxt6000_attach(&vp3021_alps_tded4_config, card->i2c_adapter);
-		if (card->fe != NULL)
+		if (card->fe != NULL) {
 			dprintk ("dvb_bt8xx: an nxt6000 was detected on your digitv card\n");
+			break;
+		}
 
 		/* New Nebula (marked (c)2005 on low profile pci card) has mt352 demod */
 		digitv_alps_tded4_reset(card);

--

