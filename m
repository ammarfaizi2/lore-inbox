Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268627AbTBZCyg>; Tue, 25 Feb 2003 21:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268622AbTBZCw4>; Tue, 25 Feb 2003 21:52:56 -0500
Received: from [24.77.48.240] ([24.77.48.240]:24889 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268625AbTBZCut>;
	Tue, 25 Feb 2003 21:50:49 -0500
Date: Tue, 25 Feb 2003 19:01:09 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302260301.h1Q319V07251@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - guarantee
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one was suggested to me by Joe Perches.

This fixes:
    guarentee -> guarantee
    guarenteed -> guaranteed
    guarentees -> guarantees

Fixes 33 occurrences in all.

diff -ur a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
--- a/arch/alpha/kernel/pci_iommu.c	Mon Feb 24 11:05:47 2003
+++ b/arch/alpha/kernel/pci_iommu.c	Tue Feb 25 17:17:06 2003
@@ -318,7 +318,7 @@
 /* Unmap a single streaming mode DMA translation.  The DMA_ADDR and
    SIZE must match what was provided for in a previous pci_map_single
    call.  All other usages are undefined.  After this call, reads by
-   the cpu to the buffer are guarenteed to see whatever the device
+   the cpu to the buffer are guaranteed to see whatever the device
    wrote there.  */
 
 void
diff -ur a/arch/ia64/lib/swiotlb.c b/arch/ia64/lib/swiotlb.c
--- a/arch/ia64/lib/swiotlb.c	Mon Feb 24 11:05:38 2003
+++ b/arch/ia64/lib/swiotlb.c	Tue Feb 25 17:17:11 2003
@@ -359,7 +359,7 @@
  * was provided for in a previous swiotlb_map_single call.  All other usages are
  * undefined.
  *
- * After this call, reads by the cpu to the buffer are guarenteed to see whatever the
+ * After this call, reads by the cpu to the buffer are guaranteed to see whatever the
  * device wrote there.
  */
 void
diff -ur a/arch/mips64/sgi-ip27/ip27-pci-dma.c b/arch/mips64/sgi-ip27/ip27-pci-dma.c
--- a/arch/mips64/sgi-ip27/ip27-pci-dma.c	Mon Feb 24 11:05:38 2003
+++ b/arch/mips64/sgi-ip27/ip27-pci-dma.c	Tue Feb 25 17:17:15 2003
@@ -74,7 +74,7 @@
  * must match what was provided for in a previous pci_map_single call.  All
  * other usages are undefined.
  *
- * After this call, reads by the cpu to the buffer are guarenteed to see
+ * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
 void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
diff -ur a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
--- a/arch/sparc/kernel/ioport.c	Mon Feb 24 11:06:01 2003
+++ b/arch/sparc/kernel/ioport.c	Tue Feb 25 17:17:37 2003
@@ -599,7 +599,7 @@
  * must match what was provided for in a previous pci_map_single call.  All
  * other usages are undefined.
  *
- * After this call, reads by the cpu to the buffer are guarenteed to see
+ * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
 void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t ba, size_t size,
diff -ur a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
--- a/arch/sparc/mm/sun4c.c	Mon Feb 24 11:05:39 2003
+++ b/arch/sparc/mm/sun4c.c	Tue Feb 25 17:17:39 2003
@@ -1042,7 +1042,7 @@
 		get_locked_segment(addr);
 
 	/* We are changing the virtual color of the page(s)
-	 * so we must flush the cache to guarentee consistency.
+	 * so we must flush the cache to guarantee consistency.
 	 */
 	sun4c_flush_page(pages);
 #ifndef CONFIG_SUN4	
diff -ur a/arch/sparc64/kernel/traps.c b/arch/sparc64/kernel/traps.c
--- a/arch/sparc64/kernel/traps.c	Mon Feb 24 11:06:01 2003
+++ b/arch/sparc64/kernel/traps.c	Tue Feb 25 17:17:18 2003
@@ -571,7 +571,7 @@
 	unsigned long flush_linesize = ecache_flush_linesize;
 	unsigned long flush_size = ecache_flush_size;
 
-	/* Run through the whole cache to guarentee the timed loop
+	/* Run through the whole cache to guarantee the timed loop
 	 * is really displacing cache lines.
 	 */
 	__asm__ __volatile__("1: subcc	%0, %4, %0\n\t"
diff -ur a/arch/sparc64/lib/U3copy_from_user.S b/arch/sparc64/lib/U3copy_from_user.S
--- a/arch/sparc64/lib/U3copy_from_user.S	Mon Feb 24 11:05:11 2003
+++ b/arch/sparc64/lib/U3copy_from_user.S	Tue Feb 25 17:19:19 2003
@@ -416,7 +416,7 @@
 
 2:	VISEntryHalf					! MS+MS
 
-	/* Compute (len - (len % 8)) into %g2.  This is guarenteed
+	/* Compute (len - (len % 8)) into %g2.  This is guaranteed
 	 * to be nonzero.
 	 */
 	andn		%o2, 0x7, %g2			! A0	Group
@@ -425,7 +425,7 @@
 	 * one 8-byte longword past the end of src.  It actually
 	 * does not, as %g2 is subtracted as loads are done from
 	 * src, so we always stop before running off the end.
-	 * Also, we are guarenteed to have at least 0x10 bytes
+	 * Also, we are guaranteed to have at least 0x10 bytes
 	 * to move here.
 	 */
 	sub		%g2, 0x8, %g2			! A0	Group (reg-dep)
diff -ur a/arch/sparc64/lib/U3copy_in_user.S b/arch/sparc64/lib/U3copy_in_user.S
--- a/arch/sparc64/lib/U3copy_in_user.S	Mon Feb 24 11:05:16 2003
+++ b/arch/sparc64/lib/U3copy_in_user.S	Tue Feb 25 17:19:26 2003
@@ -447,7 +447,7 @@
 
 2:	VISEntryHalf					! MS+MS
 
-	/* Compute (len - (len % 8)) into %g2.  This is guarenteed
+	/* Compute (len - (len % 8)) into %g2.  This is guaranteed
 	 * to be nonzero.
 	 */
 	andn		%o2, 0x7, %g2			! A0	Group
@@ -456,7 +456,7 @@
 	 * one 8-byte longword past the end of src.  It actually
 	 * does not, as %g2 is subtracted as loads are done from
 	 * src, so we always stop before running off the end.
-	 * Also, we are guarenteed to have at least 0x10 bytes
+	 * Also, we are guaranteed to have at least 0x10 bytes
 	 * to move here.
 	 */
 	sub		%g2, 0x8, %g2			! A0	Group (reg-dep)
diff -ur a/arch/sparc64/lib/U3copy_to_user.S b/arch/sparc64/lib/U3copy_to_user.S
--- a/arch/sparc64/lib/U3copy_to_user.S	Mon Feb 24 11:05:04 2003
+++ b/arch/sparc64/lib/U3copy_to_user.S	Tue Feb 25 17:19:31 2003
@@ -463,7 +463,7 @@
 
 2:	VISEntryHalf					! MS+MS
 
-	/* Compute (len - (len % 8)) into %g2.  This is guarenteed
+	/* Compute (len - (len % 8)) into %g2.  This is guaranteed
 	 * to be nonzero.
 	 */
 	andn		%o2, 0x7, %g2			! A0	Group
@@ -472,7 +472,7 @@
 	 * one 8-byte longword past the end of src.  It actually
 	 * does not, as %g2 is subtracted as loads are done from
 	 * src, so we always stop before running off the end.
-	 * Also, we are guarenteed to have at least 0x10 bytes
+	 * Also, we are guaranteed to have at least 0x10 bytes
 	 * to move here.
 	 */
 	sub		%g2, 0x8, %g2			! A0	Group (reg-dep)
diff -ur a/arch/sparc64/lib/U3memcpy.S b/arch/sparc64/lib/U3memcpy.S
--- a/arch/sparc64/lib/U3memcpy.S	Mon Feb 24 11:06:02 2003
+++ b/arch/sparc64/lib/U3memcpy.S	Tue Feb 25 17:19:33 2003
@@ -344,7 +344,7 @@
 
 2:	VISEntryHalf					! MS+MS
 
-	/* Compute (len - (len % 8)) into %g2.  This is guarenteed
+	/* Compute (len - (len % 8)) into %g2.  This is guaranteed
 	 * to be nonzero.
 	 */
 	andn		%o2, 0x7, %g2			! A0	Group
@@ -353,7 +353,7 @@
 	 * one 8-byte longword past the end of src.  It actually
 	 * does not, as %g2 is subtracted as loads are done from
 	 * src, so we always stop before running off the end.
-	 * Also, we are guarenteed to have at least 0x10 bytes
+	 * Also, we are guaranteed to have at least 0x10 bytes
 	 * to move here.
 	 */
 	sub		%g2, 0x8, %g2			! A0	Group (reg-dep)
diff -ur a/drivers/block/cciss_scsi.c b/drivers/block/cciss_scsi.c
--- a/drivers/block/cciss_scsi.c	Mon Feb 24 11:05:12 2003
+++ b/drivers/block/cciss_scsi.c	Tue Feb 25 17:17:43 2003
@@ -210,7 +210,7 @@
 	stk = &sa->cmd_stack; 
 	size = sizeof(struct cciss_scsi_cmd_stack_elem_t) * CMD_STACK_SIZE;
 
-	// pci_alloc_consistent guarentees 32-bit DMA address will
+	// pci_alloc_consistent guarantees 32-bit DMA address will
 	// be used
 
 	stk->pool = (struct cciss_scsi_cmd_stack_elem_t *)
diff -ur a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Mon Feb 24 11:05:41 2003
+++ b/drivers/char/vt.c	Tue Feb 25 17:17:44 2003
@@ -1882,7 +1882,7 @@
 		buf = con_buf;
 	}
 
-	/* At this point 'buf' is guarenteed to be a kernel buffer
+	/* At this point 'buf' is guaranteed to be a kernel buffer
 	 * and therefore no access to userspace (and therefore sleeping)
 	 * will be needed.  The con_buf_sem serializes all tty based
 	 * console rendering and vcs write/read operations.  We hold
diff -ur a/drivers/net/pppoe.c b/drivers/net/pppoe.c
--- a/drivers/net/pppoe.c	Mon Feb 24 11:05:36 2003
+++ b/drivers/net/pppoe.c	Tue Feb 25 17:17:47 2003
@@ -292,7 +292,7 @@
 
 				/* Now restart from the beginning of this
 				 * hash chain.  We always NULL out pppoe_dev
-				 * so we are guarenteed to make forward
+				 * so we are guaranteed to make forward
 				 * progress.
 				 */
 				po = item_hash_table[hash];
diff -ur a/drivers/net/sungem.c b/drivers/net/sungem.c
--- a/drivers/net/sungem.c	Mon Feb 24 11:05:47 2003
+++ b/drivers/net/sungem.c	Tue Feb 25 17:17:50 2003
@@ -2991,7 +2991,7 @@
 	gem_begin_auto_negotiation(gp, NULL);
 	spin_unlock_irq(&gp->lock);
 
-	/* It is guarenteed that the returned buffer will be at least
+	/* It is guaranteed that the returned buffer will be at least
 	 * PAGE_SIZE aligned.
 	 */
 	gp->init_block = (struct gem_init_block *)
diff -ur a/drivers/net/sungem.h b/drivers/net/sungem.h
--- a/drivers/net/sungem.h	Mon Feb 24 11:05:33 2003
+++ b/drivers/net/sungem.h	Tue Feb 25 17:17:53 2003
@@ -830,7 +830,7 @@
  * RX Kick register) by the driver it must make sure the buffers are
  * truly ready and that the ownership bits are set properly.
  *
