Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268372AbTBSC5M>; Tue, 18 Feb 2003 21:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268378AbTBSC5M>; Tue, 18 Feb 2003 21:57:12 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:39944 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S268372AbTBSC5B>; Tue, 18 Feb 2003 21:57:01 -0500
Subject: [PATCH] 2.5.62 spelling fix accessable -> accessible in 15 files.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 18 Feb 2003 19:58:25 -0700
Message-Id: <1045623507.10680.293.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the following spelling fix.

accessable -> accessible

 drivers/isdn/hardware/eicon/io.c           |    2 +-
 drivers/net/au1000_eth.c                   |    2 +-
 drivers/net/dgrs_plx9060.h                 |    2 +-
 drivers/net/sis900.c                       |    2 +-
 drivers/net/sk98lin/skge.c                 |    2 +-
 drivers/net/sk98lin/skgeinit.c             |    4 ++--
 drivers/net/skfp/pmf.c                     |    4 ++--
 drivers/s390/cio/chsc.c                    |    2 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c         |    2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.c         |    2 +-
 drivers/scsi/psi_chip.h                    |    2 +-
 include/asm-arm/arch-integrator/platform.h |    2 +-
 include/asm-ia64/sn/pci/bridge.h           |    4 ++--
 include/asm-ia64/sn/sn2/shub_md.h          |    2 +-
 include/asm-parisc/pgtable.h               |    2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)

diff -ur linux-2.5.62-1104-orig/drivers/isdn/hardware/eicon/io.c linux-2.5.62-1104/drivers/isdn/hardware/eicon/io.c
--- linux-2.5.62-1104-orig/drivers/isdn/hardware/eicon/io.c	Thu Jan 16 19:21:47 2003
+++ linux-2.5.62-1104/drivers/isdn/hardware/eicon/io.c	Tue Feb 18 18:12:35 2003
@@ -534,7 +534,7 @@
   goto Trapped ;
  }
 /*
- * memory based shared ram is accessable from different
+ * memory based shared ram is accessible from different
  * processors without disturbing concurrent processes.
  */
  a->ram_out (a, &IoAdapter->pcm->rc, 0) ;
diff -ur linux-2.5.62-1104-orig/drivers/net/au1000_eth.c linux-2.5.62-1104/drivers/net/au1000_eth.c
--- linux-2.5.62-1104-orig/drivers/net/au1000_eth.c	Thu Jan 16 19:22:14 2003
+++ linux-2.5.62-1104/drivers/net/au1000_eth.c	Tue Feb 18 18:12:35 2003
@@ -465,7 +465,7 @@
 
 		mii_status = mdio_read(dev, phy_addr, MII_STATUS);
 		if (mii_status == 0xffff || mii_status == 0x0000)
-			/* the mii is not accessable, try next one */
+			/* the mii is not accessible, try next one */
 			continue;
 
 		phy_id0 = mdio_read(dev, phy_addr, MII_PHY_ID0);
diff -ur linux-2.5.62-1104-orig/drivers/net/dgrs_plx9060.h linux-2.5.62-1104/drivers/net/dgrs_plx9060.h
--- linux-2.5.62-1104-orig/drivers/net/dgrs_plx9060.h	Thu Jan 16 19:22:07 2003
+++ linux-2.5.62-1104/drivers/net/dgrs_plx9060.h	Tue Feb 18 18:12:35 2003
@@ -18,7 +18,7 @@
 #define	PCI_INT_LINE		0x3C
 
 /*
- *	Registers accessable directly from PCI and local side.
+ *	Registers accessible directly from PCI and local side.
  *	Offset is from PCI side.  Add PLX_LCL_OFFSET for local address.
  */
 #define	PLX_LCL_OFFSET	0x80	/* Offset of regs from local side */
diff -ur linux-2.5.62-1104-orig/drivers/net/sis900.c linux-2.5.62-1104/drivers/net/sis900.c
--- linux-2.5.62-1104-orig/drivers/net/sis900.c	Fri Feb 14 20:11:58 2003
+++ linux-2.5.62-1104/drivers/net/sis900.c	Tue Feb 18 18:12:35 2003
@@ -526,7 +526,7 @@
 			mii_status = mdio_read(net_dev, phy_addr, MII_STATUS);
 
 		if (mii_status == 0xffff || mii_status == 0x0000)
