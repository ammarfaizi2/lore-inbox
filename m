Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268406AbTBSC7g>; Tue, 18 Feb 2003 21:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268374AbTBSC6u>; Tue, 18 Feb 2003 21:58:50 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:54536 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S268394AbTBSC5n>; Tue, 18 Feb 2003 21:57:43 -0500
Subject: [PATCH] 2.5.62 spelling fix for interupt -> interrupt in 36 files.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 18 Feb 2003 19:59:04 -0700
Message-Id: <1045623546.5965.303.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the following spelling fix.

interupt -> interrupt

 Documentation/s390/Debugging390.txt      |    4 +--
 Documentation/sysrq.txt                  |    2 -
 arch/cris/drivers/serial.c               |    2 -
 arch/ia64/hp/sim/simeth.c                |    2 -
 arch/ia64/sn/io/xbow.c                   |    2 -
 arch/ia64/sn/io/xtalk.c                  |    2 -
 arch/m68knommu/platform/68328/entry.S    |    2 -
 arch/m68knommu/platform/68360/commproc.c |    2 -
 arch/m68knommu/platform/68360/entry.S    |    2 -
 arch/mips/philips/nino/int-handler.S     |    2 -
 arch/parisc/kernel/irq.c                 |    2 -
 arch/ppc64/kernel/head.S                 |    6 ++---
 arch/s390/kernel/entry.S                 |    4 +--
 arch/s390x/kernel/entry.S                |    4 +--
 arch/v850/kernel/rte_cb_multi.c          |    2 -
 drivers/char/ip2/i2ellis.h               |    2 -
 drivers/char/ipmi/ipmi_kcs_intf.c        |    2 -
 drivers/char/mwave/3780i.c               |    2 -
 drivers/input/serio/i8042.c              |    2 -
 drivers/net/au1000_eth.c                 |    2 -
 drivers/net/natsemi.c                    |    2 -
 drivers/net/tc35815.c                    |    2 -
 drivers/net/tulip/interrupt.c            |    2 -
 drivers/net/wireless/orinoco.c           |    2 -
 drivers/parisc/dino.c                    |    2 -
 drivers/scsi/aic7xxx/aic79xx.h           |    2 -
 drivers/scsi/aic7xxx/aic79xx_pci.c       |    6 ++---
 drivers/scsi/pci2220i.c                  |    2 -
 include/asm-alpha/core_marvel.h          |    2 -
 include/asm-m68knommu/m68360_enet.h      |    2 -
 include/asm-parisc/pdcpat.h              |    2 -
 sound/drivers/serial-u16550.c            |   34 +++++++++++++++----------------
 sound/oss/rme96xx.c                      |    2 -
 sound/pci/als4000.c                      |    2 -
 sound/pci/cs4281.c                       |    2 -
 sound/pci/es1968.c                       |    6 ++---
 36 files changed, 61 insertions(+), 61 deletions(-)

diff -ur linux-2.5.62-1104-orig/Documentation/s390/Debugging390.txt linux-2.5.62-1104/Documentation/s390/Debugging390.txt
--- linux-2.5.62-1104-orig/Documentation/s390/Debugging390.txt	Mon Feb 17 17:35:58 2003
+++ linux-2.5.62-1104/Documentation/s390/Debugging390.txt	Tue Feb 18 18:31:36 2003
@@ -97,7 +97,7 @@
 6       6     Input/Output interrupt Mask
 
 7       7     External interrupt Mask used primarily for interprocessor signalling & 
-	      clock interupts.
+	      clock interrupts.
 
 8-11  8-11    PSW Key used for complex memory protection mechanism not used under linux
 
@@ -2423,7 +2423,7 @@
 There is a new device layer for channel devices, some
 drivers e.g. lcs are registered with this layer.
 If the device uses the channel device layer you'll be
-able to find what interupts it uses & the current state 
+able to find what interrupts it uses & the current state 
 of the device.
 See the manpage chandev.8 &type cat /proc/chandev for more info.
 
diff -ur linux-2.5.62-1104-orig/Documentation/sysrq.txt linux-2.5.62-1104/Documentation/sysrq.txt
--- linux-2.5.62-1104-orig/Documentation/sysrq.txt	Thu Jan 16 19:22:09 2003
+++ linux-2.5.62-1104/Documentation/sysrq.txt	Tue Feb 18 18:31:36 2003
@@ -164,7 +164,7 @@
 
 If for some reason you feel the need to call the handle_sysrq function from
 within a function called by handle_sysrq, you must be aware that you are in