- * Even though GEM modifies the RX descriptors, it guarentees that the
+ * Even though GEM modifies the RX descriptors, it guarantees that the
  * buffer DMA address field will stay the same when it performs these
  * updates.  Therefore it can be used to keep track of DMA mappings
  * by the host driver just as in the TX descriptor case above.
diff -ur a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	Mon Feb 24 11:05:33 2003
+++ b/drivers/net/tg3.c	Tue Feb 25 17:19:35 2003
@@ -2194,7 +2194,7 @@
 	int i;
 
 #if !PCI_DMA_BUS_IS_PHYS
-	/* IOMMU, just map the guilty area again which is guarenteed to
+	/* IOMMU, just map the guilty area again which is guaranteed to
 	 * use different addresses.
 	 */
 
@@ -2229,7 +2229,7 @@
 		return -1;
 	}
 
-	/* New SKB is guarenteed to be linear. */
+	/* New SKB is guaranteed to be linear. */
 	entry = *start;
 	new_addr = pci_map_single(tp->pdev, new_skb->data, new_skb->len,
 				  PCI_DMA_TODEVICE);
diff -ur a/drivers/net/tokenring/madgemc.c b/drivers/net/tokenring/madgemc.c
--- a/drivers/net/tokenring/madgemc.c	Mon Feb 24 11:05:45 2003
+++ b/drivers/net/tokenring/madgemc.c	Tue Feb 25 17:19:38 2003
@@ -80,7 +80,7 @@
 static void madgemc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 /*
- * These work around paging, however they dont guarentee you're on the
+ * These work around paging, however they dont guarantee you're on the
  * right page.
  */
 #define SIFREADB(reg) (inb(dev->base_addr + ((reg<0x8)?reg:reg-0x8)))
