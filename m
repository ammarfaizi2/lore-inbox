Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267364AbUIWVNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267364AbUIWVNZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUIWVM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:12:59 -0400
Received: from baikonur.stro.at ([213.239.196.228]:46258 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267364AbUIWVIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:32 -0400
Subject: [patch 05/20]  dvb/alps_tdmb7: replace 	schedule_timeout() with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:31 +0200
Message-ID: <E1CAapL-0003SY-CM@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/alps_tdmb7.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/media/dvb/frontends/alps_tdmb7.c~msleep-drivers_media_dvb_frontends_alps_tdmb7 drivers/media/dvb/frontends/alps_tdmb7.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/frontends/alps_tdmb7.c~msleep-drivers_media_dvb_frontends_alps_tdmb7	2004-09-21 20:50:11.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/alps_tdmb7.c	2004-09-21 20:50:11.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include "dvb_frontend.h"
 #include "dvb_functions.h"
@@ -159,7 +160,7 @@ static int cx22700_init (struct dvb_i2c_
 	cx22700_writereg (i2c, 0x00, 0x02);   /*  soft reset */
 	cx22700_writereg (i2c, 0x00, 0x00);
 
-	dvb_delay(10);
+	msleep(10);
 	
 	for (i=0; i<sizeof(init_tab); i+=2)
 		cx22700_writereg (i2c, init_tab[i], init_tab[i+1]);
_
