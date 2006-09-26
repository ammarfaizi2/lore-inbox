Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWIZJnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWIZJnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 05:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWIZJnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 05:43:24 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:1490 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750954AbWIZJnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 05:43:23 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][DOC] Fix kerneldoc comments in mm/vmalloc.c
Date: Tue, 26 Sep 2006 11:37:55 +0200
User-Agent: KMail/1.9.4
Cc: rdunlap@xenotime.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609261137.55916.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The empty line between the short description and the first argument
description causes a section to appear twice in the generated manpage.
Also the short description should really be short: the script can't handle
multiple lines.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit 8322f0cb8a117fe42e993d48f5ae0fbc006f8ef0
tree 22ddb2aa90e3a1392abcdc99fa675995a347c068
parent da27ef8999723a92f4ac778d4196acc9383197eb
author Rolf Eike Beer <eike-kernel@sf-tec.de> Tue, 26 Sep 2006 11:35:42 +0200
committer Rolf Eike Beer <eike-kernel@sf-tec.de> Tue, 26 Sep 2006 11:35:42 +0200

 mm/vmalloc.c |   28 ++++++++--------------------
 1 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 266162d..3ac7c03 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -238,7 +238,6 @@ struct vm_struct *__get_vm_area(unsigned
 
 /**
  *	get_vm_area  -  reserve a contingous kernel virtual area
- *
  *	@size:		size of the area
  *	@flags:		%VM_IOREMAP for I/O mappings or VM_ALLOC
  *
@@ -293,7 +292,6 @@ found:
 
 /**
  *	remove_vm_area  -  find and remove a contingous kernel virtual area
- *
  *	@addr:		base address
  *
  *	Search for the kernel VM area starting at @addr, and remove it.
@@ -352,7 +350,6 @@ void __vunmap(void *addr, int deallocate
 
 /**
  *	vfree  -  release memory allocated by vmalloc()
- *
  *	@addr:		memory base address
  *
  *	Free the virtually contiguous memory area starting at @addr, as
@@ -370,7 +367,6 @@ EXPORT_SYMBOL(vfree);
 
 /**
  *	vunmap  -  release virtual mapping obtained by vmap()
- *
  *	@addr:		memory base address
  *
  *	Free the virtually contiguous memory area starting at @addr,
@@ -387,7 +383,6 @@ EXPORT_SYMBOL(vunmap);
 
 /**
  *	vmap  -  map an array of pages into virtually contiguous space
- *
  *	@pages:		array of page pointers
  *	@count:		number of pages to map
  *	@flags:		vm_area->flags
@@ -468,7 +463,6 @@ void *__vmalloc_area(struct vm_struct *a
 
 /**
  *	__vmalloc_node  -  allocate virtually contiguous memory
- *
  *	@size:		allocation size
  *	@gfp_mask:	flags for the page level allocator
  *	@prot:		protection mask for the allocated pages
@@ -503,9 +497,7 @@ EXPORT_SYMBOL(__vmalloc);
 
 /**
  *	vmalloc  -  allocate virtually contiguous memory
- *
  *	@size:		allocation size
- *
  *	Allocate enough pages to cover @size from the page level
  *	allocator and map them into contiguous kernel virtual space.
  *
@@ -519,11 +511,11 @@ void *vmalloc(unsigned long size)
 EXPORT_SYMBOL(vmalloc);
 
 /**
- *	vmalloc_user  -  allocate virtually contiguous memory which has
- *			   been zeroed so it can be mapped to userspace without
- *			   leaking data.
+ * vmalloc_user - allocate zeroed virtually contiguous memory for userspace
+ * @size: allocation size
  *
- *	@size:		allocation size
+ * The resulting memory area is zeroed so it can be mapped to userspace
+ * without leaking data.
  */
 void *vmalloc_user(unsigned long size)
 {
@@ -542,7 +534,6 @@ EXPORT_SYMBOL(vmalloc_user);
 
 /**
  *	vmalloc_node  -  allocate memory on a specific node
- *
  *	@size:		allocation size
  *	@node:		numa node
  *
@@ -564,7 +555,6 @@ #endif
 
 /**
  *	vmalloc_exec  -  allocate virtually contiguous, executable memory
- *
  *	@size:		allocation size
  *
  *	Kernel-internal function to allocate enough pages to cover @size
@@ -582,7 +572,6 @@ void *vmalloc_exec(unsigned long size)
 
 /**
  *	vmalloc_32  -  allocate virtually contiguous memory (32bit addressable)
- *
  *	@size:		allocation size
  *
  *	Allocate enough 32bit PA addressable pages to cover @size from the
@@ -595,11 +584,11 @@ void *vmalloc_32(unsigned long size)
 EXPORT_SYMBOL(vmalloc_32);
 
 /**
- *	vmalloc_32_user  -  allocate virtually contiguous memory (32bit
- *			      addressable) which is zeroed so it can be
- *			      mapped to userspace without leaking data.
- *
+ * vmalloc_32_user - allocate zeroed virtually contiguous 32bit memory
  *	@size:		allocation size
+ *
+ * The resulting memory area is 32bit addressable and zeroed so it can be
+ * mapped to userspace without leaking data.
  */
 void *vmalloc_32_user(unsigned long size)
 {
@@ -693,7 +682,6 @@ finished:
 
 /**
  *	remap_vmalloc_range  -  map vmalloc pages to userspace
- *
  *	@vma:		vma to cover (map full range of vma)
  *	@addr:		vmalloc memory
  *	@pgoff:		number of pages into addr before first page to map
