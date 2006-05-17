Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWEQWAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWEQWAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWEQWAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:00:00 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:22210 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751171AbWEQV77
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 17:59:59 -0400
Date: Wed, 17 May 2006 16:58:18 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, mulix@mulix.org
Subject: [PATCH] x86-64: remove unused gart header file
Message-ID: <20060517215818.GC22817@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm-x86_64/gart-mapping.h is only ever used in
arch/x86_64/kernel/setup.c and none of its contents are referenced.
Looks to be leftover cruft not removed in the dma_ops patch.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 5bffc597ba65 arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c	Tue May 16 22:18:26 2006
+++ b/arch/x86_64/kernel/setup.c	Wed May 17 16:40:30 2006
@@ -67,7 +67,6 @@
 #include <asm/numa.h>
 #include <asm/swiotlb.h>
 #include <asm/sections.h>
-#include <asm/gart-mapping.h>
 #include <asm/dmi.h>
 
 /*
diff -r 5bffc597ba65 include/asm-x86_64/gart-mapping.h
--- a/include/asm-x86_64/gart-mapping.h	Tue May 16 22:18:26 2006
+++ /dev/null	Wed May 17 16:40:30 2006
@@ -1,16 +0,0 @@
-#ifndef _X8664_GART_MAPPING_H
-#define _X8664_GART_MAPPING_H 1
-
-#include <linux/types.h>
-#include <asm/types.h>
-
-struct device;
-
-extern void*
-gart_alloc_coherent(struct device *dev, size_t size,
-        dma_addr_t *dma_handle, gfp_t gfp);
-
-extern int
-gart_dma_supported(struct device *hwdev, u64 mask);
-
-#endif /* _X8664_GART_MAPPING_H */
