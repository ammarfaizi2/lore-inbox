Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUBGUeJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 15:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUBGUeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 15:34:08 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:27579 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265928AbUBGUc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 15:32:58 -0500
From: Michael Frank <mhf@linuxmail.org>
Date: Sun, 8 Feb 2004 04:27:20 +0800
User-Agent: KMail/1.5.4
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.2: Add user friendliness to highmem= option
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402080427.20647.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Enclosed is a patch for x86 to make highmem= option easier to use.

- Automates alignment of highmem zone
- Fixes invalid highmem settings whether too small or to large
- Adds entry in kernel-parameters.txt

Highmem emulation can be used on any machine with at least 72MB RAM.

The patch does not add to bloat as it is part of __init code.

Please consider applying it as it makes this option quite usable

Regards
Michael


no highmem option

0MB HIGHMEM available.
495MB LOWMEM available.
On node 0 totalpages: 126960, zones aligned at: 0x400000
  DMA zone: 4096 pages, LIFO batch:1, physical start address at: 0x0
  Normal zone: 122864 pages, LIFO batch:16, physical start address at: 0x1000000

highmem=1m

Warning highmem=1MB is too small and has been adjusted to: 8MB.
Warning bad highmem zone alignment 0x3f0000, highmem size will be adjusted.
Warning lowmem size adjusted  for zone alignment to: 488MB.
Warning highmem size adjusted for zone alignment to: 7MB.
7MB HIGHMEM available.
488MB LOWMEM available.
On node 0 totalpages: 126960, zones aligned at: 0x400000
  DMA zone: 4096 pages, LIFO batch:1, physical start address at: 0x0
  Normal zone: 120832 pages, LIFO batch:16, physical start address at: 0x1000000
  HighMem zone: 2032 pages, LIFO batch:1, physical start address at: 0x1e800000

highmem=300m

Warning bad highmem zone alignment 0x3f0000, highmem size will be adjusted.
Warning lowmem size adjusted  for zone alignment to: 196MB.
Warning highmem size adjusted for zone alignment to: 299MB.
299MB HIGHMEM available.
196MB LOWMEM available.
On node 0 totalpages: 126960, zones aligned at: 0x400000
  DMA zone: 4096 pages, LIFO batch:1, physical start address at: 0x0
  Normal zone: 46080 pages, LIFO batch:11, physical start address at: 0x1000000
  HighMem zone: 76784 pages, LIFO batch:16, physical start address at: 0xc400000

highmem=450m

Warning highmem size adjusted for a minimum of 64MB lowmem to: 431MB.
431MB HIGHMEM available.
64MB LOWMEM available.
On node 0 totalpages: 126960, zones aligned at: 0x400000
  DMA zone: 4096 pages, LIFO batch:1, physical start address at: 0x0
  Normal zone: 12288 pages, LIFO batch:3, physical start address at: 0x1000000
  HighMem zone: 110576 pages, LIFO batch:16, physical start address at: 0x4000000

highmem=5000m

Warning highmem=5000MB is bigger than available 495MB and will be adjusted.
Warning highmem size adjusted for a minimum of 64MB lowmem to: 431MB.
431MB HIGHMEM available.
64MB LOWMEM available.
On node 0 totalpages: 126960, zones aligned at: 0x400000
  DMA zone: 4096 pages, LIFO batch:1, physical start address at: 0x0
  Normal zone: 12288 pages, LIFO batch:3, physical start address at: 0x1000000
  HighMem zone: 110576 pages, LIFO batch:16, physical start address at: 0x4000000

mem=80m highmem=1m

Warning highmem=1MB is too small and has been adjusted to: 8MB.
8MB HIGHMEM available.
72MB LOWMEM available.
On node 0 totalpages: 20480, zones aligned at: 0x400000
  DMA zone: 4096 pages, LIFO batch:1, physical start address at: 0x0
  Normal zone: 14336 pages, LIFO batch:3, physical start address at: 0x1000000
  HighMem zone: 2048 pages, LIFO batch:1, physical start address at: 0x4800000

mem=80m highmem=300m

Warning highmem=300MB is bigger than available 80MB and will be adjusted.
Warning highmem size adjusted for a minimum of 64MB lowmem to: 16MB.
16MB HIGHMEM available.
64MB LOWMEM available.
On node 0 totalpages: 20480, zones aligned at: 0x400000
  DMA zone: 4096 pages, LIFO batch:1, physical start address at: 0x0
  Normal zone: 12288 pages, LIFO batch:3, physical start address at: 0x1000000
  HighMem zone: 4096 pages, LIFO batch:1, physical start address at: 0x4000000

