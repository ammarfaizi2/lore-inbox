Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUIWVMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUIWVMC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUIWVKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:10:54 -0400
Received: from baikonur.stro.at ([213.239.196.228]:45247 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266170AbUIWVIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:53 -0400
Subject: [patch 13/20]  dvb/ves1820: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:53 +0200
Message-ID: <E1CAapi-0003rG-6C@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/ves1820.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/media/dvb/frontends/ves1820.c~msleep-drivers_media_dvb_frontends_ves1820 drivers/media/dvb/frontends/ves1820.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/frontends/ves1820.c~msleep-drivers_media_dvb_frontends_ves1820	2004-09-21 20:50:21.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/ves1820.c	2004-09-21 20:50:21.000000000 +0200
@@ -143,7 +143,7 @@ static int ves1820_writereg (struct dvb_
 			"(reg == 0x%02x, val == 0x%02x, ret == %i)\n",
 			fe->i2c->adapter->num, __FUNCTION__, reg, data, ret);
 
-	dvb_delay(10);
+	msleep(10);
 	return (ret != 1) ? -EREMOTEIO : 0;
 }
 
_
