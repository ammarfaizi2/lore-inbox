Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUIXCcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUIXCcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267730AbUIXC3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 22:29:08 -0400
Received: from holomorphy.com ([207.189.100.168]:3548 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265805AbUIXCZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 22:25:44 -0400
Date: Thu, 23 Sep 2004 19:25:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Fusco <fusco_john@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 4/4] remove remap_page_range()
Message-ID: <20040924022538.GP9106@holomorphy.com>
References: <41535AAE.6090700@yahoo.com> <20040924021735.GL9106@holomorphy.com> <20040924021954.GM9106@holomorphy.com> <20040924022123.GN9106@holomorphy.com> <20040924022329.GO9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924022329.GO9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 07:23:29PM -0700, William Lee Irwin III wrote:
> Eliminate direct callers of remap_page_range().

Eliminate the last vestiges of remap_page_range() apart from maestro3
changelogs.

Index: mm2-2.6.9-rc2/include/linux/mm.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/linux/mm.h	2004-09-23 16:35:12.546535586 -0700
+++ mm2-2.6.9-rc2/include/linux/mm.h	2004-09-23 19:09:41.615422930 -0700
@@ -767,14 +767,6 @@
 int remap_pfn_range(struct vm_area_struct *vma, unsigned long uvaddr,
 		unsigned long pfn, unsigned long size, pgprot_t prot);
 
-static inline int remap_page_range(struct vm_area_struct *vma,
-					unsigned long uvaddr,
-					unsigned long paddr,
-					unsigned long size, pgprot_t prot)
-{
-	return remap_pfn_range(vma, uvaddr, paddr >> PAGE_SHIFT, size, prot);
-}
-
 #ifdef CONFIG_PROC_FS
 void __vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
 #else
