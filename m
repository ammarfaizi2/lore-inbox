Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965369AbWAGAZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965369AbWAGAZu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965382AbWAGAZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:25:50 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:17335 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S965369AbWAGAZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:25:48 -0500
Subject: [git patch review 3/8] IB/mthca: fix for RTR-to-RTS transition in
	modify QP
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 07 Jan 2006 00:25:42 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136593542999-f3246e38ef6bb0f5@cisco.com>
In-Reply-To: <1136593542999-61fb4d9a5e85dd1e@cisco.com>
X-OriginalArrivalTime: 07 Jan 2006 00:25:45.0683 (UTC) FILETIME=[E6B04230:01C61320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PKEY_INDEX is not a legal parameter in the RTR->RTS transition.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

0d3b525fff40475e58dab9176740d2efc5f37838
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 623f514..ff2def3 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -383,12 +383,10 @@ static const struct {
 				[UC]  = (IB_QP_CUR_STATE             |
 					 IB_QP_ALT_PATH              |
 					 IB_QP_ACCESS_FLAGS          |
-					 IB_QP_PKEY_INDEX            |
 					 IB_QP_PATH_MIG_STATE),
 				[RC]  = (IB_QP_CUR_STATE             |
 					 IB_QP_ALT_PATH              |
 					 IB_QP_ACCESS_FLAGS          |
-					 IB_QP_PKEY_INDEX            |
 					 IB_QP_MIN_RNR_TIMER         |
 					 IB_QP_PATH_MIG_STATE),
 				[MLX] = (IB_QP_CUR_STATE             |
-- 
0.99.9n
