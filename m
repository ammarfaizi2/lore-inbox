Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965371AbWCTPmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965371AbWCTPmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965373AbWCTPmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:42:05 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:55737 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965378AbWCTPmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:42:03 -0500
Subject: [PATCH] udf: remove duplicate definitions
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, bfennema@falcon.csc.calpoly.edu
Date: Mon, 20 Mar 2006 17:42:02 +0200
Message-Id: <1142869322.11159.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch removes duplicate definitions from include/linux/udf_fs_i.h
which are already defined in fs/udf/ecma_167.h.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

---

 include/linux/udf_fs_i.h |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

0266c667e014e5cdd30a7e94eaa8b5b82f0395f9
diff --git a/include/linux/udf_fs_i.h b/include/linux/udf_fs_i.h
index 1e75084..ffaf056 100644
--- a/include/linux/udf_fs_i.h
+++ b/include/linux/udf_fs_i.h
@@ -15,27 +15,6 @@
 
 #ifdef __KERNEL__
 
-#ifndef _ECMA_167_H
-typedef struct
-{
-	__u32			logicalBlockNum;
-	__u16			partitionReferenceNum;
-} __attribute__ ((packed)) lb_addr;
-
-typedef struct
-{
-	__u32			extLength;
-	__u32			extPosition;
-} __attribute__ ((packed)) short_ad;
-
-typedef struct
-{
-	__u32			extLength;
-	lb_addr			extLocation;
-	__u8			impUse[6];
-} __attribute__ ((packed)) long_ad;
-#endif
-
 struct udf_inode_info
 {
 	struct timespec		i_crtime;
-- 
1.2.4



