Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273024AbTG0XG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272874AbTG0XGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 19:06:18 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272892AbTG0XC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:59 -0400
Date: Sun, 27 Jul 2003 20:59:04 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307271959.h6RJx46U029551@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: more arch typo/illegal->invalid fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/arch/ia64/hp/common/sba_iommu.c linux-2.6.0-test2-ac1/arch/ia64/hp/common/sba_iommu.c
--- linux-2.6.0-test2/arch/ia64/hp/common/sba_iommu.c	2003-07-27 19:56:22.000000000 +0100
+++ linux-2.6.0-test2-ac1/arch/ia64/hp/common/sba_iommu.c	2003-07-27 20:01:33.000000000 +0100
@@ -1125,7 +1125,7 @@
  * in the DMA stream. Allocates PDIR entries but does not fill them.
  * Returns the number of DMA chunks.
  *
- * Doing the fill seperate from the coalescing/allocation keeps the
+ * Doing the fill separate from the coalescing/allocation keeps the
  * code simpler. Future enhancement could make one pass through
  * the sglist do both.
  */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/arch/mips64/mm/fault.c linux-2.6.0-test2-ac1/arch/mips64/mm/fault.c
--- linux-2.6.0-test2/arch/mips64/mm/fault.c	2003-07-10 21:10:54.000000000 +0100
+++ linux-2.6.0-test2-ac1/arch/mips64/mm/fault.c	2003-07-15 18:01:27.000000000 +0100
@@ -163,7 +163,7 @@
 		tsk->thread.cp0_badvaddr = address;
 		tsk->thread.error_code = write;
 #if 0
