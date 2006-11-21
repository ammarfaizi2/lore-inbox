Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030923AbWKUM7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030923AbWKUM7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 07:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030924AbWKUM7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 07:59:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24006 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030923AbWKUM7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 07:59:02 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 3/5] V4L/DVB (4832): Fix uninitialised variable in
	dvb_frontend_swzigzag
Date: Tue, 21 Nov 2006 10:38:50 -0200
Message-id: <20061121123850.PS4305520003@infradead.org>
In-Reply-To: <20061121123202.PS8610150000@infradead.org>
References: <20061121123202.PS8610150000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andrew de Quincey <adq_dvb@lidskialf.net>

Spotted by coverity/Adrian Bunk.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-core/dvb_frontend.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/dvb-core/dvb_frontend.c b/drivers/media/dvb/dvb-core/dvb_frontend.c
index 53304e6..a2ab2ee 100644
--- a/drivers/media/dvb/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb/dvb-core/dvb_frontend.c
@@ -348,7 +348,7 @@ static int dvb_frontend_swzigzag_autotun
 
 static void dvb_frontend_swzigzag(struct dvb_frontend *fe)
 {
-	fe_status_t s;
+	fe_status_t s = 0;
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 
 	/* if we've got no parameters, just keep idling */

