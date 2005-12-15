Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbVLOJR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbVLOJR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422633AbVLOJR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:17:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:8618 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422636AbVLOJRZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:17:25 -0500
To: torvalds@osdl.org
Subject: [PATCH] xfs: missing gfp_t annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpEq-0007yB-Ub@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:17:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 fs/xfs/quota/xfs_qm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

7b20a8e5d05e33ef2d0651e30a82915fcb7fb851
diff --git a/fs/xfs/quota/xfs_qm.c b/fs/xfs/quota/xfs_qm.c
index 1aea42d..5328a29 100644
--- a/fs/xfs/quota/xfs_qm.c
+++ b/fs/xfs/quota/xfs_qm.c
@@ -78,7 +78,7 @@ STATIC int	xfs_qm_dqhashlock_nowait(xfs_
 
 STATIC int	xfs_qm_init_quotainos(xfs_mount_t *);
 STATIC int	xfs_qm_init_quotainfo(xfs_mount_t *);
-STATIC int	xfs_qm_shake(int, unsigned int);
+STATIC int	xfs_qm_shake(int, gfp_t);
 
 #ifdef DEBUG
 extern mutex_t	qcheck_lock;
@@ -2197,7 +2197,7 @@ xfs_qm_shake_freelist(
  */
 /* ARGSUSED */
 STATIC int
-xfs_qm_shake(int nr_to_scan, unsigned int gfp_mask)
+xfs_qm_shake(int nr_to_scan, gfp_t gfp_mask)
 {
 	int	ndqused, nfree, n;
 
-- 
0.99.9.GIT

