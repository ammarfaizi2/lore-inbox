Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbTBYD3U>; Mon, 24 Feb 2003 22:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbTBYD2u>; Mon, 24 Feb 2003 22:28:50 -0500
Received: from [24.77.48.240] ([24.77.48.240]:29539 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S265711AbTBYD10>;
	Mon, 24 Feb 2003 22:27:26 -0500
Date: Mon, 24 Feb 2003 19:37:45 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302250337.h1P3bjH32713@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - necessary
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling fixes for 2.5.63:

This patch fixes:
    neccessary -> necessary
    unneccessary -> unnecessary

Fixes 46 occurrences in all.

diff -ur 2.5.63a/arch/i386/kernel/cpu/cpufreq/longrun.c 2.5.63b/arch/i386/kernel/cpu/cpufreq/longrun.c
--- 2.5.63a/arch/i386/kernel/cpu/cpufreq/longrun.c	Mon Feb 24 11:05:38 2003
+++ 2.5.63b/arch/i386/kernel/cpu/cpufreq/longrun.c	Mon Feb 24 18:28:38 2003
@@ -133,7 +133,7 @@
  * longrun_determine_freqs - determines the lowest and highest possible core frequency
  *
  * Determines the lowest and highest possible core frequencies on this CPU.
- * This is neccessary to calculate the performance percentage according to
+ * This is necessary to calculate the performance percentage according to
  * TMTA rules:
  * performance_pctg = (target_freq - low_freq)/(high_freq - low_freq)
  */
diff -ur 2.5.63a/arch/i386/kernel/suspend.c 2.5.63b/arch/i386/kernel/suspend.c
--- 2.5.63a/arch/i386/kernel/suspend.c	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/arch/i386/kernel/suspend.c	Mon Feb 24 18:30:22 2003
@@ -113,7 +113,7 @@
 	int cpu = smp_processor_id();
 	struct tss_struct * t = init_tss + cpu;
 
-	set_tss_desc(cpu,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy TSS or some similar stupidity. */
+	set_tss_desc(cpu,t);	/* This just modifies memory; should not be necessary. But... This is necessary, because 386 hardware has concept of busy TSS or some similar stupidity. */
         cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 
 	load_TR_desc();				/* This does ltr */
diff -ur 2.5.63a/arch/mips/au1000/common/serial.c 2.5.63b/arch/mips/au1000/common/serial.c
--- 2.5.63a/arch/mips/au1000/common/serial.c	Mon Feb 24 11:05:14 2003
+++ 2.5.63b/arch/mips/au1000/common/serial.c	Mon Feb 24 18:28:52 2003
@@ -2703,7 +2703,7 @@
  *	port exists and is in use an error is returned. If the port
  *	is not currently in the table it is added.
  *
- *	The port is then probed and if neccessary the IRQ is autodetected
+ *	The port is then probed and if necessary the IRQ is autodetected
  *	If this fails an error is returned.
  *
  *	On success the port is ready to use and the line number is returned.
diff -ur 2.5.63a/arch/sh/kernel/pci-dma.c 2.5.63b/arch/sh/kernel/pci-dma.c
--- 2.5.63a/arch/sh/kernel/pci-dma.c	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/arch/sh/kernel/pci-dma.c	Mon Feb 24 18:28:56 2003
@@ -24,7 +24,7 @@
 	ret = (void *) __get_free_pages(gfp, get_order(size));
 
 	if (ret != NULL) {
-	        /* Is it neccessary to do the memset? */
+	        /* Is it necessary to do the memset? */
 		memset(ret, 0, size);
 		*dma_handle = virt_to_bus(ret);
 	}
diff -ur 2.5.63a/arch/sh/stboards/pcidma.c 2.5.63b/arch/sh/stboards/pcidma.c
--- 2.5.63a/arch/sh/stboards/pcidma.c	Mon Feb 24 11:05:31 2003
+++ 2.5.63b/arch/sh/stboards/pcidma.c	Mon Feb 24 18:28:58 2003
@@ -24,7 +24,7 @@
 	ret = (void *) __get_free_pages(gfp, get_order(size));
 
 	if (ret != NULL) {
-	        /* Is it neccessary to do the memset? */
+	        /* Is it necessary to do the memset? */
 		memset(ret, 0, size);
 		*dma_handle = virt_to_bus(ret);
 	}
diff -ur 2.5.63a/drivers/char/ftape/zftape/zftape-write.c 2.5.63b/drivers/char/ftape/zftape/zftape-write.c
--- 2.5.63a/drivers/char/ftape/zftape/zftape-write.c	Mon Feb 24 11:05:32 2003
+++ 2.5.63b/drivers/char/ftape/zftape/zftape-write.c	Mon Feb 24 18:28:59 2003
@@ -357,7 +357,7 @@
 	*volume = zft_find_volume(pos->seg_pos);
 	DUMP_VOLINFO(ft_t_noise, "", *volume);
 	zft_just_before_eof = 0;
-	/* now merge with old data if neccessary */
+	/* now merge with old data if necessary */
 	if (!zft_qic_mode && pos->seg_byte_pos != 0){
 		result = zft_fetch_segment(pos->seg_pos,
 					   zft_deblock_buf,
diff -ur 2.5.63a/drivers/ide/ide-dma.c 2.5.63b/drivers/ide/ide-dma.c
--- 2.5.63a/drivers/ide/ide-dma.c	Mon Feb 24 11:05:32 2003
+++ 2.5.63b/drivers/ide/ide-dma.c	Mon Feb 24 18:30:35 2003
@@ -196,9 +196,9 @@
  *	@drive: the drive to build the DMA table for
  *	@rq: the request holding the sg list
  *
- *	Perform the PCI mapping magic neccessary to access the source or
+ *	Perform the PCI mapping magic necessary to access the source or
  *	target buffers of a request via PCI DMA. The lower layers of the
- *	kernel provide the neccessary cache management so that we can
+ *	kernel provide the necessary cache management so that we can
  *	operate in a portable fashion
  */
  
@@ -226,9 +226,9 @@
  *	@drive: the drive to build the DMA table for
  *	@rq: the request holding the sg list
  *
- *	Perform the PCI mapping magic neccessary to access the source or
+ *	Perform the PCI mapping magic necessary to access the source or
  *	target buffers of a taskfile request via PCI DMA. The lower layers 
- *	of the  kernel provide the neccessary cache management so that we can
+ *	of the  kernel provide the necessary cache management so that we can
  *	operate in a portable fashion
  */
  
diff -ur 2.5.63a/drivers/ide/ide-io.c 2.5.63b/drivers/ide/ide-io.c
--- 2.5.63a/drivers/ide/ide-io.c	Mon Feb 24 11:05:40 2003
+++ 2.5.63b/drivers/ide/ide-io.c	Mon Feb 24 18:30:38 2003
@@ -379,7 +379,7 @@
  *	@drive: drive the completion interrupt occurred on
  *
  *	drive_cmd_intr() is invoked on completion of a special DRIVE_CMD.
- *	We do any neccessary daya reading and then wait for the drive to
+ *	We do any necessary daya reading and then wait for the drive to
  *	go non busy. At that point we may read the error data and complete
  *	the request
  */
@@ -652,7 +652,7 @@
  *	@hwgroup: hardware group to select on
  *
  *	choose_drive() selects the next drive which will be serviced.
- *	This is neccessary because the IDE layer can't issue commands
+ *	This is necessary because the IDE layer can't issue commands
  *	to both drives on the same cable, unlike SCSI.
  */
  
diff -ur 2.5.63a/drivers/ide/setup-pci.c 2.5.63b/drivers/ide/setup-pci.c
--- 2.5.63a/drivers/ide/setup-pci.c	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/drivers/ide/setup-pci.c	Mon Feb 24 18:30:40 2003
@@ -470,7 +470,7 @@
  *	@hwif: Hardware interface we are configuring
  *
  *	Set up the DMA base for the interface. Enable the master bits as
- *	neccessary and attempt to bring the device DMA into a ready to use
+ *	necessary and attempt to bring the device DMA into a ready to use
  *	state
  */
  
@@ -573,7 +573,7 @@
  *	@index: ata index to update
  *
  *	Scan the interfaces attached to this device and do any
- *	neccessary per port setup. Attach the devices and ask the
+ *	necessary per port setup. Attach the devices and ask the
  *	generic DMA layer to do its work for us.
  *
  *	Normally called automaticall from do_ide_pci_setup_device,
diff -ur 2.5.63a/drivers/isdn/hisax/amd7930_fn.c 2.5.63b/drivers/isdn/hisax/amd7930_fn.c
--- 2.5.63a/drivers/isdn/hisax/amd7930_fn.c	Mon Feb 24 11:05:35 2003
+++ 2.5.63b/drivers/isdn/hisax/amd7930_fn.c	Mon Feb 24 18:29:06 2003
@@ -42,7 +42,7 @@
  *
  * Credits:
  * Programming the driver for Formula-n enter:now ISDN PCI and
- * neccessary this driver for the used Amd 7930 D-channel-controller
+ * necessary this driver for the used Amd 7930 D-channel-controller
  * was spnsored by Formula-n Europe AG.
  * Thanks to Karsten Keil and Petr Novak, who gave me support in
  * Hisax-specific questions.
diff -ur 2.5.63a/drivers/isdn/hisax/enternow_pci.c 2.5.63b/drivers/isdn/hisax/enternow_pci.c
--- 2.5.63a/drivers/isdn/hisax/enternow_pci.c	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/drivers/isdn/hisax/enternow_pci.c	Mon Feb 24 18:29:08 2003
@@ -49,7 +49,7 @@
  *
  * Credits:
  * Programming the driver for Formula-n enter:now ISDN PCI and
- * neccessary the driver for the used Amd 7930 D-channel-controller
+ * necessary the driver for the used Amd 7930 D-channel-controller
  * was spnsored by Formula-n Europe AG.
  * Thanks to Karsten Keil and Petr Novak, who gave me support in
  * Hisax-specific questions.
diff -ur 2.5.63a/drivers/isdn/hysdn/hycapi.c 2.5.63b/drivers/isdn/hysdn/hycapi.c
--- 2.5.63a/drivers/isdn/hysdn/hycapi.c	Mon Feb 24 11:05:06 2003
+++ 2.5.63b/drivers/isdn/hysdn/hycapi.c	Mon Feb 24 18:29:09 2003
@@ -521,7 +521,7 @@
 Receive a capi-message.
 
 All B3_DATA_IND are converted to 64K-extension compatible format.
-New nccis are created if neccessary.
+New nccis are created if necessary.
 *******************************************************************/
 
 void
diff -ur 2.5.63a/drivers/md/dm-table.c 2.5.63b/drivers/md/dm-table.c
--- 2.5.63a/drivers/md/dm-table.c	Mon Feb 24 11:06:01 2003
+++ 2.5.63b/drivers/md/dm-table.c	Mon Feb 24 18:29:11 2003
@@ -499,7 +499,7 @@
 }
 
 /*
- * Decrement a devices use count and remove it if neccessary.
+ * Decrement a devices use count and remove it if necessary.
  */
 void dm_put_device(struct dm_target *ti, struct dm_dev *dd)
 {
diff -ur 2.5.63a/drivers/message/i2o/i2o_core.c 2.5.63b/drivers/message/i2o/i2o_core.c
--- 2.5.63a/drivers/message/i2o/i2o_core.c	Mon Feb 24 11:05:35 2003
+++ 2.5.63b/drivers/message/i2o/i2o_core.c	Mon Feb 24 18:29:12 2003
@@ -2120,7 +2120,7 @@
  *	@iop: controller
  *
  *	This function brings an I2O controller into HOLD state. The adapter
- *	is reset if neccessary and then the queues and resource table
+ *	is reset if necessary and then the queues and resource table
  *	are read. -1 is returned on a failure, 0 on success.
  *	
  */
diff -ur 2.5.63a/drivers/net/3c527.c 2.5.63b/drivers/net/3c527.c
--- 2.5.63a/drivers/net/3c527.c	Mon Feb 24 11:05:33 2003
+++ 2.5.63b/drivers/net/3c527.c	Mon Feb 24 18:29:14 2003
@@ -1168,7 +1168,7 @@
  * 	the stack or, if the packet is near MTU sized, we allocate
  *	another buffer and flip the old one up the stack.
  * 
- *	We must succeed in keeping a buffer on the ring. If neccessary we
+ *	We must succeed in keeping a buffer on the ring. If necessary we
  *	will toss a received packet rather than lose a ring entry. Once
  *	the first uncompleted descriptor is found, we move the
  *	End-Of-List bit to include the buffers just processed.
diff -ur 2.5.63a/drivers/net/8390.c 2.5.63b/drivers/net/8390.c
--- 2.5.63a/drivers/net/8390.c	Mon Feb 24 11:05:08 2003
+++ 2.5.63b/drivers/net/8390.c	Mon Feb 24 18:29:16 2003
@@ -417,7 +417,7 @@
  * Handle the ether interface interrupts. We pull packets from
  * the 8390 via the card specific functions and fire them at the networking
  * stack. We also handle transmit completions and wake the transmit path if
- * neccessary. We also update the counters and do other housekeeping as
+ * necessary. We also update the counters and do other housekeeping as
  * needed.
  */
 
diff -ur 2.5.63a/drivers/net/e100/e100_config.c 2.5.63b/drivers/net/e100/e100_config.c
--- 2.5.63a/drivers/net/e100/e100_config.c	Mon Feb 24 11:05:15 2003
+++ 2.5.63b/drivers/net/e100/e100_config.c	Mon Feb 24 18:29:17 2003
@@ -149,7 +149,7 @@
 	 * 32 from the RFD base address, instead of at offset 16. */
 	bdp->config[7] |= CB_CFIG_EXTENDED_RFD;
 
-	/* put the chip into D102 receive mode.  This is neccessary
+	/* put the chip into D102 receive mode.  This is necessary
 	 * for any parsing and offloading features. */
 	bdp->config[22] = CB_CFIG_RECEIVE_GAMLA_MODE;
 
diff -ur 2.5.63a/drivers/net/pcmcia/axnet_cs.c 2.5.63b/drivers/net/pcmcia/axnet_cs.c
--- 2.5.63a/drivers/net/pcmcia/axnet_cs.c	Mon Feb 24 11:05:33 2003
+++ 2.5.63b/drivers/net/pcmcia/axnet_cs.c	Mon Feb 24 18:29:19 2003
@@ -1341,7 +1341,7 @@
  * Handle the ether interface interrupts. We pull packets from
  * the 8390 via the card specific functions and fire them at the networking
  * stack. We also handle transmit completions and wake the transmit path if
- * neccessary. We also update the counters and do other housekeeping as
+ * necessary. We also update the counters and do other housekeeping as
  * needed.
  */
 
diff -ur 2.5.63a/drivers/net/sk98lin/h/skdrv1st.h 2.5.63b/drivers/net/sk98lin/h/skdrv1st.h
--- 2.5.63a/drivers/net/sk98lin/h/skdrv1st.h	Mon Feb 24 11:05:05 2003
+++ 2.5.63b/drivers/net/sk98lin/h/skdrv1st.h	Mon Feb 24 18:29:21 2003
@@ -72,7 +72,7 @@
  * Description:
  *
  * This is the first include file of the driver, which includes all
- * neccessary system header files and some of the GEnesis header files.
+ * necessary system header files and some of the GEnesis header files.
  * It also defines some basic items.
  *
  * Include File Hierarchy:
diff -ur 2.5.63a/drivers/net/sk98lin/h/skdrv2nd.h 2.5.63b/drivers/net/sk98lin/h/skdrv2nd.h
--- 2.5.63a/drivers/net/sk98lin/h/skdrv2nd.h	Mon Feb 24 11:06:02 2003
+++ 2.5.63b/drivers/net/sk98lin/h/skdrv2nd.h	Mon Feb 24 18:29:22 2003
@@ -85,7 +85,7 @@
  * Description:
  *
  * This is the second include file of the driver, which includes all other
- * neccessary files and defines all structures and constants used by the
+ * necessary files and defines all structures and constants used by the
  * driver and the common modules.
  *
  * Include File Hierarchy:
diff -ur 2.5.63a/drivers/net/sk98lin/skgehwt.c 2.5.63b/drivers/net/sk98lin/skgehwt.c
--- 2.5.63a/drivers/net/sk98lin/skgehwt.c	Mon Feb 24 11:05:43 2003
+++ 2.5.63b/drivers/net/sk98lin/skgehwt.c	Mon Feb 24 18:30:56 2003
@@ -61,14 +61,14 @@
  *	fix: chg pAc -> pAC
  *	
  *	Revision 1.4  1998/08/10 14:14:52  gklug
- *	rmv: unneccessary SK_ADDR macro
+ *	rmv: unnecessary SK_ADDR macro
  *	
  *	Revision 1.3  1998/08/07 12:53:44  gklug
  *	fix: first compiled version
  *	
  *	Revision 1.2  1998/08/07 09:19:29  gklug
  *	adapt functions to the C coding conventions
- *	rmv unneccessary functions.
+ *	rmv unnecessary functions.
  *	
  *	Revision 1.1  1998/08/05 11:28:36  gklug
  *	first version: adapted from SMT/FDDI
diff -ur 2.5.63a/drivers/net/sk98lin/ski2c.c 2.5.63b/drivers/net/sk98lin/ski2c.c
--- 2.5.63a/drivers/net/sk98lin/ski2c.c	Mon Feb 24 11:05:04 2003
+++ 2.5.63b/drivers/net/sk98lin/ski2c.c	Mon Feb 24 18:29:25 2003
@@ -178,7 +178,7 @@
  *	Revision 1.2  1998/08/11 07:27:15  gklug
  *	add: functions of the interface
  *	adapt rest of source to C coding Conventions
- *	rmv: unneccessary code taken from Mona Lisa
+ *	rmv: unnecessary code taken from Mona Lisa
  *
  *	Revision 1.1  1998/06/19 14:28:43  malthoff
  *	Created. Sources taken from ML Projekt.
diff -ur 2.5.63a/drivers/net/sk98lin/skxmac2.c 2.5.63b/drivers/net/sk98lin/skxmac2.c
--- 2.5.63a/drivers/net/sk98lin/skxmac2.c	Mon Feb 24 11:05:47 2003
+++ 2.5.63b/drivers/net/sk98lin/skxmac2.c	Mon Feb 24 18:29:27 2003
@@ -596,7 +596,7 @@
  *	none, National: 80ns).
  *
  * ATTENTION:
- * 	It is absolutely neccessary to reset the SW_RST Bit first
+ * 	It is absolutely necessary to reset the SW_RST Bit first
  *	before calling this function.
  *
  * Returns:
diff -ur 2.5.63a/drivers/s390/block/dasd_3990_erp.c 2.5.63b/drivers/s390/block/dasd_3990_erp.c
--- 2.5.63a/drivers/s390/block/dasd_3990_erp.c	Mon Feb 24 11:05:41 2003
+++ 2.5.63b/drivers/s390/block/dasd_3990_erp.c	Mon Feb 24 18:29:29 2003
@@ -197,7 +197,7 @@
  * DASD_3990_ERP_CLEANUP 
  *
  * DESCRIPTION
- *   Removes the already build but not neccessary ERP request and sets
+ *   Removes the already build but not necessary ERP request and sets
  *   the status of the original cqr / erp to the given (final) status
  *
  *  PARAMETER
diff -ur 2.5.63a/drivers/scsi/FlashPoint.c 2.5.63b/drivers/scsi/FlashPoint.c
--- 2.5.63a/drivers/scsi/FlashPoint.c	Mon Feb 24 11:05:12 2003
+++ 2.5.63b/drivers/scsi/FlashPoint.c	Mon Feb 24 18:29:30 2003
@@ -10866,7 +10866,7 @@
  * Function: DiagEEPROM
  *
  * Description: Verfiy checksum and 'Key' and initialize the EEPROM if
- *              neccessary.
+ *              necessary.
  *
  *---------------------------------------------------------------------*/
 
diff -ur 2.5.63a/drivers/scsi/oktagon_esp.c 2.5.63b/drivers/scsi/oktagon_esp.c
--- 2.5.63a/drivers/scsi/oktagon_esp.c	Mon Feb 24 11:05:05 2003
+++ 2.5.63b/drivers/scsi/oktagon_esp.c	Mon Feb 24 18:29:33 2003
@@ -245,7 +245,7 @@
   if((code == SYS_DOWN || code == SYS_HALT) && (esp = current_esp))
    {
     esp_bootup_reset(esp,esp->eregs);
-    udelay(500); /* Settle time. Maybe unneccessary. */
+    udelay(500); /* Settle time. Maybe unnecessary. */
    }
   return NOTIFY_DONE;
 }
diff -ur 2.5.63a/drivers/serial/8250.c 2.5.63b/drivers/serial/8250.c
--- 2.5.63a/drivers/serial/8250.c	Mon Feb 24 11:05:06 2003
+++ 2.5.63b/drivers/serial/8250.c	Mon Feb 24 18:29:35 2003
@@ -1989,7 +1989,7 @@
  *	port exists and is in use an error is returned. If the port
  *	is not currently in the table it is added.
  *
- *	The port is then probed and if neccessary the IRQ is autodetected
+ *	The port is then probed and if necessary the IRQ is autodetected
  *	If this fails an error is returned.
  *
  *	On success the port is ready to use and the line number is returned.
diff -ur 2.5.63a/drivers/usb/serial/kobil_sct.c 2.5.63b/drivers/usb/serial/kobil_sct.c
--- 2.5.63a/drivers/usb/serial/kobil_sct.c	Mon Feb 24 11:05:42 2003
+++ 2.5.63b/drivers/usb/serial/kobil_sct.c	Mon Feb 24 18:29:37 2003
@@ -159,7 +159,7 @@
 	}
 	usb_set_serial_port_data(serial->port, priv);
 
-	// search for the neccessary endpoints
+	// search for the necessary endpoints
 	pdev = serial->dev;
  	actconfig = pdev->actconfig;
  	interface = actconfig->interface;
diff -ur 2.5.63a/fs/reiserfs/lbalance.c 2.5.63b/fs/reiserfs/lbalance.c
--- 2.5.63a/fs/reiserfs/lbalance.c	Mon Feb 24 11:06:02 2003
+++ 2.5.63b/fs/reiserfs/lbalance.c	Mon Feb 24 18:29:39 2003
@@ -1192,7 +1192,7 @@
   }
 
 
