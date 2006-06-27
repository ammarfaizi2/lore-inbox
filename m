Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWF0Mte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWF0Mte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWF0Mtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:49:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20557 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932306AbWF0Mtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:49:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=CjcJhhEYpmSnllu117754/EMAg+28eYXkLP6k8g/duyVGWGNbMfhUMn9UJv1Zx+CZ63ZuSuPhOCuaaiD6soZD397LvbZin6y4cmaSWQwPTHGVNJev9KGXIbi0QRYJml8t31soTUoWtq37UesKm6KKKCTI3NbcXikjw9mEZ+rFhI=
Message-ID: <44A12A6A.6050209@innova-card.com>
Date: Tue, 27 Jun 2006 14:54:02 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] bootmem: remove useless parentheses in bootmem header
 file
References: <449FDD02.2090307@innova-card.com> <1151344691.10877.44.camel@localhost.localdomain>
In-Reply-To: <1151344691.10877.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 include/linux/bootmem.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index 1dee668..0e821ca 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -59,13 +59,13 @@ extern void * __alloc_bootmem_core(struc
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 extern void reserve_bootmem (unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
-	__alloc_bootmem((x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem(x, SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low(x) \
-	__alloc_bootmem_low((x), SMP_CACHE_BYTES, 0)
+	__alloc_bootmem_low(x, SMP_CACHE_BYTES, 0)
 #define alloc_bootmem_pages(x) \
-	__alloc_bootmem((x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem(x, PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low_pages(x) \
-	__alloc_bootmem_low((x), PAGE_SIZE, 0)
+	__alloc_bootmem_low(x, PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 extern unsigned long free_all_bootmem (void);
 extern void * __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
@@ -75,11 +75,11 @@ extern void free_bootmem_node (pg_data_t
 extern unsigned long free_all_bootmem_node (pg_data_t *pgdat);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 #define alloc_bootmem_node(pgdat, x) \
-	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem_node(pgdat, x, SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_pages_node(pgdat, x) \
-	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem_node(pgdat, x, PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low_pages_node(pgdat, x) \
-	__alloc_bootmem_low_node((pgdat), (x), PAGE_SIZE, 0)
+	__alloc_bootmem_low_node(pgdat, x, PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 
 #ifdef CONFIG_HAVE_ARCH_ALLOC_REMAP
-- 
1.4.0.g64e8


