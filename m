Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUGWPLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUGWPLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbUGWPLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:11:21 -0400
Received: from baikonur.stro.at ([213.239.196.228]:32739 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267785AbUGWPLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:11:19 -0400
Date: Fri, 23 Jul 2004 17:11:16 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-mtd@lists.infradead.org
Cc: wmw2@redhat.com, linux-kernel@vger.kernel.org
Subject: [patch-kj] remove old ifdefs
Message-ID: <20040723151116.GH14000@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 Patches to remove some old ifdefs.
 remove most of the #include <linux/version.h>
 kill compat cruft like #define ahd_pci_set_dma_mask pci_set_dma_mask

applies cleanly to 2.6.8-rc2

From: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.7-bk20-max/include/linux/mtd/cfi.h |    2 --
 1 files changed, 2 deletions(-)

diff -puN include/linux/mtd/cfi.h~remove-old-ifdefs-mtd-cfi include/linux/mtd/cfi.h
--- linux-2.6.7-bk20/include/linux/mtd/cfi.h~remove-old-ifdefs-mtd-cfi	2004-07-11 14:42:34.000000000 +0200
+++ linux-2.6.7-bk20-max/include/linux/mtd/cfi.h	2004-07-11 14:42:34.000000000 +0200
@@ -458,14 +458,12 @@ static inline __u8 cfi_read_query(struct
 
 static inline void cfi_udelay(int us)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
 	unsigned long t = us * HZ / 1000000;
 	if (t) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(t);
 		return;
 	}
-#endif
 	udelay(us);
 	cond_resched();
 }