@@ -436,7 +436,7 @@
  * both with their own disadvantages...
  *
  * 1)  	Read in the SIFSTS register from the TMS controller.  This
- *	is guarenteed to be accurate, however, there's a fairly
+ *	is guaranteed to be accurate, however, there's a fairly
  *	large performance penalty for doing so: the Madge chips
  *	must request the register from the Eagle, the Eagle must
  *	read them from its internal bus, and then take the route
diff -ur a/fs/bio.c b/fs/bio.c
--- a/fs/bio.c	Mon Feb 24 11:05:34 2003
+++ b/fs/bio.c	Tue Feb 25 17:18:00 2003
@@ -334,7 +334,7 @@
  *	@bdev:  I/O target
  *
  *	Return the approximate number of pages we can send to this target.
- *	There's no guarentee that you will be able to fit this number of pages
+ *	There's no guarantee that you will be able to fit this number of pages
  *	into a bio, it does not account for dynamic restrictions that vary
  *	on offset.
  */
diff -ur a/fs/mpage.c b/fs/mpage.c
--- a/fs/mpage.c	Mon Feb 24 11:05:12 2003
+++ b/fs/mpage.c	Tue Feb 25 17:18:02 2003
@@ -598,7 +598,7 @@
  * If a page is already under I/O, generic_writepages() skips it, even
  * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
  * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