-a lock (you are also in an interupt handler, which means don't sleep!), so
+a lock (you are also in an interrupt handler, which means don't sleep!), so
 you must call __handle_sysrq_nolock instead.
 
 *  I have more questions, who can I ask?
diff -ur linux-2.5.62-1104-orig/arch/cris/drivers/serial.c linux-2.5.62-1104/arch/cris/drivers/serial.c
--- linux-2.5.62-1104-orig/arch/cris/drivers/serial.c	Mon Feb 10 12:22:53 2003
+++ linux-2.5.62-1104/arch/cris/drivers/serial.c	Tue Feb 18 18:31:36 2003
@@ -1904,7 +1904,7 @@
 		}
 
 #ifdef SERIAL_DEBUG_INTR
-		printk("** OK, disabling ser_interupts\n");
+		printk("** OK, disabling ser_interrupts\n");
 #endif
 		e100_disable_serial_data_irq(info);
 
diff -ur linux-2.5.62-1104-orig/arch/ia64/hp/sim/simeth.c linux-2.5.62-1104/arch/ia64/hp/sim/simeth.c
--- linux-2.5.62-1104-orig/arch/ia64/hp/sim/simeth.c	Mon Feb 10 12:22:53 2003
+++ linux-2.5.62-1104/arch/ia64/hp/sim/simeth.c	Tue Feb 18 18:31:36 2003
@@ -149,7 +149,7 @@
 static inline int
 netdev_attach(int fd, int irq, unsigned int ipaddr)
 {
-	/* this puts the host interface in the right mode (start interupting) */
+	/* this puts the host interface in the right mode (start interrupting) */
 	return ia64_ssc(fd, ipaddr, 0,0, SSC_NETDEV_ATTACH);
 }
 
diff -ur linux-2.5.62-1104-orig/arch/ia64/sn/io/xbow.c linux-2.5.62-1104/arch/ia64/sn/io/xbow.c
--- linux-2.5.62-1104-orig/arch/ia64/sn/io/xbow.c	Thu Jan 16 19:21:33 2003
+++ linux-2.5.62-1104/arch/ia64/sn/io/xbow.c	Tue Feb 18 18:31:36 2003
@@ -305,7 +305,7 @@
 
     /*
      * get the name of this xbow vertex and keep the info.
-     * This is needed during errors and interupts, but as
+     * This is needed during errors and interrupts, but as
      * long as we have it, we can use it elsewhere.
      */
     s = dev_to_name(vhdl, devnm, MAXDEVNAME);
diff -ur linux-2.5.62-1104-orig/arch/ia64/sn/io/xtalk.c linux-2.5.62-1104/arch/ia64/sn/io/xtalk.c
--- linux-2.5.62-1104-orig/arch/ia64/sn/io/xtalk.c	Thu Jan 16 19:21:40 2003
+++ linux-2.5.62-1104/arch/ia64/sn/io/xtalk.c	Tue Feb 18 18:31:36 2003
@@ -890,7 +890,7 @@
     widget_info->w_einfo = 0;
     /*
      * get the name of this xwidget vertex and keep the info.
-     * This is needed during errors and interupts, but as
+     * This is needed during errors and interrupts, but as
      * long as we have it, we can use it elsewhere.
      */
     s = dev_to_name(widget,devnm,MAXDEVNAME);
diff -ur linux-2.5.62-1104-orig/arch/m68knommu/platform/68328/entry.S linux-2.5.62-1104/arch/m68knommu/platform/68328/entry.S
--- linux-2.5.62-1104-orig/arch/m68knommu/platform/68328/entry.S	Thu Jan 16 19:21:38 2003
+++ linux-2.5.62-1104/arch/m68knommu/platform/68328/entry.S	Tue Feb 18 18:31:36 2003
@@ -95,7 +95,7 @@
 Luser_return:
 	/* only allow interrupts when we are really the last one on the*/
 	/* kernel stack, otherwise stack overflow can occur during*/
-	/* heavy interupt load*/
+	/* heavy interrupt load*/
 	andw	#ALLOWINT,%sr
 
 	movel	%sp,%d1			/* get thread_info pointer */
diff -ur linux-2.5.62-1104-orig/arch/m68knommu/platform/68360/commproc.c linux-2.5.62-1104/arch/m68knommu/platform/68360/commproc.c
--- linux-2.5.62-1104-orig/arch/m68knommu/platform/68360/commproc.c	Thu Jan 16 19:22:39 2003
+++ linux-2.5.62-1104/arch/m68knommu/platform/68360/commproc.c	Tue Feb 18 18:31:36 2003
@@ -90,7 +90,7 @@
 	while (pquicc->cp_cr & CMD_FLAG);
 
 	/* On the recommendation of the 68360 manual, p. 7-60
-	 * - Set sdma interupt service mask to 7
+	 * - Set sdma interrupt service mask to 7
 	 * - Set sdma arbitration ID to 4
 	 */
 	pquicc->sdma_sdcr = 0x0740;
diff -ur linux-2.5.62-1104-orig/arch/m68knommu/platform/68360/entry.S linux-2.5.62-1104/arch/m68knommu/platform/68360/entry.S
--- linux-2.5.62-1104-orig/arch/m68knommu/platform/68360/entry.S	Thu Jan 16 19:22:24 2003
+++ linux-2.5.62-1104/arch/m68knommu/platform/68360/entry.S	Tue Feb 18 18:31:36 2003
@@ -91,7 +91,7 @@
 Luser_return:
 	/* only allow interrupts when we are really the last one on the*/
 	/* kernel stack, otherwise stack overflow can occur during*/
-	/* heavy interupt load*/
+	/* heavy interrupt load*/
 	andw	#ALLOWINT,%sr
 
 	movel	%sp,%d1			/* get thread_info pointer */
diff -ur linux-2.5.62-1104-orig/arch/mips/philips/nino/int-handler.S linux-2.5.62-1104/arch/mips/philips/nino/int-handler.S
--- linux-2.5.62-1104-orig/arch/mips/philips/nino/int-handler.S	Thu Jan 16 19:21:35 2003
+++ linux-2.5.62-1104/arch/mips/philips/nino/int-handler.S	Tue Feb 18 18:31:36 2003
@@ -72,7 +72,7 @@
 		nop
 
 /*
- * Ok, we've got one of over a hundred other interupts.
+ * Ok, we've got one of over a hundred other interrupts.
  */
 low_priority:
 		lui	t0, %hi(IntStatus1)
diff -ur linux-2.5.62-1104-orig/arch/parisc/kernel/irq.c linux-2.5.62-1104/arch/parisc/kernel/irq.c
--- linux-2.5.62-1104-orig/arch/parisc/kernel/irq.c	Mon Feb 10 12:22:56 2003
+++ linux-2.5.62-1104/arch/parisc/kernel/irq.c	Tue Feb 18 18:31:36 2003
@@ -447,7 +447,7 @@
 
 	/* 1) only process IRQs that are enabled/unmasked (cpu_eiem)
 	 * 2) We loop here on EIRR contents in order to avoid
-	 *    nested interrupts or having to take another interupt
+	 *    nested interrupts or having to take another interrupt
 	 *    when we could have just handled it right away.
 	 * 3) Limit the number of times we loop to make sure other
 	 *    processing can occur.
diff -ur linux-2.5.62-1104-orig/arch/ppc64/kernel/head.S linux-2.5.62-1104/arch/ppc64/kernel/head.S
--- linux-2.5.62-1104-orig/arch/ppc64/kernel/head.S	Mon Feb 10 12:22:56 2003
+++ linux-2.5.62-1104/arch/ppc64/kernel/head.S	Tue Feb 18 18:31:36 2003
@@ -337,8 +337,8 @@
  * Start of pSeries system interrupt routines
  */
 	. = 0x100
-	.globl __start_interupts
-__start_interupts:
+	.globl __start_interrupts
+__start_interrupts:
 
 	STD_EXCEPTION_PSERIES( 0x100, SystemReset )
 	STD_EXCEPTION_PSERIES( 0x200, MachineCheck )
@@ -367,7 +367,7 @@
 	. = 0x4000
 	.globl __end_interrupts
 	.globl __start_naca
-__end_interupts:
+__end_interrupts:
 __start_naca:
 #ifdef CONFIG_PPC_ISERIES
 	.llong itVpdAreas
diff -ur linux-2.5.62-1104-orig/arch/s390/kernel/entry.S linux-2.5.62-1104/arch/s390/kernel/entry.S
--- linux-2.5.62-1104-orig/arch/s390/kernel/entry.S	Thu Jan 16 19:21:41 2003
+++ linux-2.5.62-1104/arch/s390/kernel/entry.S	Tue Feb 18 18:31:36 2003
@@ -757,8 +757,8 @@
         la      %r2,SP_PTREGS(%r15) # address of register-save area
         sr      %r3,%r3
         icm     %r3,3,__LC_SUBCHANNEL_NR   # load subchannel nr & extend to int
-        l       %r4,__LC_IO_INT_PARM       # load interuption parm
-	l       %r5,__LC_IO_INT_WORD       # load interuption word
+        l       %r4,__LC_IO_INT_PARM       # load interruption parm
+	l       %r5,__LC_IO_INT_WORD       # load interruption word
         basr    %r14,%r1          # branch to standard irq handler
 
 io_return:
diff -ur linux-2.5.62-1104-orig/arch/s390x/kernel/entry.S linux-2.5.62-1104/arch/s390x/kernel/entry.S
--- linux-2.5.62-1104-orig/arch/s390x/kernel/entry.S	Mon Feb 17 17:36:00 2003
+++ linux-2.5.62-1104/arch/s390x/kernel/entry.S	Tue Feb 18 18:31:36 2003
@@ -781,8 +781,8 @@
         GET_THREAD_INFO                # load pointer to task_struct to R9
         la      %r2,SP_PTREGS(%r15)    # address of register-save area
 	llgh    %r3,__LC_SUBCHANNEL_NR # load subchannel number
-        llgf    %r4,__LC_IO_INT_PARM   # load interuption parm
-        llgf    %r5,__LC_IO_INT_WORD   # load interuption word
+        llgf    %r4,__LC_IO_INT_PARM   # load interruption parm
+        llgf    %r5,__LC_IO_INT_WORD   # load interruption word
 	brasl   %r14,do_IRQ            # call standard irq handler
 
 io_return:
diff -ur linux-2.5.62-1104-orig/arch/v850/kernel/rte_cb_multi.c linux-2.5.62-1104/arch/v850/kernel/rte_cb_multi.c
--- linux-2.5.62-1104-orig/arch/v850/kernel/rte_cb_multi.c	Thu Jan 16 19:21:51 2003
+++ linux-2.5.62-1104/arch/v850/kernel/rte_cb_multi.c	Tue Feb 18 18:31:36 2003
@@ -52,7 +52,7 @@
 	register unsigned long jr_fixup = (char *)&_intv_start - (char *)dst;
 	register long *ii;
 
-	/* Copy interupt vectors as instructed by multi_intv_install_table. */
+	/* Copy interrupt vectors as instructed by multi_intv_install_table. */
 	for (ii = multi_intv_install_table; *ii >= 0; ii++) {
 		/* Copy 16-byte interrupt vector at offset *ii.  */
 		int boffs;
diff -ur linux-2.5.62-1104-orig/drivers/char/ip2/i2ellis.h linux-2.5.62-1104/drivers/char/ip2/i2ellis.h
--- linux-2.5.62-1104-orig/drivers/char/ip2/i2ellis.h	Thu Jan 16 19:21:37 2003
+++ linux-2.5.62-1104/drivers/char/ip2/i2ellis.h	Tue Feb 18 18:31:36 2003
@@ -400,7 +400,7 @@
 	rwlock_t	read_fifo_spinlock;
 	rwlock_t	write_fifo_spinlock;
 
-//	For queuing interupt bottom half handlers.	/\/\|=mhw=|\/\/
+//	For queuing interrupt bottom half handlers.	/\/\|=mhw=|\/\/
 	struct work_struct	tqueue_interrupt;
 
 	struct timer_list  SendPendingTimer;   // Used by iiSendPending
diff -ur linux-2.5.62-1104-orig/drivers/char/ipmi/ipmi_kcs_intf.c linux-2.5.62-1104/drivers/char/ipmi/ipmi_kcs_intf.c
--- linux-2.5.62-1104-orig/drivers/char/ipmi/ipmi_kcs_intf.c	Thu Jan 16 19:21:33 2003
+++ linux-2.5.62-1104/drivers/char/ipmi/ipmi_kcs_intf.c	Tue Feb 18 18:31:36 2003
@@ -128,7 +128,7 @@
 	/* The driver will disable interrupts when it gets into a
 	   situation where it cannot handle messages due to lack of
 	   memory.  Once that situation clears up, it will re-enable
-	   interupts. */
+	   interrupts. */
 	int                 interrupt_disabled;
 };
 
diff -ur linux-2.5.62-1104-orig/drivers/char/mwave/3780i.c linux-2.5.62-1104/drivers/char/mwave/3780i.c
--- linux-2.5.62-1104-orig/drivers/char/mwave/3780i.c	Thu Jan 16 19:22:43 2003
+++ linux-2.5.62-1104/drivers/char/mwave/3780i.c	Tue Feb 18 18:31:36 2003
@@ -698,7 +698,7 @@
 		usDspBaseIO, pusIPCSource);
 
 	/*
-	* Disable DSP to PC interrupts, read the interupt register,
+	* Disable DSP to PC interrupts, read the interrupt register,
 	* clear the pending IPC bits, and reenable DSP to PC interrupts
 	*/
 	spin_lock_irqsave(&dsp_lock, flags);
