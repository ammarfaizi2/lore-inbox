Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVIUQrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVIUQrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVIUQrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:47:04 -0400
Received: from [151.97.230.9] ([151.97.230.9]:30606 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751142AbVIUQrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:47:02 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 02/10] [ALL ARCHES] Remove unused var from asm/futex.h
Date: Wed, 21 Sep 2005 18:38:09 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921163800.30500.3342.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

As recently done by Russell King for ARM, commit
4732efbeb997189d9f9b04708dc26bf8613ed721 introduces a generic asm/futex.h copied
along most arches, which includes a "-ENOSYS support" to be changed if needed.
However, it includes an unused var (taken from the "real" version) which GCC
warns about.

Remove it from all arches having that file version (i.e. same GIT id).
$ git-diff-tree -r HEAD
and
$ git-ls-tree  -r HEAD include/|grep 9feff4ce1424bc390608326240be369eb13aa648

may be more interesting than looking at the patch itself, to make sure I've
just copied the arm header to all other archs having the original dummy version
of this file.

Cc: Jakub Jelinek <jakub@redhat.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-alpha/futex.h     |    2 +-
 include/asm-arm26/futex.h     |    2 +-
 include/asm-cris/futex.h      |    2 +-
 include/asm-frv/futex.h       |    2 +-
 include/asm-h8300/futex.h     |    2 +-
 include/asm-ia64/futex.h      |    2 +-
 include/asm-m32r/futex.h      |    2 +-
 include/asm-m68k/futex.h      |    2 +-
 include/asm-m68knommu/futex.h |    2 +-
 include/asm-parisc/futex.h    |    2 +-
 include/asm-ppc/futex.h       |    2 +-
 include/asm-s390/futex.h      |    2 +-
 include/asm-sh/futex.h        |    2 +-
 include/asm-sh64/futex.h      |    2 +-
 include/asm-sparc/futex.h     |    2 +-
 include/asm-sparc64/futex.h   |    2 +-
 include/asm-v850/futex.h      |    2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/asm-alpha/futex.h b/include/asm-alpha/futex.h
--- a/include/asm-alpha/futex.h
+++ b/include/asm-alpha/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-arm26/futex.h b/include/asm-arm26/futex.h
--- a/include/asm-arm26/futex.h
+++ b/include/asm-arm26/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-cris/futex.h b/include/asm-cris/futex.h
--- a/include/asm-cris/futex.h
+++ b/include/asm-cris/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-frv/futex.h b/include/asm-frv/futex.h
--- a/include/asm-frv/futex.h
+++ b/include/asm-frv/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-h8300/futex.h b/include/asm-h8300/futex.h
--- a/include/asm-h8300/futex.h
+++ b/include/asm-h8300/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-ia64/futex.h b/include/asm-ia64/futex.h
--- a/include/asm-ia64/futex.h
+++ b/include/asm-ia64/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-m32r/futex.h b/include/asm-m32r/futex.h
--- a/include/asm-m32r/futex.h
+++ b/include/asm-m32r/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-m68k/futex.h b/include/asm-m68k/futex.h
--- a/include/asm-m68k/futex.h
+++ b/include/asm-m68k/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-m68knommu/futex.h b/include/asm-m68knommu/futex.h
--- a/include/asm-m68knommu/futex.h
+++ b/include/asm-m68knommu/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-parisc/futex.h b/include/asm-parisc/futex.h
--- a/include/asm-parisc/futex.h
+++ b/include/asm-parisc/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-ppc/futex.h b/include/asm-ppc/futex.h
--- a/include/asm-ppc/futex.h
+++ b/include/asm-ppc/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-s390/futex.h b/include/asm-s390/futex.h
--- a/include/asm-s390/futex.h
+++ b/include/asm-s390/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-sh/futex.h b/include/asm-sh/futex.h
--- a/include/asm-sh/futex.h
+++ b/include/asm-sh/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-sh64/futex.h b/include/asm-sh64/futex.h
--- a/include/asm-sh64/futex.h
+++ b/include/asm-sh64/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-sparc/futex.h b/include/asm-sparc/futex.h
--- a/include/asm-sparc/futex.h
+++ b/include/asm-sparc/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-sparc64/futex.h b/include/asm-sparc64/futex.h
--- a/include/asm-sparc64/futex.h
+++ b/include/asm-sparc64/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-v850/futex.h b/include/asm-v850/futex.h
--- a/include/asm-v850/futex.h
+++ b/include/asm-v850/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 

