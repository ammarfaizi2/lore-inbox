Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268607AbTBZCf7>; Tue, 25 Feb 2003 21:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268611AbTBZCf7>; Tue, 25 Feb 2003 21:35:59 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:12297 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S268607AbTBZCfe>; Tue, 25 Feb 2003 21:35:34 -0500
Subject: [PATCH] 2.5.63-current replace its with it's where appropriate.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 25 Feb 2003 19:44:48 -0700
Message-Id: <1046227493.7527.272.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces its (possessive of it) with it's (it is)
in the following cases where "it is" is meant.

its a   -> it's a
its an  -> it's an
its not -> it's not

except for the files 
arch/cris/boot/rescue/head.S and
arch/cris/kernel/kgdb.c
where the substitution is "its not" -> "it is not"
to avoid possible problems with single quotes in assembly comments.

This was diffed against the current 2.5 tree.

Steven

 Documentation/block/biodoc.txt             |    2 +-
 Documentation/networking/decnet.txt        |    2 +-
 Documentation/sound/oss/Wavefront          |    2 +-
 Documentation/vm/overcommit-accounting     |    2 +-
 arch/cris/boot/rescue/head.S               |    2 +-
 arch/cris/kernel/kgdb.c                    |    2 +-
 arch/m68k/kernel/head.S                    |    2 +-
 arch/ppc/syslib/mpc10x_common.c            |    2 +-
 drivers/acorn/block/mfmhd.c                |    2 +-
 drivers/block/cciss.c                      |    2 +-
 drivers/block/cpqarray.c                   |    2 +-
 drivers/char/drm/drm_vm.h                  |    2 +-
 drivers/char/epca.c                        |    2 +-
 drivers/char/ftape/lowlevel/ftape-calibr.c |    2 +-
 drivers/char/rio/rioroute.c                |    2 +-
 drivers/char/rio/riotable.c                |    2 +-
 drivers/ide/pci/pdc202xx_new.c             |    2 +-
 drivers/isdn/eicon/idi.c                   |    2 +-
 drivers/isdn/hardware/eicon/di.c           |    4 ++--
 drivers/isdn/hisax/hfc_sx.c                |    2 +-
 drivers/media/video/saa7110.c              |    2 +-
 drivers/message/i2o/i2o_block.c            |    2 +-
 drivers/net/declance.c                     |    2 +-
 drivers/net/dgrs.c                         |   10 +++++-----
 drivers/net/slhc.c                         |    2 +-
 drivers/net/tulip/tulip_core.c             |    2 +-
 drivers/net/wan/hostess_sv11.c             |    2 +-
 drivers/net/wan/sdla_fr.c                  |    2 +-
 drivers/net/wan/sdla_ppp.c                 |    2 +-
 drivers/net/wan/sdla_x25.c                 |    2 +-
 drivers/net/wan/sdlamain.c                 |    2 +-
 drivers/net/wan/sealevel.c                 |    2 +-
 drivers/scsi/megaraid.c                    |    2 +-
 drivers/video/retz3fb.c                    |    2 +-
 include/asm-i386/page.h                    |    2 +-
 include/net/dn_dev.h                       |    2 +-
 net/decnet/dn_dev.c                        |    4 ++--
 net/ipv4/tcp.c                             |    2 +-
 net/ipx/af_ipx.c                           |    2 +-
 net/sched/sch_gred.c                       |    2 +-
 sound/isa/wavefront/wavefront_synth.c      |    2 +-
 sound/oss/maestro.c                        |    2 +-
 sound/oss/wavfront.c                       |    4 ++--
 43 files changed, 50 insertions(+), 50 deletions(-)

diff -ur linux-2.5/Documentation/block/biodoc.txt linux/Documentation/block/biodoc.txt
--- linux-2.5/Documentation/block/biodoc.txt	Tue Feb 25 18:27:29 2003
+++ linux/Documentation/block/biodoc.txt	Tue Feb 25 19:05:27 2003
@@ -1038,7 +1038,7 @@
 in fact all queues get unplugged as a side-effect.
 
 Aside:
-  This is kind of controversial territory, as its not clear if plugging is
+  This is kind of controversial territory, as it's not clear if plugging is
   always the right thing to do. Devices typically have their own queues,
   and allowing a big queue to build up in software, while letting the device be
   idle for a while may not always make sense. The trick is to handle the fine