diff -ur linux-2.5.62-1104-orig/drivers/input/serio/i8042.c linux-2.5.62-1104/drivers/input/serio/i8042.c
--- linux-2.5.62-1104-orig/drivers/input/serio/i8042.c	Fri Feb 14 20:11:57 2003
+++ linux-2.5.62-1104/drivers/input/serio/i8042.c	Tue Feb 18 18:31:36 2003
@@ -257,7 +257,7 @@
 /*
  * i8042_close() frees the interrupt, so that it can possibly be used
  * by another driver. We never know - if the user doesn't have a mouse,
- * the BIOS could have used the AUX interupt for PCI.
+ * the BIOS could have used the AUX interrupt for PCI.
  */
 
 static void i8042_close(struct serio *port)
diff -ur linux-2.5.62-1104-orig/drivers/net/au1000_eth.c linux-2.5.62-1104/drivers/net/au1000_eth.c
--- linux-2.5.62-1104-orig/drivers/net/au1000_eth.c	Thu Jan 16 19:22:14 2003
+++ linux-2.5.62-1104/drivers/net/au1000_eth.c	Tue Feb 18 18:31:36 2003
@@ -110,7 +110,7 @@
 

 /*
- * Base address and interupt of the Au1xxx ethernet macs
+ * Base address and interrupt of the Au1xxx ethernet macs
  */
 static struct {
 	unsigned int port;
diff -ur linux-2.5.62-1104-orig/drivers/net/natsemi.c linux-2.5.62-1104/drivers/net/natsemi.c
--- linux-2.5.62-1104-orig/drivers/net/natsemi.c	Thu Jan 16 19:21:37 2003
+++ linux-2.5.62-1104/drivers/net/natsemi.c	Tue Feb 18 18:31:36 2003
@@ -2608,7 +2608,7 @@
 			if (wol) {
 				/* restart the NIC in WOL mode.
 				 * The nic must be stopped for this.
-				 * FIXME: use the WOL interupt
+				 * FIXME: use the WOL interrupt
 				 */
 				enable_wol_mode(dev, 0);
 			} else {
diff -ur linux-2.5.62-1104-orig/drivers/net/tc35815.c linux-2.5.62-1104/drivers/net/tc35815.c
--- linux-2.5.62-1104-orig/drivers/net/tc35815.c	Thu Jan 16 19:21:34 2003
+++ linux-2.5.62-1104/drivers/net/tc35815.c	Tue Feb 18 18:31:36 2003
@@ -1227,7 +1227,7 @@
 		lp->rfd_cur = next_rfd;
 	}
 
-	/* re-enable BL/FDA Exhaust interupts. */
+	/* re-enable BL/FDA Exhaust interrupts. */
 	if (fd_free_count) {
 		tc_writel(tc_readl(&tr->Int_En) | Int_FDAExEn, &tr->Int_En);
 		if (buf_free_count)
diff -ur linux-2.5.62-1104-orig/drivers/net/tulip/interrupt.c linux-2.5.62-1104/drivers/net/tulip/interrupt.c
--- linux-2.5.62-1104-orig/drivers/net/tulip/interrupt.c	Thu Jan 16 19:21:47 2003
+++ linux-2.5.62-1104/drivers/net/tulip/interrupt.c	Tue Feb 18 18:31:36 2003
@@ -501,7 +501,7 @@
 					   dev->name, csr5);
 #ifdef CONFIG_NET_HW_FLOWCONTROL
                         if (tp->fc_bit && (test_bit(tp->fc_bit, &netdev_fc_xoff)))
-                          if (net_ratelimit()) printk("BUG!! enabling interupt when FC off (timerintr.) \n");
+                          if (net_ratelimit()) printk("BUG!! enabling interrupt when FC off (timerintr.) \n");
 #endif
 			outl(tulip_tbl[tp->chip_id].valid_intrs, ioaddr + CSR7);
 			tp->ttimer = 0;
diff -ur linux-2.5.62-1104-orig/drivers/net/wireless/orinoco.c linux-2.5.62-1104/drivers/net/wireless/orinoco.c
--- linux-2.5.62-1104-orig/drivers/net/wireless/orinoco.c	Fri Feb 14 20:11:59 2003
+++ linux-2.5.62-1104/drivers/net/wireless/orinoco.c	Tue Feb 18 18:31:36 2003
@@ -289,7 +289,7 @@
  *	  which are used as the dev->open, dev->stop, priv->reset
  *	  callbacks if none are specified when alloc_orinocodev() is
  *	  called.
- *	o Removed orinoco_plx_interupt() and orinoco_pci_interrupt().
+ *	o Removed orinoco_plx_interrupt() and orinoco_pci_interrupt().
  *	  They didn't do anything.
  *
  * v0.12 -> v0.12a - 4 Jul 2002 - David Gibson
diff -ur linux-2.5.62-1104-orig/drivers/parisc/dino.c linux-2.5.62-1104/drivers/parisc/dino.c
--- linux-2.5.62-1104-orig/drivers/parisc/dino.c	Thu Jan 16 19:21:37 2003
+++ linux-2.5.62-1104/drivers/parisc/dino.c	Tue Feb 18 18:31:36 2003
@@ -403,7 +403,7 @@
 
 		/*
 		 * Perform a binary search on set bits.
-		 * `Less than Fatal' and PS2 interupts aren't supported.
+		 * `Less than Fatal' and PS2 interrupts aren't supported.
 		 */
 		if (mask & 0xf) {
 			if (mask & 0x3) {
diff -ur linux-2.5.62-1104-orig/drivers/scsi/aic7xxx/aic79xx.h linux-2.5.62-1104/drivers/scsi/aic7xxx/aic79xx.h
--- linux-2.5.62-1104-orig/drivers/scsi/aic7xxx/aic79xx.h	Thu Jan 16 19:22:23 2003
+++ linux-2.5.62-1104/drivers/scsi/aic7xxx/aic79xx.h	Tue Feb 18 18:31:36 2003
@@ -404,7 +404,7 @@
  * Initiator mode SCB shared data area.
  * If the embedded CDB is 12 bytes or less, we embed
  * the sense buffer address in the SCB.  This allows
- * us to retrieve sense information without interupting
+ * us to retrieve sense information without interrupting
  * the host in packetized mode.
  */
 typedef uint32_t sense_addr_t;
diff -ur linux-2.5.62-1104-orig/drivers/scsi/aic7xxx/aic79xx_pci.c linux-2.5.62-1104/drivers/scsi/aic7xxx/aic79xx_pci.c
--- linux-2.5.62-1104-orig/drivers/scsi/aic7xxx/aic79xx_pci.c	Fri Feb 14 20:11:59 2003
+++ linux-2.5.62-1104/drivers/scsi/aic7xxx/aic79xx_pci.c	Tue Feb 18 18:31:36 2003
@@ -740,7 +740,7 @@
 		if (i == 5)
 			continue;
 		pci_status[i] = ahd_inb(ahd, reg);
-		/* Clear latched errors.  So our interupt deasserts. */
+		/* Clear latched errors.  So our interrupt deasserts. */
 		ahd_outb(ahd, reg, pci_status[i]);
 	}
 
@@ -796,14 +796,14 @@
 
 		split_status[i] = ahd_inb(ahd, DCHSPLTSTAT0);
 		split_status1[i] = ahd_inb(ahd, DCHSPLTSTAT1);
-		/* Clear latched errors.  So our interupt deasserts. */
+		/* Clear latched errors.  So our interrupt deasserts. */
 		ahd_outb(ahd, DCHSPLTSTAT0, split_status[i]);
 		ahd_outb(ahd, DCHSPLTSTAT1, split_status1[i]);
 		if (i != 0)
 			continue;
 		sg_split_status[i] = ahd_inb(ahd, SGSPLTSTAT0);
 		sg_split_status1[i] = ahd_inb(ahd, SGSPLTSTAT1);
-		/* Clear latched errors.  So our interupt deasserts. */
+		/* Clear latched errors.  So our interrupt deasserts. */
 		ahd_outb(ahd, SGSPLTSTAT0, sg_split_status[i]);
 		ahd_outb(ahd, SGSPLTSTAT1, sg_split_status1[i]);
 	}
diff -ur linux-2.5.62-1104-orig/drivers/scsi/pci2220i.c linux-2.5.62-1104/drivers/scsi/pci2220i.c
--- linux-2.5.62-1104-orig/drivers/scsi/pci2220i.c	Tue Feb 18 18:06:18 2003
+++ linux-2.5.62-1104/drivers/scsi/pci2220i.c	Tue Feb 18 18:31:36 2003
@@ -2389,7 +2389,7 @@
 	padapter->regRemap		= zr + RTR_LOCAL_REMAP;					// 32 bit local space remap
 	padapter->regDesc		= zr + RTR_REGIONS;	  					// 32 bit local region descriptor
 	padapter->regRange		= zr + RTR_LOCAL_RANGE;					// 32 bit local range
-	padapter->regIrqControl	= zr + RTR_INT_CONTROL_STATUS;			// 16 bit interupt control and status
+	padapter->regIrqControl	= zr + RTR_INT_CONTROL_STATUS;			// 16 bit interrupt control and status
 	padapter->regScratchPad	= zr + RTR_MAILBOX;	  					// 16 byte scratchpad I/O base address
 
 	padapter->regBase		= zl;
diff -ur linux-2.5.62-1104-orig/include/asm-alpha/core_marvel.h linux-2.5.62-1104/include/asm-alpha/core_marvel.h
--- linux-2.5.62-1104-orig/include/asm-alpha/core_marvel.h	Thu Jan 16 19:21:48 2003
+++ linux-2.5.62-1104/include/asm-alpha/core_marvel.h	Tue Feb 18 18:31:36 2003
@@ -222,7 +222,7 @@
 /*
  * IO7 IID (Interrupt IDentifier) format
  *
- * For level-sensative interupts, int_num is encoded as:
+ * For level-sensative interrupts, int_num is encoded as:
  *
  *	bus/port	slot/device	INTx
  *	<7:5>		<4:2>		<1:0>
diff -ur linux-2.5.62-1104-orig/include/asm-m68knommu/m68360_enet.h linux-2.5.62-1104/include/asm-m68knommu/m68360_enet.h
--- linux-2.5.62-1104-orig/include/asm-m68knommu/m68360_enet.h	Thu Jan 16 19:22:03 2003
+++ linux-2.5.62-1104/include/asm-m68knommu/m68360_enet.h	Tue Feb 18 18:31:36 2003
@@ -93,7 +93,7 @@
 #define ALEC     0x00000000
 #define DISFC    0x00000000
 #define PADS     0x00000000
-#define RET_LIM  0x000f     /* retry 15 times to send a frame before interupt */
+#define RET_LIM  0x000f     /* retry 15 times to send a frame before interrupt */
 #define ETH_MFLR 0x05ee     /* 1518 max frame size */
 #define MINFLR   0x0040     /* Minimum frame size 64 */
 #define MAXD1    0x05ee     /* Max dma count 1518 */
diff -ur linux-2.5.62-1104-orig/include/asm-parisc/pdcpat.h linux-2.5.62-1104/include/asm-parisc/pdcpat.h
--- linux-2.5.62-1104-orig/include/asm-parisc/pdcpat.h	Thu Jan 16 19:22:29 2003
+++ linux-2.5.62-1104/include/asm-parisc/pdcpat.h	Tue Feb 18 18:31:36 2003
@@ -99,7 +99,7 @@
 				       ** Monarch Processor */
 #define PDC_PAT_HPMC_RENDEZ_CPU     0L /* go into spin loop */
 #define PDC_PAT_HPMC_SET_PARAMS     1L /* Allows OS to specify intr which PDC 
-                                        * will use to interupt OS during machine
+                                        * will use to interrupt OS during machine
                                         * check rendezvous */
 
 /* parameters for PDC_PAT_HPMC_SET_PARAMS: */
diff -ur linux-2.5.62-1104-orig/sound/drivers/serial-u16550.c linux-2.5.62-1104/sound/drivers/serial-u16550.c
--- linux-2.5.62-1104-orig/sound/drivers/serial-u16550.c	Mon Feb 10 12:23:09 2003
+++ linux-2.5.62-1104/sound/drivers/serial-u16550.c	Tue Feb 18 18:31:36 2003
@@ -204,7 +204,7 @@
 
 /* This loop should be called with interrupts disabled
  * We don't want to interrupt this, 
- * as we're already handling an interupt 
+ * as we're already handling an interrupt 
  */
 static void snd_uart16550_io_loop(snd_uart16550_t * uart)
 {
@@ -274,16 +274,16 @@
  * ---------------------------
  * After receiving a interrupt, it is important to indicate to the UART that
  * this has been done. 
- * For a Rx interupt, this is done by reading the received byte.
- * For a Tx interupt this is done by either:
+ * For a Rx interrupt, this is done by reading the received byte.
+ * For a Tx interrupt this is done by either:
  * a) Writing a byte
  * b) Reading the IIR
