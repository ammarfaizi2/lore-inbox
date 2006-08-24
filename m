Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbWHXSUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWHXSUr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWHXSUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:20:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:48792 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030377AbWHXSUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:20:43 -0400
Date: Thu, 24 Aug 2006 13:20:44 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mhalcrow@us.ibm.com
Subject: [PATCH 4/4] eCryptfs: ino_t to u64 for filldir
Message-ID: <20060824182044.GE17658@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060824181722.GA17658@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824181722.GA17658@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

filldir()'s inode number is now type u64 instead of ino_t.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

5cecf3b66f0e7ec3fcf953edbf4bf14d1a030a83
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 6da9363..6d6c62c 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -135,7 +135,7 @@ struct ecryptfs_getdents_callback {
 /* Inspired by generic filldir in fs/readir.c */
 static int
 ecryptfs_filldir(void *dirent, const char *name, int namelen, loff_t offset,
-		 ino_t ino, unsigned int d_type)
+		 u64 ino, unsigned int d_type)
 {
 	struct ecryptfs_crypt_stat *crypt_stat;
 	struct ecryptfs_getdents_callback *buf =
-- 
1.3.3

