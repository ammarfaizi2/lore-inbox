Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUIWWbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUIWWbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267403AbUIWW3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:29:00 -0400
Received: from baikonur.stro.at ([213.239.196.228]:45025 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267405AbUIWVJK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:09:10 -0400
Subject: [patch 19/20]  dvb/budget-av: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:09:11 +0200
Message-ID: <E1CAaq0-0004A2-4D@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Replace dvb_delay() with msleep() to guarantee the
task delays the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/ttpci/budget-av.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/media/dvb/ttpci/budget-av.c~msleep-drivers_media_dvb_ttpci_budget-av drivers/media/dvb/ttpci/budget-av.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/ttpci/budget-av.c~msleep-drivers_media_dvb_ttpci_budget-av	2004-09-21 20:50:27.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/ttpci/budget-av.c	2004-09-21 20:50:27.000000000 +0200
@@ -177,7 +177,7 @@ static int budget_av_detach (struct saa7
 	if ( 1 == budget_av->has_saa7113 ) {
 	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTLO);
 
-	dvb_delay(200);
+	msleep(200);
 
 	saa7146_unregister_device (&budget_av->vd, dev);
 	}
@@ -225,7 +225,7 @@ static int budget_av_attach (struct saa7
 	//test_knc_ci(av7110);
 
 	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTHI);
-	dvb_delay(500);
+	msleep(500);
 
 	if ( 0 == saa7113_init(budget_av) ) {
 		budget_av->has_saa7113 = 1;
_