- * It is particularly important to read the IIR if a Tx interupt is received
+ * It is particularly important to read the IIR if a Tx interrupt is received
  * when there is no data in tx_buff[], as in this case there no other
- * indication that the interupt has been serviced, and it remains outstanding
- * indefinitely. This has the curious side effect that and no further interupts
+ * indication that the interrupt has been serviced, and it remains outstanding
+ * indefinitely. This has the curious side effect that and no further interrupts
  * will be generated from this device AT ALL!!.
- * It is also desirable to clear outstanding interupts when the device is
+ * It is also desirable to clear outstanding interrupts when the device is
  * opened/closed.
  *
  *
@@ -300,7 +300,7 @@
 		spin_unlock(&uart->open_lock);
 		return;
 	}
-	inb(uart->base + UART_IIR);		/* indicate to the UART that the interupt has been serviced */
+	inb(uart->base + UART_IIR);		/* indicate to the UART that the interrupt has been serviced */
 	snd_uart16550_io_loop(uart);
 	spin_unlock(&uart->open_lock);
 }
@@ -378,7 +378,7 @@
 	     | UART_FCR_CLEAR_RCVR	/* Clear receiver FIFO */
 	     | UART_FCR_CLEAR_XMIT	/* Clear transmitter FIFO */
 	     | UART_FCR_TRIGGER_4	/* Set FIFO trigger at 4-bytes */
