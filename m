Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268626AbTBZCwT>; Tue, 25 Feb 2003 21:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268628AbTBZCvl>; Tue, 25 Feb 2003 21:51:41 -0500
Received: from [24.77.48.240] ([24.77.48.240]:23609 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268618AbTBZCut>;
	Tue, 25 Feb 2003 21:50:49 -0500
Date: Tue, 25 Feb 2003 19:01:09 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302260301.h1Q319D07249@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - boundary
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    boundry -> boundary
    boundries -> boundaries

Fixes 33 occurrences in all.

diff -ur a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
--- a/arch/m68k/sun3/config.c	Mon Feb 24 11:05:36 2003
+++ b/arch/m68k/sun3/config.c	Tue Feb 25 17:58:48 2003
@@ -119,7 +119,7 @@
 {
 	unsigned long start_page;
 
-	/* align start/end to page boundries */
+	/* align start/end to page boundaries */
 	memory_start = ((memory_start + (PAGE_SIZE-1)) & PAGE_MASK);
 	memory_end = memory_end & PAGE_MASK;
 		
diff -ur a/arch/sparc/kernel/init_task.c b/arch/sparc/kernel/init_task.c
--- a/arch/sparc/kernel/init_task.c	Mon Feb 24 11:05:34 2003
+++ b/arch/sparc/kernel/init_task.c	Tue Feb 25 17:56:18 2003
@@ -12,7 +12,7 @@
 struct mm_struct init_mm = INIT_MM(init_mm);
 struct task_struct init_task = INIT_TASK(init_task);
 
-/* .text section in head.S is aligned at 8k boundry and this gets linked
+/* .text section in head.S is aligned at 8k boundary and this gets linked
  * right after that so that the init_thread_union is aligned properly as well.
  * If this is not aligned on a 8k boundry, then you should change code
  * in etrap.S which assumes it.
diff -ur a/arch/sparc/lib/blockops.S b/arch/sparc/lib/blockops.S
--- a/arch/sparc/lib/blockops.S	Mon Feb 24 11:06:03 2003
+++ b/arch/sparc/lib/blockops.S	Tue Feb 25 17:56:20 2003
@@ -38,7 +38,7 @@
 	 * and (2 * PAGE_SIZE) (for kernel stacks)
 	 * and with a second arg of zero.  We assume in
 	 * all of these cases that the buffer is aligned
-	 * on at least an 8 byte boundry.
+	 * on at least an 8 byte boundary.
 	 *
 	 * Therefore we special case them to make them
 	 * as fast as possible.
diff -ur a/arch/sparc/lib/checksum.S b/arch/sparc/lib/checksum.S
--- a/arch/sparc/lib/checksum.S	Mon Feb 24 11:05:34 2003
+++ b/arch/sparc/lib/checksum.S	Tue Feb 25 17:56:24 2003
@@ -336,7 +336,7 @@
 	bne	cc_dword_align		! yes, we check for short lengths there
 	 andcc	%g1, 0xffffff80, %g0	! can we use unrolled loop?
 3:	be	3f			! nope, less than one loop remains
-	 andcc	%o1, 4, %g0		! dest aligned on 4 or 8 byte boundry?
+	 andcc	%o1, 4, %g0		! dest aligned on 4 or 8 byte boundary?
 	be	ccdbl + 4		! 8 byte aligned, kick ass
 5:	CSUMCOPY_BIGCHUNK(%o0,%o1,%g7,0x00,%o4,%o5,%g2,%g3,%g4,%g5,%o2,%o3)
 	CSUMCOPY_BIGCHUNK(%o0,%o1,%g7,0x20,%o4,%o5,%g2,%g3,%g4,%g5,%o2,%o3)
diff -ur a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
--- a/arch/sparc/mm/sun4c.c	Mon Feb 24 11:05:39 2003
+++ b/arch/sparc/mm/sun4c.c	Tue Feb 25 17:56:29 2003
@@ -533,7 +533,7 @@
 	}
 }
 
-/* Addr is always aligned on a page boundry for us already. */
+/* Addr is always aligned on a page boundary for us already. */
 static void sun4c_map_dma_area(unsigned long va, u32 addr, int len)
 {
 	unsigned long page, end;
diff -ur a/arch/sparc64/kernel/init_task.c b/arch/sparc64/kernel/init_task.c
--- a/arch/sparc64/kernel/init_task.c	Mon Feb 24 11:06:01 2003
+++ b/arch/sparc64/kernel/init_task.c	Tue Feb 25 17:56:10 2003
@@ -12,7 +12,7 @@
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
 
-/* .text section in head.S is aligned at 2 page boundry and this gets linked
+/* .text section in head.S is aligned at 2 page boundary and this gets linked
  * right after that so that the init_thread_union is aligned properly as well.
  * We really don't need this special alignment like the Intel does, but
  * I do it anyways for completeness.
diff -ur a/arch/sparc64/kernel/iommu_common.h b/arch/sparc64/kernel/iommu_common.h
--- a/arch/sparc64/kernel/iommu_common.h	Mon Feb 24 11:06:02 2003
+++ b/arch/sparc64/kernel/iommu_common.h	Tue Feb 25 17:56:12 2003
@@ -40,7 +40,7 @@
 
 /* Two addresses are "virtually contiguous" if and only if:
  * 1) They are equal, or...
- * 2) They are both on a page boundry
+ * 2) They are both on a page boundary
  */
 #define VCONTIG(__X, __Y)	(((__X) == (__Y)) || \
 				 (((__X) | (__Y)) << (64UL - PAGE_SHIFT)) == 0UL)
diff -ur a/arch/sparc64/kernel/sbus.c b/arch/sparc64/kernel/sbus.c
--- a/arch/sparc64/kernel/sbus.c	Mon Feb 24 11:06:02 2003
+++ b/arch/sparc64/kernel/sbus.c	Tue Feb 25 17:56:15 2003
@@ -24,7 +24,7 @@
 #include "iommu_common.h"
 
 /* These should be allocated on an SMP_CACHE_BYTES
- * aligned boundry for optimal performance.
+ * aligned boundary for optimal performance.
  *
  * On SYSIO, using an 8K page size we have 1GB of SBUS
  * DMA space mapped.  We divide this space into equally
diff -ur a/drivers/char/nwflash.c b/drivers/char/nwflash.c
--- a/drivers/char/nwflash.c	Mon Feb 24 11:06:02 2003
+++ b/drivers/char/nwflash.c	Tue Feb 25 17:56:31 2003
@@ -215,7 +215,7 @@
 	temp = ((int) (p + count) >> 16) - nBlock + 1;
 
 	/*
-	 * write ends at exactly 64k boundry?
+	 * write ends at exactly 64k boundary?
 	 */
 	if (((int) (p + count) & 0xFFFF) == 0)
 		temp -= 1;
diff -ur a/drivers/net/acenic.c b/drivers/net/acenic.c
--- a/drivers/net/acenic.c	Mon Feb 24 11:05:31 2003
+++ b/drivers/net/acenic.c	Tue Feb 25 17:56:33 2003
@@ -1378,7 +1378,7 @@
 	 * On this platform, we know what the best dma settings
 	 * are.  We use 64-byte maximum bursts, because if we
 	 * burst larger than the cache line size (or even cross
-	 * a 64byte boundry in a single burst) the UltraSparc
+	 * a 64byte boundary in a single burst) the UltraSparc
 	 * PCI controller will disconnect at 64-byte multiples.
 	 *
 	 * Read-multiple will be properly enabled above, and when
diff -ur a/drivers/net/b44.h b/drivers/net/b44.h
--- a/drivers/net/b44.h	Mon Feb 24 11:05:36 2003
+++ b/drivers/net/b44.h	Tue Feb 25 17:56:34 2003
@@ -424,7 +424,7 @@
 };
 
 /* There are only 12 bits in the DMA engine for descriptor offsetting
- * so the table must be aligned on a boundry of this.
+ * so the table must be aligned on a boundary of this.
  */
 #define DMA_TABLE_BYTES		4096
 
