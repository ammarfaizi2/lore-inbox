Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUIWVJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUIWVJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUIWVJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:09:09 -0400
Received: from baikonur.stro.at ([213.239.196.228]:62174 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267370AbUIWVIX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:23 -0400
Subject: [patch 02/20]  dvb/dvb_ca_en50221: replace 	schedule_timeout() with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:22 +0200
Message-ID: <E1CAapC-0003J8-V1@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/dvb-core/dvb_ca_en50221.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/media/dvb/dvb-core/dvb_ca_en50221.c~msleep-drivers_media_dvb_dvb-core_dvb_ca_en50221 drivers/media/dvb/dvb-core/dvb_ca_en50221.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/dvb-core/dvb_ca_en50221.c~msleep-drivers_media_dvb_dvb-core_dvb_ca_en50221	2004-09-21 20:50:07.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2004-09-21 20:50:07.000000000 +0200
@@ -277,7 +277,7 @@ static int dvb_ca_en50221_wait_if_status
                 }
 
                 /* wait for a bit */
-                dvb_delay(1);
+                msleep(1);
         }
 
         dprintk("%s failed timeout:%lu\n", __FUNCTION__, jiffies - start);
@@ -1233,7 +1233,7 @@ static ssize_t dvb_ca_en50221_io_write(s
 			}
                         if (status != -EAGAIN) goto exit;
 
-                        dvb_delay(1);
+                        msleep(1);
                 }
 	        if (!written) {
 		        status = -EIO;
_