diff -ur linux-2.5/Documentation/networking/decnet.txt linux/Documentation/networking/decnet.txt
--- linux-2.5/Documentation/networking/decnet.txt	Tue Feb 25 18:24:43 2003
+++ linux/Documentation/networking/decnet.txt	Tue Feb 25 19:05:27 2003
@@ -42,7 +42,7 @@
 3) Command line options
 
 You can set a DECnet address on the kernel command line for compatibility
-with the 2.4 configuration procedure, but in general its not needed any more.
+with the 2.4 configuration procedure, but in general it's not needed any more.
 If you do st a DECnet address on the command line, it has only one purpose
 which is that its added to the addresses on the loopback device.
 
diff -ur linux-2.5/Documentation/sound/oss/Wavefront linux/Documentation/sound/oss/Wavefront
--- linux-2.5/Documentation/sound/oss/Wavefront	Tue Feb 25 18:24:49 2003
+++ linux/Documentation/sound/oss/Wavefront	Tue Feb 25 19:05:27 2003
@@ -81,7 +81,7 @@
 2) Why does line XXX of the code look like this .... ?
 **********************************************************************
 
-Either because its not finished yet, or because you're a better coder
+Either because it's not finished yet, or because you're a better coder
 than I am, or because you don't understand some aspect of how the card
 or the code works. 
 
diff -ur linux-2.5/Documentation/vm/overcommit-accounting linux/Documentation/vm/overcommit-accounting
--- linux-2.5/Documentation/vm/overcommit-accounting	Tue Feb 25 18:25:06 2003
+++ linux/Documentation/vm/overcommit-accounting	Tue Feb 25 19:05:23 2003
@@ -26,7 +26,7 @@
 The C language stack growth does an implicit mremap. If you want absolute
 guarantees and run close to the edge you MUST mmap your stack for the 
 largest size you think you will need. For typical stack usage is does
-not matter much but its a corner case if you really really care
+not matter much but it's a corner case if you really really care
 
 In mode 2 the MAP_NORESERVE flag is ignored. 
 
diff -ur linux-2.5/arch/cris/boot/rescue/head.S linux/arch/cris/boot/rescue/head.S
--- linux-2.5/arch/cris/boot/rescue/head.S	Tue Feb 25 18:27:38 2003
+++ linux/arch/cris/boot/rescue/head.S	Tue Feb 25 19:05:27 2003
@@ -130,7 +130,7 @@
 
 	;; first put a jump test to give a possibility of upgrading the rescue code
 	;; without erasing/reflashing the sector. we put a longword of -1 here and if
-	;; its not -1, we jump using the value as jump target. since we can always
+	;; it is not -1, we jump using the value as jump target. since we can always
 	;; change 1's to 0's without erasing the sector, it is possible to add new
 	;; code after this and altering the jumptarget in an upgrade.
 
diff -ur linux-2.5/arch/cris/kernel/kgdb.c linux/arch/cris/kernel/kgdb.c
--- linux-2.5/arch/cris/kernel/kgdb.c	Tue Feb 25 18:28:21 2003
+++ linux/arch/cris/kernel/kgdb.c	Tue Feb 25 19:05:23 2003
@@ -1486,7 +1486,7 @@
   move.d   $r0,[reg+0x62]   ; Save the return address in BRP
   move     $usp,[reg+0x66]  ; USP
 
-;; get the serial character (from debugport.c) and check if its a ctrl-c
+;; get the serial character (from debugport.c) and check if it is a ctrl-c
 
   jsr getDebugChar
   cmp.b 3, $r10
diff -ur linux-2.5/arch/m68k/kernel/head.S linux/arch/m68k/kernel/head.S
--- linux-2.5/arch/m68k/kernel/head.S	Tue Feb 25 18:28:52 2003
+++ linux/arch/m68k/kernel/head.S	Tue Feb 25 19:05:23 2003
@@ -3127,7 +3127,7 @@
 	moveb	%d0,M162_SCC_CTRL_A
 	jra	3f
 5:
-	/* 166/167/177; its a CD2401 */
+	/* 166/167/177; it's a CD2401 */
 	moveb	#0,M167_CYCAR
 	moveb	M167_CYIER,%d2
 	moveb	#0x02,M167_CYIER
diff -ur linux-2.5/arch/ppc/syslib/mpc10x_common.c linux/arch/ppc/syslib/mpc10x_common.c
--- linux-2.5/arch/ppc/syslib/mpc10x_common.c	Tue Feb 25 18:24:57 2003
+++ linux/arch/ppc/syslib/mpc10x_common.c	Tue Feb 25 19:05:23 2003
@@ -109,7 +109,7 @@
 			return -1;
 	}
 
