Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbWACXhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWACXhZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWACXhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:37:16 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:988 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S965072AbWACX2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:28:31 -0500
To: torvalds@osdl.org
Subject: [PATCH 25/41] m68k: checksum __user annotations
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvZu-0003O2-M5@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:28:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135011600 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/lib/checksum.c    |    2 +-
 include/asm-m68k/checksum.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

0a0fad177c47eb2423f74d9c01906be15d701624
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

