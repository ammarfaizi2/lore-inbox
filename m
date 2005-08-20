Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVHTTZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVHTTZy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVHTTZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:25:54 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30987 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750811AbVHTTZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 15:25:53 -0400
Date: Sat, 20 Aug 2005 21:25:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jack@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/quotaops.h: "extern inline" doesn't make sense
Message-ID: <20050820192551.GE3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/quotaops.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.13-rc6-mm1/include/linux/quotaops.h.old	2005-08-20 14:40:53.000000000 +0200
+++ linux-2.6.13-rc6-mm1/include/linux/quotaops.h	2005-08-20 14:41:30.000000000 +0200
@@ -198,38 +198,38 @@
 #define DQUOT_SYNC(sb)				do { } while(0)
 #define DQUOT_OFF(sb)				do { } while(0)
 #define DQUOT_TRANSFER(inode, iattr)		(0)
-extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	inode_add_bytes(inode, nr);
 	return 0;
 }
 
-extern __inline__ int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 	return 0;
 }
 
-extern __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	inode_add_bytes(inode, nr);
 	return 0;
 }
 
-extern __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_ALLOC_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 	return 0;
 }
 
-extern __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	inode_sub_bytes(inode, nr);
 }
 
-extern __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);