-	/* NOTE: interupt generated after T=(time)4-bytes
+	/* NOTE: interrupt generated after T=(time)4-bytes
 	 * if less than UART_FCR_TRIGGER bytes received
 	 */
 	     ,uart->base + UART_FCR);	/* FIFO Control Register */
@@ -430,8 +430,8 @@
 	}
 
 	if (uart->irq < 0) {
-		byte = (0 & UART_IER_RDI)	/* Disable Receiver data interupt */
-		    |(0 & UART_IER_THRI)	/* Disable Transmitter holding register empty interupt */
+		byte = (0 & UART_IER_RDI)	/* Disable Receiver data interrupt */
+		    |(0 & UART_IER_THRI)	/* Disable Transmitter holding register empty interrupt */
 		    ;
 	} else if (uart->adaptor == SNDRV_SERIAL_MS124W_SA) {
 		byte = UART_IER_RDI	/* Enable Receiver data interrupt */
@@ -440,11 +440,11 @@
 	} else if (uart->adaptor == SNDRV_SERIAL_GENERIC) {
 		byte = UART_IER_RDI	/* Enable Receiver data interrupt */
 		    | UART_IER_MSI	/* Enable Modem status interrupt */
-		    | UART_IER_THRI	/* Enable Transmitter holding register empty interupt */
+		    | UART_IER_THRI	/* Enable Transmitter holding register empty interrupt */
 		    ;
 	} else {
-		byte = UART_IER_RDI	/* Enable Receiver data interupt */
-		    | UART_IER_THRI	/* Enable Transmitter holding register empty interupt */
+		byte = UART_IER_RDI	/* Enable Receiver data interrupt */
+		    | UART_IER_THRI	/* Enable Transmitter holding register empty interrupt */
 		    ;
 	}
 	outb(byte, uart->base + UART_IER);	/* Interupt enable Register */
