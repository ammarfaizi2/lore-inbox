Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUKTCnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUKTCnh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbUKTCnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:43:16 -0500
Received: from baikonur.stro.at ([213.239.196.228]:55685 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263067AbUKTCev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:34:51 -0500
Subject: [patch 08/10]  mtd/cfi_cmdset_0001: 	replace schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:34:50 +0100
Message-ID: <E1CVL5O-0001Xu-LJ@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/drivers/mtd/chips/cfi_cmdset_0001.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mtd/chips/cfi_cmdset_0001.c~msleep-drivers_mtd_chips_cfi_cmdset_0001 drivers/mtd/chips/cfi_cmdset_0001.c
--- linux-2.6.10-rc2-bk4/drivers/mtd/chips/cfi_cmdset_0001.c~msleep-drivers_mtd_chips_cfi_cmdset_0001	2004-11-19 17:15:32.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/mtd/chips/cfi_cmdset_0001.c	2004-11-19 17:15:32.000000000 +0100
@@ -1683,7 +1683,7 @@ static int do_xxlock_oneblock(struct map
 		BUG();
 
 	spin_unlock(chip->mutex);
-	schedule_timeout(HZ);
+	msleep(1000);
 	spin_lock(chip->mutex);
 
 	/* FIXME. Use a timer to check this, and return immediately. */
_
