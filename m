Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUIWVQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUIWVQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUIWVO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:14:57 -0400
Received: from baikonur.stro.at ([213.239.196.228]:43927 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267380AbUIWVIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:45 -0400
Subject: [patch 10/20]  dvb/grundig_29504-491: replace 	schedule_timeout() with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:45 +0200
Message-ID: <E1CAapZ-0003i1-Pc@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/grundig_29504-491.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/media/dvb/frontends/grundig_29504-491.c~msleep-drivers_media_dvb_frontends_grundig_29504-491 drivers/media/dvb/frontends/grundig_29504-491.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/frontends/grundig_29504-491.c~msleep-drivers_media_dvb_frontends_grundig_29504-491	2004-09-21 20:50:17.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/grundig_29504-491.c	2004-09-21 20:50:17.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include "dvb_frontend.h"
 #include "dvb_functions.h"
@@ -231,7 +232,7 @@ static void tda8083_wait_diseqc_fifo (st
 	while (jiffies - start < timeout &&
                !(tda8083_readreg(i2c, 0x02) & 0x80))
 	{
-		dvb_delay(50);
+		msleep(50);
 	};
 }
 
_
