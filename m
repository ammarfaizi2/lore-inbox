Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293712AbSBREYv>; Sun, 17 Feb 2002 23:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293713AbSBREYn>; Sun, 17 Feb 2002 23:24:43 -0500
Received: from [202.135.142.194] ([202.135.142.194]:13838 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293712AbSBREYg>; Sun, 17 Feb 2002 23:24:36 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4 Trivial patches
Date: Mon, 18 Feb 2002 15:24:08 +1100
Message-Id: <E16cfLU-0001t5-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

	Just three trivial patches this week for 2.4.  Do you prefer
them one at a time, or is this OK?

Trivial patch update against 2.4.18-rc1:
"Jahn Veach" <V64@V64.net>: [PATCH 2.5.4] Typo corrections:
  This applies to 2.5.4. It fixes various typos that I've looked for and
  corrected. Not sure how many of these still exist in 2.5.5-pre1. I'll send
  another one out if I can finish up this Perl script to go through and
  automatically correct some of the more numerous typos (such as 'existant').

Andrey Panin <pazke@orbita1.ru>: [PATCH] remove annoying ISAPNP message:
  This patch removes useless messages like:
  "isapnp: Calling quirk for 02:00".
  
  These were debug messages some years ago and IMHO totally useless now.

René Scharfe <l.s.r@web.de>: [PATCH] compiler warnings in scripts_tkgen.c:
  this patch fixes two compiler warnings during make xconfig which
  turn up if one uses -Wshadow

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/Documentation/networking/arcnet-hardware.txt /home/rusty/devel/kernel/trivial-2.4.18-rc1/Documentation/networking/arcnet-hardware.txt
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/Documentation/networking/arcnet-hardware.txt	Wed Aug 23 08:21:54 2000
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/Documentation/networking/arcnet-hardware.txt	Mon Feb 18 15:23:20 2002
@@ -2256,7 +2256,7 @@
 When I got my two cards, one of them had this switch set to "enhanced". That
 card didn't work at all, it wasn't even recognized by the driver. The other
 card had this switch set to "compatible" and it behaved absolutely normally. I
-guess that the switch on one of the cards, must have been changed accidently
+guess that the switch on one of the cards, must have been changed accidentally
 when the card was taken out of its former host. The question remains
 unanswered, what is the purpose of the "enhanced" position?
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/Documentation/networking/bonding.txt /home/rusty/devel/kernel/trivial-2.4.18-rc1/Documentation/networking/bonding.txt
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/Documentation/networking/bonding.txt	Thu Jan 17 16:31:37 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/Documentation/networking/bonding.txt	Mon Feb 18 15:23:20 2002
@@ -503,7 +503,7 @@
 Resources and links
 ===================
 
-Current developement on this driver is posted to:
+Current development on this driver is posted to:
  - http://www.sourceforge.net/projects/bonding/
 
 Donald Becker's Ethernet Drivers and diag programs may be found at :
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/Documentation/sound/OPL3-SA2 /home/rusty/devel/kernel/trivial-2.4.18-rc1/Documentation/sound/OPL3-SA2
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/Documentation/sound/OPL3-SA2	Thu Jul 19 00:14:01 2001
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/Documentation/sound/OPL3-SA2	Mon Feb 18 15:23:20 2002
@@ -65,7 +65,7 @@
 ------------
 
 In previous kernels (2.2.x), some configuration was required to
-get the driver to talk to the card.  Being the new millenium and
+get the driver to talk to the card.  Being the new millennium and
 all, the 2.4.x kernels now support auto-configuration if ISA PnP
 support is configured in.  Theoretically, the driver even supports
 having more than one card in this case.
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/Documentation/sound/README.OSS /home/rusty/devel/kernel/trivial-2.4.18-rc1/Documentation/sound/README.OSS
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/Documentation/sound/README.OSS	Wed Jun 13 03:56:11 2001
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/Documentation/sound/README.OSS	Mon Feb 18 15:23:20 2002
@@ -542,7 +542,7 @@
 
 	SoftOSS keeps the samples loaded on the system's RAM so much RAM is
 	required. SoftOSS should never be used on machines with less than 16 MB
-	of RAM since this is potentially dangerous (you may accidently run out
+	of RAM since this is potentially dangerous (you may accidentally run out
 	of memory which probably crashes the machine). 
 
 	SoftOSS implements the wave table API originally designed for GUS. For
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/arch/ia64/sn/io/pci_bus_cvlink.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/arch/ia64/sn/io/pci_bus_cvlink.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/arch/ia64/sn/io/pci_bus_cvlink.c	Fri Apr 13 05:16:35 2001
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/arch/ia64/sn/io/pci_bus_cvlink.c	Mon Feb 18 15:23:20 2002
@@ -112,9 +112,9 @@
 	pci_bus = pci_bus_to_vertex(busnum);
 	if (!pci_bus) {
 		/*
-		 * During probing, the Linux pci code invents non existant
+		 * During probing, the Linux pci code invents non-existent
 		 * bus numbers and pci_dev structures and tries to access
-		 * them to determine existance. Don't crib during probing.
+		 * them to determine existence. Don't crib during probing.
 		 */
 		if (done_probing)
 			printk("devfn_to_vertex: Invalid bus number %d given.\n", busnum);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/arch/ppc/kernel/qspan_pci.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/arch/ppc/kernel/qspan_pci.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/arch/ppc/kernel/qspan_pci.c	Tue May 22 10:04:47 2001
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/arch/ppc/kernel/qspan_pci.c	Mon Feb 18 15:23:20 2002
@@ -14,7 +14,7 @@
  * PCI access and QSpan control register addresses.  The selection is
  * further selected by a bit setting in a board control register.
  * Although it should happen, we disable interrupts during this operation
- * to make sure some driver doesn't accidently access the PCI while
+ * to make sure some driver doesn't accidentally access the PCI while
  * we have switched the chip select.
  */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/acpi/executer/exresnte.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/acpi/executer/exresnte.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/acpi/executer/exresnte.c	Thu Jan 17 16:31:24 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/acpi/executer/exresnte.c	Mon Feb 18 15:23:20 2002
@@ -44,7 +44,7 @@
  * FUNCTION:    Acpi_ex_resolve_node_to_value
  *
  * PARAMETERS:  Object_ptr      - Pointer to a location that contains
- *                                a pointer to a NS node, and will recieve a
+ *                                a pointer to a NS node, and will receive a
  *                                pointer to the resolved object.
  *              Walk_state      - Current state.  Valid only if executing AML
  *                                code.  NULL if simply resolving an object
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/char/synclink.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/char/synclink.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/char/synclink.c	Fri Feb 15 13:53:00 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/char/synclink.c	Mon Feb 18 15:23:20 2002
@@ -1811,7 +1811,7 @@
 	/* Allocate and claim adapter resources */
 	retval = mgsl_claim_resources(info);
 	
-	/* perform existance check and diagnostics */
+	/* perform existence check and diagnostics */
 	if ( !retval )
 		retval = mgsl_adapter_test(info);
 		
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/ide/ide.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/ide/ide.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/ide/ide.c	Fri Feb 15 13:53:00 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/ide/ide.c	Mon Feb 18 15:23:20 2002
@@ -1619,7 +1619,7 @@
  * drive is ready to accept one, in which case we know the drive is not
  * trying to interrupt us.  And ide_set_handler() is always invoked before
  * completing the issuance of any new drive command, so we will not be
- * accidently invoked as a result of any valid command completion interrupt.
+ * accidentally invoked as a result of any valid command completion interrupt.
  *
  */
 static void unexpected_intr (int irq, ide_hwgroup_t *hwgroup)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/mtd/devices/pmc551.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/mtd/devices/pmc551.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/mtd/devices/pmc551.c	Fri Oct  5 08:14:59 2001
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/mtd/devices/pmc551.c	Mon Feb 18 15:23:20 2002
@@ -716,7 +716,7 @@
                 }
 
 		/*
-		 * This is needed untill the driver is capable of reading the
+		 * This is needed until the driver is capable of reading the
 		 * onboard I2C SROM to discover the "real" memory size.
 		 */
 		if(msize) {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/mtd/nand/spia.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/mtd/nand/spia.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/mtd/nand/spia.c	Fri Oct  5 08:14:59 2001
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/mtd/nand/spia.c	Mon Feb 18 15:23:20 2002
@@ -113,7 +113,7 @@
 	this->ALE = 0x02;
 	this->NCE = 0x04;
 
-	/* Scan to find existance of the device */
+	/* Scan to find existence of the device */
 	if (nand_scan (spia_mtd)) {
 		kfree (spia_mtd);
 		return -ENXIO;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/net/irda/sa1100_ir.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/net/irda/sa1100_ir.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/net/irda/sa1100_ir.c	Thu Jan 17 16:31:26 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/net/irda/sa1100_ir.c	Mon Feb 18 15:23:20 2002
@@ -132,7 +132,7 @@
 	Ser2HSCR0 = si->hscr0 | HSCR0_HSSP;
 
 	/*
-	 * Enable the DMA, receiver and recieve interrupt.
+	 * Enable the DMA, receiver and receive interrupt.
 	 */
 	sa1100_dma_flush_all(si->rxdma);
 	sa1100_dma_queue_buffer(si->rxdma, NULL, si->rxbuf_dma, HPSIR_MAX_RXLEN);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/net/wan/sdla_x25.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/net/wan/sdla_x25.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/net/wan/sdla_x25.c	Fri Sep 14 09:04:43 2001
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/net/wan/sdla_x25.c	Mon Feb 18 15:23:20 2002
@@ -1272,7 +1272,7 @@
 			add_timer(&card->u.x.x25_timer);
 		}
 	}
-	/* Device is not up untill the we are in connected state */
+	/* Device is not up until the we are in connected state */
 	do_gettimeofday( &tv );
 	chan->router_start_time = tv.tv_sec;
 
@@ -4756,7 +4756,7 @@
  * send_delayed_cmd_result
  *
  *	Wait commands like PLEACE CALL or CLEAR CALL must wait
- *      untill the result arrivers. This function passes
+ *      until the result arrives. This function passes
  *      the result to a waiting sock. 
  *
  *===============================================================*/
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/pnp/quirks.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/pnp/quirks.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/pnp/quirks.c	Thu Jan 17 16:31:26 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/pnp/quirks.c	Mon Feb 18 15:23:20 2002
@@ -18,6 +18,10 @@
 #include <linux/isapnp.h>
 #include <linux/string.h>
 
+#if 0
+#define ISAPNP_DEBUG
+#endif
+
 static void __init quirk_awe32_resources(struct pci_dev *dev)
 {
 	struct isapnp_port *port, *port2, *port3;
@@ -139,8 +143,10 @@
 	while (isapnp_fixups[i].vendor != 0) {
 		if ((isapnp_fixups[i].vendor == dev->vendor) &&
 		    (isapnp_fixups[i].device == dev->device)) {
+#ifdef ISAPNP_DEBUG
 			printk(KERN_DEBUG "isapnp: Calling quirk for %02x:%02x\n",
 			       dev->bus->number, dev->devfn);
+#endif
 			isapnp_fixups[i].quirk_function(dev);
 		}
 		i++;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/s390/char/tape34xx.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/s390/char/tape34xx.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/s390/char/tape34xx.c	Thu Jan 17 16:31:42 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/s390/char/tape34xx.c	Mon Feb 18 15:23:20 2002
@@ -2152,7 +2152,7 @@
       	    tape34xx_error_recovery_HWBUG(ti,21);
 	    return;
 	case 0x3490:
-	    // Resetting event recieved. Since the driver does not support resetting event recovery
+	    // Resetting event received. Since the driver does not support resetting event recovery
 	    // (which has to be handled by the I/O Layer), we'll report and retry our command.
 	    tape34xx_error_recovery_do_retry(ti);
 	    return;
@@ -2219,7 +2219,7 @@
 	    return;
 	case 0x3490:
 	    // Global status intercept. We have to reissue the command.
-	    PRINT_WARN("An global status intercept was recieved, which will be recovered.\n");
+	    PRINT_WARN("An global status intercept was received, which will be recovered.\n");
 	    tape34xx_error_recovery_do_retry(ti);
 	    return;
 	}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/s390/misc/chandev.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/s390/misc/chandev.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/s390/misc/chandev.c	Fri Feb 15 13:53:05 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/s390/misc/chandev.c	Mon Feb 18 15:23:20 2002
@@ -2024,7 +2024,7 @@
 		/* This is required because the device can go & come back */
                 /* even before we realize it is gone owing to the waits in our kernel threads */
 		/* & the device will be marked as not owned but its status will be good */
-                /* & an attempt to accidently reprobe it may be done. */ 
+                /* & an attempt to accidentally reprobe it may be done. */ 
 		remove:
 		chandev_remove(chandev_get_by_irq(curr_irqinfo->sch.irq));
 		
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/scsi/aic7xxx/aic7xxx.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/scsi/aic7xxx/aic7xxx.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/scsi/aic7xxx/aic7xxx.c	Thu Jan 17 16:31:27 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/scsi/aic7xxx/aic7xxx.c	Mon Feb 18 15:23:20 2002
@@ -2584,7 +2584,7 @@
 
 		/*
 		 * Read the latched byte, but turn off SPIOEN first
-		 * so that we don't inadvertantly cause a REQ for the
+		 * so that we don't inadvertently cause a REQ for the
 		 * next byte.
 		 */
 		ahc_outb(ahc, SXFRCTL0, ahc_inb(ahc, SXFRCTL0) & ~SPIOEN);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/telephony/ixj.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/telephony/ixj.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/telephony/ixj.c	Thu Jan 17 16:31:30 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/telephony/ixj.c	Mon Feb 18 15:23:20 2002
@@ -3451,7 +3451,7 @@
 	j->cidcw_wait = 0;
 	if(!j->flags.cidcw_ack) {
 		if(ixjdebug & 0x0200) {
-			printk("IXJ cidcw phone%d did not recieve ACK from display %ld\n", j->board, jiffies);
+			printk("IXJ cidcw phone%d did not receive ACK from display %ld\n", j->board, jiffies);
 		}
 		ixj_post_cid(j);
 		if(j->cid_play_flag) {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/usb/storage/isd200.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/usb/storage/isd200.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/usb/storage/isd200.c	Thu Jan 17 16:31:45 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/usb/storage/isd200.c	Mon Feb 18 15:23:20 2002
@@ -821,7 +821,7 @@
  * Invoke the transport and basic error-handling/recovery methods
  *
  * This is used by the protocol layers to actually send the message to
- * the device and recieve the response.
+ * the device and receive the response.
  */
 void isd200_invoke_transport( struct us_data *us, 
 			      Scsi_Cmnd *srb, 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/usb/storage/transport.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/usb/storage/transport.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/drivers/usb/storage/transport.c	Fri Feb 15 13:53:07 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/drivers/usb/storage/transport.c	Mon Feb 18 15:23:20 2002
@@ -612,7 +612,7 @@
 /* Invoke the transport and basic error-handling/recovery methods
  *
  * This is used by the protocol layers to actually send the message to
- * the device and recieve the response.
+ * the device and receive the response.
  */
 void usb_stor_invoke_transport(Scsi_Cmnd *srb, struct us_data *us)
 {
@@ -798,7 +798,7 @@
 {
 	struct us_data *us = (struct us_data *)urb->context;
 
-	US_DEBUGP("USB IRQ recieved for device on host %d\n", us->host_no);
+	US_DEBUGP("USB IRQ received for device on host %d\n", us->host_no);
 	US_DEBUGP("-- IRQ data length is %d\n", urb->actual_length);
 	US_DEBUGP("-- IRQ state is %d\n", urb->status);
 	US_DEBUGP("-- Interrupt Status (0x%x, 0x%x)\n",
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/fs/hpfs/ea.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/fs/hpfs/ea.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/fs/hpfs/ea.c	Wed Sep  6 08:07:29 2000
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/fs/hpfs/ea.c	Mon Feb 18 15:23:20 2002
@@ -9,8 +9,8 @@
 #include <linux/string.h>
 #include "hpfs_fn.h"
 
-/* Remove external extended attributes. ano specifies wheter a is a 
-   direct sector where eas start or an anode */
+/* Remove external extended attributes. ano specifies whether a is a 
+   direct sector where eas starts or an anode */
 
 void hpfs_ea_ext_remove(struct super_block *s, secno a, int ano, unsigned len)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/include/asm-ia64/sn/pci/pcibr.h /home/rusty/devel/kernel/trivial-2.4.18-rc1/include/asm-ia64/sn/pci/pcibr.h
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/include/asm-ia64/sn/pci/pcibr.h	Fri Apr  6 05:51:47 2001
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/include/asm-ia64/sn/pci/pcibr.h	Mon Feb 18 15:23:20 2002
@@ -47,7 +47,7 @@
  *	These functions are normal device driver entry points
  *	and are called along with the similar entry points from
  *	other device drivers. They are included here as documentation
- *	of their existance and purpose.
+ *	of their existence and purpose.
  *
  *	pcibr_init() is called to inform us that there is a pcibr driver
  *	configured into the kernel; it is responsible for registering
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/include/linux/jbd.h /home/rusty/devel/kernel/trivial-2.4.18-rc1/include/linux/jbd.h
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/include/linux/jbd.h	Fri Feb 15 13:53:11 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/include/linux/jbd.h	Mon Feb 18 15:23:20 2002
@@ -352,7 +352,7 @@
 	 */
 	struct journal_head *	t_async_datalist;
 	
-	/* Doubly-linked circular list of all forget buffers (superceded
+	/* Doubly-linked circular list of all forget buffers (superseded
            buffers which we can un-checkpoint once this transaction
            commits) */
 	struct journal_head *	t_forget;
@@ -793,7 +793,7 @@
 #define BJ_SyncData	1	/* Normal data: flush before commit */
 #define BJ_AsyncData	2	/* writepage data: wait on it before commit */
 #define BJ_Metadata	3	/* Normal journaled metadata */
-#define BJ_Forget	4	/* Buffer superceded by this transaction */
+#define BJ_Forget	4	/* Buffer superseded by this transaction */
 #define BJ_IO		5	/* Buffer is for temporary IO use */
 #define BJ_Shadow	6	/* Buffer contents being shadowed to the log */
 #define BJ_LogCtl	7	/* Buffer contains log descriptors */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/include/linux/telephony.h /home/rusty/devel/kernel/trivial-2.4.18-rc1/include/linux/telephony.h
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/include/linux/telephony.h	Sat Sep  8 02:28:37 2001
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/include/linux/telephony.h	Mon Feb 18 15:23:20 2002
@@ -228,8 +228,8 @@
 * indicate the current state of the hookswitch.  The pstn_ring bit
 * indicates that the DAA on a LineJACK card has detected ring voltage on
 * the PSTN port.  The caller_id bit indicates that caller_id data has been
-* recieved and is available.  The pstn_wink bit indicates that the DAA on
-* the LineJACK has recieved a wink from the telco switch.  The f0, f1, f2
+* received and is available.  The pstn_wink bit indicates that the DAA on
+* the LineJACK has received a wink from the telco switch.  The f0, f1, f2
 * and f3 bits indicate that the filter has been triggered by detecting the
 * frequency programmed into that filter.
 *
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/kernel/signal.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/kernel/signal.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/kernel/signal.c	Thu Jan 17 16:31:50 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/kernel/signal.c	Mon Feb 18 15:23:20 2002
@@ -519,7 +519,7 @@
 	if (bad_signal(sig, info, t))
 		goto out_nolock;
 
-	/* The null signal is a permissions and process existance probe.
+	/* The null signal is a permissions and process existence probe.
 	   No signal is actually delivered.  Same goes for zombies. */
 	ret = 0;
 	if (!sig || !t->sig)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/net/core/dev.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/net/core/dev.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/net/core/dev.c	Fri Feb 15 13:53:13 2002
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/net/core/dev.c	Mon Feb 18 15:23:20 2002
@@ -444,7 +444,7 @@
 
 /* 
    Return value is changed to int to prevent illegal usage in future.
-   It is still legal to use to check for device existance.
+   It is still legal to use to check for device existence.
 
    User should understand, that the result returned by this function
    is meaningless, if it was not issued under rtnl semaphore.
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/net/wanrouter/af_wanpipe.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/net/wanrouter/af_wanpipe.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/net/wanrouter/af_wanpipe.c	Mon Oct  1 05:26:42 2001
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/net/wanrouter/af_wanpipe.c	Mon Feb 18 15:23:20 2002
@@ -110,7 +110,7 @@
  *         passes the packet to the driver. Before each send(), a poll
  *         routine checks the sock resources The maximum value of
  *         packet sent counter is 1, thus if one packet is queued, the
- *         application will block untill that packet is passed to the
+ *         application will block until that packet is passed to the
  *         driver.
  *
  *   RECEIVE:
@@ -121,7 +121,7 @@
  *      return code, the driver knows whether the packet was
  *      sucessfully queued.  If the socket queue is full, 
  *      protocol flow control is used by the driver, if any, 
- *      to slow down the traffic untill the sock queue is free.
+ *      to slow down the traffic until the sock queue is free.
  *
  *      Every time a packet arrives into a socket queue the 
  *      socket wakes up processes which are waiting to receive
@@ -2396,7 +2396,7 @@
 
 
 			/* Check if data buffers are pending for transmission,
-                         * if so, check wheter user wants to wait untill data
+                         * if so, check whether user wants to wait until data
                          * is transmitted, or clear a call and drop packets */
                           
 			if (atomic_read(&sk->wmem_alloc) || check_driver_busy(sk)){
@@ -2432,7 +2432,7 @@
 
 
 			/* Check if data buffers are pending for transmission,
-                         * if so, check wheter user wants to wait untill data
+                         * if so, check whether user wants to wait until data
                          * is transmitted, or reset a call and drop packets */
                           
 			if (atomic_read(&sk->wmem_alloc) || check_driver_busy(sk)){
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.4.18-rc1/scripts/tkgen.c /home/rusty/devel/kernel/trivial-2.4.18-rc1/scripts/tkgen.c
--- /home/rusty/devel/kernel/linux-2.4.18-rc1/scripts/tkgen.c	Sat Apr  7 03:42:55 2001
+++ /home/rusty/devel/kernel/trivial-2.4.18-rc1/scripts/tkgen.c	Mon Feb 18 15:23:20 2002
@@ -620,11 +620,11 @@
 	case token_int:
 	    if ( cfg->value && *cfg->value == '$' )
 	    {
-		int index = get_varnum( cfg->value+1 );
+		int i = get_varnum( cfg->value+1 );
 		printf( "\n" );
-		if ( ! vartable[index].global_written )
+		if ( ! vartable[i].global_written )
 		{
-		    global( vartable[index].name );
+		    global( vartable[i].name );
 		}
 		printf( "\t" );
 	    }
@@ -989,7 +989,6 @@
 static void end_proc( struct kconfig * scfg, int menu_num )
 {
     struct kconfig * cfg;
-    int i;
 
     printf( "\n\n\n" );
     printf( "\tfocus $w\n" );
@@ -1084,6 +1083,7 @@
 	    {
 		if ( cfg->token == token_tristate )
 		{
+		    int i;
 		    if ( ! vartable[cfg->nameindex].global_written )
 		    {
 			vartable[cfg->nameindex].global_written = 1;

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
