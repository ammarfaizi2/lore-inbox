Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVAWJDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVAWJDi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 04:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVAWJDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 04:03:38 -0500
Received: from cantor.suse.de ([195.135.220.2]:29870 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261262AbVAWJD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 04:03:28 -0500
Date: Sun, 23 Jan 2005 10:03:24 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix architecture names in hugetlbpage.txt
Message-ID: <20050123090324.GA15252@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anton fixed the code recently, but forgot to fix the documentation.
There is no "ia32" thing, its i386. The other thing is named 'ia64' in arch/

Signed-off-by: Olaf Hering <olh@suse.de>

--- ../linux-2.6.11-rc2.orig/Documentation/vm/hugetlbpage.txt	2005-01-22 21:55:47.000000000 +0100
+++ ./Documentation/vm/hugetlbpage.txt	2005-01-23 09:55:52.321128541 +0100
@@ -1,8 +1,8 @@
 
 The intent of this file is to give a brief summary of hugetlbpage support in
 the Linux kernel.  This support is built on top of multiple page size support
-that is provided by most modern architectures.  For example, IA-32
-architecture supports 4K and 4M (2M in PAE mode) page sizes, IA-64
+that is provided by most modern architectures.  For example, i386
+architecture supports 4K and 4M (2M in PAE mode) page sizes, ia64
 architecture supports multiple page sizes 4K, 8K, 64K, 256K, 1M, 4M, 16M,
 256M and ppc64 supports 4K and 16M.  A TLB is a cache of virtual-to-physical
 translations.  Typically this is a very scarce resource on processor.
@@ -107,10 +107,10 @@
  * SHM_HUGETLB in the shmget system call to inform the kernel that it is
  * requesting hugepages.
  *
- * For the IA-64 architecture, the Linux kernel reserves Region number 4 for
+ * For the ia64 architecture, the Linux kernel reserves Region number 4 for
  * hugepages.  That means the addresses starting with 0x800000... will need
  * to be specified.  Specifying a fixed address is not required on ppc64,
- * i386 or amd64.
+ * i386 or x86_64.
  *
  * Note: The default shared memory limit is quite low on many kernels,
  * you may need to increase it via:
@@ -139,8 +139,8 @@
 
 #define dprintf(x)  printf(x)
 
-/* Only IA64 requires this */
-#ifdef IA64
+/* Only ia64 requires this */
+#ifdef __ia64__
 #define ADDR (void *)(0x8000000000000000UL)
 #define SHMAT_FLAGS (SHM_RND)
 #else
@@ -204,10 +204,10 @@
  * example, the app is requesting memory of size 256MB that is backed by
  * huge pages.
  *
- * For IA-64 architecture, Linux kernel reserves Region number 4 for hugepages.
+ * For ia64 architecture, Linux kernel reserves Region number 4 for hugepages.
  * That means the addresses starting with 0x800000... will need to be
  * specified.  Specifying a fixed address is not required on ppc64, i386
- * or amd64.
+ * or x86_64.
  */
 #include <stdlib.h>
 #include <stdio.h>
@@ -219,8 +219,8 @@
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
 
-/* Only IA64 requires this */
-#ifdef IA64
+/* Only ia64 requires this */
+#ifdef __ia64__
 #define ADDR (void *)(0x8000000000000000UL)
 #define FLAGS (MAP_SHARED | MAP_FIXED)
 #else
