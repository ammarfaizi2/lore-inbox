Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752289AbWFLUSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbWFLUSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbWFLUSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:18:24 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:9347 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1752245AbWFLUSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:18:23 -0400
Date: Mon, 12 Jun 2006 21:18:17 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Delete unused definitions of kvaddr_to_nid
Message-ID: <20060612201817.GA5036@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-mips/mmzone.h b/include/asm-mips/mmzone.h
index 7bde443..e07e1a4 100644
--- a/include/asm-mips/mmzone.h
+++ b/include/asm-mips/mmzone.h
@@ -11,7 +11,6 @@ #include <mmzone.h>
 
 #ifdef CONFIG_DISCONTIGMEM
 
-#define kvaddr_to_nid(kvaddr)	pa_to_nid(__pa(kvaddr))
 #define pfn_to_nid(pfn)		pa_to_nid((pfn) << PAGE_SHIFT)
 
 #define pfn_valid(pfn)						\
diff --git a/include/asm-parisc/mmzone.h b/include/asm-parisc/mmzone.h
index ceb9b73..c878136 100644
--- a/include/asm-parisc/mmzone.h
+++ b/include/asm-parisc/mmzone.h
@@ -14,11 +14,6 @@ extern struct node_map_data node_data[];
 
 #define NODE_DATA(nid)          (&node_data[nid].pg_data)
 
-/*
- * Given a kernel address, find the home node of the underlying memory.
- */
-#define kvaddr_to_nid(kaddr)	pfn_to_nid(__pa(kaddr) >> PAGE_SHIFT)
-
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid)						\
 ({									\
diff --git a/include/asm-x86_64/mmzone.h b/include/asm-x86_64/mmzone.h
index 6944e71..05704f9 100644
--- a/include/asm-x86_64/mmzone.h
+++ b/include/asm-x86_64/mmzone.h
@@ -43,7 +43,6 @@ #define node_end_pfn(nid)       (NODE_DA
 
 #ifdef CONFIG_DISCONTIGMEM
 #define pfn_to_nid(pfn) phys_to_nid((unsigned long)(pfn) << PAGE_SHIFT)
-#define kvaddr_to_nid(kaddr)	phys_to_nid(__pa(kaddr))
 
 extern int pfn_valid(unsigned long pfn);
 #endif
