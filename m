Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVDLOQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVDLOQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVDLLJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:09:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:64202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262291AbVDLKdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:55 -0400
Message-Id: <200504121033.j3CAXZSK005922@shell0.pdx.osdl.net>
Subject: [patch 190/198] drivers/infiniband/hw/mthca/mthca_main.c: remove an  unused label
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Correct unwinding in error path of mthca_init_icm().

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-add-support-for-new-mt25204-hca-fix drivers/infiniband/hw/mthca/mthca_main.c
--- 25/drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-add-support-for-new-mt25204-hca-fix	2005-04-12 03:21:48.679736456 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-12 03:21:48.683735848 -0700
@@ -437,7 +437,7 @@ static int __devinit mthca_init_icm(stru
 	if (!mdev->qp_table.rdb_table) {
 		mthca_err(mdev, "Failed to map RDB context memory, aborting\n");
 		err = -ENOMEM;
-		goto err_unmap_rdb;
+		goto err_unmap_eqp;
 	}
 
        mdev->cq_table.table = mthca_alloc_icm_table(mdev, init_hca->cqc_base,
_
