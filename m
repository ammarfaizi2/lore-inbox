Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263065AbUKTCng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbUKTCng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbUKTCnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:43:31 -0500
Received: from baikonur.stro.at ([213.239.196.228]:62132 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263065AbUKTCes
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:34:48 -0500
Subject: [patch 07/10]  mtd/amd_flash: replace 	schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:34:47 +0100
Message-ID: <E1CVL5L-0001V3-BQ@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/drivers/mtd/chips/amd_flash.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mtd/chips/amd_flash.c~msleep-drivers_mtd_chips_amd_flash drivers/mtd/chips/amd_flash.c
--- linux-2.6.10-rc2-bk4/drivers/mtd/chips/amd_flash.c~msleep-drivers_mtd_chips_amd_flash	2004-11-19 17:15:31.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/mtd/chips/amd_flash.c	2004-11-19 17:15:31.000000000 +0100
@@ -1122,7 +1122,7 @@ retry:
 	timeo = jiffies + (HZ * 20);
 
 	spin_unlock_bh(chip->mutex);
-	schedule_timeout(HZ);
+	msleep(1000);
 	spin_lock_bh(chip->mutex);
 	
 	while (flash_is_busy(map, adr, private->interleave)) {
_