- * and msync() need to guarentee that all the data which was dirty at the time
+ * and msync() need to guarantee that all the data which was dirty at the time
  * the call was made get new I/O started against them.  So if called_for_sync()
  * is true, we must wait for existing IO to complete.
  *
diff -ur a/include/asm-alpha/pci.h b/include/asm-alpha/pci.h
--- a/include/asm-alpha/pci.h	Mon Feb 24 11:05:04 2003
+++ b/include/asm-alpha/pci.h	Tue Feb 25 17:18:05 2003
@@ -97,7 +97,7 @@
 /* Unmap a single streaming mode DMA translation.  The DMA_ADDR and
    SIZE must match what was provided for in a previous pci_map_single
    call.  All other usages are undefined.  After this call, reads by
-   the cpu to the buffer are guarenteed to see whatever the device
+   the cpu to the buffer are guaranteed to see whatever the device
    wrote there.  */
 
 extern void pci_unmap_single(struct pci_dev *, dma_addr_t, size_t, int);
diff -ur a/include/asm-mips/pci.h b/include/asm-mips/pci.h
--- a/include/asm-mips/pci.h	Mon Feb 24 11:05:38 2003
+++ b/include/asm-mips/pci.h	Tue Feb 25 17:18:09 2003
@@ -102,7 +102,7 @@
  * must match what was provided for in a previous pci_map_single call.  All
  * other usages are undefined.
  *