-  /* change item key if neccessary (when we paste before 0-th entry */
+  /* change item key if necessary (when we paste before 0-th entry */
   if (!before)
     {
 	set_le_ih_k_offset (ih, deh_offset(new_dehs));
diff -ur 2.5.63a/include/asm-arm/arch-sa1100/simpad.h 2.5.63b/include/asm-arm/arch-sa1100/simpad.h
--- 2.5.63a/include/asm-arm/arch-sa1100/simpad.h	Mon Feb 24 11:05:14 2003
+++ 2.5.63b/include/asm-arm/arch-sa1100/simpad.h	Mon Feb 24 18:29:41 2003
@@ -46,7 +46,7 @@
 #define IRQ_GPIO_CF_IRQ         IRQ_GPIO1
 #define IRQ_GPIO_CF_CD          IRQ_GPIO24      
 
-// CS3 Latch is write only, a shadow is neccessary 
+// CS3 Latch is write only, a shadow is necessary 
 
 #define CS3BUSTYPE unsigned volatile long           
 #define CS3_BASE        0xf1000000
diff -ur 2.5.63a/include/asm-m68k/page.h 2.5.63b/include/asm-m68k/page.h
--- 2.5.63a/include/asm-m68k/page.h	Mon Feb 24 11:06:02 2003
+++ 2.5.63b/include/asm-m68k/page.h	Mon Feb 24 18:29:43 2003
@@ -164,7 +164,7 @@
  * NOTE: virtual isn't really correct, actually it should be the offset into the
  * memory node, but we have no highmem, so that works for now.
  * TODO: implement (fast) pfn<->pgdat_idx conversion functions, this makes lots
- * of the shifts unneccessary.
+ * of the shifts unnecessary.
  */
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
 #define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
diff -ur 2.5.63a/include/asm-s390/types.h 2.5.63b/include/asm-s390/types.h
--- 2.5.63a/include/asm-s390/types.h	Mon Feb 24 11:05:32 2003
+++ 2.5.63b/include/asm-s390/types.h	Mon Feb 24 18:29:45 2003
@@ -32,7 +32,7 @@
 typedef unsigned long long __u64;
 #endif
 /* A address type so that arithmetic can be done on it & it can be upgraded to
-   64 bit when neccessary 
+   64 bit when necessary 
 */
 typedef __u32  addr_t; 
 typedef __s32  saddr_t;
diff -ur 2.5.63a/include/asm-s390x/types.h 2.5.63b/include/asm-s390x/types.h
--- 2.5.63a/include/asm-s390x/types.h	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/include/asm-s390x/types.h	Mon Feb 24 18:29:47 2003
@@ -32,7 +32,7 @@
 
 /* 
  * A address type so that arithmetic can be done on it & it can be upgraded to
- * 64 bit when neccessary 
+ * 64 bit when necessary 
  */
 
 typedef unsigned long  addr_t; 
diff -ur 2.5.63a/kernel/cpufreq.c 2.5.63b/kernel/cpufreq.c
--- 2.5.63a/kernel/cpufreq.c	Mon Feb 24 11:05:12 2003
+++ 2.5.63b/kernel/cpufreq.c	Mon Feb 24 18:29:50 2003
@@ -1078,11 +1078,11 @@
 
 	down(&cpufreq_notifier_sem);
 
-	/* adjust if neccessary - all reasons */
+	/* adjust if necessary - all reasons */
 	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_ADJUST,
 			    policy);
 
