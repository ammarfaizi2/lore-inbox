Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSFAIh1>; Sat, 1 Jun 2002 04:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSFAIh0>; Sat, 1 Jun 2002 04:37:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42762 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315414AbSFAIgu>;
	Sat, 1 Jun 2002 04:36:50 -0400
Message-ID: <3CF8886D.F129F209@zip.com.au>
Date: Sat, 01 Jun 2002 01:40:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 3/16] remove PageSkip() macros
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Remove some unused PageSkip() macros.  Presumably leftovers from
PG_skip which isn't there any more.


=====================================

--- 2.5.19/include/asm-alpha/pgtable.h~cleanup-PageSkip	Sat Jun  1 01:18:06 2002
+++ 2.5.19-akpm/include/asm-alpha/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -346,9 +346,6 @@ extern inline pte_t mk_swap_pte(unsigned
 #define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define PageSkip(page)		(0)
-
 #ifndef CONFIG_DISCONTIGMEM
 #define kern_addr_valid(addr)	(1)
 #endif
--- 2.5.19/include/asm-cris/pgtable.h~cleanup-PageSkip	Sat Jun  1 01:18:06 2002
+++ 2.5.19-akpm/include/asm-cris/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -506,8 +506,6 @@ static inline void update_mmu_cache(stru
 #define pte_to_swp_entry(pte)           ((swp_entry_t) { pte_val(pte) })
 #define swp_entry_to_pte(x)             ((pte_t) { (x).val })
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define PageSkip(page)          (0)
 #define kern_addr_valid(addr)   (1)
 
 #include <asm-generic/pgtable.h>
--- 2.5.19/include/asm-i386/pgtable.h~cleanup-PageSkip	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-i386/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -277,8 +277,6 @@ static inline pte_t pte_modify(pte_t pte
 
 #endif /* !__ASSEMBLY__ */
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
 #define io_remap_page_range remap_page_range
--- 2.5.19/include/asm-ia64/pgtable.h~cleanup-PageSkip	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-ia64/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -408,9 +408,6 @@ extern void paging_init (void);
 #define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define PageSkip(page)		(0)
-
 #define io_remap_page_range remap_page_range	/* XXX is this right? */
 
 /*
--- 2.5.19/include/asm-m68k/pgtable.h~cleanup-PageSkip	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-m68k/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -164,8 +164,6 @@ extern inline void update_mmu_cache(stru
 
 #endif /* !__ASSEMBLY__ */
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
 #define io_remap_page_range remap_page_range
--- 2.5.19/include/asm-mips/pgtable.h~cleanup-PageSkip	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-mips/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -500,8 +500,6 @@ extern void update_mmu_cache(struct vm_a
 #define swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
 /* TLB operations. */
--- 2.5.19/include/asm-mips64/pgtable.h~cleanup-PageSkip	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-mips64/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -559,8 +559,6 @@ extern inline pte_t mk_swap_pte(unsigned
 #define pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define PageSkip(page)		(0)
 #ifndef CONFIG_DISCONTIGMEM
 #define kern_addr_valid(addr)	(1)
 #endif
--- 2.5.19/include/asm-parisc/pgtable.h~cleanup-PageSkip	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-parisc/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -328,9 +328,6 @@ extern inline void update_mmu_cache(stru
 
 #endif /* !__ASSEMBLY__ */
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define PageSkip(page)		(0)
-
 #define io_remap_page_range remap_page_range
 
 /*
--- 2.5.19/include/asm-s390/pgtable.h~cleanup-PageSkip	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-s390/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -494,8 +494,6 @@ extern inline pte_t mk_swap_pte(unsigned
 
 #endif /* !__ASSEMBLY__ */
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define PageSkip(page)          (0)
 #define kern_addr_valid(addr)   (1)
 
 /*
--- 2.5.19/include/asm-s390x/pgtable.h~cleanup-PageSkip	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-s390x/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -514,8 +514,6 @@ extern inline pte_t mk_swap_pte(unsigned
 
 #endif /* !__ASSEMBLY__ */
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define PageSkip(page)          (0)
 #define kern_addr_valid(addr)   (1)
 
 /*
--- 2.5.19/include/asm-sh/pgtable.h~cleanup-PageSkip	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-sh/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -312,8 +312,6 @@ extern void update_mmu_cache(struct vm_a
 
 #endif /* !__ASSEMBLY__ */
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
 #define io_remap_page_range remap_page_range
--- 2.5.19/include/asm-x86_64/pgtable.h~cleanup-PageSkip	Sat Jun  1 01:18:07 2002
+++ 2.5.19-akpm/include/asm-x86_64/pgtable.h	Sat Jun  1 01:18:07 2002
@@ -337,8 +337,6 @@ extern inline pte_t pte_modify(pte_t pte
 
 #endif /* !__ASSEMBLY__ */
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
 #define io_remap_page_range remap_page_range

-