- * After this call, reads by the cpu to the buffer are guarenteed to see
+ * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
 extern inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
diff -ur a/include/asm-mips64/pci.h b/include/asm-mips64/pci.h
--- a/include/asm-mips64/pci.h	Mon Feb 24 11:05:07 2003
+++ b/include/asm-mips64/pci.h	Tue Feb 25 17:18:07 2003
@@ -126,7 +126,7 @@
  * must match what was provided for in a previous pci_map_single call.  All
  * other usages are undefined.
  *
- * After this call, reads by the cpu to the buffer are guarenteed to see
+ * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
 static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
diff -ur a/include/asm-sh/pci.h b/include/asm-sh/pci.h
--- a/include/asm-sh/pci.h	Mon Feb 24 11:05:36 2003
+++ b/include/asm-sh/pci.h	Tue Feb 25 17:18:11 2003
@@ -118,7 +118,7 @@
  * must match what was provided for in a previous pci_map_single call.  All
  * other usages are undefined.
  *
- * After this call, reads by the cpu to the buffer are guarenteed to see
+ * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
 static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
diff -ur a/include/asm-sparc/pci.h b/include/asm-sparc/pci.h
--- a/include/asm-sparc/pci.h	Mon Feb 24 11:05:39 2003
+++ b/include/asm-sparc/pci.h	Tue Feb 25 17:18:18 2003
@@ -59,7 +59,7 @@
  * must match what was provided for in a previous pci_map_single call.  All
  * other usages are undefined.
  *
- * After this call, reads by the cpu to the buffer are guarenteed to see
+ * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
 extern void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr, size_t size, int direction);
diff -ur a/include/asm-sparc64/pbm.h b/include/asm-sparc64/pbm.h
--- a/include/asm-sparc64/pbm.h	Mon Feb 24 11:06:03 2003
+++ b/include/asm-sparc64/pbm.h	Tue Feb 25 17:18:14 2003
@@ -59,7 +59,7 @@
 	unsigned long	iommu_ctxflush;		/* IOMMU context flush register */
 
 	/* This is a register in the PCI controller, which if
-	 * read will have no side-effects but will guarentee
+	 * read will have no side-effects but will guarantee
 	 * completion of all previous writes into IOMMU/STC.
 	 */
 	unsigned long	write_complete_reg;
diff -ur a/include/asm-sparc64/pci.h b/include/asm-sparc64/pci.h
--- a/include/asm-sparc64/pci.h	Mon Feb 24 11:05:11 2003
+++ b/include/asm-sparc64/pci.h	Tue Feb 25 17:18:16 2003
@@ -67,7 +67,7 @@
  * must match what was provided for in a previous pci_map_single call.  All
  * other usages are undefined.
  *
- * After this call, reads by the cpu to the buffer are guarenteed to see
+ * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
 extern void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr, size_t size, int direction);
diff -ur a/net/ipv4/netfilter/ip_conntrack_irc.c b/net/ipv4/netfilter/ip_conntrack_irc.c
--- a/net/ipv4/netfilter/ip_conntrack_irc.c	Mon Feb 24 11:05:39 2003
+++ b/net/ipv4/netfilter/ip_conntrack_irc.c	Tue Feb 25 17:18:25 2003
@@ -107,7 +107,7 @@
 static int help(const struct iphdr *iph, size_t len,
 		struct ip_conntrack *ct, enum ip_conntrack_info ctinfo)
 {
-	/* tcplen not negative guarenteed by ip_conntrack_tcp.c */
+	/* tcplen not negative guaranteed by ip_conntrack_tcp.c */
 	struct tcphdr *tcph = (void *) iph + iph->ihl * 4;
 	const char *data = (const char *) tcph + tcph->doff * 4;
 	const char *_data = data;