-	/* adjust if neccessary - hardware incompatibility*/
+	/* adjust if necessary - hardware incompatibility*/
 	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_INCOMPATIBLE,
 			    policy);
 
diff -ur 2.5.63a/kernel/suspend.c 2.5.63b/kernel/suspend.c
--- 2.5.63a/kernel/suspend.c	Mon Feb 24 11:05:13 2003
+++ 2.5.63b/kernel/suspend.c	Mon Feb 24 18:29:52 2003
@@ -961,7 +961,7 @@
 	printk("Relocating pagedir");
 
 	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
-		printk("not neccessary\n");
+		printk("not necessary\n");
 		return 0;
 	}
 
diff -ur 2.5.63a/net/ipv4/netfilter/ip_conntrack_ftp.c 2.5.63b/net/ipv4/netfilter/ip_conntrack_ftp.c
--- 2.5.63a/net/ipv4/netfilter/ip_conntrack_ftp.c	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/net/ipv4/netfilter/ip_conntrack_ftp.c	Mon Feb 24 18:29:54 2003
@@ -321,7 +321,7 @@
 	if (found == -1) {
 		/* We don't usually drop packets.  After all, this is
 		   connection tracking, not packet filtering.
-		   However, it is neccessary for accurate tracking in
+		   However, it is necessary for accurate tracking in
 		   this case. */
 		if (net_ratelimit())
 			printk("conntrack_ftp: partial %s %u+%u\n",
diff -ur 2.5.63a/net/ipv4/netfilter/ip_conntrack_irc.c 2.5.63b/net/ipv4/netfilter/ip_conntrack_irc.c
--- 2.5.63a/net/ipv4/netfilter/ip_conntrack_irc.c	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/net/ipv4/netfilter/ip_conntrack_irc.c	Mon Feb 24 18:29:55 2003
@@ -199,7 +199,7 @@
 			LOCK_BH(&ip_irc_lock);
 
 			/* save position of address in dcc string,
-			 * neccessary for NAT */
+			 * necessary for NAT */
 			DEBUGP("tcph->seq = %u\n", tcph->seq);
 			exp->seq = ntohl(tcph->seq) + (addr_beg_p - _data);
 			exp_irc_info->len = (addr_end_p - addr_beg_p);
diff -ur 2.5.63a/net/ipv4/netfilter/ip_nat_core.c 2.5.63b/net/ipv4/netfilter/ip_nat_core.c
--- 2.5.63a/net/ipv4/netfilter/ip_nat_core.c	Mon Feb 24 11:05:10 2003
+++ 2.5.63b/net/ipv4/netfilter/ip_nat_core.c	Mon Feb 24 18:29:57 2003
@@ -288,7 +288,7 @@
 		saved_ip = tuple->src.ip;
 		other_ipp = &tuple->src.ip;
 	}
-	/* Don't do do_extra_mangle unless neccessary (overrides
+	/* Don't do do_extra_mangle unless necessary (overrides
            explicit socket bindings, for example) */
 	orig_dstip = tuple->dst.ip;
 
diff -ur 2.5.63a/net/sched/sch_htb.c 2.5.63b/net/sched/sch_htb.c
--- 2.5.63a/net/sched/sch_htb.c	Mon Feb 24 11:05:35 2003
+++ 2.5.63b/net/sched/sch_htb.c	Mon Feb 24 18:30:00 2003
@@ -623,7 +623,7 @@
 	if (new_mode == cl->cmode)
 		return;	
 	
-	if (cl->prio_activity) { /* not neccessary: speed optimization */
+	if (cl->prio_activity) { /* not necessary: speed optimization */
 		if (cl->cmode != HTB_CANT_SEND) 
 			htb_deactivate_prios(q,cl);
 		cl->cmode = new_mode;
