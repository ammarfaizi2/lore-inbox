Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUIXADv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUIXADv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUIXACo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:02:44 -0400
Received: from baikonur.stro.at ([213.239.196.228]:39614 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267343AbUIWUoe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:44:34 -0400
Subject: [patch 9/9]  block/swim_iop: replace direct 	assignment with set_current_state()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:44:35 +0200
Message-ID: <E1CAaSB-0002fY-FJ@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: set_current_state() is used instead of direct assignment of
current->state.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/block/swim_iop.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/block/swim_iop.c~set_current_state-drivers_block_swim_iop drivers/block/swim_iop.c
--- linux-2.6.9-rc2-bk7/drivers/block/swim_iop.c~set_current_state-drivers_block_swim_iop	2004-09-21 21:17:26.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/block/swim_iop.c	2004-09-21 21:17:26.000000000 +0200
@@ -338,7 +338,7 @@ static int swimiop_eject(struct floppy_s
 			err = -EINTR;
 			break;
 		}
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 	release_drive(fs);
_
