Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUIWVNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUIWVNZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUIWVMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:12:35 -0400
Received: from baikonur.stro.at ([213.239.196.228]:58519 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267403AbUIWVJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:09:08 -0400
Subject: [patch 18/20]  dvb/budget: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:09:09 +0200
Message-ID: <E1CAapx-00046x-Bv@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/ttpci/budget.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/media/dvb/ttpci/budget.c~msleep-drivers_media_dvb_ttpci_budget drivers/media/dvb/ttpci/budget.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/ttpci/budget.c~msleep-drivers_media_dvb_ttpci_budget	2004-09-21 20:50:26.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/ttpci/budget.c	2004-09-21 20:50:26.000000000 +0200
@@ -100,7 +100,7 @@ static int SendDiSEqCMsg (struct budget 
 			udelay(12500);
 			saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO);
 		}
-		dvb_delay(20);
+		msleep(20);
 	}
 
 	return 0;
_
