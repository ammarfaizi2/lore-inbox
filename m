Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSGSCdU>; Thu, 18 Jul 2002 22:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318301AbSGSCdU>; Thu, 18 Jul 2002 22:33:20 -0400
Received: from holomorphy.com ([66.224.33.161]:42893 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315593AbSGSCdT>;
	Thu, 18 Jul 2002 22:33:19 -0400
Date: Thu, 18 Jul 2002 19:36:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: kernel-janitor-discuss@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: remove declaration of __free_pte()
Message-ID: <20020719023613.GF1022@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	kernel-janitor-discuss@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__free_pte() no longer exists in the kernel, but is still declared
from include/linux/mm.h. This patch removes that declaration.


Cheers,
Bill


===== include/linux/mm.h 1.56 vs edited =====
--- 1.56/include/linux/mm.h	Thu Jul  4 09:17:35 2002
+++ edited/include/linux/mm.h	Thu Jul 18 21:41:41 2002
@@ -393,8 +393,6 @@
 extern int can_share_swap_page(struct page *);
 extern int remove_exclusive_swap_page(struct page *);
 
-extern void __free_pte(pte_t);
-
 /* mmap.c */
 extern void lock_vma_mappings(struct vm_area_struct *);
 extern void unlock_vma_mappings(struct vm_area_struct *);
