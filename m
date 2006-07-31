Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWGaHcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWGaHcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWGaHcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:32:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:27822 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964807AbWGaHcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:32:02 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 17:31:54 +1000
Message-Id: <1060731073154.24442@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 9] md: Fix a comment that is wrong in raid5.h
References: <20060731172842.24323.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/raid/raid5.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff .prev/include/linux/raid/raid5.h ./include/linux/raid/raid5.h
--- .prev/include/linux/raid/raid5.h	2006-07-31 16:33:02.000000000 +1000
+++ ./include/linux/raid/raid5.h	2006-07-31 16:33:02.000000000 +1000
@@ -195,8 +195,9 @@ struct stripe_head {
  * it to the count of prereading stripes.
  * When write is initiated, or the stripe refcnt == 0 (just in case) we
  * clear the PREREAD_ACTIVE flag and decrement the count
- * Whenever the delayed queue is empty and the device is not plugged, we
- * move any strips from delayed to handle and clear the DELAYED flag and set PREREAD_ACTIVE.
+ * Whenever the 'handle' queue is empty and the device is not plugged, we
+ * move any strips from delayed to handle and clear the DELAYED flag and set
+ * PREREAD_ACTIVE.
  * In stripe_handle, if we find pre-reading is necessary, we do it if
  * PREREAD_ACTIVE is set, else we set DELAYED which will send it to the delayed queue.
  * HANDLE gets cleared if stripe_handle leave nothing locked.