-		printk("do_page_fault() #2: sending SIGSEGV to %s for illegal %s\n"
+		printk("do_page_fault() #2: sending SIGSEGV to %s for invalid %s\n"
 		       "%08lx (epc == %08lx, ra == %08lx)\n",
 		       tsk->comm,
 		       write ? "write access to" : "read access from",
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/arch/ppc/8xx_io/cs4218_tdm.c linux-2.6.0-test2-ac1/arch/ppc/8xx_io/cs4218_tdm.c
--- linux-2.6.0-test2/arch/ppc/8xx_io/cs4218_tdm.c	2003-07-10 21:04:50.000000000 +0100
+++ linux-2.6.0-test2-ac1/arch/ppc/8xx_io/cs4218_tdm.c	2003-07-15 18:01:29.000000000 +0100
@@ -2696,24 +2696,24 @@
 	switch (ints[0]) {
 	case 3:
 		if ((ints[3] < 0) || (ints[3] > MAX_CATCH_RADIUS))
-			printk("dmasound_setup: illegal catch radius, using default = %d\n", catchRadius);
+			printk("dmasound_setup: invalid catch radius, using default = %d\n", catchRadius);
 		else
 			catchRadius = ints[3];
 		/* fall through */
 	case 2:
 		if (ints[1] < MIN_BUFFERS)
-			printk("dmasound_setup: illegal number of buffers, using default = %d\n", numBufs);
+			printk("dmasound_setup: invalid number of buffers, using default = %d\n", numBufs);
 		else
 			numBufs = ints[1];
 		if (ints[2] < MIN_BUFSIZE || ints[2] > MAX_BUFSIZE)
-			printk("dmasound_setup: illegal buffer size, using default = %d\n", bufSize);
+			printk("dmasound_setup: invalid buffer size, using default = %d\n", bufSize);
 		else
 			bufSize = ints[2];
 		break;
 	case 0:
 		break;
 	default:
-		printk("dmasound_setup: illegal number of arguments\n");
+		printk("dmasound_setup: invalid number of arguments\n");
 	}
 }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/arch/ppc/boot/openfirmware/Makefile linux-2.6.0-test2-ac1/arch/ppc/boot/openfirmware/Makefile
--- linux-2.6.0-test2/arch/ppc/boot/openfirmware/Makefile	2003-07-10 21:07:33.000000000 +0100
+++ linux-2.6.0-test2-ac1/arch/ppc/boot/openfirmware/Makefile	2003-07-23 16:39:58.000000000 +0100
@@ -50,7 +50,7 @@
 
 $(images)/ramdisk.image.gz:
 	@echo '  MISSING $@'
-	@echo '          RAM disk image must be provided seperatly'
+	@echo '          RAM disk image must be provided separately'
 	@/bin/false
 
 objcpxmon-$(CONFIG_XMON) := --add-section=.sysmap=System.map \
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/arch/ppc/syslib/open_pic.c linux-2.6.0-test2-ac1/arch/ppc/syslib/open_pic.c
--- linux-2.6.0-test2/arch/ppc/syslib/open_pic.c	2003-07-10 21:10:56.000000000 +0100
+++ linux-2.6.0-test2-ac1/arch/ppc/syslib/open_pic.c	2003-07-15 18:01:29.000000000 +0100
@@ -133,16 +133,16 @@
 #if 1
 #define check_arg_ipi(ipi) \
     if (ipi < 0 || ipi >= OPENPIC_NUM_IPI) \
-	printk("open_pic.c:%d: illegal ipi %d\n", __LINE__, ipi);
+	printk("open_pic.c:%d: invalid ipi %d\n", __LINE__, ipi);
 #define check_arg_timer(timer) \
     if (timer < 0 || timer >= OPENPIC_NUM_TIMERS) \
-	printk("open_pic.c:%d: illegal timer %d\n", __LINE__, timer);
+	printk("open_pic.c:%d: invalid timer %d\n", __LINE__, timer);
 #define check_arg_vec(vec) \
     if (vec < 0 || vec >= OPENPIC_NUM_VECTORS) \
-	printk("open_pic.c:%d: illegal vector %d\n", __LINE__, vec);
+	printk("open_pic.c:%d: invalid vector %d\n", __LINE__, vec);
 #define check_arg_pri(pri) \
     if (pri < 0 || pri >= OPENPIC_NUM_PRI) \
-	printk("open_pic.c:%d: illegal priority %d\n", __LINE__, pri);
+	printk("open_pic.c:%d: invalid priority %d\n", __LINE__, pri);
 /*
  * Print out a backtrace if it's out of range, since if it's larger than NR_IRQ's
  * data has probably been corrupted and we're going to panic or deadlock later
@@ -151,11 +151,11 @@
 #define check_arg_irq(irq) \
     if (irq < open_pic_irq_offset || irq >= NumSources+open_pic_irq_offset \
 	|| ISR[irq - open_pic_irq_offset] == 0) { \
-      printk("open_pic.c:%d: illegal irq %d\n", __LINE__, irq); \
+      printk("open_pic.c:%d: invalid irq %d\n", __LINE__, irq); \
       dump_stack(); }
 #define check_arg_cpu(cpu) \
     if (cpu < 0 || cpu >= NumProcessors){ \
-	printk("open_pic.c:%d: illegal cpu %d\n", __LINE__, cpu); \
+	printk("open_pic.c:%d: invalid cpu %d\n", __LINE__, cpu); \
 	dump_stack(); }
 #else
 #define check_arg_ipi(ipi)	do {} while (0)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/arch/ppc64/kernel/open_pic.c linux-2.6.0-test2-ac1/arch/ppc64/kernel/open_pic.c
--- linux-2.6.0-test2/arch/ppc64/kernel/open_pic.c	2003-07-10 21:10:58.000000000 +0100
+++ linux-2.6.0-test2-ac1/arch/ppc64/kernel/open_pic.c	2003-07-15 18:01:29.000000000 +0100
@@ -96,16 +96,16 @@
 #if 0
 #define check_arg_ipi(ipi) \
     if (ipi < 0 || ipi >= OPENPIC_NUM_IPI) \
-	printk(KERN_ERR "open_pic.c:%d: illegal ipi %d\n", __LINE__, ipi);
+	printk(KERN_ERR "open_pic.c:%d: invalid ipi %d\n", __LINE__, ipi);
 #define check_arg_timer(timer) \
     if (timer < 0 || timer >= OPENPIC_NUM_TIMERS) \
-	printk(KERN_ERR "open_pic.c:%d: illegal timer %d\n", __LINE__, timer);
+	printk(KERN_ERR "open_pic.c:%d: invalid timer %d\n", __LINE__, timer);
 #define check_arg_vec(vec) \
     if (vec < 0 || vec >= OPENPIC_NUM_VECTORS) \
-	printk(KERN_ERR "open_pic.c:%d: illegal vector %d\n", __LINE__, vec);
+	printk(KERN_ERR "open_pic.c:%d: invalid vector %d\n", __LINE__, vec);
 #define check_arg_pri(pri) \
     if (pri < 0 || pri >= OPENPIC_NUM_PRI) \
-	printk(KERN_ERR "open_pic.c:%d: illegal priority %d\n", __LINE__, pri);
+	printk(KERN_ERR "open_pic.c:%d: invalid priority %d\n", __LINE__, pri);
 /*
  * Print out a backtrace if it's out of range, since if it's larger than NR_IRQ's
  * data has probably been corrupted and we're going to panic or deadlock later
@@ -113,11 +113,11 @@
  */
 #define check_arg_irq(irq) \
     if (irq < open_pic_irq_offset || irq >= (NumSources+open_pic_irq_offset)){ \
-      printk(KERN_ERR "open_pic.c:%d: illegal irq %d\n", __LINE__, irq); \
+      printk(KERN_ERR "open_pic.c:%d: invalid irq %d\n", __LINE__, irq); \
       dump_stack(); }
 #define check_arg_cpu(cpu) \
     if (cpu < 0 || cpu >= OPENPIC_MAX_PROCESSORS){ \
-	printk(KERN_ERR "open_pic.c:%d: illegal cpu %d\n", __LINE__, cpu); \
+	printk(KERN_ERR "open_pic.c:%d: invalid cpu %d\n", __LINE__, cpu); \
 	dump_stack(); }
 #else
 #define check_arg_ipi(ipi)	do {} while (0)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/arch/sh/mm/cache-sh2.c linux-2.6.0-test2-ac1/arch/sh/mm/cache-sh2.c
--- linux-2.6.0-test2/arch/sh/mm/cache-sh2.c	2003-07-10 21:08:20.000000000 +0100
+++ linux-2.6.0-test2-ac1/arch/sh/mm/cache-sh2.c	2003-07-23 16:39:58.000000000 +0100
@@ -62,7 +62,7 @@
 	cpu_data->dcache.flags		= 0;
 
 	/*
-	 * SH-2 doesn't have seperate caches
+	 * SH-2 doesn't have separate caches
 	 */
 	cpu_data->dcache.flags |= SH_CACHE_COMBINED;
 	cpu_data->icache = cpu_data->dcache;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/arch/sh/mm/cache-sh3.c linux-2.6.0-test2-ac1/arch/sh/mm/cache-sh3.c
--- linux-2.6.0-test2/arch/sh/mm/cache-sh3.c	2003-07-10 21:04:45.000000000 +0100
+++ linux-2.6.0-test2-ac1/arch/sh/mm/cache-sh3.c	2003-07-23 16:39:58.000000000 +0100
@@ -78,7 +78,7 @@
 	}
 
 		/*
-	 * SH-3 doesn't have seperate caches
+	 * SH-3 doesn't have separate caches
 		 */
 	cpu_data->dcache.flags |= SH_CACHE_COMBINED;
 	cpu_data->icache = cpu_data->dcache;
