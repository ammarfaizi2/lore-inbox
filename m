Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314552AbSDSEtA>; Fri, 19 Apr 2002 00:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSDSEsf>; Fri, 19 Apr 2002 00:48:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64152 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314555AbSDSEsX>;
	Fri, 19 Apr 2002 00:48:23 -0400
Date: Fri, 19 Apr 2002 00:48:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (6/6) alpha fixes
In-Reply-To: <Pine.GSO.4.21.0204190047140.20383-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0204190047340.20383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -urN C8-max_pfn/include/asm-alpha/pgalloc.h C8-populate_pmd/include/asm-alpha/pgalloc.h
--- C8-max_pfn/include/asm-alpha/pgalloc.h	Sun Apr 14 17:53:11 2002
+++ C8-populate_pmd/include/asm-alpha/pgalloc.h	Thu Apr 18 23:29:18 2002
@@ -12,7 +12,7 @@
 static inline void
 pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
 {
-	pmd_set(pmd, (pte_t *)((pte - mem_map) << PAGE_SHIFT));
+	pmd_set(pmd, (pte_t *)(((pte - mem_map) << PAGE_SHIFT) + PAGE_OFFSET));
 }
 
 static inline void


