Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271161AbUJVBwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271161AbUJVBwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271160AbUJVBsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:48:30 -0400
Received: from holomorphy.com ([207.189.100.168]:28094 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S271087AbUJVBpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:45:17 -0400
Date: Thu, 21 Oct 2004 18:45:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Matthew Wilcox <willy@debian.org>,
       James Bottomley <James.Bottomley@Steeley.com>,
       Joel Soete <soete.joel@tiscali.be>
Subject: [vm] PA-RISC io_remap_page_range() compilefix
Message-ID: <20041022014511.GH17038@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel reported that I forgot a backslash in this macro definition. This
patch gets PA-RISC compiling again. Linus/akpm, please apply.

Signed-off-by: William Irwin <wli@holomorphy.com>
Signed-off-by: Joel Soete <soete.joel@tiscali.be>

===== include/asm-parisc/pgtable.h 1.21 vs edited =====
--- 1.21/include/asm-parisc/pgtable.h	Wed Oct 20 01:37:06 2004
+++ edited/include/asm-parisc/pgtable.h	Thu Oct 21 07:39:08 2004
@@ -505,7 +505,7 @@
 
 #endif /* !__ASSEMBLY__ */
 
-#define io_remap_page_range(vma, vaddr, paddr, size, prot)
+#define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
 
 /* We provide our own get_unmapped_area to provide cache coherency */