mem=71m highmem=1m

Error highmem support requires at least 72MB but only 71MB are available.
0MB HIGHMEM available.
71MB LOWMEM available.
On node 0 totalpages: 18176, zones aligned at: 0x400000
  DMA zone: 4096 pages, LIFO batch:1, physical start address at: 0x0
  Normal zone: 14080 pages, LIFO batch:3, physical start address at: 0x1000000

mem=72m highmem=10m

Warning highmem size adjusted for a minimum of 64MB lowmem to: 8MB.
8MB HIGHMEM available.
64MB LOWMEM available.
On node 0 totalpages: 18432, zones aligned at: 0x400000
  DMA zone: 4096 pages, LIFO batch:1, physical start address at: 0x0
  Normal zone: 12288 pages, LIFO batch:3, physical start address at: 0x1000000
  HighMem zone: 2048 pages, LIFO batch:1, physical start address at: 0x4000000

highmem=13m - note this is for testing only ;)


diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.6.2-Vanilla/arch/i386/kernel/setup.c linux-2.6.2-mhf177/arch/i386/kernel/setup.c
--- linux-2.6.2-Vanilla/arch/i386/kernel/setup.c	2004-02-06 19:36:54.000000000 +0800
+++ linux-2.6.2-mhf177/arch/i386/kernel/setup.c	2004-02-08 04:07:39.000000000 +0800
@@ -581,9 +581,12 @@
 #endif /* CONFIG_ACPI_BOOT */
 
 		/*
-		 * highmem=size forces highmem to be exactly 'size' bytes.
+		 * highmem=size forces highmem to be at most 'size' bytes.
 		 * This works even on boxes that have no highmem otherwise.
 		 * This also works to reduce highmem size on bigger boxes.
+		 *
+		 * Note: highmem sise is adjusted downward for proper zone
+		 *       alignment of the highmem physical start address.
 		 */
 		if (c == ' ' && !memcmp(from, "highmem=", 8))
 			highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
@@ -650,6 +653,11 @@
 /*
  * Determine low and high memory ranges:
  */
+
+#define ZONE_REQUIRED_PAGE_ALIGNMENT (1UL << (MAX_ORDER-1))
+#define ZONE_REQUIRED_PAGE_ALIGNMENT_MASK (ZONE_REQUIRED_PAGE_ALIGNMENT-1)
+#define PAGES_FOR_64MB (64*1024*1024/PAGE_SIZE)
+
 unsigned long __init find_max_low_pfn(void)
 {
 	unsigned long max_low_pfn;
@@ -661,14 +669,16 @@
 		if (highmem_pages + MAXMEM_PFN < max_pfn)
 			max_pfn = MAXMEM_PFN + highmem_pages;
 		if (highmem_pages + MAXMEM_PFN > max_pfn) {
-			printk("only %luMB highmem pages available, ignoring highmem size of %uMB.\n", pages_to_mb(max_pfn - MAXMEM_PFN), pages_to_mb(highmem_pages));
-			highmem_pages = 0;
+			printk("Warning reducing highmem=%uMB to: %luMB.\n",
+			       pages_to_mb(highmem_pages),
+			       pages_to_mb((max_pfn - MAXMEM_PFN)));
+			highmem_pages = max_pfn - MAXMEM_PFN;
 		}
 		max_low_pfn = MAXMEM_PFN;
 #ifndef CONFIG_HIGHMEM
 		/* Maximum memory usable is what is directly addressable */
-		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
-					MAXMEM>>20);
+		printk(KERN_WARNING "Warning only %dMB will be used.\n",
+		       MAXMEM>>20);
 		if (max_pfn > MAX_NONPAE_PFN)
 			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
 		else
@@ -683,26 +693,61 @@
 		}
 #endif /* !CONFIG_X86_PAE */
 #endif /* !CONFIG_HIGHMEM */
-	} else {
-		if (highmem_pages == -1)
-			highmem_pages = 0;
+	} else if (highmem_pages == -1)
+		highmem_pages = 0;
 #ifdef CONFIG_HIGHMEM
