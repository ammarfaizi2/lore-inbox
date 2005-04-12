Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVDLUOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVDLUOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVDLUNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:13:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:29384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262143AbVDLKbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:34 -0400
Message-Id: <200504121030.j3CAUie5005135@shell0.pdx.osdl.net>
Subject: [patch 006/198] arm: add comment about max_low_pfn/max_pfn
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rmk+lkml@arm.linux.org.uk,
       rmk@arm.linux.org.uk
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Russell King <rmk+lkml@arm.linux.org.uk>

Oddly, max_low_pfn/max_pfn end up being the number of pages in the system,
rather than the maximum PFN on ARM.  This doesn't seem to cause any problems,
so just add a note about it.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/arm/mm/init.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN arch/arm/mm/init.c~arm-add-comment-about-max_low_pfn-max_pfn arch/arm/mm/init.c
--- 25/arch/arm/mm/init.c~arm-add-comment-about-max_low_pfn-max_pfn	2005-04-12 03:21:04.967381744 -0700
+++ 25-akpm/arch/arm/mm/init.c	2005-04-12 03:21:04.971381136 -0700
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
_
