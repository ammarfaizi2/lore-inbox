Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030494AbWJJVok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbWJJVok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbWJJVog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:44:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:29124 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030482AbWJJVoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:44:18 -0400
To: torvalds@osdl.org
Subject: [PATCH] more fs/compat.c __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPOb-0007JF-2a@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:44:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/compat.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/compat.c b/fs/compat.c
index 4d3fbcb..50624d4 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -1316,7 +1316,7 @@ compat_sys_vmsplice(int fd, const struct
 		    unsigned int nr_segs, unsigned int flags)
 {
 	unsigned i;
-	struct iovec *iov;
+	struct iovec __user *iov;
 	if (nr_segs > UIO_MAXIOV)
 		return -EINVAL;
 	iov = compat_alloc_user_space(nr_segs * sizeof(struct iovec));
-- 
1.4.2.GIT


