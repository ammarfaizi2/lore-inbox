Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267773AbUIXDsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbUIXDsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUIXDq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:46:56 -0400
Received: from baikonur.stro.at ([213.239.196.228]:9435 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267170AbUIWUb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:31:58 -0400
Subject: [patch 04/21]  video/radeonfb: remove MS_TO_HZ()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:31:59 +0200
Message-ID: <E1CAaFz-0000zb-S6@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitors list. 



Depends-on: Patch to radeon_base.c which replaces call to MS_TO_HZ()
with msecs_to_jiffies().

Description: Removes definition of MS_TO_HZ() in favor of
msecs_to_jiffies().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/video/aty/radeonfb.h |    2 --
 1 files changed, 2 deletions(-)

diff -puN drivers/video/aty/radeonfb.h~use-msecs-to-jiffies-drivers_video_aty_radeonfb drivers/video/aty/radeonfb.h
--- linux-2.6.9-rc2-bk7/drivers/video/aty/radeonfb.h~use-msecs-to-jiffies-drivers_video_aty_radeonfb	2004-09-21 20:51:47.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/video/aty/radeonfb.h	2004-09-21 20:51:47.000000000 +0200
@@ -425,8 +425,6 @@ static inline u32 _INPLL(struct radeonfb
 		spin_unlock_irqrestore(&rinfo->reg_lock, flags); 	\
 	} while (0)
 
-#define MS_TO_HZ(ms)       ((ms * HZ + 999) / 1000)
-
 #define BIOS_IN8(v)  	(readb(rinfo->bios_seg + (v)))
 #define BIOS_IN16(v) 	(readb(rinfo->bios_seg + (v)) | \
 			  (readb(rinfo->bios_seg + (v) + 1) << 8))
_