-	/* Make sure its a supported bridge */
+	/* Make sure it's a supported bridge */
 	early_read_config_dword(hose,
 			        0,
 			        PCI_DEVFN(0,0),
diff -ur linux-2.5/drivers/acorn/block/mfmhd.c linux/drivers/acorn/block/mfmhd.c
--- linux-2.5/drivers/acorn/block/mfmhd.c	Tue Feb 25 18:25:00 2003
+++ linux/drivers/acorn/block/mfmhd.c	Tue Feb 25 19:05:27 2003
@@ -451,7 +451,7 @@
 		return;
 	};
 
-	/* OK so what ever happend its not an error, now I reckon we are left between
+	/* OK so what ever happened it's not an error, now I reckon we are left between
 	   a choice of command end or some data which is ready to be collected */
 	/* I think we have to transfer data while the interrupt line is on and its
 	   not any other type of interrupt */
diff -ur linux-2.5/drivers/block/cciss.c linux/drivers/block/cciss.c
--- linux-2.5/drivers/block/cciss.c	Tue Feb 25 18:28:32 2003
+++ linux/drivers/block/cciss.c	Tue Feb 25 19:05:27 2003
@@ -351,7 +351,7 @@
 	if (ctlr >= MAX_CTLR || hba[ctlr] == NULL)
 		return -ENXIO;
 	/*
-	 * Root is allowed to open raw volume zero even if its not configured
+	 * Root is allowed to open raw volume zero even if it's not configured
 	 * so array config can still work.  I don't think I really like this,
 	 * but I'm already using way to many device nodes to claim another one
 	 * for "raw controller".
diff -ur linux-2.5/drivers/block/cpqarray.c linux/drivers/block/cpqarray.c
--- linux-2.5/drivers/block/cpqarray.c	Tue Feb 25 18:24:56 2003
+++ linux/drivers/block/cpqarray.c	Tue Feb 25 19:05:27 2003
@@ -715,7 +715,7 @@
 		return -ENXIO;
 
 	/*
-	 * Root is allowed to open raw volume zero even if its not configured
+	 * Root is allowed to open raw volume zero even if it's not configured
 	 * so array config can still work.  I don't think I really like this,
 	 * but I'm already using way to many device nodes to claim another one
 	 * for "raw controller".
diff -ur linux-2.5/drivers/char/drm/drm_vm.h linux/drivers/char/drm/drm_vm.h
--- linux-2.5/drivers/char/drm/drm_vm.h	Tue Feb 25 18:28:54 2003
+++ linux/drivers/char/drm/drm_vm.h	Tue Feb 25 19:05:27 2003
@@ -147,7 +147,7 @@
 }
 
 /* Special close routine which deletes map information if we are the last
- * person to close a mapping and its not in the global maplist.
+ * person to close a mapping and it's not in the global maplist.
  */
 
 void DRM(vm_shm_close)(struct vm_area_struct *vma)
diff -ur linux-2.5/drivers/char/epca.c linux/drivers/char/epca.c
--- linux-2.5/drivers/char/epca.c	Tue Feb 25 18:26:33 2003
+++ linux/drivers/char/epca.c	Tue Feb 25 19:05:23 2003
@@ -1865,7 +1865,7 @@
 			case PCXI:
 				board_id = inb((int)bd->port);
 				if ((board_id & 0x1) == 0x1) 
