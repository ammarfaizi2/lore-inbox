Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUIWVMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUIWVMB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUIWVLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:11:07 -0400
Received: from baikonur.stro.at ([213.239.196.228]:60041 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267389AbUIWVIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:55 -0400
Subject: [patch 14/20]  dvb/ves1x93: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:56 +0200
Message-ID: <E1CAapl-0003uL-05@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/ves1x93.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/media/dvb/frontends/ves1x93.c~msleep-drivers_media_dvb_frontends_ves1x93 drivers/media/dvb/frontends/ves1x93.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/frontends/ves1x93.c~msleep-drivers_media_dvb_frontends_ves1x93	2004-09-21 20:50:22.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/ves1x93.c	2004-09-21 20:50:22.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include "dvb_frontend.h"
 #include "dvb_functions.h"
@@ -253,7 +254,7 @@ static int ves1x93_clr_bit (struct dvb_i
 {
         ves1x93_writereg (i2c, 0, init_1x93_tab[0] & 0xfe);
         ves1x93_writereg (i2c, 0, init_1x93_tab[0]);
-	dvb_delay(5);
+	msleep(5);
 	return 0;
 }
 
@@ -261,7 +262,7 @@ static int ves1x93_init_aquire (struct d
 {
         ves1x93_writereg (i2c, 3, 0x00);
 	ves1x93_writereg (i2c, 3, init_1x93_tab[3]);
-	dvb_delay(5);
+	msleep(5);
 	return 0;
 }
 
_