-			/* the mii is not accessable, try next one */
+			/* the mii is not accessible, try next one */
 			continue;
 		
 		if ((mii_phy = kmalloc(sizeof(struct mii_phy), GFP_KERNEL)) == NULL) {
diff -ur linux-2.5.62-1104-orig/drivers/net/sk98lin/skge.c linux-2.5.62-1104/drivers/net/sk98lin/skge.c
--- linux-2.5.62-1104-orig/drivers/net/sk98lin/skge.c	Thu Jan 16 19:21:40 2003
+++ linux-2.5.62-1104/drivers/net/sk98lin/skge.c	Tue Feb 18 18:12:35 2003
@@ -2516,7 +2516,7 @@
 		/*
 		 * Do not set the Limit to 0, because this could cause
 		 * wrap around with ReQueue'ed buffers (a buffer could
-		 * be requeued in the same position, made accessable to
+		 * be requeued in the same position, made accessible to
 		 * the hardware, and the hardware could change its
 		 * contents!
 		 */
diff -ur linux-2.5.62-1104-orig/drivers/net/sk98lin/skgeinit.c linux-2.5.62-1104/drivers/net/sk98lin/skgeinit.c
--- linux-2.5.62-1104-orig/drivers/net/sk98lin/skgeinit.c	Mon Feb 10 12:23:00 2003
+++ linux-2.5.62-1104/drivers/net/sk98lin/skgeinit.c	Tue Feb 18 18:12:35 2003
@@ -1781,7 +1781,7 @@
  * Returns:
  *	0:	success
  *	1:	Number of MACs exceeds SK_MAX_MACS	( after level 1)
- *	2:	Adapter not present or not accessable
+ *	2:	Adapter not present or not accessible
  *	3:	Illegal initialization level
  *	4:	Initialization Level 1 Call missing
  *	5:	Unexpected PHY type detected
@@ -1808,7 +1808,7 @@
 		/* Initialization Level 1 */
 		RetVal = SkGeInit1(pAC, IoC);
 
-		/* Check if the adapter seems to be accessable */
+		/* Check if the adapter seems to be accessible */
 		SK_OUT32(IoC, B2_IRQM_INI, 0x11335577L);
 		SK_IN32(IoC, B2_IRQM_INI, &DWord);
 		SK_OUT32(IoC, B2_IRQM_INI, 0x00000000L);
diff -ur linux-2.5.62-1104-orig/drivers/net/skfp/pmf.c linux-2.5.62-1104/drivers/net/skfp/pmf.c
--- linux-2.5.62-1104-orig/drivers/net/skfp/pmf.c	Thu Jan 16 19:22:47 2003
+++ linux-2.5.62-1104/drivers/net/skfp/pmf.c	Tue Feb 18 18:12:35 2003
@@ -122,7 +122,7 @@
 
 	/*
 	 * PRIVATE EXTENSIONS
-	 * only accessable locally to get/set passwd
+	 * only accessible locally to get/set passwd
 	 */
 	{ SMT_P10F0,AC_GR,	MOFFSA(fddiPRPMFPasswd),	"8"	} ,
 	{ SMT_P10F1,AC_GR,	MOFFSS(fddiPRPMFStation),	"8"	} ,
@@ -211,7 +211,7 @@
 
 	/*
 	 * PRIVATE EXTENSIONS
-	 * only accessable locally to get/set TMIN
+	 * only accessible locally to get/set TMIN
 	 */
 	{ SMT_P20F0,AC_NA						} ,
 	{ SMT_P20F1,AC_GR,	MOFFMS(fddiMACT_Min),		"lT"	} ,
diff -ur linux-2.5.62-1104-orig/drivers/s390/cio/chsc.c linux-2.5.62-1104/drivers/s390/cio/chsc.c
--- linux-2.5.62-1104-orig/drivers/s390/cio/chsc.c	Thu Jan 16 19:22:16 2003
+++ linux-2.5.62-1104/drivers/s390/cio/chsc.c	Tue Feb 18 18:12:35 2003
@@ -486,7 +486,7 @@
 	case 2: /* i/o resource accessibiliy */
 		CIO_CRW_EVENT(4, "chsc_process_crw: "
 			      "channel subsystem reports some I/O "
-			      "devices may have become accessable\n");
+			      "devices may have become accessible\n");
 		pr_debug( KERN_DEBUG "Data received after sei: \n");
 		pr_debug( KERN_DEBUG "Validity flags: %x\n", sei_res->vf);
 
diff -ur linux-2.5.62-1104-orig/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.5.62-1104/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.5.62-1104-orig/drivers/scsi/aic7xxx/aic79xx_osm.c	Tue Feb 18 18:06:18 2003
+++ linux-2.5.62-1104/drivers/scsi/aic7xxx/aic79xx_osm.c	Tue Feb 18 18:12:35 2003
@@ -1826,7 +1826,7 @@
 	 * At least in 2.2.14, malloc is a slab allocator so all
 	 * allocations are aligned.  We assume for these kernel versions
 	 * that all allocations will be bellow 4Gig, physically contiguous,
-	 * and accessable via DMA by the controller.
+	 * and accessible via DMA by the controller.
 	 */
 	map = NULL; /* No additional information to store */
 	*vaddr = malloc(dmat->maxsize, M_DEVBUF, M_NOWAIT);
diff -ur linux-2.5.62-1104-orig/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.5.62-1104/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.5.62-1104-orig/drivers/scsi/aic7xxx/aic7xxx_osm.c	Tue Feb 18 18:06:18 2003
+++ linux-2.5.62-1104/drivers/scsi/aic7xxx/aic7xxx_osm.c	Tue Feb 18 18:12:35 2003
@@ -1435,7 +1435,7 @@
 	 * At least in 2.2.14, malloc is a slab allocator so all
 	 * allocations are aligned.  We assume for these kernel versions
 	 * that all allocations will be bellow 4Gig, physically contiguous,
