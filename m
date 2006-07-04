Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWGDPkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWGDPkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWGDPkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:40:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13116 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751278AbWGDPkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:40:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=k77o0b2+W+A8jOcp3o3jjN+nH/7IJYXXV8ydXv/qowiTyEFED4eY4FYNvX+SqOZj9OtWBNcvTHuGIo/DqCyTZwYBP6apgF9c2Bu2UnXjy2dXLHosRfzwt6VvuKQddeSgxCWHuHVSA8Knx63vWeG9qp6xvU8p8sdCAUvoUPV10Bo=
Message-ID: <44AA8D0E.4090006@innova-card.com>
Date: Tue, 04 Jul 2006 17:45:18 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Franck <vagabon.xyz@gmail.com>
Subject: [PATCH 3/7] bootmem: remove useless parentheses in bootmem header
 file
References: <44AA89D2.8010307@innova-card.com>
In-Reply-To: <44AA89D2.8010307@innova-card.com>
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
1.4.1.g35c6