@@ -463,8 +463,8 @@
 	 * For now, the consequences are harmless.
 	 */
 
-	outb((0 & UART_IER_RDI)		/* Disable Receiver data interupt */
-	     |(0 & UART_IER_THRI)	/* Disable Transmitter holding register empty interupt */
+	outb((0 & UART_IER_RDI)		/* Disable Receiver data interrupt */
+	     |(0 & UART_IER_THRI)	/* Disable Transmitter holding register empty interrupt */
 	     ,uart->base + UART_IER);	/* Interupt enable Register */
 
 	switch (uart->adaptor) {
@@ -489,7 +489,7 @@
 		break;
 	}
 
-	inb(uart->base + UART_IIR);	/* Clear any outstanding interupts */
+	inb(uart->base + UART_IIR);	/* Clear any outstanding interrupts */
 
 	/* Restore old divisor */
 	if (uart->divisor != 0) {
diff -ur linux-2.5.62-1104-orig/sound/oss/rme96xx.c linux-2.5.62-1104/sound/oss/rme96xx.c
--- linux-2.5.62-1104-orig/sound/oss/rme96xx.c	Fri Feb 14 20:12:06 2003
+++ linux-2.5.62-1104/sound/oss/rme96xx.c	Tue Feb 18 18:31:36 2003
@@ -604,7 +604,7 @@
 		     return 1;
 		}
 	}
