Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbTIHEmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 00:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbTIHEmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 00:42:21 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:4224
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261946AbTIHElX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 00:41:23 -0400
Date: Mon, 8 Sep 2003 00:40:17 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Russell King <rmk@arm.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH][2.6] declare __get_vm_area in vmalloc.h
Message-ID: <Pine.LNX.4.53.0309080031020.14426@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      arch/arm/kernel/module.o
arch/arm/kernel/module.c: In function `module_alloc':
arch/arm/kernel/module.c:32: warning: implicit declaration of function `__get_vm_area'
arch/arm/kernel/module.c:32: warning: assignment makes pointer from integer without a cast

Index: linux-2.6.0-test4-mm6-arm/include/linux/vmalloc.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test4-mm6/include/linux/vmalloc.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmalloc.h
--- linux-2.6.0-test4-mm6-arm/include/linux/vmalloc.h	7 Sep 2003 20:27:52 -0000	1.1.1.1
+++ linux-2.6.0-test4-mm6-arm/include/linux/vmalloc.h	8 Sep 2003 03:43:06 -0000
@@ -35,6 +35,8 @@ extern void vunmap(void *addr);
  *	Lowlevel-APIs (not for driver use!)
  */
 extern struct vm_struct *get_vm_area(unsigned long size, unsigned long flags);
+extern struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
+					unsigned long start, unsigned long end);
 extern struct vm_struct *remove_vm_area(void *addr);
 extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
 			struct page ***pages);
