Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268365AbTBSDJA>; Tue, 18 Feb 2003 22:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268400AbTBSDI5>; Tue, 18 Feb 2003 22:08:57 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:61960 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S268365AbTBSC6L>; Tue, 18 Feb 2003 21:58:11 -0500
Subject: [PATCH] 2.5.62 spelling fix for propogate -> propagate in 13 files.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 18 Feb 2003 19:59:35 -0700
Message-Id: <1045623578.5965.307.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the following spelling fix.

propogate -> propagate

 arch/m68k/ifpsp060/src/fpsp.S  |    4 ++--
 arch/m68k/ifpsp060/src/pfpsp.S |    4 ++--
 arch/m68k/kernel/head.S        |    2 +-
 arch/mips/ddb5xxx/common/pci.c |    2 +-
 arch/mips/kernel/pci.c         |    2 +-
 drivers/block/floppy.c         |    2 +-
 drivers/char/epca.c            |    4 ++--
 drivers/ide/setup-pci.c        |    2 +-
 drivers/parisc/lba_pci.c       |    2 +-
 drivers/scsi/53c7xx.c          |    2 +-
 include/net/sctp/ulpqueue.h    |    2 +-
 net/sctp/ulpqueue.c            |    2 +-
 sound/oss/maestro.c            |    2 +-
 13 files changed, 16 insertions(+), 16 deletions(-)

diff -ur linux-2.5.62-1104-orig/arch/m68k/ifpsp060/src/fpsp.S linux-2.5.62-1104/arch/m68k/ifpsp060/src/fpsp.S
--- linux-2.5.62-1104-orig/arch/m68k/ifpsp060/src/fpsp.S	Thu Jan 16 19:22:53 2003
+++ linux-2.5.62-1104/arch/m68k/ifpsp060/src/fpsp.S	Tue Feb 18 18:44:43 2003
@@ -22147,7 +22147,7 @@
 add_ext:
 	addq.l		&1,FTEMP_LO(%a0)	# add 1 to l-bit
 	bcc.b		xcc_clr			# test for carry out
-	addq.l		&1,FTEMP_HI(%a0)	# propogate carry
+	addq.l		&1,FTEMP_HI(%a0)	# propagate carry
 	bcc.b		xcc_clr
 	roxr.w		FTEMP_HI(%a0)		# mant is 0 so restore v-bit
 	roxr.w		FTEMP_HI+2(%a0)		# mant is 0 so restore v-bit
@@ -22167,7 +22167,7 @@
 add_dbl:
 	add.l		&ad_1_dbl, FTEMP_LO(%a0) # add 1 to lsb
 	bcc.b		dcc_clr			# no carry
-	addq.l		&0x1, FTEMP_HI(%a0)	# propogate carry
+	addq.l		&0x1, FTEMP_HI(%a0)	# propagate carry
 	bcc.b		dcc_clr			# no carry
 
 	roxr.w		FTEMP_HI(%a0)		# mant is 0 so restore v-bit
diff -ur linux-2.5.62-1104-orig/arch/m68k/ifpsp060/src/pfpsp.S linux-2.5.62-1104/arch/m68k/ifpsp060/src/pfpsp.S
--- linux-2.5.62-1104-orig/arch/m68k/ifpsp060/src/pfpsp.S	Thu Jan 16 19:21:38 2003
+++ linux-2.5.62-1104/arch/m68k/ifpsp060/src/pfpsp.S	Tue Feb 18 18:44:43 2003
@@ -6269,7 +6269,7 @@
 add_ext:
 	addq.l		&1,FTEMP_LO(%a0)	# add 1 to l-bit
 	bcc.b		xcc_clr			# test for carry out
-	addq.l		&1,FTEMP_HI(%a0)	# propogate carry
+	addq.l		&1,FTEMP_HI(%a0)	# propagate carry
 	bcc.b		xcc_clr
 	roxr.w		FTEMP_HI(%a0)		# mant is 0 so restore v-bit
 	roxr.w		FTEMP_HI+2(%a0)		# mant is 0 so restore v-bit
@@ -6289,7 +6289,7 @@
 add_dbl:
 	add.l		&ad_1_dbl, FTEMP_LO(%a0) # add 1 to lsb
 	bcc.b		dcc_clr			# no carry
-	addq.l		&0x1, FTEMP_HI(%a0)	# propogate carry
+	addq.l		&0x1, FTEMP_HI(%a0)	# propagate carry
 	bcc.b		dcc_clr			# no carry
 
 	roxr.w		FTEMP_HI(%a0)		# mant is 0 so restore v-bit
