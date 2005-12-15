Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161151AbVLOJRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbVLOJRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbVLOJRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:17:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:8106 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161151AbVLOJRU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:17:20 -0500
To: torvalds@osdl.org
Subject: [PATCH] iscsi gfp_t annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpEl-0007y2-US@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:17:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/scsi/iscsi_tcp.c            |    2 +-
 drivers/scsi/scsi_transport_iscsi.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

37944e69f7c3aa1768522a74c1e5d4cdf42c983f
diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 4fea3e4..3d8009f 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -3368,7 +3368,7 @@ iscsi_conn_set_param(iscsi_connh_t connh
 	switch(param) {
 	case ISCSI_PARAM_MAX_RECV_DLENGTH: {
 		char *saveptr = conn->data;
-		int flags = GFP_KERNEL;
+		gfp_t flags = GFP_KERNEL;
 
 		if (conn->data_size >= value) {
 			conn->max_recv_dlength = value;
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 49fd18c..e08462d 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -249,7 +249,7 @@ static inline struct list_head *skb_to_l
 }
 
 static void*
-mempool_zone_alloc_skb(unsigned int gfp_mask, void *pool_data)
+mempool_zone_alloc_skb(gfp_t gfp_mask, void *pool_data)
 {
 	struct mempool_zone *zone = pool_data;
 
-- 
0.99.9.GIT

