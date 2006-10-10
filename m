Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030614AbWJJWh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030614AbWJJWh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030610AbWJJWhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:37:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52098 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030609AbWJJWhQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:37:16 -0400
To: torvalds@osdl.org
Subject: [PATCH 3/16] chelsio: add endian annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQDr-0008UZ-PJ@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:37:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Fri, 23 Dec 2005 01:18:25 +0300

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/chelsio/cpl5_cmd.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/chelsio/cpl5_cmd.h b/drivers/net/chelsio/cpl5_cmd.h
index 27925e4..5b357d9 100644
--- a/drivers/net/chelsio/cpl5_cmd.h
+++ b/drivers/net/chelsio/cpl5_cmd.h
@@ -108,7 +108,7 @@ #else
 	u8 iff:4;
 #endif
 	u16 vlan;
-	u32 len;
+	__be32 len;
 
 	u32 rsvd2;
 	u8 rsvd3;
@@ -119,7 +119,7 @@ #else
 	u8 ip_hdr_words:4;
 	u8 tcp_hdr_words:4;
 #endif
-	u16 eth_type_mss;
+	__be16 eth_type_mss;
 };
 
 struct cpl_rx_pkt {
@@ -138,7 +138,7 @@ #else
 	u8 iff:4;
 #endif
 	u16 csum;
-	u16 vlan;
+	__be16 vlan;
 	u16 len;
 };
 
-- 
1.4.2.GIT


