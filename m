Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVHOVTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVHOVTo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVHOVTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:19:44 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:63768 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S964954AbVHOVTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:19:43 -0400
Subject: [PATCH] 2.6.13-rc6-git[67] UML compile fix
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 23:19:41 +0200
Message-Id: <1124140781.15180.17.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff, Andrew,

A small patch to make UML build on recent kernels. Still in time for 2.6.13 ?

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

--- linux-2.6.13-rc6-git7/include/asm-um/page.h~  2005-08-15 21:19:47.000000000 +0200
+++ linux-2.6.13-rc6-git7/include/asm-um/page.h   2005-08-15 23:15:05.000000000 +0200
@@ -104,8 +104,8 @@
  * casting is the right thing, but 32-bit UML can't have 64-bit virtual
  * addresses
  */
-#define __pa(virt) to_phys((void *) (unsigned long) virt)
-#define __va(phys) to_virt((unsigned long) phys)
+#define __pa(virt) to_phys((void *) (unsigned long) (virt))
+#define __va(phys) to_virt((unsigned long) (phys))

 #define page_to_pfn(page) ((page) - mem_map)
 #define pfn_to_page(pfn) (mem_map + (pfn))

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

