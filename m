Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUIWVUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUIWVUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUIWVOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:14:45 -0400
Received: from baikonur.stro.at ([213.239.196.228]:6860 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267378AbUIWVIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:43 -0400
Subject: [patch 09/20]  dvb/grundig_29504-401: replace 	schedule_timeout() with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:42 +0200
Message-ID: <E1CAapW-0003ew-MO@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/grundig_29504-401.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/media/dvb/frontends/grundig_29504-401.c~msleep-drivers_media_dvb_frontends_grundig_29504-401 drivers/media/dvb/frontends/grundig_29504-401.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/frontends/grundig_29504-401.c~msleep-drivers_media_dvb_frontends_grundig_29504-401	2004-09-21 20:50:16.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/grundig_29504-401.c	2004-09-21 20:50:16.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include "dvb_frontend.h"
 #include "dvb_functions.h"
@@ -546,7 +547,7 @@ int grundig_29504_401_ioctl (struct dvb_
 		res = init (i2c);
 		if ((res == 0) && (state->first)) {
 			state->first = 0;
-			dvb_delay(200);
+			msleep(200);
 		}
 		return res;
 
_
