Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265031AbSJPPQw>; Wed, 16 Oct 2002 11:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265038AbSJPPQw>; Wed, 16 Oct 2002 11:16:52 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:20730 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S265031AbSJPPQu>;
	Wed, 16 Oct 2002 11:16:50 -0400
Date: Wed, 16 Oct 2002 11:22:43 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.43: cpqarray compile fix
Message-ID: <20021016152243.GA31369@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a recent dyslexicism in cpqarray.

--Adam

--- linux-2.5.43/drivers/block/cpqarray.c	Wed Oct 16 10:16:53 2002
+++ linux-2.5.43-mm1/drivers/block/cpqarray.c	Wed Oct 16 11:15:16 2002
@@ -1427,7 +1427,7 @@
 	 */
 	for (i = 0; i < NWD; i++) {
 		struct gendisk *disk = ida_gendisk[ctlr][i];
-		if (disk->flags & GENDH_FL_UP)
+		if (disk->flags & GENHD_FL_UP)
 			del_gendisk(disk);
 	}
 	memset(hba[ctlr]->drv,            0, sizeof(drv_info_t)*NWD);