-		if (highmem_pages >= max_pfn) {
-			printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages available (%luMB)!.\n", pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
-			highmem_pages = 0;
-		}
-		if (highmem_pages) {
-			if (max_low_pfn-highmem_pages < 64*1024*1024/PAGE_SIZE){
-				printk(KERN_ERR "highmem size %uMB results in smaller than 64MB lowmem, ignoring it.\n", pages_to_mb(highmem_pages));
-				highmem_pages = 0;
-			}
-			max_low_pfn -= highmem_pages;
-		}
+	if (!highmem_pages)
+		goto out;
+	if (max_pfn < PAGES_FOR_64MB + ZONE_REQUIRED_PAGE_ALIGNMENT * 2) {
+		printk(KERN_ERR
+		       "Error highmem support requires at least %luMB but only %luMB are available.\n",
+		       pages_to_mb(PAGES_FOR_64MB + ZONE_REQUIRED_PAGE_ALIGNMENT * 2),
+		       pages_to_mb(max_pfn));
+		highmem_pages = 0;
+		goto out;
+	}
+	if (highmem_pages > max_pfn) {
+		printk(KERN_WARNING
+		       "Warning highmem=%uMB is bigger than available %luMB and will be adjusted.\n",
+		       pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
+	}
+	if (highmem_pages <= ZONE_REQUIRED_PAGE_ALIGNMENT) {
+		printk(KERN_WARNING
+		       "Warning highmem=%uMB is too small and has been adjusted to: %luMB.\n",
+		       pages_to_mb(highmem_pages),
+		       pages_to_mb(ZONE_REQUIRED_PAGE_ALIGNMENT * 2));
+		highmem_pages = ZONE_REQUIRED_PAGE_ALIGNMENT * 2;
+	}
+	if (max_low_pfn < highmem_pages || max_low_pfn-highmem_pages < PAGES_FOR_64MB){
+		highmem_pages = max_low_pfn - PAGES_FOR_64MB;
+		printk(KERN_WARNING
+		       "Warning highmem size adjusted for a minimum of 64MB lowmem to: %uMB.\n",
+		       pages_to_mb(highmem_pages));
+	}
+	max_low_pfn -= highmem_pages;
+	goto out;
+	/* remove this when done testing bad zone alignment kernel shutdown: end */
+
+	if (max_low_pfn & ZONE_REQUIRED_PAGE_ALIGNMENT_MASK) {
+		printk(KERN_WARNING
+		       "Warning bad highmem zone alignment 0x%lx, highmem size will be adjusted.\n",
+		       (max_low_pfn & ZONE_REQUIRED_PAGE_ALIGNMENT_MASK) << PAGE_SHIFT);
+		highmem_pages -= ZONE_REQUIRED_PAGE_ALIGNMENT -
+			(max_low_pfn & ZONE_REQUIRED_PAGE_ALIGNMENT_MASK);
+		max_low_pfn &= ~ZONE_REQUIRED_PAGE_ALIGNMENT_MASK;
+		max_low_pfn += ZONE_REQUIRED_PAGE_ALIGNMENT;
+		printk(KERN_WARNING
+		       "Warning lowmem size adjusted  for zone alignment to: %luMB.\n",
+		       pages_to_mb(max_low_pfn));
+		printk(KERN_WARNING
+		       "Warning highmem size adjusted for zone alignment to: %uMB.\n",
+		        pages_to_mb(highmem_pages));
+	}
 #else
-		if (highmem_pages)
-			printk(KERN_ERR "ignoring highmem size on non-highmem kernel!\n");
+	if (highmem_pages)
+		printk(KERN_ERR "ignoring highmem size on non-highmem kernel!\n");
 #endif
-	}
+out:
 	return max_low_pfn;
 }
 
diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.6.2-Vanilla/Documentation/kernel-parameters.txt linux-2.6.2-mhf177/Documentation/kernel-parameters.txt
--- linux-2.6.2-Vanilla/Documentation/kernel-parameters.txt	2004-02-06 19:36:53.000000000 +0800
+++ linux-2.6.2-mhf177/Documentation/kernel-parameters.txt	2004-02-08 03:17:40.000000000 +0800
@@ -387,6 +387,14 @@
 	hd?=		[HW] (E)IDE subsystem
 	hd?lun=		See Documentation/ide.txt.
 
+	highmem=size[KMG] [IA32,KNL,BOOT] forces highmem to be at most 'size' bytes.
+			This works even on boxes with at least 72MB RAM that have no 
+                        highmem otherwise. This also works to reduce highmem size on 
+                        bigger boxes. 
+			
+                        Note: highmem is adjusted downward for proper zone alignment 
+                        of  the highmem physical start address
+
 	hisax=		[HW,ISDN]
 			See Documentation/isdn/README.HiSax.
 

