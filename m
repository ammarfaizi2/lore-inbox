Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUIXCQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUIXCQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267770AbUIXCKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 22:10:30 -0400
Received: from baikonur.stro.at ([213.239.196.228]:14749 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266835AbUIWUjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:39:09 -0400
Subject: [patch 03/21]  video/radeon_base: replace MS_TO_HZ() 	with msecs_to_jiffies()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:31:56 +0200
Message-ID: <E1CAaFx-0000wQ-2B@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitors list. 



Description: Replace MS_TO_HZ() with msecs_to_jiffies().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/video/aty/radeon_base.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/video/aty/radeon_base.c~use-msecs-to-jiffies-drivers_video_aty_radeon_base drivers/video/aty/radeon_base.c
--- linux-2.6.9-rc2-bk7/drivers/video/aty/radeon_base.c~use-msecs-to-jiffies-drivers_video_aty_radeon_base	2004-09-21 20:51:45.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/video/aty/radeon_base.c	2004-09-21 20:51:45.000000000 +0200
@@ -61,6 +61,7 @@
 #include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/time.h>
 #include <linux/fb.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -1286,7 +1287,7 @@ static void radeon_write_mode (struct ra
 					OUTREG(LVDS_GEN_CNTL, mode->lvds_gen_cntl | LVDS_BLON);
 				rinfo->pending_lvds_gen_cntl = mode->lvds_gen_cntl;
 				mod_timer(&rinfo->lvds_timer,
-					  jiffies + MS_TO_HZ(rinfo->panel_info.pwr_delay));
+					  jiffies + msecs_to_jiffies(rinfo->panel_info.pwr_delay));
 			}
 		}
 	}
_
