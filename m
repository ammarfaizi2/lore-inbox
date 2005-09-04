Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVIDXg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVIDXg5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVIDXg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:36:56 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:55681 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932147AbVIDXbE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:31:04 -0400
Message-Id: <20050904232334.936421000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:47 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Content-Disposition: inline; filename=dvb-ttpci-knc1-frontend-enable-fix.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 48/54] budget-av: enable frontend on KNC1 Plus cards
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Enable frontend on KNC plus cards.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/budget-av.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/budget-av.c	2005-09-04 22:30:56.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/budget-av.c	2005-09-04 22:30:57.000000000 +0200
@@ -743,6 +743,7 @@ static void frontend_init(struct budget_
 		case SUBID_DVBC_KNC1_PLUS:
 		case SUBID_DVBT_KNC1_PLUS:
 			// Enable / PowerON Frontend
+			saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTLO);
 			saa7146_setgpio(saa, 3, SAA7146_GPIO_OUTHI);
 			break;
 	}

--