-	COMM       ("interupt disabled");
+	COMM       ("interrupt disabled");
 	/* first initialize all pointers on card */
 	for(i=0;i<RME96xx_num_of_init_regs;i++){
 		writel(0,s->iobase + i);
diff -ur linux-2.5.62-1104-orig/sound/pci/als4000.c linux-2.5.62-1104/sound/pci/als4000.c
--- linux-2.5.62-1104-orig/sound/pci/als4000.c	Thu Jan 16 19:22:44 2003
+++ linux-2.5.62-1104/sound/pci/als4000.c	Tue Feb 18 18:31:36 2003
@@ -370,7 +370,7 @@
 		snd_pcm_period_elapsed(chip->playback_substream);
 	if ((gcr_status & 0x40) && (chip->capture_substream)) /* capturing */
 		snd_pcm_period_elapsed(chip->capture_substream);
-	if ((gcr_status & 0x10) && (chip->rmidi)) /* MPU401 interupt */
+	if ((gcr_status & 0x10) && (chip->rmidi)) /* MPU401 interrupt */
 		snd_mpu401_uart_interrupt(irq, chip->rmidi, regs);
 	/* release the gcr */
 	outb(gcr_status, chip->alt_port + 0xe);
diff -ur linux-2.5.62-1104-orig/sound/pci/cs4281.c linux-2.5.62-1104/sound/pci/cs4281.c
--- linux-2.5.62-1104-orig/sound/pci/cs4281.c	Mon Feb 10 12:23:10 2003
+++ linux-2.5.62-1104/sound/pci/cs4281.c	Tue Feb 18 18:31:36 2003
@@ -87,7 +87,7 @@
 #define BA0_HISR_MIDI		(1<<22)	/* MIDI port interrupt */
 #define BA0_HISR_FIFOI		(1<<20)	/* FIFO polled interrupt */
 #define BA0_HISR_DMAI		(1<<18)	/* DMA interrupt (half or end) */
-#define BA0_HISR_FIFO(c)	(1<<(12+(c))) /* FIFO channel interupt */
+#define BA0_HISR_FIFO(c)	(1<<(12+(c))) /* FIFO channel interrupt */
 #define BA0_HISR_DMA(c)		(1<<(8+(c)))  /* DMA channel interrupt */
 #define BA0_HISR_GPPI		(1<<5)	/* General Purpose Input (Primary chip) */
 #define BA0_HISR_GPSI		(1<<4)	/* General Purpose Input (Secondary chip) */
diff -ur linux-2.5.62-1104-orig/sound/pci/es1968.c linux-2.5.62-1104/sound/pci/es1968.c
--- linux-2.5.62-1104-orig/sound/pci/es1968.c	Mon Feb 10 12:23:10 2003
+++ linux-2.5.62-1104/sound/pci/es1968.c	Tue Feb 18 18:31:36 2003
@@ -1132,7 +1132,7 @@
 	}
 
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	/* clear WP interupts */
+	/* clear WP interrupts */
 	outw(1, chip->io_port + 0x04);
 	/* enable WP ints */
 	outw(inw(chip->io_port + ESM_PORT_HOST_IRQ) | ESM_HIRQ_DSIE, chip->io_port + ESM_PORT_HOST_IRQ);
@@ -1263,7 +1263,7 @@
 	}
 
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	/* clear WP interupts */
+	/* clear WP interrupts */
 	outw(1, chip->io_port + 0x04);
 	/* enable WP ints */
 	outw(inw(chip->io_port + ESM_PORT_HOST_IRQ) | ESM_HIRQ_DSIE, chip->io_port + ESM_PORT_HOST_IRQ);
@@ -1828,7 +1828,7 @@
 	apu_set_register(chip, apu, 10, 0x8F08);
 	apu_set_register(chip, apu, 11, 0x0000);
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	outw(1, chip->io_port + 0x04); /* clear WP interupts */
+	outw(1, chip->io_port + 0x04); /* clear WP interrupts */
 	outw(inw(chip->io_port + ESM_PORT_HOST_IRQ) | ESM_HIRQ_DSIE, chip->io_port + ESM_PORT_HOST_IRQ); /* enable WP ints */
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 