diff -ur a/drivers/net/fc/iph5526.c b/drivers/net/fc/iph5526.c
--- a/drivers/net/fc/iph5526.c	Mon Feb 24 11:05:12 2003
+++ b/drivers/net/fc/iph5526.c	Tue Feb 25 17:58:52 2003
@@ -499,7 +499,7 @@
 		fi->q.ptr_tachyon_header[i] = fi->q.ptr_tachyon_header_base + 16*i;
 	
 	/* Allocate memory for indices.
-	 * Indices should be aligned on 32 byte boundries. 
+	 * Indices should be aligned on 32 byte boundaries. 
 	 */
 	fi->q.host_ocq_cons_indx = kmalloc(2*32, GFP_KERNEL);
 	if (fi->q.host_ocq_cons_indx == NULL){ 
diff -ur a/drivers/net/sunhme.c b/drivers/net/sunhme.c
--- a/drivers/net/sunhme.c	Mon Feb 24 11:05:15 2003
+++ b/drivers/net/sunhme.c	Tue Feb 25 17:56:37 2003
@@ -1198,7 +1198,7 @@
  * (ETH_FRAME_LEN + 64 + 2) = (1514 + 64 + 2) = 1580 bytes.
  *
  * First our alloc_skb() routine aligns the data base to a 64 byte
- * boundry.  We now have 0xf001b040 as our skb data address.  We
+ * boundary.  We now have 0xf001b040 as our skb data address.  We
  * plug this into the receive descriptor address.
  *
  * Next, we skb_reserve() 2 bytes to account for the Happy Meal offset.
diff -ur a/drivers/net/sunhme.h b/drivers/net/sunhme.h
--- a/drivers/net/sunhme.h	Mon Feb 24 11:05:30 2003
+++ b/drivers/net/sunhme.h	Tue Feb 25 17:56:40 2003
@@ -298,7 +298,7 @@
 #define CSCONFIG_NDISABLE       0x8000  /* Disable NRZI                */
 
 /* Happy Meal descriptor rings and such.
- * All descriptor rings must be aligned on a 2K boundry.
+ * All descriptor rings must be aligned on a 2K boundary.
  * All receive buffers must be 64 byte aligned.
  * Always write the address first before setting the ownership
  * bits to avoid races with the hardware scanning the ring.
diff -ur a/drivers/net/sunlance.c b/drivers/net/sunlance.c
--- a/drivers/net/sunlance.c	Mon Feb 24 11:05:14 2003
+++ b/drivers/net/sunlance.c	Tue Feb 25 17:56:42 2003
@@ -647,7 +647,7 @@
 	u8 *p8;
 	unsigned long pbuf = (unsigned long) piobuf;
 
-	/* We know here that both src and dest are on a 16bit boundry. */
+	/* We know here that both src and dest are on a 16bit boundary. */
 	*p16++ = sbus_readw(pbuf);
 	p32 = (u32 *) p16;
 	pbuf += 2;
diff -ur a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	Mon Feb 24 11:05:33 2003
+++ b/drivers/net/tg3.c	Tue Feb 25 17:56:46 2003
@@ -5941,7 +5941,7 @@
 
 	/* Force memory write invalidate off.  If we leave it on,
 	 * then on 5700_BX chips we have to enable a workaround.
-	 * The workaround is to set the TG3PCI_DMA_RW_CTRL boundry
+	 * The workaround is to set the TG3PCI_DMA_RW_CTRL boundary
 	 * to match the cacheline size.  The Broadcom driver have this
 	 * workaround but turns MWI off all the times so never uses
 	 * it.  This seems to suggest that the workaround is insufficient.
diff -ur a/drivers/net/tokenring/smctr.c b/drivers/net/tokenring/smctr.c
--- a/drivers/net/tokenring/smctr.c	Mon Feb 24 11:05:32 2003
+++ b/drivers/net/tokenring/smctr.c	Tue Feb 25 17:56:54 2003
@@ -417,7 +417,7 @@
         tp->tx_buff_end[BUG_QUEUE] = (__u16 *)smctr_malloc(dev, 0);
 
         /* Allocate MAC receive data buffers.
-         * MAC Rx buffer doesn't have to be on a 256 byte boundry.
+         * MAC Rx buffer doesn't have to be on a 256 byte boundary.
          */
         tp->rx_buff_head[MAC_QUEUE] = (__u16 *)smctr_malloc(dev,
                 RX_DATA_BUFFER_SIZE * tp->num_rx_bdbs[MAC_QUEUE]);
@@ -438,7 +438,7 @@
          * To guarantee a minimum of 256 contigous memory to
          * UM_Receive_Packet's lookahead pointer, before a page
          * change or ring end is encountered, place each rx buffer on
-         * a 256 byte boundry.
+         * a 256 byte boundary.
          */
         smctr_malloc(dev, TO_256_BYTE_BOUNDRY(tp->sh_mem_used));
         tp->rx_buff_head[NON_MAC_QUEUE] = (__u16 *)smctr_malloc(dev,
@@ -1331,7 +1331,7 @@
         mem_used += tp->tx_buff_size[BUG_QUEUE];
 
         /* Allocate MAC receive data buffers.
-         * MAC receive buffers don't have to be on a 256 byte boundry.
+         * MAC receive buffers don't have to be on a 256 byte boundary.
          */
         mem_used += RX_DATA_BUFFER_SIZE * tp->num_rx_bdbs[MAC_QUEUE];
 
@@ -1348,7 +1348,7 @@
          *
          * Make sure the mem_used offset at this point is the
          * same as in allocate_shared memory or the following
-         * boundry adjustment will be incorrect (i.e. not allocating
+         * boundary adjustment will be incorrect (i.e. not allocating
          * the non-mac receive buffers above cannot change the 256
          * byte offset).
          *
@@ -3930,7 +3930,7 @@
         return (err);
 }
 
-/* Adapter RAM test. Incremental word ODD boundry data test. */
+/* Adapter RAM test. Incremental word ODD boundary data test. */
 static int smctr_ram_memory_test(struct net_device *dev)
 {
         struct net_local *tp = (struct net_local *)dev->priv;
@@ -3947,7 +3947,7 @@
         pages_of_ram    = tp->ram_size / tp->ram_usable;
         pword           = tp->ram_access;
 
-        /* Incremental word ODD boundry test. */
+        /* Incremental word ODD boundary test. */
         for(page = 0; (page < pages_of_ram) && (~err);
                 page++, start_pattern += 0x8000)
         {
diff -ur a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
--- a/drivers/parisc/sba_iommu.c	Mon Feb 24 11:05:39 2003
+++ b/drivers/parisc/sba_iommu.c	Tue Feb 25 17:56:59 2003
@@ -1114,7 +1114,7 @@
 
 /*
 ** Two address ranges are DMA contiguous *iff* "end of prev" and
-** "start of next" are both on a page boundry.
+** "start of next" are both on a page boundary.
 **
 ** (shift left is a quick trick to mask off upper bits)
 */
diff -ur a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
--- a/drivers/scsi/qlogicpti.c	Mon Feb 24 11:05:37 2003
+++ b/drivers/scsi/qlogicpti.c	Tue Feb 25 17:57:01 2003
@@ -776,7 +776,7 @@
 }
 
 /* The request and response queues must each be aligned
- * on a page boundry.
+ * on a page boundary.
  */
 static int __init qpti_map_queues(struct qlogicpti *qpti)
 {
diff -ur a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
--- a/fs/jfs/jfs_dmap.c	Mon Feb 24 11:05:41 2003
+++ b/fs/jfs/jfs_dmap.c	Tue Feb 25 17:57:03 2003
@@ -1112,7 +1112,7 @@
 	 * current allocation in place if the number of additional blocks
 	 * can fit into a dmap, the last block of the current allocation
 	 * is not the last block of the file system, and the start of the
-	 * inplace extension is not on an allocation group boundry.
+	 * inplace extension is not on an allocation group boundary.
 	 */
 	if (addnblocks > BPERDMAP || extblkno >= bmp->db_mapsize ||
 	    (extblkno & (bmp->db_agsize - 1)) == 0) {
diff -ur a/include/asm-m68k/dvma.h b/include/asm-m68k/dvma.h
--- a/include/asm-m68k/dvma.h	Mon Feb 24 11:05:34 2003
+++ b/include/asm-m68k/dvma.h	Tue Feb 25 17:58:58 2003
@@ -45,7 +45,7 @@
 #define IOMMU_ENTRIES 120
 
 /* empirical kludge -- dvma regions only seem to work right on 0x10000 
-   byte boundries */
+   byte boundaries */
 #define DVMA_REGION_SIZE 0x10000
 #define DVMA_ALIGN(addr) (((addr)+DVMA_REGION_SIZE-1) & \
                          ~(DVMA_REGION_SIZE-1))
diff -ur a/include/asm-ppc/page.h b/include/asm-ppc/page.h
--- a/include/asm-ppc/page.h	Mon Feb 24 11:05:14 2003
+++ b/include/asm-ppc/page.h	Tue Feb 25 17:57:21 2003
@@ -58,7 +58,7 @@
 #endif
 
 
-/* align addr on a size boundry - adjust address up if needed -- Cort */
+/* align addr on a size boundary - adjust address up if needed -- Cort */
 #define _ALIGN(addr,size)	(((addr)+(size)-1)&(~((size)-1)))
 
 /* to align the pointer to the (next) page boundary */
diff -ur a/include/asm-ppc64/page.h b/include/asm-ppc64/page.h
--- a/include/asm-ppc64/page.h	Mon Feb 24 11:05:05 2003
+++ b/include/asm-ppc64/page.h	Tue Feb 25 17:57:19 2003
@@ -114,11 +114,11 @@
 
 #endif /* __ASSEMBLY__ */
 
-/* align addr on a size boundry - adjust address up/down if needed */
+/* align addr on a size boundary - adjust address up/down if needed */
 #define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
 #define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
 
-/* align addr on a size boundry - adjust address up if needed */
+/* align addr on a size boundary - adjust address up if needed */
 #define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
 
 /* to align the pointer to the (next) double word boundary */
diff -ur a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
--- a/sound/oss/cs46xx.c	Mon Feb 24 11:05:05 2003
+++ b/sound/oss/cs46xx.c	Tue Feb 25 17:57:23 2003
@@ -1016,7 +1016,7 @@
 	}
 		
 	/*
-	 * ganularity is byte boundry, good part.
+	 * ganularity is byte boundary, good part.
 	 */
 	if(dmabuf->enable & DAC_RUNNING)
 	{
diff -ur a/sound/oss/maestro3.c b/sound/oss/maestro3.c
--- a/sound/oss/maestro3.c	Mon Feb 24 11:05:43 2003
+++ b/sound/oss/maestro3.c	Tue Feb 25 17:57:27 2003
@@ -1916,8 +1916,8 @@
      * the amazingly complicated prog_dmabuf wants it.
      *
      * pci_alloc_sonsistent guarantees that it won't cross a natural
-     * boundry; the m3 hardware can't have dma cross a 64k bus
-     * address boundry.
+     * boundary; the m3 hardware can't have dma cross a 64k bus
+     * address boundary.
      */
     for (order = 16-PAGE_SHIFT; order >= 1; order--) {
         db->rawbuf = pci_alloc_consistent(pci_dev, PAGE_SIZE << order,
