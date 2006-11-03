Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753053AbWKCEDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbWKCEDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbWKCEDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:03:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1691 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753053AbWKCEDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:03:51 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Raymond Mantchala <raymond.mantchala@streamvision.fr>,
       Perceval Anichini <perceval.anichini@streamvision.fr>,
       Oliver Endriss <o.endriss@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 4/7] V4L/DVB (4787): Budget-ci: Inversion setting fixed for
	Technotrend 1500 T
Date: Fri, 03 Nov 2006 01:02:14 -0300
Message-id: <20061103040213.PS9786710004@infradead.org>
In-Reply-To: <20061103035925.PS9047100000@infradead.org>
References: <20061103035925.PS9047100000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Raymond Mantchala <raymond.mantchala@streamvision.fr>

Technotrend 1500 T card have "inverted inversion". This patch fixes that.
Many thanks to Martin Zwickel from Technotrend for his confirmation and
correction proposal.

Signed-off-by: Raymond Mantchala <raymond.mantchala@streamvision.fr>
Signed-off-by: Perceval Anichini <perceval.anichini@streamvision.fr>
Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/ttpci/budget-ci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/dvb/ttpci/budget-ci.c b/drivers/media/dvb/ttpci/budget-ci.c
index ac0cecb..cd5ec48 100644
--- a/drivers/media/dvb/ttpci/budget-ci.c
+++ b/drivers/media/dvb/ttpci/budget-ci.c
@@ -1035,6 +1035,7 @@ static void frontend_init(struct budget_
 
 	case 0x1012:		// TT DVB-T CI budget (tda10046/Philips tdm1316l(tda6651tt))
 		budget_ci->tuner_pll_address = 0x60;
+		philips_tdm1316l_config.invert = 1;
 		budget_ci->budget.dvb_frontend =
 			dvb_attach(tda10046_attach, &philips_tdm1316l_config, &budget_ci->budget.i2c_adap);
 		if (budget_ci->budget.dvb_frontend) {

