Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbUEFSwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUEFSwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 14:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUEFSwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:52:11 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:37708 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261920AbUEFStB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:49:01 -0400
Date: Thu, 6 May 2004 11:48:20 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Joe Korty <joe.korty@ccur.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH mask 4/15] pj-fix-4-include-mempolicy
Message-Id: <20040506114820.29c019c8.pj@sgi.com>
In-Reply-To: <20040506111814.62d1f537.pj@sgi.com>
References: <20040506111814.62d1f537.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix numa build - small-numa-api-fixups.patch replaced
an included with a struct forward declaration, so now
some other files need to include mempolicy.h explicitly.

--- 2.6.6-rc3-mm2-old/arch/ia64/ia32/binfmt_elf32.c	2004-05-06 03:57:09.000000000 -0700
+++ 2.6.6-rc3-mm2/arch/ia64/ia32/binfmt_elf32.c	2004-05-05 11:54:15.000000000 -0700
@@ -13,6 +13,7 @@
 
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/security.h>
 
 #include <asm/param.h>


--- 2.6.6-rc3-mm2-old/arch/ia64/kernel/perfmon.c	2004-05-06 03:57:09.000000000 -0700
+++ 2.6.6-rc3-mm2/arch/ia64/kernel/perfmon.c	2004-05-05 11:54:15.000000000 -0700
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/sysctl.h>
 #include <linux/list.h>
 #include <linux/file.h>


--- 2.6.6-rc3-mm2-old/arch/ia64/mm/init.c	2004-05-06 03:57:36.000000000 -0700
+++ 2.6.6-rc3-mm2/arch/ia64/mm/init.c	2004-05-05 11:54:39.000000000 -0700
@@ -12,6 +12,7 @@
 #include <linux/efi.h>
 #include <linux/elf.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/mmzone.h>
 #include <linux/module.h>
 #include <linux/personality.h>


--- 2.6.6-rc3-mm2-old/kernel/exit.c	2004-05-06 03:57:09.000000000 -0700
+++ 2.6.6-rc3-mm2/kernel/exit.c	2004-05-05 11:54:16.000000000 -0700
@@ -6,6 +6,7 @@
 
 #include <linux/config.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
