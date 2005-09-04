Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVIDXtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVIDXtx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVIDXaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:30:35 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:33665 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932116AbVIDXaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:18 -0400
Message-Id: <20050904232322.072462000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:15 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Content-Disposition: inline; filename=dvb-frontend-tda1004x-snr-fix.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 16/54] frontend: tda1004x: fix SNR reading
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Fix SNR reading

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/tda1004x.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/tda1004x.c	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/tda1004x.c	2005-09-04 22:28:07.000000000 +0200
@@ -1046,8 +1046,7 @@ static int tda1004x_read_snr(struct dvb_
 	tmp = tda1004x_read_byte(state, TDA1004X_SNR);
 	if (tmp < 0)
 		return -EIO;
-	if (tmp)
-		tmp = 255 - tmp;
+	tmp = 255 - tmp;
 
 	*snr = ((tmp << 8) | tmp);
 	dprintk("%s: snr=0x%x\n", __FUNCTION__, *snr);

--

