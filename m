Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936370AbWK3MZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936370AbWK3MZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936388AbWK3MZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:25:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51088 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936387AbWK3MYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:24:51 -0500
Subject: [GFS2] lock function parameter [65/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:23:25 +0000
Message-Id: <1164889405.3752.439.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 0ac230699a0f3f0d15ad4e4ad99446dac5b4a21f Mon Sep 17 00:00:00 2001
From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Tue, 28 Nov 2006 22:29:19 -0800
Subject: [PATCH] [GFS2] lock function parameter

Fix function parameter typing:
fs/gfs2/glock.c:100: warning: function declaration isn't a prototype

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/glock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 3c2ff81..f130f98 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -96,7 +96,7 @@ static inline rwlock_t *gl_lock_addr(uns
 	return &gl_hash_locks[x & (GL_HASH_LOCK_SZ-1)];
 }
 #else /* not SMP, so no spinlocks required */
-static inline rwlock_t *gl_lock_addr(x)
+static inline rwlock_t *gl_lock_addr(unsigned int x)
 {
 	return NULL;
 }
-- 
1.4.1