-				{ /* Begin its an XI card */ 
+				{ /* Begin it's an XI card */ 
 
 					/* Is it a 64K board */
 					if ((board_id & 0x30) == 0) 
diff -ur linux-2.5/drivers/char/ftape/lowlevel/ftape-calibr.c linux/drivers/char/ftape/lowlevel/ftape-calibr.c
--- linux-2.5/drivers/char/ftape/lowlevel/ftape-calibr.c	Tue Feb 25 18:25:14 2003
+++ linux/drivers/char/ftape/lowlevel/ftape-calibr.c	Tue Feb 25 19:05:27 2003
@@ -56,7 +56,7 @@
  * used directly to implement fine-grained timeouts.  However, on
  * Alpha PCs, the 8254 is *not* used to implement the clock tick
  * (which is 1024 Hz, normally) and the 8254 timer runs at some
- * "random" frequency (it seems to run at 18Hz, but its not safe to
+ * "random" frequency (it seems to run at 18Hz, but it's not safe to
  * rely on this value).  Instead, we use the Alpha's "rpcc"
  * instruction to read cycle counts.  As this is a 32 bit counter,
  * it will overflow only once per 30 seconds (on a 200MHz machine),
diff -ur linux-2.5/drivers/char/rio/rioroute.c linux/drivers/char/rio/rioroute.c
--- linux-2.5/drivers/char/rio/rioroute.c	Tue Feb 25 18:26:25 2003
+++ linux/drivers/char/rio/rioroute.c	Tue Feb 25 19:05:23 2003
@@ -976,7 +976,7 @@
     /*
     ** We loop for all entries even after finding an entry and
     ** zeroing it because we may have two entries to delete if
-    ** its a 16 port RTA.
+    ** it's a 16 port RTA.
     */
     for (entry = 0; entry < TOTAL_MAP_ENTRIES; entry++)
     {
diff -ur linux-2.5/drivers/char/rio/riotable.c linux/drivers/char/rio/riotable.c
--- linux-2.5/drivers/char/rio/riotable.c	Tue Feb 25 18:28:28 2003
+++ linux/drivers/char/rio/riotable.c	Tue Feb 25 19:05:23 2003
@@ -309,7 +309,7 @@
 	}
 
 	/*
-	** wow! if we get here then its a goody!
+	** wow! if we get here then it's a goody!
 	*/
 
 	/*
diff -ur linux-2.5/drivers/ide/pci/pdc202xx_new.c linux/drivers/ide/pci/pdc202xx_new.c
--- linux-2.5/drivers/ide/pci/pdc202xx_new.c	Tue Feb 25 18:27:28 2003
+++ linux/drivers/ide/pci/pdc202xx_new.c	Tue Feb 25 19:05:27 2003
@@ -327,7 +327,7 @@
 #endif /* PDC202_DEBUG_CABLE */
 			break;
 		default:
-			/* If its not one we know we should never
+			/* If it's not one we know we should never
 			   arrive here.. */
 			BUG();
 	}
diff -ur linux-2.5/drivers/isdn/eicon/idi.c linux/drivers/isdn/eicon/idi.c
--- linux-2.5/drivers/isdn/eicon/idi.c	Tue Feb 25 18:25:04 2003
+++ linux/drivers/isdn/eicon/idi.c	Tue Feb 25 19:05:23 2003
@@ -435,7 +435,7 @@
     a->ram_out(a, &ReqOut->ReqId, this->Id);
     a->ram_out(a, &ReqOut->ReqCh, this->ReqCh);
 
-        /* if its a specific request (no ASSIGN) ...                */
+        /* if it's a specific request (no ASSIGN) ...                */
 
     if(this->Id &0x1f) {
 
diff -ur linux-2.5/drivers/isdn/hardware/eicon/di.c linux/drivers/isdn/hardware/eicon/di.c
--- linux-2.5/drivers/isdn/hardware/eicon/di.c	Tue Feb 25 18:25:34 2003
+++ linux/drivers/isdn/hardware/eicon/di.c	Tue Feb 25 19:05:23 2003
@@ -169,7 +169,7 @@
     a->ram_outw(a, &ReqOut->XBuffer.length, length);
     a->ram_out(a, &ReqOut->ReqId, this->Id);
     a->ram_out(a, &ReqOut->ReqCh, this->ReqCh);
-        /* if its a specific request (no ASSIGN) ...                */
+        /* if it's a specific request (no ASSIGN) ...                */
     if(this->Id &0x1f) {
         /* if buffers are left in the list of data buffers do       */
         /* do chaining (LL_MDATA, N_MDATA)                          */
@@ -405,7 +405,7 @@
   a->ram_outw(a, &RAM->XBuffer.length, length);
   a->ram_out(a, &RAM->ReqId, this->Id);
   a->ram_out(a, &RAM->ReqCh, this->ReqCh);
-        /* if its a specific request (no ASSIGN) ...                */
+        /* if it's a specific request (no ASSIGN) ...                */
   if(this->Id &0x1f) {
         /* if buffers are left in the list of data buffers do       */
         /* chaining (LL_MDATA, N_MDATA)                             */
diff -ur linux-2.5/drivers/isdn/hisax/hfc_sx.c linux/drivers/isdn/hisax/hfc_sx.c
--- linux-2.5/drivers/isdn/hisax/hfc_sx.c	Tue Feb 25 18:24:49 2003
+++ linux/drivers/isdn/hisax/hfc_sx.c	Tue Feb 25 19:05:23 2003
@@ -97,7 +97,7 @@
 
 /******************************************/
 /* reset the specified fifo to defaults.  */
-/* If its a send fifo init needed markers */
+/* If it's a send fifo init needed markers */
 /******************************************/
 static void
 reset_fifo(struct IsdnCardState *cs, u8 fifo)
diff -ur linux-2.5/drivers/media/video/saa7110.c linux/drivers/media/video/saa7110.c
--- linux-2.5/drivers/media/video/saa7110.c	Tue Feb 25 18:24:37 2003
+++ linux/drivers/media/video/saa7110.c	Tue Feb 25 19:05:23 2003
@@ -33,7 +33,7 @@
 #define DEBUG(x...)			/* remove when no long debugging */
 
 #define SAA7110_MAX_INPUT	9	/* 6 CVBS, 3 SVHS */
-#define SAA7110_MAX_OUTPUT	0	/* its a decoder only */
+#define SAA7110_MAX_OUTPUT	0	/* it's a decoder only */
 
 #define	I2C_SAA7110		0x9C	/* or 0x9E */
 
diff -ur linux-2.5/drivers/message/i2o/i2o_block.c linux/drivers/message/i2o/i2o_block.c
--- linux-2.5/drivers/message/i2o/i2o_block.c	Tue Feb 25 18:27:21 2003
+++ linux/drivers/message/i2o/i2o_block.c	Tue Feb 25 19:05:27 2003
@@ -798,7 +798,7 @@
 
 		/* 
 		 *	Queue depths probably belong with some kind of 
-		 *	generic IOP commit control. Certainly its not right 
+		 *	generic IOP commit control. Certainly it's not right 
 		 *	its global!  
 		 */
 		if(atomic_read(&i2ob_queues[dev->unit]->queue_depth) >= dev->depth)
diff -ur linux-2.5/drivers/net/declance.c linux/drivers/net/declance.c
--- linux-2.5/drivers/net/declance.c	Tue Feb 25 18:26:34 2003
+++ linux/drivers/net/declance.c	Tue Feb 25 19:05:23 2003
@@ -887,7 +887,7 @@
 	cp_to_buf((char *) lp->tx_buf_ptr_cpu[entry], skb->data, skblen);
 
 	/* Clear the slack of the packet, do I need this? */
-	/* For a firewall its a good idea - AC */
+	/* For a firewall it's a good idea - AC */
 /*
    if (len != skblen)
    memset ((char *) &ib->tx_buf [entry][skblen], 0, (len - skblen) << 1);
diff -ur linux-2.5/drivers/net/dgrs.c linux/drivers/net/dgrs.c
--- linux-2.5/drivers/net/dgrs.c	Tue Feb 25 18:24:46 2003
+++ linux/drivers/net/dgrs.c	Tue Feb 25 19:05:27 2003
@@ -274,7 +274,7 @@
 	ulong	x;
 
 	/*
-	 *	If Space.c says not to use DMA, or if its not a PLX based
+	 *	If Space.c says not to use DMA, or if it's not a PLX based
 	 *	PCI board, or if the expansion ROM space is not PCI
 	 *	configured, then return false.
 	 */
@@ -331,10 +331,10 @@
  *	Initiate DMA using PLX part on PCI board.  Spin the
  *	processor until completed.  All addresses are physical!
  *
- *	If pciaddr is NULL, then its a chaining DMA, and lcladdr is
+ *	If pciaddr is NULL, then it's a chaining DMA, and lcladdr is
  *	the address of the first DMA descriptor in the chain.
  *
- *	If pciaddr is not NULL, then its a single DMA.
+ *	If pciaddr is not NULL, then it's a single DMA.
  *
  *	In either case, "lcladdr" must have been fixed up to make
  *	sure the MSB isn't set using the S2DMA macro before passing
@@ -511,7 +511,7 @@
 	if (priv0->use_dma && priv0->dmadesc_h && len > 64)
 	{
 		/*
-		 *	If we can use DMA and its a long frame, copy it using
+		 *	If we can use DMA and it's a long frame, copy it using
 		 *	DMA chaining.
 		 */
 		DMACHAIN	*ddp_h;	/* Host virtual DMA desc. pointer */
@@ -583,7 +583,7 @@
 	else if (priv0->use_dma)
 	{
 		/*
-		 *	If we can use DMA and its a shorter frame, copy it
+		 *	If we can use DMA and it's a shorter frame, copy it
 		 *	using single DMA transfers.
 		 */
 		uchar		*phys_p;
diff -ur linux-2.5/drivers/net/slhc.c linux/drivers/net/slhc.c
--- linux-2.5/drivers/net/slhc.c	Tue Feb 25 18:24:58 2003
+++ linux/drivers/net/slhc.c	Tue Feb 25 19:05:23 2003
@@ -265,7 +265,7 @@
 
 	/*  Bail if the TCP packet isn't `compressible' (i.e., ACK isn't set or
 	 *  some other control bit is set). Also uncompressible if
-	 *  its a runt.
+	 *  it's a runt.
 	 */
 	if(hlen > isize || th->syn || th->fin || th->rst ||
 	    ! (th->ack)){
diff -ur linux-2.5/drivers/net/tulip/tulip_core.c linux/drivers/net/tulip/tulip_core.c
--- linux-2.5/drivers/net/tulip/tulip_core.c	Tue Feb 25 18:26:35 2003
+++ linux/drivers/net/tulip/tulip_core.c	Tue Feb 25 19:05:23 2003
@@ -1306,7 +1306,7 @@
 
 	/* Intel Saturn. Switch to 8 long words burst, 8 long word cache aligned
 	   Aries might need this too. The Saturn errata are not pretty reading but
-	   thankfully its an old 486 chipset.
+	   thankfully it's an old 486 chipset.
 	*/
 
 	if (pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82424, NULL)) {
diff -ur linux-2.5/drivers/net/wan/hostess_sv11.c linux/drivers/net/wan/hostess_sv11.c
--- linux-2.5/drivers/net/wan/hostess_sv11.c	Tue Feb 25 18:27:21 2003
+++ linux/drivers/net/wan/hostess_sv11.c	Tue Feb 25 19:05:27 2003
@@ -55,7 +55,7 @@
  
 static void hostess_input(struct z8530_channel *c, struct sk_buff *skb)
 {
-	/* Drop the CRC - its not a good idea to try and negotiate it ;) */
+	/* Drop the CRC - it's not a good idea to try and negotiate it ;) */
 	skb_trim(skb, skb->len-2);
 	skb->protocol=__constant_htons(ETH_P_WAN_PPP);
 	skb->mac.raw=skb->data;
diff -ur linux-2.5/drivers/net/wan/sdla_fr.c linux/drivers/net/wan/sdla_fr.c
--- linux-2.5/drivers/net/wan/sdla_fr.c	Tue Feb 25 18:28:44 2003
+++ linux/drivers/net/wan/sdla_fr.c	Tue Feb 25 19:05:23 2003
@@ -2747,7 +2747,7 @@
 		return 1;
 	}
 
-	/* If we get here, its an IPX-data packet so it'll get passed up the 
+	/* If we get here, it's an IPX-data packet so it'll get passed up the 
 	 * stack.
 	 * switch the network numbers 
 	 */
diff -ur linux-2.5/drivers/net/wan/sdla_ppp.c linux/drivers/net/wan/sdla_ppp.c
--- linux-2.5/drivers/net/wan/sdla_ppp.c	Tue Feb 25 18:24:59 2003
+++ linux/drivers/net/wan/sdla_ppp.c	Tue Feb 25 19:05:23 2003
@@ -2221,7 +2221,7 @@
 
 		return 1;
 	} else {
-		//If we get here's its an IPX-data packet, so it'll get passed up the stack.
+		//If we get here it's an IPX-data packet, so it'll get passed up the stack.
 
 		//switch the network numbers
 		switch_net_numbers(sendpacket, network_number, 1);	
diff -ur linux-2.5/drivers/net/wan/sdla_x25.c linux/drivers/net/wan/sdla_x25.c
--- linux-2.5/drivers/net/wan/sdla_x25.c	Tue Feb 25 18:27:14 2003
+++ linux/drivers/net/wan/sdla_x25.c	Tue Feb 25 19:05:23 2003
@@ -4088,7 +4088,7 @@
 
 		return 1;
 	} else {
-		/*If we get here its an IPX-data packet, so it'll get passed up the stack.
+		/*If we get here it's an IPX-data packet, so it'll get passed up the stack.
 		 */
 		/* switch the network numbers */
 		switch_net_numbers(sendpacket, network_number, 1);	
diff -ur linux-2.5/drivers/net/wan/sdlamain.c linux/drivers/net/wan/sdlamain.c
--- linux-2.5/drivers/net/wan/sdlamain.c	Tue Feb 25 18:27:27 2003
+++ linux/drivers/net/wan/sdlamain.c	Tue Feb 25 19:05:23 2003
@@ -434,7 +434,7 @@
 	}
 
 	/* If the current card has already been configured
-         * or its a piggyback card, do not try to allocate
+         * or it's a piggyback card, do not try to allocate
          * resources.
 	 */
 	if (!card->wandev.piggyback && !card->configured){
diff -ur linux-2.5/drivers/net/wan/sealevel.c linux/drivers/net/wan/sealevel.c
--- linux-2.5/drivers/net/wan/sealevel.c	Tue Feb 25 18:26:48 2003
+++ linux/drivers/net/wan/sealevel.c	Tue Feb 25 19:05:27 2003
@@ -56,7 +56,7 @@
  
 static void sealevel_input(struct z8530_channel *c, struct sk_buff *skb)
 {
-	/* Drop the CRC - its not a good idea to try and negotiate it ;) */
+	/* Drop the CRC - it's not a good idea to try and negotiate it ;) */
 	skb_trim(skb, skb->len-2);
 	skb->protocol=htons(ETH_P_WAN_PPP);
 	skb->mac.raw=skb->data;
diff -ur linux-2.5/drivers/scsi/megaraid.c linux/drivers/scsi/megaraid.c
--- linux-2.5/drivers/scsi/megaraid.c	Tue Feb 25 18:24:38 2003
+++ linux/drivers/scsi/megaraid.c	Tue Feb 25 19:05:27 2003
@@ -309,7 +309,7 @@
  *	Thu Mar 15 18:38:11 EST 2001 - AM
  *
  *	Firmware version check removed if subsysid==0x1111 and
- *	subsysvid==0x1111, since its not yet initialized.
+ *	subsysvid==0x1111, since it's not yet initialized.
  *
  *	changes made to correctly calculate the base in mega_findCard.
  *
diff -ur linux-2.5/drivers/video/retz3fb.c linux/drivers/video/retz3fb.c
--- linux-2.5/drivers/video/retz3fb.c	Tue Feb 25 18:28:05 2003
+++ linux/drivers/video/retz3fb.c	Tue Feb 25 19:05:23 2003
@@ -1379,7 +1379,7 @@
 		zinfo->base = ioremap(board_addr, board_size);
 		zinfo->regs = zinfo->base;
 		zinfo->fbmem = zinfo->base + VIDEO_MEM_OFFSET;
-		/* Get memory size - for now we asume its a 4MB board */
+		/* Get memory size - for now we asume it's a 4MB board */
 		zinfo->fbsize = 0x00400000; /* 4 MB */
 		zinfo->physregs = board_addr;
 		zinfo->physfbmem = board_addr + VIDEO_MEM_OFFSET;
diff -ur linux-2.5/include/asm-i386/page.h linux/include/asm-i386/page.h
--- linux-2.5/include/asm-i386/page.h	Tue Feb 25 18:24:57 2003
+++ linux/include/asm-i386/page.h	Tue Feb 25 19:05:27 2003
@@ -24,7 +24,7 @@
 #else
 
 /*
- *	On older X86 processors its not a win to use MMX here it seems.
+ *	On older X86 processors it's not a win to use MMX here it seems.
  *	Maybe the K6-III ?
  */
  
diff -ur linux-2.5/include/net/dn_dev.h linux/include/net/dn_dev.h
--- linux-2.5/include/net/dn_dev.h	Tue Feb 25 18:24:41 2003
+++ linux/include/net/dn_dev.h	Tue Feb 25 19:05:23 2003
@@ -45,7 +45,7 @@
  * device will come up. In the dn_dev structure, it is the actual
  * state.
  *
- * Things have changed here. I've killed timer1 since its a user space
+ * Things have changed here. I've killed timer1 since it's a user space
  * issue for a user space routing deamon to sort out. The kernel does
  * not need to be bothered with it.
  *
diff -ur linux-2.5/net/decnet/dn_dev.c linux/net/decnet/dn_dev.c
--- linux-2.5/net/decnet/dn_dev.c	Tue Feb 25 18:25:27 2003
+++ linux/net/decnet/dn_dev.c	Tue Feb 25 19:05:27 2003
@@ -18,7 +18,7 @@
  *          Steve Whitehouse : Multiple ifaddr support
  *          Steve Whitehouse : SIOCGIFCONF is now a compile time option
  *          Steve Whitehouse : /proc/sys/net/decnet/conf/<sys>/forwarding
- *          Steve Whitehouse : Removed timer1 - its a user space issue now
+ *          Steve Whitehouse : Removed timer1 - it's a user space issue now
  *         Patrick Caulfield : Fixed router hello message format
  */
 
@@ -807,7 +807,7 @@
  * This is one of those areas where the initial VMS concepts don't really
  * map onto the Linux concepts, and since we introduced multiple addresses
  * per interface we have to cope with slightly odd ways of finding out what
- * "our address" really is. Mostly its not a problem; for this we just guess
+ * "our address" really is. Mostly it's not a problem; for this we just guess
  * a sensible default. Eventually the routing code will take care of all the
  * nasties for us I hope.
  */
diff -ur linux-2.5/net/ipv4/tcp.c linux/net/ipv4/tcp.c
--- linux-2.5/net/ipv4/tcp.c	Tue Feb 25 18:25:13 2003
+++ linux/net/ipv4/tcp.c	Tue Feb 25 19:05:23 2003
@@ -172,7 +172,7 @@
  *					ack if state is TCP_CLOSED.
  *		Alan Cox	:	Look up device on a retransmit - routes may
  *					change. Doesn't yet cope with MSS shrink right
- *					but its a start!
+ *					but it's a start!
  *		Marc Tamsky	:	Closing in closing fixes.
  *		Mike Shaver	:	RFC1122 verifications.
  *		Alan Cox	:	rcv_saddr errors.
diff -ur linux-2.5/net/ipx/af_ipx.c linux/net/ipx/af_ipx.c
--- linux-2.5/net/ipx/af_ipx.c	Tue Feb 25 18:24:57 2003
+++ linux/net/ipx/af_ipx.c	Tue Feb 25 19:05:23 2003
@@ -684,7 +684,7 @@
 	if (ipx->ipx_source.net != intrfc->if_netnum) {
 		/*
 		 * Unshare the buffer before modifying the count in
-		 * case its a flood or tcpdump
+		 * case it's a flood or tcpdump
 		 */
 		skb = skb_unshare(skb, GFP_ATOMIC);
 		if (!skb)
diff -ur linux-2.5/net/sched/sch_gred.c linux/net/sched/sch_gred.c
--- linux-2.5/net/sched/sch_gred.c	Tue Feb 25 18:28:05 2003
+++ linux/net/sched/sch_gred.c	Tue Feb 25 19:05:27 2003
@@ -416,7 +416,7 @@
 	memcpy(q->Stab, RTA_DATA(tb[TCA_GRED_STAB-1]), 256);
 
 	if ( table->initd && table->grio) {
-	/* this looks ugly but its not in the fast path */
+	/* this looks ugly but it's not in the fast path */
 		for (i=0;i<table->DPs;i++) {
 			if ((!table->tab[i]) || (i==q->DP) )    
 				continue; 
diff -ur linux-2.5/sound/isa/wavefront/wavefront_synth.c linux/sound/isa/wavefront/wavefront_synth.c
--- linux-2.5/sound/isa/wavefront/wavefront_synth.c	Tue Feb 25 18:25:38 2003
+++ linux/sound/isa/wavefront/wavefront_synth.c	Tue Feb 25 19:05:23 2003
@@ -906,7 +906,7 @@
 
 	if (header->size) {
 
-		/* XXX its a debatable point whether or not RDONLY semantics
+		/* XXX it's a debatable point whether or not RDONLY semantics
 		   on the ROM samples should cover just the sample data or
 		   the sample header. For now, it only covers the sample data,
 		   so anyone is free at all times to rewrite sample headers.
diff -ur linux-2.5/sound/oss/maestro.c linux/sound/oss/maestro.c
--- linux-2.5/sound/oss/maestro.c	Tue Feb 25 18:28:07 2003
+++ linux/sound/oss/maestro.c	Tue Feb 25 19:05:24 2003
@@ -292,7 +292,7 @@
 

 /* changed so that I could actually find all the
-	references and fix them up.  its a little more readable now. */
+	references and fix them up.  it's a little more readable now. */
 #define ESS_FMT_STEREO	0x01
 #define ESS_FMT_16BIT	0x02
 #define ESS_FMT_MASK	0x03
diff -ur linux-2.5/sound/oss/wavfront.c linux/sound/oss/wavfront.c
--- linux-2.5/sound/oss/wavfront.c	Tue Feb 25 18:26:27 2003
+++ linux/sound/oss/wavfront.c	Tue Feb 25 19:05:27 2003
@@ -95,7 +95,7 @@
 
    I consider /dev/sequencer to be an anachronism, but given its
    widespread usage by various Linux MIDI software, it seems worth
-   offering support to it if its not too painful. Instead of using
+   offering support to it if it's not too painful. Instead of using
    /dev/sequencer, I recommend:
 
      for synth programming and patch loading: /dev/synthNN
@@ -1041,7 +1041,7 @@
 
 	if (header->size) {
 
-		/* XXX its a debatable point whether or not RDONLY semantics
+		/* XXX it's a debatable point whether or not RDONLY semantics
 		   on the ROM samples should cover just the sample data or
 		   the sample header. For now, it only covers the sample data,
 		   so anyone is free at all times to rewrite sample headers.

