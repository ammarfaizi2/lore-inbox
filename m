Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267413AbUIWVJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUIWVJp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUIWVIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:08:51 -0400
Received: from baikonur.stro.at ([213.239.196.228]:18628 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266170AbUIWVIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:20 -0400
Subject: [patch 01/20]  dvb/skystar2: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:19 +0200
Message-ID: <E1CAapA-0003G3-4b@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/b2c2/skystar2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/media/dvb/b2c2/skystar2.c~msleep-drivers_media_dvb_b2c2_skystar2 drivers/media/dvb/b2c2/skystar2.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/b2c2/skystar2.c~msleep-drivers_media_dvb_b2c2_skystar2	2004-09-21 20:50:06.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/b2c2/skystar2.c	2004-09-21 20:50:06.000000000 +0200
@@ -2122,7 +2122,7 @@ static int send_diseqc_msg(struct adapte
 			udelay(12500);
 			set_tuner_tone(adapter, 0);
 		}
-		dvb_delay(20);
+		msleep(20);
 	}
 
 	return 0;
_
