Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSDSEs7>; Fri, 19 Apr 2002 00:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314552AbSDSEsd>; Fri, 19 Apr 2002 00:48:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48535 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314551AbSDSEr3>;
	Fri, 19 Apr 2002 00:47:29 -0400
Date: Fri, 19 Apr 2002 00:47:28 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (5/6) alpha fixes
In-Reply-To: <Pine.GSO.4.21.0204190046520.20383-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0204190047140.20383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -urN C8-cpu_idle/arch/alpha/mm/init.c C8-max_pfn/arch/alpha/mm/init.c
--- C8-cpu_idle/arch/alpha/mm/init.c	Fri Mar  8 02:09:42 2002
+++ C8-max_pfn/arch/alpha/mm/init.c	Thu Apr 18 23:28:48 2002
@@ -283,7 +283,7 @@
 	unsigned long dma_pfn, high_pfn;
 
 	dma_pfn = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-	high_pfn = max_low_pfn;
+	high_pfn = max_pfn = max_low_pfn;
 
 	if (dma_pfn >= high_pfn)
 		zones_size[ZONE_DMA] = high_pfn;


