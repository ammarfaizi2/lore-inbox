Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbSKDIdn>; Mon, 4 Nov 2002 03:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265988AbSKDIcq>; Mon, 4 Nov 2002 03:32:46 -0500
Received: from dp.samba.org ([66.70.73.150]:28578 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265987AbSKDIco>;
	Mon, 4 Nov 2002 03:32:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] vmalloc.h needs pgprot_t
Date: Mon, 04 Nov 2002 18:33:38 +1100
Message-Id: <20021104083918.534392C314@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, uncovered in PPC compile.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22822-2.5.45-bk-module-ppc.pre/include/linux/vmalloc.h .22822-2.5.45-bk-module-ppc/include/linux/vmalloc.h
--- .22822-2.5.45-bk-module-ppc.pre/include/linux/vmalloc.h	2002-08-28 09:29:53.000000000 +1000
+++ .22822-2.5.45-bk-module-ppc/include/linux/vmalloc.h	2002-11-04 18:28:53.000000000 +1100
@@ -2,6 +2,7 @@
 #define _LINUX_VMALLOC_H
 
 #include <linux/spinlock.h>
+#include <asm/page.h>		/* pgprot_t */
 
 /* bits in vm_struct->flags */
 #define VM_IOREMAP	0x00000001	/* ioremap() and friends */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
