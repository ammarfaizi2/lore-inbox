Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWFTVWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWFTVWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWFTVWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:22:53 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:52647 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751131AbWFTVWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:22:52 -0400
In-reply-to: <20060620212134.GB18701@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 1/12] asm/scatterlist.h -> linux/scatterlist.h
Message-Id: <E1FsngK-00078d-HG@localhost.localdomain>
Date: Tue, 20 Jun 2006 16:22:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grab the scatterlist header from the right place.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c   |    1 -
 fs/ecryptfs/keystore.c |    2 +-
 fs/ecryptfs/mmap.c     |    2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

bdf5f99c53c8be77cdef2aa1aacdc30383676255
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 49b7eb3..5de537c 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -33,7 +33,6 @@ #include <linux/namei.h>
 #include <linux/crypto.h>
 #include <linux/file.h>
 #include <linux/scatterlist.h>
-#include <asm/scatterlist.h>
 #include "ecryptfs_kernel.h"
 
 /**
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 7c5ac0d..c250888 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -31,7 +31,7 @@ #include <linux/pagemap.h>
 #include <linux/key.h>
 #include <linux/random.h>
 #include <linux/crypto.h>
-#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #include "ecryptfs_kernel.h"
 
 /**
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index e9cff02..ad48b3e 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -31,7 +31,7 @@ #include <linux/page-flags.h>
 #include <linux/mount.h>
 #include <linux/file.h>
 #include <linux/crypto.h>
-#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #include "ecryptfs_kernel.h"
 
 struct kmem_cache *ecryptfs_lower_page_cache;
-- 
1.3.3