-	 * and accessable via DMA by the controller.
+	 * and accessible via DMA by the controller.
 	 */
 	map = NULL; /* No additional information to store */
 	*vaddr = malloc(dmat->maxsize, M_DEVBUF, M_NOWAIT);
diff -ur linux-2.5.62-1104-orig/drivers/scsi/psi_chip.h linux-2.5.62-1104/drivers/scsi/psi_chip.h
--- linux-2.5.62-1104-orig/drivers/scsi/psi_chip.h	Thu Jan 16 19:21:38 2003
+++ linux-2.5.62-1104/drivers/scsi/psi_chip.h	Tue Feb 18 18:12:35 2003
@@ -108,7 +108,7 @@
 typedef struct
 	{
 	UCHAR		irq;			// interrupt request channel number
-	UCHAR		numDrives;		// Number of accessable drives
+	UCHAR		numDrives;		// Number of accessible drives
 	UCHAR		fastFormat;	 	// Boolean for fast format enable
 	}	CHIP_CONFIG_N;
 
diff -ur linux-2.5.62-1104-orig/include/asm-arm/arch-integrator/platform.h linux-2.5.62-1104/include/asm-arm/arch-integrator/platform.h
--- linux-2.5.62-1104-orig/include/asm-arm/arch-integrator/platform.h	Thu Jan 16 19:22:14 2003
+++ linux-2.5.62-1104/include/asm-arm/arch-integrator/platform.h	Tue Feb 18 18:12:35 2003
@@ -466,7 +466,7 @@
 #define MAXSWINUM                       31
  
 /* ------------------------------------------------------------------------
- *  LED's - The header LED is not accessable via the uHAL API
+ *  LED's - The header LED is not accessible via the uHAL API
  * ------------------------------------------------------------------------
  * 
  */
diff -ur linux-2.5.62-1104-orig/include/asm-ia64/sn/pci/bridge.h linux-2.5.62-1104/include/asm-ia64/sn/pci/bridge.h
--- linux-2.5.62-1104-orig/include/asm-ia64/sn/pci/bridge.h	Thu Jan 16 19:21:43 2003
+++ linux-2.5.62-1104/include/asm-ia64/sn/pci/bridge.h	Tue Feb 18 18:12:35 2003
@@ -186,8 +186,8 @@
 
 /*
  * BRIDGE, XBRIDGE, PIC register definitions.  NOTE: Prior to PIC, registers
- * were a 32bit quantity and double word aligned (and only accessable as a
- * 32bit word.  PIC registers are 64bits and accessable as words or double
+ * were a 32bit quantity and double word aligned (and only accessible as a
+ * 32bit word.  PIC registers are 64bits and accessible as words or double
  * words.  PIC registers that have valid bits (ie. not just reserved) in the
  * upper 32bits are defined as a union of one 64bit picreg_t and two 32bit
  * bridgereg_t so we can access them both ways.
diff -ur linux-2.5.62-1104-orig/include/asm-ia64/sn/sn2/shub_md.h linux-2.5.62-1104/include/asm-ia64/sn/sn2/shub_md.h
--- linux-2.5.62-1104-orig/include/asm-ia64/sn/sn2/shub_md.h	Thu Jan 16 19:22:45 2003
+++ linux-2.5.62-1104/include/asm-ia64/sn/sn2/shub_md.h	Tue Feb 18 18:12:35 2003
@@ -133,7 +133,7 @@
 #define MD_DIMM_SIZE_MBYTES(_size, _2bk) (				 \
 	 	( (_size) == 7 ? 0 : ( 0x40L << (_size) ) << (_2bk)))  	 \
 
-/* The top 1/32 of each bank is directory memory, and not accessable
+/* The top 1/32 of each bank is directory memory, and not accessible
  * via normal reads and writes */
 #define MD_DIMM_USER_SIZE(_size)	((_size) * 31 / 32)
 
diff -ur linux-2.5.62-1104-orig/include/asm-parisc/pgtable.h linux-2.5.62-1104/include/asm-parisc/pgtable.h
--- linux-2.5.62-1104-orig/include/asm-parisc/pgtable.h	Thu Jan 16 19:22:41 2003
+++ linux-2.5.62-1104/include/asm-parisc/pgtable.h	Tue Feb 18 18:12:35 2003
@@ -128,7 +128,7 @@
 #define _PAGE_PRESENT_BIT  22   /* (0x200) Software: translation valid */
 #define _PAGE_FLUSH_BIT    21   /* (0x400) Software: translation valid */
 				/*             for cache flushing only */
-#define _PAGE_USER_BIT     20   /* (0x800) Software: User accessable page */
+#define _PAGE_USER_BIT     20   /* (0x800) Software: User accessible page */
 
 /* N.B. The bits are defined in terms of a 32 bit word above, so the */
 /*      following macro is ok for both 32 and 64 bit.                */





