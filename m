Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWEZOW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWEZOW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWEZOW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:22:26 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:27268 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750783AbWEZOV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:21:57 -0400
In-reply-to: <20060526142117.GA2764@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 5/10] Remove unnecessary #ifndef's
Message-Id: <E1FjdCG-00033R-LZ@localhost.localdomain>
Date: Fri, 26 May 2006 09:21:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry these got in there; they are really only useful for the
userspace tools.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/ecryptfs_kernel.h |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

28ea0fb87bb7dafb8dbf327f86359b9e80c40bb5
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index e8b8691..8e35dbd 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -31,16 +31,9 @@ #include <linux/fs.h>
 #include <linux/scatterlist.h>
 
 /* Version verification for shared data structures w/ userspace */
-#ifndef ECRYPTFS_VERSION_MAJOR
 #define ECRYPTFS_VERSION_MAJOR 0x00
-#endif
-#ifndef ECRYPTFS_VERSION_MINOR
 #define ECRYPTFS_VERSION_MINOR 0x01
-#endif
-
-#ifndef ECRYPTFS_SUPPORTED_FILE_VERSION
 #define ECRYPTFS_SUPPORTED_FILE_VERSION 0x01
-#endif
 
 #define ECRYPTFS_MAX_PASSWORD_LENGTH 64
 #define ECRYPTFS_MAX_PASSPHRASE_BYTES ECRYPTFS_MAX_PASSWORD_LENGTH
@@ -168,9 +161,7 @@ #define ECRYPTFS_DEFAULT_KEY_BYTES 16
 #define ECRYPTFS_DEFAULT_CHAINING_MODE CRYPTO_TFM_MODE_CBC
 #define ECRYPTFS_TAG_3_PACKET_TYPE 0x8C
 #define ECRYPTFS_TAG_11_PACKET_TYPE 0xED
-#ifndef MD5_DIGEST_SIZE
 #define MD5_DIGEST_SIZE 16
-#endif
 
 /**
  * This is the primary struct associated with each encrypted file.
-- 
1.3.3

