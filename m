Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUIWVNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUIWVNk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUIWVN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:13:27 -0400
Received: from baikonur.stro.at ([213.239.196.228]:8131 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267376AbUIWVIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:34 -0400
Subject: [patch 06/20]  dvb/at76c651: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:33 +0200
Message-ID: <E1CAapO-0003Vd-6w@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/at76c651.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/media/dvb/frontends/at76c651.c~msleep-drivers_media_dvb_frontends_at76c651 drivers/media/dvb/frontends/at76c651.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/frontends/at76c651.c~msleep-drivers_media_dvb_frontends_at76c651	2004-09-21 20:50:13.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/at76c651.c	2004-09-21 20:50:13.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #if defined(__powerpc__)
 #include <asm/bitops.h>
@@ -103,7 +104,7 @@ static int at76c651_writereg(struct dvb_
 			"(reg == 0x%02x, val == 0x%02x, ret == %i)\n",
 			__FUNCTION__, reg, data, ret);
 
-	dvb_delay(10);
+	msleep(10);
 
 	return (ret != 1) ? -EREMOTEIO : 0;
 
_