diff -ur linux-2.5.62-1104-orig/arch/m68k/kernel/head.S linux-2.5.62-1104/arch/m68k/kernel/head.S
--- linux-2.5.62-1104-orig/arch/m68k/kernel/head.S	Thu Jan 16 19:22:59 2003
+++ linux-2.5.62-1104/arch/m68k/kernel/head.S	Tue Feb 18 18:44:43 2003
@@ -92,7 +92,7 @@
  *	mmu_map was written for two key reasons.  First, it was clear
  * that it was very difficult to read the previous code for mapping
  * regions of memory.  Second, the Macintosh required such extensive
- * memory allocations that it didn't make sense to propogate the
+ * memory allocations that it didn't make sense to propagate the
  * existing code any further.
  *	mmu_map requires some parameters:
  *
diff -ur linux-2.5.62-1104-orig/arch/mips/ddb5xxx/common/pci.c linux-2.5.62-1104/arch/mips/ddb5xxx/common/pci.c
--- linux-2.5.62-1104-orig/arch/mips/ddb5xxx/common/pci.c	Thu Jan 16 19:22:56 2003
+++ linux-2.5.62-1104/arch/mips/ddb5xxx/common/pci.c	Tue Feb 18 18:44:43 2003
@@ -148,7 +148,7 @@
                 }
                 bus->resource[0]->flags |= pci_bridge_check_io(dev);
                 bus->resource[1]->flags |= IORESOURCE_MEM;
-                /* For now, propogate hose limits to the bus;
+                /* For now, propagate hose limits to the bus;
                    we'll adjust them later. */
                 bus->resource[0]->end = hose->io_resource->end;
                 bus->resource[1]->end = hose->mem_resource->end;
diff -ur linux-2.5.62-1104-orig/arch/mips/kernel/pci.c linux-2.5.62-1104/arch/mips/kernel/pci.c
--- linux-2.5.62-1104-orig/arch/mips/kernel/pci.c	Thu Jan 16 19:22:24 2003
+++ linux-2.5.62-1104/arch/mips/kernel/pci.c	Tue Feb 18 18:44:43 2003
@@ -145,7 +145,7 @@
 		}
 		bus->resource[0]->flags |= pci_bridge_check_io(dev);
 		bus->resource[1]->flags |= IORESOURCE_MEM;
-		/* For now, propogate hose limits to the bus;
+		/* For now, propagate hose limits to the bus;
 		   we'll adjust them later. */
 		bus->resource[0]->end = hose->io_resource->end;
 		bus->resource[1]->end = hose->mem_resource->end;
diff -ur linux-2.5.62-1104-orig/drivers/block/floppy.c linux-2.5.62-1104/drivers/block/floppy.c
--- linux-2.5.62-1104-orig/drivers/block/floppy.c	Mon Feb 10 12:22:58 2003
+++ linux-2.5.62-1104/drivers/block/floppy.c	Tue Feb 18 18:44:43 2003
@@ -822,7 +822,7 @@
 		}
 	}
 	/*
-	 *	We should propogate failures to grab the resources back
+	 *	We should propagate failures to grab the resources back
 	 *	nicely from here. Actually we ought to rewrite the fd
 	 *	driver some day too.
 	 */
diff -ur linux-2.5.62-1104-orig/drivers/char/epca.c linux-2.5.62-1104/drivers/char/epca.c
--- linux-2.5.62-1104-orig/drivers/char/epca.c	Thu Jan 16 19:22:18 2003
+++ linux-2.5.62-1104/drivers/char/epca.c	Tue Feb 18 18:44:43 2003
@@ -2805,7 +2805,7 @@
 		ch->fepstopc = ch->stopc;
 
 		/* ------------------------------------------------------------
-			The XON / XOFF characters have changed; propogate these
+			The XON / XOFF characters have changed; propagate these
 			changes to the card.	
 		--------------------------------------------------------------- */
 
@@ -2819,7 +2819,7 @@
 
 		/* ---------------------------------------------------------------
 			Similar to the above, this time the auxilarly XON / XOFF 
-			characters have changed; propogate these changes to the card.
+			characters have changed; propagate these changes to the card.
 		------------------------------------------------------------------ */
 
 		fepcmd(ch, SAUXONOFFC, ch->fepstartca, ch->fepstopca, 0, 1);
diff -ur linux-2.5.62-1104-orig/drivers/ide/setup-pci.c linux-2.5.62-1104/drivers/ide/setup-pci.c
--- linux-2.5.62-1104-orig/drivers/ide/setup-pci.c	Thu Jan 16 19:22:03 2003
+++ linux-2.5.62-1104/drivers/ide/setup-pci.c	Tue Feb 18 18:44:43 2003
@@ -662,7 +662,7 @@
 		 *	This is in the wrong place. The driver may
 		 *	do set up based on the autotune value and this
 		 *	will then trash it. Torben please move it and
