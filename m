Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbUCGNSX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 08:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbUCGNSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 08:18:23 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:51332 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261946AbUCGNSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 08:18:04 -0500
Date: Sun, 07 Mar 2004 21:17:27 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Pavel Machek" <pavel@ucw.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>
Subject: Re: Highmem emulation for 2.6?
References: <20040307125939.GA965@elf.ucw.cz>
Content-Type: multipart/mixed; boundary=----------Eb3lTbkJAsjMvLvrzWqaHb
MIME-Version: 1.0
Message-ID: <opr4htvdoa4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040307125939.GA965@elf.ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------Eb3lTbkJAsjMvLvrzWqaHb
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

On Sun, 7 Mar 2004 13:59:40 +0100, Pavel Machek <pavel@ucw.cz> wrote:

> Does anyone have `subj`?

Enclosed patches is tested and works on UP wo ramdisk.

It was in -mm until Andrew dropped it due to it causing
problems on SMP, NUMA and with ramdisk.

Ramdisk expects to be at the end of lowmem zone so it
wont work in it's current implementation with this patch
when memory is shiften into highmem zone.

I'll be looking into fixes when less busy.

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
------------Eb3lTbkJAsjMvLvrzWqaHb
Content-Disposition: attachment; filename=highmem-equals-user-friendliness.patch
Content-Type: application/octet-stream; name=highmem-equals-user-friendliness.patch
Content-Transfer-Encoding: 8bit


From: Michael Frank <mhf@linuxmail.org>

Enclosed is a patch for x86 to make highmem= option easier to use.

- Automates alignment of highmem zone

- Fixes invalid highmem settings whether too small or to large

- Adds entry in kernel-parameters.txt

- Permits highmem emulation, so people with less than 896MB of memory can
  test CONFIG_HIGHMEM.  Highmem emulation can be used on any machine with at
  least 72MB RAM.

The patch does not add to bloat as it is part of __init code.




---

 Documentation/kernel-parameters.txt |    8 +++
 arch/i386/kernel/setup.c            |   91 +++++++++++++++++++++++++++---------
 2 files changed, 77 insertions(+), 22 deletions(-)

diff -puN arch/i386/kernel/setup.c~highmem-equals-user-friendliness arch/i386/kernel/setup.c
--- 25/arch/i386/kernel/setup.c~highmem-equals-user-friendliness	2004-02-09 00:14:08.000000000 -0800
+++ 25-akpm/arch/i386/kernel/setup.c	2004-02-09 00:14:08.000000000 -0800
@@ -588,9 +588,12 @@ static void __init parse_cmdline_early (
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
@@ -657,6 +660,11 @@ void __init find_max_pfn(void)
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
@@ -668,14 +676,16 @@ unsigned long __init find_max_low_pfn(vo
 		if (highmem_pages + MAXMEM_PFN < max_pfn)
 			max_pfn = MAXMEM_PFN + highmem_pages;
 		if (highmem_pages + MAXMEM_PFN > max_pfn) {
-			printk("only %luMB highmem pages available, ignoring highmem size of %uMB.\n", pages_to_mb(max_pfn - MAXMEM_PFN), pages_to_mb(highmem_pages));
-			highmem_pages = 0;
+			printk("Warning reducing highmem=%uMB to: %luMB.\n",
+				pages_to_mb(highmem_pages),
+				pages_to_mb((max_pfn - MAXMEM_PFN)));
+			highmem_pages = max_pfn - MAXMEM_PFN;
 		}
 		max_low_pfn = MAXMEM_PFN;
 #ifndef CONFIG_HIGHMEM
 		/* Maximum memory usable is what is directly addressable */
-		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
-					MAXMEM>>20);
+		printk(KERN_WARNING "Warning only %luMB will be used.\n",
+			MAXMEM >> 20);
 		if (max_pfn > MAX_NONPAE_PFN)
 			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
 		else
@@ -690,26 +700,63 @@ unsigned long __init find_max_low_pfn(vo
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
+		printk(KERN_ERR "Error highmem support requires at least %luMB "
+			"but only %luMB are available.\n",
+			pages_to_mb(PAGES_FOR_64MB +
+					ZONE_REQUIRED_PAGE_ALIGNMENT * 2),
+			pages_to_mb(max_pfn));
+		highmem_pages = 0;
+		goto out;
+	}
+	if (highmem_pages > max_pfn) {
+		printk(KERN_WARNING "Warning highmem=%uMB is bigger than "
+				"available %luMB and will be adjusted.\n",
+		pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
+	}
+	if (highmem_pages <= ZONE_REQUIRED_PAGE_ALIGNMENT) {
+		printk(KERN_WARNING "Warning highmem=%uMB is too small and has "
+			"been adjusted to: %luMB.\n",
+			pages_to_mb(highmem_pages),
+			pages_to_mb(ZONE_REQUIRED_PAGE_ALIGNMENT * 2));
+		highmem_pages = ZONE_REQUIRED_PAGE_ALIGNMENT * 2;
+	}
+	if (max_low_pfn < highmem_pages ||
+			max_low_pfn-highmem_pages < PAGES_FOR_64MB){
+		highmem_pages = max_low_pfn - PAGES_FOR_64MB;
+		printk(KERN_WARNING "Warning highmem size adjusted for a "
+				"minimum of 64MB lowmem to: %uMB.\n",
+			pages_to_mb(highmem_pages));
+	}
+	max_low_pfn -= highmem_pages;
+
+	if (max_low_pfn & ZONE_REQUIRED_PAGE_ALIGNMENT_MASK) {
+		printk(KERN_WARNING "Warning bad highmem zone alignment 0x%lx, "
+			"highmem size will be adjusted.\n",
+			(max_low_pfn & ZONE_REQUIRED_PAGE_ALIGNMENT_MASK) <<
+					PAGE_SHIFT);
+		highmem_pages -= ZONE_REQUIRED_PAGE_ALIGNMENT -
+			(max_low_pfn & ZONE_REQUIRED_PAGE_ALIGNMENT_MASK);
+		max_low_pfn &= ~ZONE_REQUIRED_PAGE_ALIGNMENT_MASK;
+		max_low_pfn += ZONE_REQUIRED_PAGE_ALIGNMENT;
+		printk(KERN_WARNING "Warning lowmem size adjusted for zone "
+			"alignment to: %luMB.\n",
+			pages_to_mb(max_low_pfn));
+		printk(KERN_WARNING "Warning highmem size adjusted for zone "
+				"alignment to: %uMB.\n",
+			pages_to_mb(highmem_pages));
+	}
+out:
 #else
-		if (highmem_pages)
-			printk(KERN_ERR "ignoring highmem size on non-highmem kernel!\n");
+	if (highmem_pages)
+		printk(KERN_ERR "ignoring highmem size on non-highmem "
+					"kernel!\n");
 #endif
-	}
 	return max_low_pfn;
 }
 
diff -puN Documentation/kernel-parameters.txt~highmem-equals-user-friendliness Documentation/kernel-parameters.txt
--- 25/Documentation/kernel-parameters.txt~highmem-equals-user-friendliness	2004-02-09 00:14:08.000000000 -0800
+++ 25-akpm/Documentation/kernel-parameters.txt	2004-02-09 00:14:08.000000000 -0800
@@ -394,6 +394,14 @@ running once the system is up.
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
 

_

------------Eb3lTbkJAsjMvLvrzWqaHb--

