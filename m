Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUIWWWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUIWWWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUIWVJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:09:28 -0400
Received: from baikonur.stro.at ([213.239.196.228]:37517 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267368AbUIWVI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:29 -0400
Subject: [patch 04/20]  dvb/dvb_functions: replace 	schedule_timeout() with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:28 +0200
Message-ID: <E1CAapI-0003PT-Jx@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Remove dvb_delay(), replacing its invocations with
msleep() to guarantee the task delays the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/dvb-core/dvb_functions.h |   11 ----------
 1 files changed, 11 deletions(-)

diff -puN drivers/media/dvb/dvb-core/dvb_functions.h~msleep-drivers_media_dvb_dvb-core_dvb_functions drivers/media/dvb/dvb-core/dvb_functions.h
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/dvb-core/dvb_functions.h~msleep-drivers_media_dvb_dvb-core_dvb_functions	2004-09-21 20:50:10.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/dvb-core/dvb_functions.h	2004-09-21 20:50:10.000000000 +0200
@@ -24,17 +24,6 @@
 #ifndef __DVB_FUNCTIONS_H__
 #define __DVB_FUNCTIONS_H__
 
-/**
- *  a sleeping delay function, waits i ms
- *
- */
-static inline
-void dvb_delay(int i)
-{
-	current->state=TASK_INTERRUPTIBLE;
-	schedule_timeout((HZ*i)/1000);
-}
-
 /* we don't mess with video_usercopy() any more,
 we simply define out own dvb_usercopy(), which will hopefull become
 generic_usercopy()  someday... */
_
