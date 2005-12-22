Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbVLVExy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbVLVExy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVLVEv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:51:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36304 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965064AbVLVEvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:51:15 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 26/36] m68k: checksum __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIQ6-0004t5-Ma@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:51:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135011600 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/lib/checksum.c    |    2 +-
 include/asm-m68k/checksum.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

ecd15db89bf50541015c754364b5e5d19bde9802
diff --git a/arch/m68k/lib/checksum.c b/arch/m68k/lib/checksum.c
index 4a5c544..cb13c6e 100644
--- a/arch/m68k/lib/checksum.c
+++ b/arch/m68k/lib/checksum.c
@@ -134,7 +134,7 @@ EXPORT_SYMBOL(csum_partial);
  */
 
 unsigned int
-csum_partial_copy_from_user(const unsigned char *src, unsigned char *dst,
+csum_partial_copy_from_user(const unsigned char __user *src, unsigned char *dst,
 			    int len, int sum, int *csum_err)
 {
 	/*
diff --git a/include/asm-m68k/checksum.h b/include/asm-m68k/checksum.h
index 78860c2..17280ef 100644
--- a/include/asm-m68k/checksum.h
+++ b/include/asm-m68k/checksum.h
@@ -25,7 +25,7 @@ unsigned int csum_partial(const unsigned
  * better 64-bit) boundary
  */
 
-extern unsigned int csum_partial_copy_from_user(const unsigned char *src,
+extern unsigned int csum_partial_copy_from_user(const unsigned char __user *src,
 						unsigned char *dst,
 						int len, int sum,
 						int *csum_err);
-- 
0.99.9.GIT

