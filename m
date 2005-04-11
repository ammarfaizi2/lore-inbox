Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVDKWST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVDKWST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVDKWRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:17:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33810 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261966AbVDKWPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:15:39 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add comment about max_low_pfn/max_pfn
X-Patch-Ref: 01-fixes/06-max_pfn-comments
Message-Id: <E1DL7Bu-0003CI-Pe@raistlin.arm.linux.org.uk>
Date: Mon, 11 Apr 2005 23:15:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oddly, max_low_pfn/max_pfn end up being the number of pages
in the system, rather than the maximum PFN on ARM.  This
doesn't seem to cause any problems, so just add a note about
it.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/arch/arm/mm/init.c linux/arch/arm/mm/init.c
--- orig/arch/arm/mm/init.c	Sat Mar 19 11:20:00 2005
+++ linux/arch/arm/mm/init.c	Mon Apr 11 14:06:10 2005
@@ -223,6 +223,9 @@ find_memend_and_nodes(struct meminfo *mi
 	 * This doesn't seem to be used by the Linux memory
 	 * manager any more.  If we can get rid of it, we
 	 * also get rid of some of the stuff above as well.
+	 *
+	 * Note: max_low_pfn and max_pfn reflect the number
+	 * of _pages_ in the system, not the maximum PFN.
 	 */
 	max_low_pfn = memend_pfn - O_PFN_DOWN(PHYS_OFFSET);
 	max_pfn = memend_pfn - O_PFN_DOWN(PHYS_OFFSET);

