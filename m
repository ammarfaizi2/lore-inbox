Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbUJZCEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUJZCEF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUJZCBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:01:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46805 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261920AbUJZBaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:30:35 -0400
Date: Mon, 25 Oct 2004 18:29:58 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Hugepages demand paging V2 [5/8]: i386 arch modifications
In-Reply-To: <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410251829350.12962@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Provide definition of huge_update_mmu_cache (i386 does nothing in
	  update_mmu_cache and flush_dcache_page)
	* Built and tested

Index: linux-2.6.9/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-i386/pgtable.h	2004-10-21 12:01:24.000000000 -0700
+++ linux-2.6.9/include/asm-i386/pgtable.h	2004-10-22 13:09:46.000000000 -0700
@@ -389,6 +389,7 @@
  * bit at the same time.
  */
 #define update_mmu_cache(vma,address,pte) do { } while (0)
+#define huge_update_mmu_cache(vma,address,pte) do { } while (0)
 #define  __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
 	do {								  \