-		 *	propogate the fixes into the drivers
+		 *	propagate the fixes into the drivers
 		 */		
 		if (drive0_tune == IDE_TUNE_BIOS) /* biostimings */
 			hwif->drives[0].autotune = IDE_TUNE_BIOS;
diff -ur linux-2.5.62-1104-orig/drivers/parisc/lba_pci.c linux-2.5.62-1104/drivers/parisc/lba_pci.c
--- linux-2.5.62-1104-orig/drivers/parisc/lba_pci.c	Thu Jan 16 19:22:24 2003
+++ linux-2.5.62-1104/drivers/parisc/lba_pci.c	Tue Feb 18 18:44:43 2003
@@ -765,7 +765,7 @@
 			pci_read_bridge_bases(bus);
 		} else {
 			/* Not configured.
-			** For now, propogate HBA limits to the bus;
+			** For now, propagate HBA limits to the bus;
 			**	PCI will adjust them later.
 			*/
 			bus->resource[0]->end = ldev->hba.io_space.end;
diff -ur linux-2.5.62-1104-orig/drivers/scsi/53c7xx.c linux-2.5.62-1104/drivers/scsi/53c7xx.c
--- linux-2.5.62-1104-orig/drivers/scsi/53c7xx.c	Thu Jan 16 19:23:01 2003
+++ linux-2.5.62-1104/drivers/scsi/53c7xx.c	Tue Feb 18 18:44:43 2003
@@ -5794,7 +5794,7 @@
  *	so we don't perturb hostdata.  We don't use a field of the 
  *	NCR53c7x0_cmd structure since we may not have allocated one 
  *	for the command causing the reset.) of Scsi_Cmnd structures that 
- *  	had propogated below the Linux issue queue level.  If free is set, 
+ *  	had propagated below the Linux issue queue level.  If free is set, 
  *	free the NCR53c7x0_cmd structures which are associated with 
  *	the Scsi_Cmnd structures, and clean up any internal 
  *	NCR lists that the commands were on.  If issue is set,
diff -ur linux-2.5.62-1104-orig/include/net/sctp/ulpqueue.h linux-2.5.62-1104/include/net/sctp/ulpqueue.h
--- linux-2.5.62-1104-orig/include/net/sctp/ulpqueue.h	Fri Feb 14 20:12:05 2003
+++ linux-2.5.62-1104/include/net/sctp/ulpqueue.h	Tue Feb 18 18:44:43 2003
@@ -62,7 +62,7 @@
 /* Add a new DATA chunk for processing. */
 int sctp_ulpq_tail_data(struct sctp_ulpq *, sctp_chunk_t *chunk, int priority);
 
-/* Add a new event for propogation to the ULP. */
+/* Add a new event for propagation to the ULP. */
 int sctp_ulpq_tail_event(struct sctp_ulpq *, struct sctp_ulpevent *ev);
 
 /* Is the ulpqueue empty. */
diff -ur linux-2.5.62-1104-orig/net/sctp/ulpqueue.c linux-2.5.62-1104/net/sctp/ulpqueue.c
--- linux-2.5.62-1104-orig/net/sctp/ulpqueue.c	Fri Feb 14 20:12:06 2003
+++ linux-2.5.62-1104/net/sctp/ulpqueue.c	Tue Feb 18 18:44:43 2003
@@ -154,7 +154,7 @@
 	return 0;
 }
 
-/* Add a new event for propogation to the ULP.  */
+/* Add a new event for propagation to the ULP.  */
 int sctp_ulpq_tail_event(struct sctp_ulpq *ulpq, struct sctp_ulpevent *event)
 {
 	struct sock *sk = ulpq->asoc->base.sk;
diff -ur linux-2.5.62-1104-orig/sound/oss/maestro.c linux-2.5.62-1104/sound/oss/maestro.c
--- linux-2.5.62-1104-orig/sound/oss/maestro.c	Mon Feb 10 12:23:10 2003
+++ linux-2.5.62-1104/sound/oss/maestro.c	Tue Feb 18 18:44:43 2003
@@ -1830,7 +1830,7 @@
 	if (s->dma_adc.ready) {
 		/* oh boy should this all be re-written.  everything in the current code paths think
 		that the various counters/pointers are expressed in bytes to the user but we have
-		two apus doing stereo stuff so we fix it up here.. it propogates to all the various
+		two apus doing stereo stuff so we fix it up here.. it propagates to all the various
 		counters from here.  */
 		if ( s->fmt & (ESS_FMT_STEREO << ESS_ADC_SHIFT)) {
 			hwptr = (get_dmac(s)*2) % s->dma_adc.dmasize;





