Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbTBYDbz>; Mon, 24 Feb 2003 22:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266638AbTBYDbQ>; Mon, 24 Feb 2003 22:31:16 -0500
Received: from [24.77.48.240] ([24.77.48.240]:29795 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S265736AbTBYD11>;
	Mon, 24 Feb 2003 22:27:27 -0500
Date: Mon, 24 Feb 2003 19:37:45 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302250337.h1P3bju32716@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - occurred 
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling fixes for 2.5.63:

This patch fixes:
    occured -> occurred

Fixes 135 occurrences in all.

diff -ur 2.5.63a/arch/i386/kernel/cpu/mcheck/non-fatal.c 2.5.63b/arch/i386/kernel/cpu/mcheck/non-fatal.c
--- 2.5.63a/arch/i386/kernel/cpu/mcheck/non-fatal.c	Mon Feb 24 11:05:10 2003
+++ 2.5.63b/arch/i386/kernel/cpu/mcheck/non-fatal.c	Mon Feb 24 18:14:06 2003
@@ -33,7 +33,7 @@
 		rdmsr (MSR_IA32_MC0_STATUS+i*4, low, high);
 
 		if (high & (1<<31)) {
-			printk (KERN_EMERG "MCE: The hardware reports a non fatal, correctable incident occured on CPU %d.\n",
+			printk (KERN_EMERG "MCE: The hardware reports a non fatal, correctable incident occurred on CPU %d.\n",
 				smp_processor_id());
 			printk (KERN_EMERG "Bank %d: %08x%08x\n", i, high, low);
 
diff -ur 2.5.63a/arch/ia64/sn/io/sn2/pcibr/pcibr_error.c 2.5.63b/arch/ia64/sn/io/sn2/pcibr/pcibr_error.c
--- 2.5.63a/arch/ia64/sn/io/sn2/pcibr/pcibr_error.c	Mon Feb 24 11:05:06 2003
+++ 2.5.63b/arch/ia64/sn/io/sn2/pcibr/pcibr_error.c	Mon Feb 24 18:14:08 2003
@@ -1806,7 +1806,7 @@
 	 *
 	 * CAUTION: Resetting bit BRIDGE_IRR_PCI_GRP_CLR, acknowledges
 	 *      a group of interrupts. If while handling this error,
-	 *      some other error has occured, that would be
+	 *      some other error has occurred, that would be
 	 *      implicitly cleared by this write.
 	 *      Need a way to ensure we don't inadvertently clear some
 	 *      other errors.
diff -ur 2.5.63a/arch/mips/mips-boards/generic/pci.c 2.5.63b/arch/mips/mips-boards/generic/pci.c
--- 2.5.63a/arch/mips/mips-boards/generic/pci.c	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/arch/mips/mips-boards/generic/pci.c	Mon Feb 24 18:14:10 2003
@@ -81,7 +81,7 @@
 
 	if (intr & (GT_INTRCAUSE_MASABORT0_BIT | GT_INTRCAUSE_TARABORT0_BIT))
 	{
-	        /* Error occured */
+	        /* Error occurred */
 
 	        /* Clear bits */
 	        GT_WRITE( GT_INTRCAUSE_OFS, ~(GT_INTRCAUSE_MASABORT0_BIT | 
diff -ur 2.5.63a/arch/mips64/mips-boards/generic/pci.c 2.5.63b/arch/mips64/mips-boards/generic/pci.c
--- 2.5.63a/arch/mips64/mips-boards/generic/pci.c	Mon Feb 24 11:05:07 2003
+++ 2.5.63b/arch/mips64/mips-boards/generic/pci.c	Mon Feb 24 18:14:12 2003
@@ -87,7 +87,7 @@
 
 	if (intr & (GT_INTRCAUSE_MASABORT0_BIT | GT_INTRCAUSE_TARABORT0_BIT))
 	{
-	        /* Error occured */
+	        /* Error occurred */
 
 	        /* Clear bits */
 	        GT_WRITE( GT_INTRCAUSE_OFS, ~(GT_INTRCAUSE_MASABORT0_BIT | 
diff -ur 2.5.63a/arch/ppc64/kernel/ras.c 2.5.63b/arch/ppc64/kernel/ras.c
--- 2.5.63a/arch/ppc64/kernel/ras.c	Mon Feb 24 11:05:14 2003
+++ 2.5.63b/arch/ppc64/kernel/ras.c	Mon Feb 24 18:14:15 2003
@@ -94,7 +94,7 @@
 /*
  * Handle power subsystem events (EPOW).
  *
- * Presently we just log the event has occured.  This should be fixed
+ * Presently we just log the event has occurred.  This should be fixed
  * to examine the type of power failure and take appropriate action where
  * the time horizon permits something useful to be done.
  */
diff -ur 2.5.63a/arch/x86_64/kernel/bluesmoke.c 2.5.63b/arch/x86_64/kernel/bluesmoke.c
--- 2.5.63a/arch/x86_64/kernel/bluesmoke.c	Mon Feb 24 11:05:43 2003
+++ 2.5.63b/arch/x86_64/kernel/bluesmoke.c	Mon Feb 24 18:14:17 2003
@@ -120,7 +120,7 @@
 		rdmsr(MSR_IA32_MC0_STATUS+i*4, low, high);
 
 		if ((low | high) != 0) {
-			printk (KERN_EMERG "MCE: The hardware reports a non fatal, correctable incident occured on CPU %d.\n", smp_processor_id());
+			printk (KERN_EMERG "MCE: The hardware reports a non fatal, correctable incident occurred on CPU %d.\n", smp_processor_id());
 			printk (KERN_EMERG "Bank %d: %08x%08x\n", i, high, low);
 
 			/* Scrub the error so we don't pick it up in MCE_RATE seconds time. */
diff -ur 2.5.63a/drivers/char/ser_a2232.c 2.5.63b/drivers/char/ser_a2232.c
--- 2.5.63a/drivers/char/ser_a2232.c	Mon Feb 24 11:05:14 2003
+++ 2.5.63b/drivers/char/ser_a2232.c	Mon Feb 24 18:14:21 2003
@@ -590,7 +590,7 @@
 									printk("A2232: 65EC02 software sent SYNC event, don't know what to do. Ignoring.");
 									break;
 								default:
-									printk("A2232: 65EC02 software broken, unknown event type %d occured.\n",ibuf[bufpos-1]);
+									printk("A2232: 65EC02 software broken, unknown event type %d occurred.\n",ibuf[bufpos-1]);
 								} /* event type switch */
 								break;
  							case A2232INCTL_CHAR:
@@ -599,7 +599,7 @@
 								bufpos++;
 								break;
  							default:
-								printk("A2232: 65EC02 software broken, unknown data type %d occured.\n",cbuf[bufpos]);
+								printk("A2232: 65EC02 software broken, unknown data type %d occurred.\n",cbuf[bufpos]);
 								bufpos++;
 							} /* switch on input data type */
 						} /* while there's something in the buffer */
diff -ur 2.5.63a/drivers/char/synclink.c 2.5.63b/drivers/char/synclink.c
--- 2.5.63a/drivers/char/synclink.c	Mon Feb 24 11:05:15 2003
+++ 2.5.63b/drivers/char/synclink.c	Mon Feb 24 18:14:23 2003
@@ -7621,7 +7621,7 @@
 		status = info->rx_buffer_list[0].status;
 
 		if ( status & (BIT8 + BIT3 + BIT1) ) {
-			/* receive error has occured */
+			/* receive error has occurred */
 			rc = FALSE;
 		} else {
 			if ( memcmp( info->tx_buffer_list[0].virt_addr ,
diff -ur 2.5.63a/drivers/hotplug/acpiphp_glue.c 2.5.63b/drivers/hotplug/acpiphp_glue.c
--- 2.5.63a/drivers/hotplug/acpiphp_glue.c	Mon Feb 24 11:05:15 2003
+++ 2.5.63b/drivers/hotplug/acpiphp_glue.c	Mon Feb 24 18:14:26 2003
@@ -1357,7 +1357,7 @@
 			if (sta != ACPI_STA_ALL) {
 				retval = acpiphp_disable_slot(slot);
 				if (retval) {
-					err("Error occured in enabling\n");
+					err("Error occurred in enabling\n");
 					up(&slot->crit_sect);
 					goto err_exit;
 				}
@@ -1368,7 +1368,7 @@
 			if (sta == ACPI_STA_ALL) {
 				retval = acpiphp_enable_slot(slot);
 				if (retval) {
-					err("Error occured in enabling\n");
+					err("Error occurred in enabling\n");
 					up(&slot->crit_sect);
 					goto err_exit;
 				}
diff -ur 2.5.63a/drivers/hotplug/ibmphp_core.c 2.5.63b/drivers/hotplug/ibmphp_core.c
--- 2.5.63a/drivers/hotplug/ibmphp_core.c	Mon Feb 24 11:06:03 2003
+++ 2.5.63b/drivers/hotplug/ibmphp_core.c	Mon Feb 24 18:14:32 2003
@@ -1343,12 +1343,12 @@
 		}
 		/* Check to see the error of why it failed */
 		if ((SLOT_POWER (slot_cur->status)) && !(SLOT_PWRGD (slot_cur->status)))
-			err ("power fault occured trying to power up \n");
+			err ("power fault occurred trying to power up \n");
 		else if (SLOT_BUS_SPEED (slot_cur->status)) {
-			err ("bus speed mismatch occured.  please check current bus speed and card capability \n");
+			err ("bus speed mismatch occurred.  please check current bus speed and card capability \n");
 			print_card_capability (slot_cur);
 		} else if (SLOT_BUS_MODE (slot_cur->ext_status)) {
-			err ("bus mode mismatch occured.  please check current bus mode and card capability \n");
+			err ("bus mode mismatch occurred.  please check current bus mode and card capability \n");
 			print_card_capability (slot_cur);
 		}
 		ibmphp_update_slot_info (slot_cur);
@@ -1376,10 +1376,10 @@
 	
 	if (SLOT_POWER (slot_cur->status) && !(SLOT_PWRGD (slot_cur->status))) {
 		faulted = 1;
-		err ("power fault occured trying to power up... \n");
+		err ("power fault occurred trying to power up... \n");
 	} else if (SLOT_POWER (slot_cur->status) && (SLOT_BUS_SPEED (slot_cur->status))) {
 		faulted = 1;
-		err ("bus speed mismatch occured.  please check current bus speed and card capability \n");
+		err ("bus speed mismatch occurred.  please check current bus speed and card capability \n");
 		print_card_capability (slot_cur);
 	} 
 	/* Don't think this case will happen after above checks... but just in case, for paranoia sake */
diff -ur 2.5.63a/drivers/ide/arm/icside.c 2.5.63b/drivers/ide/arm/icside.c
--- 2.5.63a/drivers/ide/arm/icside.c	Mon Feb 24 11:05:32 2003
+++ 2.5.63b/drivers/ide/arm/icside.c	Mon Feb 24 18:14:34 2003
@@ -731,7 +731,7 @@
 
 static int icside_dma_timeout(ide_drive_t *drive)
 {
-	printk(KERN_ERR "%s: DMA timeout occured: ", drive->name);
+	printk(KERN_ERR "%s: DMA timeout occurred: ", drive->name);
 
 	if (icside_dma_test_irq(drive))
 		return 0;
diff -ur 2.5.63a/drivers/ide/ppc/pmac.c 2.5.63b/drivers/ide/ppc/pmac.c
--- 2.5.63a/drivers/ide/ppc/pmac.c	Mon Feb 24 11:05:07 2003
+++ 2.5.63b/drivers/ide/ppc/pmac.c	Mon Feb 24 18:14:36 2003
@@ -1400,7 +1400,7 @@
 	 * to system memory when the disk interrupt occurs.
 	 * 
 	 * The trick here is to increment drive->waiting_for_dma,
-	 * and return as if no interrupt occured. If the counter
+	 * and return as if no interrupt occurred. If the counter
 	 * reach a certain timeout value, we then return 1. If
 	 * we really got the interrupt, it will happen right away
 	 * again.
diff -ur 2.5.63a/drivers/ieee1394/ohci1394.c 2.5.63b/drivers/ieee1394/ohci1394.c
--- 2.5.63a/drivers/ieee1394/ohci1394.c	Mon Feb 24 11:05:41 2003
+++ 2.5.63b/drivers/ieee1394/ohci1394.c	Mon Feb 24 18:14:38 2003
@@ -2366,7 +2366,7 @@
 			if (!(node_id & 0x80000000)) {
 				PRINT(KERN_ERR, ohci->id,
 				      "SelfID received, but NodeID invalid "
-				      "(probably new bus reset occured): %08X",
+				      "(probably new bus reset occurred): %08X",
 				      node_id);
 				goto selfid_not_valid;
 			}
diff -ur 2.5.63a/drivers/ieee1394/ohci1394.h 2.5.63b/drivers/ieee1394/ohci1394.h
--- 2.5.63a/drivers/ieee1394/ohci1394.h	Mon Feb 24 11:05:09 2003
+++ 2.5.63b/drivers/ieee1394/ohci1394.h	Mon Feb 24 18:14:42 2003
@@ -405,12 +405,12 @@
 					   truncated */
 #define EVT_OVERRUN		0x5	/* A recv FIFO overflowed on reception of ISO
 					   packet */
-#define EVT_DESCRIPTOR_READ	0x6	/* An unrecoverable error occured while host was
+#define EVT_DESCRIPTOR_READ	0x6	/* An unrecoverable error occurred while host was
 					   reading a descriptor block */
-#define EVT_DATA_READ		0x7	/* An error occured while host controller was
+#define EVT_DATA_READ		0x7	/* An error occurred while host controller was
 					   attempting to read from host memory in the data
 					   stage of descriptor processing */
-#define EVT_DATA_WRITE		0x8	/* An error occured while host controller was
+#define EVT_DATA_WRITE		0x8	/* An error occurred while host controller was
 					   attempting to write either during the data stage
 					   of descriptor processing, or when processing a single
 					   16-bit host memory write */
diff -ur 2.5.63a/drivers/ieee1394/raw1394.c 2.5.63b/drivers/ieee1394/raw1394.c
--- 2.5.63a/drivers/ieee1394/raw1394.c	Mon Feb 24 11:05:05 2003
+++ 2.5.63b/drivers/ieee1394/raw1394.c	Mon Feb 24 18:14:44 2003
@@ -2440,7 +2440,7 @@
         spin_unlock_irq(&host_info_lock);
         if (fail > 0) {
                 printk(KERN_ERR "raw1394: during addr_list-release "
-                        "error(s) occured \n");
+                        "error(s) occurred \n");
         }
 
         while (!done) {
diff -ur 2.5.63a/drivers/media/dvb/av7110/saa7146.c 2.5.63b/drivers/media/dvb/av7110/saa7146.c
--- 2.5.63a/drivers/media/dvb/av7110/saa7146.c	Mon Feb 24 11:05:10 2003
+++ 2.5.63b/drivers/media/dvb/av7110/saa7146.c	Mon Feb 24 18:14:48 2003
@@ -1396,7 +1396,7 @@
 		saa7146_write(saa->mem, MC2, (MASK_00 | MASK_16));
 	}
 
-	/* if any error is still present, a fatal error has occured ... */
+	/* if any error is still present, a fatal error has occurred ... */
 	if ( SAA7146_I2C_BBR != (status = i2c_status_check(saa)) ) {
 		hprintk("saa7146: i2c_reset: fatal error, status:0x%08x\n",status);
 		return -EIO;
@@ -1444,7 +1444,7 @@
 
 	/* check for some other mysterious error; we don't handle this here */
 	if ( 0 != ( status & 0xff)) {
-		hprintk("saa7146: i2c_write_out: some error has occured\n");
+		hprintk("saa7146: i2c_write_out: some error has occurred\n");
         	return -EIO;
   	}
 	
@@ -1570,7 +1570,7 @@
 		/* check, if DEBI still active */
 		u32 psr = saa7146_read(saa->mem, PSR);
 		if (0 !=  (psr & SPCI_DEBI_S)) {
-			/* check, if error occured */
+			/* check, if error occurred */
 /*			if ( 0 != (saa7146_read(saa->mem, SSR) & (MASK_23|MASK_22))) { */
 			if ( 0 != (saa7146_read(saa->mem, SSR) & (MASK_22))) {
 				/* clear error status and indicate error */
diff -ur 2.5.63a/drivers/media/dvb/av7110/saa7146_core.c 2.5.63b/drivers/media/dvb/av7110/saa7146_core.c
--- 2.5.63a/drivers/media/dvb/av7110/saa7146_core.c	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/drivers/media/dvb/av7110/saa7146_core.c	Mon Feb 24 18:14:50 2003
@@ -222,7 +222,7 @@
 		 * we do not start the whole rps1-engine...
 		 */
 
-			/* if address-error occured, don't retry */
+			/* if address-error occurred, don't retry */
 		if (i2c_write_out(a, &a->i2c[i], SAA7146_I2C_TIMEOUT) < 0) {
 			hprintk (KERN_ERR "saa7146_core.o: "
 				"i2c error in address phase\n");
diff -ur 2.5.63a/drivers/message/fusion/mptscsih.c 2.5.63b/drivers/message/fusion/mptscsih.c
--- 2.5.63a/drivers/message/fusion/mptscsih.c	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/drivers/message/fusion/mptscsih.c	Mon Feb 24 18:14:52 2003
@@ -116,7 +116,7 @@
 #define MPT_ICFLAG_ECHO		0x02	/* ReadBuffer Echo buffer format */
 #define MPT_ICFLAG_PHYS_DISK	0x04	/* Any SCSI IO but do Phys Disk Format */
 #define MPT_ICFLAG_TAGGED_CMD	0x08	/* Do tagged IO */
-#define MPT_ICFLAG_DID_RESET	0x20	/* Bus Reset occured with this command */
+#define MPT_ICFLAG_DID_RESET	0x20	/* Bus Reset occurred with this command */
 #define MPT_ICFLAG_RESERVED	0x40	/* Reserved has been issued */
 
 typedef struct _internal_cmd {
diff -ur 2.5.63a/drivers/mtd/devices/blkmtd.c 2.5.63b/drivers/mtd/devices/blkmtd.c
--- 2.5.63a/drivers/mtd/devices/blkmtd.c	Mon Feb 24 11:05:05 2003
+++ 2.5.63b/drivers/mtd/devices/blkmtd.c	Mon Feb 24 18:14:54 2003
@@ -394,7 +394,7 @@
 	err = brw_kiovec(WRITE, 1, &iobuf, item->rawdevice->binding, blocks, item->rawdevice->sector_size);
 	DEBUG(3, "bklmtd: write_task: done, err = %d\n", err);
 	if(err != (cursectors << item->rawdevice->sector_bits)) {
-	  /* if an error occured - set this to exit the loop */
+	  /* if an error occurred - set this to exit the loop */
 	  sectorcnt = 0;
 	} else {
 	  sectorcnt -= cursectors;
diff -ur 2.5.63a/drivers/net/e100/e100_eeprom.c 2.5.63b/drivers/net/e100/e100_eeprom.c
--- 2.5.63a/drivers/net/e100/e100_eeprom.c	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/drivers/net/e100/e100_eeprom.c	Mon Feb 24 18:14:56 2003
@@ -138,7 +138,7 @@
 //              is then passed to the read/write functions.
 //
 // Returns:
-//      Size of the eeprom, or zero if an error occured
+//      Size of the eeprom, or zero if an error occurred
 //----------------------------------------------------------------------------------------
 u16
 e100_eeprom_size(struct e100_private *adapter)
diff -ur 2.5.63a/drivers/net/sb1250-mac.c 2.5.63b/drivers/net/sb1250-mac.c
--- 2.5.63a/drivers/net/sb1250-mac.c	Mon Feb 24 11:05:44 2003
+++ 2.5.63b/drivers/net/sb1250-mac.c	Mon Feb 24 18:14:59 2003
@@ -512,7 +512,7 @@
  *  	   regidx = index of register to read
  *  	   
  *  Return value:
- *  	   value read, or 0 if an error occured.
+ *  	   value read, or 0 if an error occurred.
  ********************************************************************* */
 
 static unsigned int sbmac_mii_read(struct sbmac_softc *s,int phyaddr,int regidx)
@@ -554,7 +554,7 @@
 	SBMAC_WRITECSR(s->sbm_mdio,M_MAC_MDIO_DIR_INPUT);
 	
 	/* 
-	 * If an error occured, the PHY will signal '1' back
+	 * If an error occurred, the PHY will signal '1' back
 	 */
 	error = SBMAC_READCSR(s->sbm_mdio) & M_MAC_MDIO_IN;
 	
diff -ur 2.5.63a/drivers/net/sk98lin/h/lm80.h 2.5.63b/drivers/net/sk98lin/h/lm80.h
--- 2.5.63a/drivers/net/sk98lin/h/lm80.h	Mon Feb 24 11:05:43 2003
+++ 2.5.63b/drivers/net/sk98lin/h/lm80.h	Mon Feb 24 18:15:02 2003
@@ -126,7 +126,7 @@
 #define LM80_IS_BTI		(1<<1)	/* state of BTI# pin */
 #define LM80_IS_FAN1		(1<<2)	/* count limit exceeded for Fan 1 */
 #define LM80_IS_FAN2		(1<<3)	/* count limit exceeded for Fan 2 */
-#define LM80_IS_CI		(1<<4)	/* Chassis Intrusion occured */
+#define LM80_IS_CI		(1<<4)	/* Chassis Intrusion occurred */
 #define LM80_IS_OS		(1<<5)	/* OS temperature limit exceeded */
 	/* bit 6 and 7 are reserved in LM80_ISRC_2 */
 #define LM80_IS_HT_IRQ_MD	(1<<6)	/* Hot temperature interrupt mode */
diff -ur 2.5.63a/drivers/net/sk98lin/h/xmac_ii.h 2.5.63b/drivers/net/sk98lin/h/xmac_ii.h
--- 2.5.63a/drivers/net/sk98lin/h/xmac_ii.h	Mon Feb 24 11:05:41 2003
+++ 2.5.63b/drivers/net/sk98lin/h/xmac_ii.h	Mon Feb 24 18:16:10 2003
@@ -413,7 +413,7 @@
 #define XM_ST_BC		(1L<<7)		/* Bit	7:	Broadcast packet */
 #define XM_ST_MC		(1L<<6)		/* Bit	6:	Multicast packet */
 #define XM_ST_UC		(1L<<5)		/* Bit	5:	Unicast packet */
-#define XM_ST_TX_UR		(1L<<4)		/* Bit	4:	FIFO Underrun occured */
+#define XM_ST_TX_UR		(1L<<4)		/* Bit	4:	FIFO Underrun occurred */
 #define XM_ST_CS_ERR	(1L<<3)		/* Bit	3:	Carrier Sense Error */
 #define XM_ST_LAT_COL	(1L<<2)		/* Bit	2:	Late Collision Error */
 #define XM_ST_MUL_COL	(1L<<1)		/* Bit	1:	Multiple Collisions */
diff -ur 2.5.63a/drivers/net/sk98lin/skgepnmi.c 2.5.63b/drivers/net/sk98lin/skgepnmi.c
--- 2.5.63a/drivers/net/sk98lin/skgepnmi.c	Mon Feb 24 11:05:38 2003
+++ 2.5.63b/drivers/net/sk98lin/skgepnmi.c	Mon Feb 24 18:16:28 2003
@@ -1639,7 +1639,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to take
  *	                         the data.
  *	SK_PNMI_ERR_UNKNOWN_OID  The requested OID is unknown
@@ -1678,7 +1678,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -1722,7 +1722,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -1766,7 +1766,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to take
  *	                         the data.
  *	SK_PNMI_ERR_UNKNOWN_NET  The requested NetIndex doesn't exist 
@@ -1944,7 +1944,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -1983,7 +1983,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -2934,7 +2934,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -3002,7 +3002,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -3137,7 +3137,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -3280,7 +3280,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -3427,7 +3427,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -3639,7 +3639,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -3758,7 +3758,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -4003,7 +4003,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -4482,7 +4482,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -5189,7 +5189,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -5498,7 +5498,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -5698,7 +5698,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -6362,7 +6362,7 @@
  *
  * Returns:
  *	SK_PNMI_ERR_OK           The request was successfully performed.
- *	SK_PNMI_ERR_GENERAL      A general severe internal error occured.
+ *	SK_PNMI_ERR_GENERAL      A general severe internal error occurred.
  *	SK_PNMI_ERR_TOO_SHORT    The passed buffer is too short to contain
  *	                         the correct data (e.g. a 32bit value is
  *	                         needed, but a 16 bit value was passed).
@@ -7364,7 +7364,7 @@
  *
  * Description:
  *	The trap buffer stores various events. A user application somehow
- *	gets notified that an event occured and retrieves the trap buffer
+ *	gets notified that an event occurred and retrieves the trap buffer
  *	contens (or simply polls the buffer). The buffer is organized as
  *	a ring which stores the newest traps at the beginning. The oldest
  *	traps are overwritten by the newest ones. Each trap entry has a
diff -ur 2.5.63a/drivers/net/sk98lin/skgesirq.c 2.5.63b/drivers/net/sk98lin/skgesirq.c
--- 2.5.63a/drivers/net/sk98lin/skgesirq.c	Mon Feb 24 11:05:04 2003
+++ 2.5.63b/drivers/net/sk98lin/skgesirq.c	Mon Feb 24 18:16:37 2003
@@ -736,14 +736,14 @@
 	/* Check whether XMACs are correctly initialized */
 	if ((Istatus & (IS_PA_TO_RX1 | IS_PA_TO_TX1)) &&
 		!pAC->GIni.GP[MAC_1].PState) {
-		/* XMAC was not initialized but Packet timeout occured */
+		/* XMAC was not initialized but Packet timeout occurred */
 		SK_ERR_LOG(pAC, SK_ERRCL_SW | SK_ERRCL_INIT, SKERR_SIRQ_E004,
 			SKERR_SIRQ_E004MSG);
 	}
 
 	if ((Istatus & (IS_PA_TO_RX2 | IS_PA_TO_TX2)) &&
 	    !pAC->GIni.GP[MAC_2].PState) {
-		/* XMAC was not initialized but Packet timeout occured */
+		/* XMAC was not initialized but Packet timeout occurred */
 		SK_ERR_LOG(pAC, SK_ERRCL_SW | SK_ERRCL_INIT, SKERR_SIRQ_E005,
 			SKERR_SIRQ_E005MSG);
 	}
@@ -1111,7 +1111,7 @@
 			 * otherwise the Linux driver will have a problem.
 			 */
 			/*
-			 * We received a bunch of frames or no CRC error occured on the
+			 * We received a bunch of frames or no CRC error occurred on the
 			 * network -> ok.
 			 */
 			pPrt->PPrevRx = RxCts;
@@ -1379,7 +1379,7 @@
 			pPrt->PAutoNegTOCt ++;
 
 			/*
-			 * Timeout occured.
+			 * Timeout occurred.
 			 * What do we need now?
 			 */
 			SK_DBG_MSG(pAC,SK_DBGMOD_HWM,
@@ -1389,7 +1389,7 @@
 			if (pPrt->PLinkModeConf == SK_LMODE_AUTOSENSE &&
 				pPrt->PLipaAutoNeg != SK_LIPA_AUTO) {
 				/*
-				 * Timeout occured
+				 * Timeout occurred
 				 * Set Link manually up.
 				 */
 				SkHWSenseSetNext(pAC, IoC, Port, SK_LMODE_FULL);
@@ -1872,7 +1872,7 @@
 		pPrt->PAutoNegTimeOut ++;
 		if (pPrt->PAutoNegTimeOut >= SK_AND_MAX_TO) {
 			/*
-			 * Timeout occured.
+			 * Timeout occurred.
 			 * What do we need now?
 			 */
 			SK_DBG_MSG(pAC,SK_DBGMOD_HWM,
@@ -1882,7 +1882,7 @@
 			if (pPrt->PLinkModeConf == SK_LMODE_AUTOSENSE &&
 				pPrt->PLipaAutoNeg != SK_LIPA_AUTO) {
 				/*
-				 * Timeout occured
+				 * Timeout occurred
 				 * Set Link manually up.
 				 */
 				SkHWSenseSetNext(pAC, IoC, Port,
diff -ur 2.5.63a/drivers/net/sk98lin/skqueue.c 2.5.63b/drivers/net/sk98lin/skqueue.c
--- 2.5.63a/drivers/net/sk98lin/skqueue.c	Mon Feb 24 11:05:12 2003
+++ 2.5.63b/drivers/net/sk98lin/skqueue.c	Mon Feb 24 18:16:39 2003
@@ -153,7 +153,7 @@
  *		send command to state machine
  *	end
  *	return error reported by individual Event function
- *		0 if no error occured.
+ *		0 if no error occurred.
  */
 int	SkEventDispatcher(
 SK_AC	*pAC,	/* Adapters Context */
diff -ur 2.5.63a/drivers/net/tulip/interrupt.c 2.5.63b/drivers/net/tulip/interrupt.c
--- 2.5.63a/drivers/net/tulip/interrupt.c	Mon Feb 24 11:05:13 2003
+++ 2.5.63b/drivers/net/tulip/interrupt.c	Mon Feb 24 18:16:42 2003
@@ -487,7 +487,7 @@
 				 * to the 21142/3 docs that is).
 				 *   -- rmk
 				 */
-				printk(KERN_ERR "%s: (%lu) System Error occured (%d)\n",
+				printk(KERN_ERR "%s: (%lu) System Error occurred (%d)\n",
 					dev->name, tp->nir, error);
 			}
 			/* Clear all error sources, included undocumented ones! */
diff -ur 2.5.63a/drivers/net/wan/sbni.c 2.5.63b/drivers/net/wan/sbni.c
--- 2.5.63a/drivers/net/wan/sbni.c	Mon Feb 24 11:05:15 2003
+++ 2.5.63b/drivers/net/wan/sbni.c	Mon Feb 24 18:16:44 2003
@@ -684,7 +684,7 @@
 
 		/*
 		 * if CRC is right but framelen incorrect then transmitter
-		 * error was occured... drop entire packet
+		 * error was occurred... drop entire packet
 		 */
 		else if( (frame_ok = skip_tail( dev->base_addr, framelen, crc ))
 			 != 0 )
diff -ur 2.5.63a/drivers/net/wan/sdla_fr.c 2.5.63b/drivers/net/wan/sdla_fr.c
--- 2.5.63a/drivers/net/wan/sdla_fr.c	Mon Feb 24 11:06:01 2003
+++ 2.5.63b/drivers/net/wan/sdla_fr.c	Mon Feb 24 18:16:46 2003
@@ -2071,7 +2071,7 @@
 			++card->statistics.isr_intr_test;
 	    		break;	
 
-                case FR_INTR_DLC: /* Event interrupt occured */
+                case FR_INTR_DLC: /* Event interrupt occurred */
 			mbox->cmd.command = FR_READ_STATUS;
 			mbox->cmd.length = 0;
 			err = sdla_exec(mbox) ? mbox->cmd.result : CMD_TIMEOUT;
diff -ur 2.5.63a/drivers/net/wan/sdla_ppp.c 2.5.63b/drivers/net/wan/sdla_ppp.c
--- 2.5.63a/drivers/net/wan/sdla_ppp.c	Mon Feb 24 11:05:11 2003
+++ 2.5.63b/drivers/net/wan/sdla_ppp.c	Mon Feb 24 18:16:48 2003
@@ -2004,7 +2004,7 @@
 					(unsigned long)card->u.p.txbuf, *card->u.p.txbuf_next,
 					(unsigned long)card->rxmb, *card->u.p.rxbuf_next);
 
-				/* Tell timer interrupt that PPP event occured */
+				/* Tell timer interrupt that PPP event occurred */
 				ppp_priv_area->timer_int_enabled |= TMR_INT_ENABLED_PPP_EVENT;
 				flags->imask |= PPP_INTR_TIMER;
 
diff -ur 2.5.63a/drivers/net/wan/sdla_x25.c 2.5.63b/drivers/net/wan/sdla_x25.c
--- 2.5.63a/drivers/net/wan/sdla_x25.c	Mon Feb 24 11:05:38 2003
+++ 2.5.63b/drivers/net/wan/sdla_x25.c	Mon Feb 24 18:16:57 2003
@@ -3178,7 +3178,7 @@
  *	   when clearing a call because protocol encapsulation is not 
  *	   supported.
  *	4. If an incoming call is received while a call request is 
- *	   pending (i.e. call collision has occured), the incoming call 
+ *	   pending (i.e. call collision has occurred), the incoming call 
  *	   shall be rejected and call request shall be retried.
  *====================================================================*/
 
diff -ur 2.5.63a/drivers/parport/parport_pc.c 2.5.63b/drivers/parport/parport_pc.c
--- 2.5.63a/drivers/parport/parport_pc.c	Mon Feb 24 11:05:47 2003
+++ 2.5.63b/drivers/parport/parport_pc.c	Mon Feb 24 18:17:00 2003
@@ -422,7 +422,7 @@
 			status = inb (STATUS (port));
 			if (status & 0x01) {
 				/* EPP timeout should never occur... */
-				printk (KERN_DEBUG "%s: EPP timeout occured while talking to "
+				printk (KERN_DEBUG "%s: EPP timeout occurred while talking to "
 					"w91284pic (should not have done)\n", port->name);
 				clear_epp_timeout (port);
 			}
diff -ur 2.5.63a/drivers/s390/net/iucv.h 2.5.63b/drivers/s390/net/iucv.h
--- 2.5.63a/drivers/s390/net/iucv.h	Mon Feb 24 11:06:02 2003
+++ 2.5.63b/drivers/s390/net/iucv.h	Mon Feb 24 18:17:02 2003
@@ -214,7 +214,7 @@
  *        pgm_data- application data passed to interrupt handlers 
  * Output: NA                                                     
  * Return: address of handler                                     
- *         (0) - Error occured, registration not completed.
+ *         (0) - Error occurred, registration not completed.
  * NOTE: Exact cause of failure will be recorded in syslog.                        
 */
 iucv_handle_t iucv_register_program (uchar pgmname[16],
diff -ur 2.5.63a/drivers/scsi/gdth.h 2.5.63b/drivers/scsi/gdth.h
--- 2.5.63a/drivers/scsi/gdth.h	Mon Feb 24 11:05:15 2003
+++ 2.5.63b/drivers/scsi/gdth.h	Mon Feb 24 18:17:11 2003
@@ -915,7 +915,7 @@
         unchar          ldr_no;                 /* log. drive no. */
         unchar          rw_attribs;             /* r/w attributes */
         unchar          cluster_type;           /* cluster properties */
-        unchar          media_changed;          /* Flag:MOUNT/UNMOUNT occured */
+        unchar          media_changed;          /* Flag:MOUNT/UNMOUNT occurred*/
         ulong32         start_sec;              /* start sector */
     } hdr[MAX_LDRIVES];                         /* host drives */
     struct {
diff -ur 2.5.63a/drivers/scsi/ips.c 2.5.63b/drivers/scsi/ips.c
--- 2.5.63a/drivers/scsi/ips.c	Mon Feb 24 11:05:05 2003
+++ 2.5.63b/drivers/scsi/ips.c	Mon Feb 24 18:17:21 2003
@@ -1801,7 +1801,7 @@
 /*                                                                          */
 /* Routine Description:                                                     */
 /*   Fill in a single scb sg_list element from an address                   */
-/*   return a -1 if a breakup occured                                       */
+/*   return a -1 if a breakup occurred                                      */
 /****************************************************************************/
 static inline int ips_fill_scb_sg_single(ips_ha_t *ha, dma_addr_t busaddr,
                             ips_scb_t *scb, int indx, unsigned int e_len)
diff -ur 2.5.63a/drivers/scsi/nsp32.c 2.5.63b/drivers/scsi/nsp32.c
--- 2.5.63a/drivers/scsi/nsp32.c	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/drivers/scsi/nsp32.c	Mon Feb 24 18:18:04 2003
@@ -939,7 +939,7 @@
 	/*
 	 * If reselected New ID:LUN is not existed
 	 * or current nexus is not existed, unexpected
-	 * reselection is occured. Send reject message.
+	 * reselection is occurred. Send reject message.
 	 */
 	if (newid >= MAX_TARGET || newlun >= MAX_LUN) {
 		nsp32_msg(KERN_WARNING, "unknown id/lun");
@@ -1333,7 +1333,7 @@
 
 	/*
 	 * AutoSCSI Interrupt.
-	 * Note: This interrupt is occured when AutoSCSI is finished.  Then
+	 * Note: This interrupt is occurred when AutoSCSI is finished.  Then
 	 * check SCSIEXECUTEPHASE, and do appropriate action.  Each phases are
 	 * recorded when AutoSCSI sequencer has been processed.
 	 */
@@ -1345,7 +1345,7 @@
 		/* Selection Timeout, go busfree phase. */
 		if (auto_stat & SELECTION_TIMEOUT) {
 			nsp32_dbg(NSP32_DEBUG_INTR,
-				  "selection timeout occured");
+				  "selection timeout occurred");
 
 			SCpnt->result = DID_TIME_OUT << 16;
 			nsp32_scsi_done(data, SCpnt);
@@ -1357,7 +1357,7 @@
 			 * MsgOut phase was processed.
 			 * If MSG_IN_OCCUER is not set, then MsgOut phase is
 			 * completed. Thus, msgoutlen must reset.  Otherwise,
-			 * nothing to do here. If MSG_OUT_OCCUER is occured,
+			 * nothing to do here. If MSG_OUT_OCCUER is occurred,
 			 * then we will encounter the condition and check.
 			 */
 			if (!(auto_stat & MSG_IN_OCCUER) &&
@@ -1515,7 +1515,7 @@
 
 	/* PCI_IRQ */
 	if (irq_stat & IRQSTATUS_PCI_IRQ) {
-		nsp32_dbg(NSP32_DEBUG_INTR, "PCI IRQ occured");
+		nsp32_dbg(NSP32_DEBUG_INTR, "PCI IRQ occurred");
 		/* Do nothing */
 	}
 
@@ -1524,7 +1524,7 @@
 		nsp32_msg(KERN_ERR, "Received unexpected BMCNTERR IRQ! ");
 		/*
 		 * TODO: To be implemented improving bus master
-		 * transfer reliablity when BMCNTERR is occured in
+		 * transfer reliablity when BMCNTERR is occurred in
 		 * AutoSCSI phase described in specification.
 		 */
 	}
@@ -2300,7 +2300,7 @@
 		} else {
 			/*
 			 * On the contrary, if unexpected bus free is
-			 * occured, then negotiation is failed. Fall
+			 * occurred, then negotiation is failed. Fall
 			 * back to ASYNC mode.
 			 */
 			nsp32_set_async(data, data->curtarget);
@@ -2338,7 +2338,7 @@
 		return (TRUE);
 	} else {
 		/* Unexpected bus free */
-		nsp32_msg(KERN_WARNING, "unexpected bus free occured");
+		nsp32_msg(KERN_WARNING, "unexpected bus free occurred");
 
 		/* DID_ERROR? */
 		//SCpnt->result   = (DID_OK << 16) | (SCpnt->SCp.Message << 8) | (SCpnt->SCp.Status << 0);
@@ -2426,7 +2426,7 @@
 		  "enter: msgoutlen: 0x%x", data->msgoutlen);
 
 	/*
-	 * If MsgOut phase is occured without having any
+	 * If MsgOut phase is occurred without having any
 	 * message, then No_Operation is sent (SCSI-2).
 	 */
 	if (data->msgoutlen == 0) {
@@ -2614,7 +2614,7 @@
 	case COMMAND_COMPLETE:
 	case DISCONNECT:
 		/*
-		 * These messages should not be occured.
+		 * These messages should not be occurred.
 		 * They should be processed on AutoSCSI sequencer.
 		 */
 		nsp32_msg(KERN_WARNING, 
@@ -2654,7 +2654,7 @@
 
 	case SAVE_POINTERS:
 		/*
-		 * These messages should not be occured.
+		 * These messages should not be occurred.
 		 * They should be processed on AutoSCSI sequencer.
 		 */
 		nsp32_msg (KERN_WARNING, 
diff -ur 2.5.63a/drivers/scsi/sd.c 2.5.63b/drivers/scsi/sd.c
--- 2.5.63a/drivers/scsi/sd.c	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/drivers/scsi/sd.c	Mon Feb 24 18:18:07 2003
@@ -678,7 +678,7 @@
 	 */
 
 	/* An error occurred */
-	if (driver_byte(result) != 0 && 	/* An error occured */
+	if (driver_byte(result) != 0 && 	/* An error occurred */
 	    SCpnt->sense_buffer[0] == 0xF0) {	/* Sense data is valid */
 		switch (SCpnt->sense_buffer[2]) {
 		case MEDIUM_ERROR:
@@ -719,7 +719,7 @@
 
 		case RECOVERED_ERROR:
 			/*
-			 * An error occured, but it recovered.  Inform the
+			 * An error occurred, but it recovered.  Inform the
 			 * user, but make sure that it's not treated as a
 			 * hard error.
 			 */
diff -ur 2.5.63a/drivers/usb/image/microtek.c 2.5.63b/drivers/usb/image/microtek.c
--- 2.5.63a/drivers/usb/image/microtek.c	Mon Feb 24 11:06:03 2003
+++ 2.5.63b/drivers/usb/image/microtek.c	Mon Feb 24 18:18:09 2003
@@ -572,7 +572,7 @@
 			MTS_DEBUG_GOT_HERE();
 			context->srb->result = DID_ABORT<<16;
                 } else {
-		        /* A genuine error has occured */
+		        /* A genuine error has occurred */
 			MTS_DEBUG_GOT_HERE();
 
 		        context->srb->result = DID_ERROR<<16;
diff -ur 2.5.63a/drivers/usb/storage/freecom.c 2.5.63b/drivers/usb/storage/freecom.c
--- 2.5.63a/drivers/usb/storage/freecom.c	Mon Feb 24 11:06:02 2003
+++ 2.5.63b/drivers/usb/storage/freecom.c	Mon Feb 24 18:18:11 2003
@@ -240,7 +240,7 @@
 	 * may not work, but that is a condition that should never happen.
 	 */
 	while (fst->Status & FCM_STATUS_BUSY) {
-		US_DEBUGP("20 second USB/ATAPI bridge TIMEOUT occured!\n");
+		US_DEBUGP("20 second USB/ATAPI bridge TIMEOUT occurred!\n");
 		US_DEBUGP("fst->Status is %x\n", fst->Status);
 
 		/* Get the status again */
diff -ur 2.5.63a/fs/eventpoll.c 2.5.63b/fs/eventpoll.c
--- 2.5.63a/fs/eventpoll.c	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/fs/eventpoll.c	Mon Feb 24 18:18:13 2003
@@ -950,7 +950,7 @@
 	}
 	else
 	{
-		/* We have to signal that an error occured */
+		/* We have to signal that an error occurred */
 		epi->nwait = -1;
 	}
 }
diff -ur 2.5.63a/fs/nfsd/nfs4xdr.c 2.5.63b/fs/nfsd/nfs4xdr.c
--- 2.5.63a/fs/nfsd/nfs4xdr.c	Mon Feb 24 11:05:41 2003
+++ 2.5.63b/fs/nfsd/nfs4xdr.c	Mon Feb 24 18:18:15 2003
@@ -1770,7 +1770,7 @@
 	 * XXX: By default, the ->readlink() VFS op will truncate symlinks
 	 * if they would overflow the buffer.  Is this kosher in NFSv4?  If
 	 * not, one easy fix is: if ->readlink() precisely fills the buffer,
-	 * assume that truncation occured, and return NFS4ERR_RESOURCE.
+	 * assume that truncation occurred, and return NFS4ERR_RESOURCE.
 	 */
 	nfserr = nfsd_readlink(readlink->rl_rqstp, readlink->rl_fhp, page, &maxcount);
 	if (nfserr)
diff -ur 2.5.63a/fs/ntfs/layout.h 2.5.63b/fs/ntfs/layout.h
--- 2.5.63a/fs/ntfs/layout.h	Mon Feb 24 11:05:33 2003
+++ 2.5.63b/fs/ntfs/layout.h	Mon Feb 24 18:18:17 2003
@@ -152,7 +152,7 @@
  * been written to disk. The values 0 and -1 (ie. 0xffff) are not used. All
  * last u16's of each sector have to be equal to the usn (during reading) or
  * are set to it (during writing). If they are not, an incomplete multi sector
- * transfer has occured when the data was written.
+ * transfer has occurred when the data was written.
  * The maximum size for the update sequence array is fixed to:
  * 	maximum size = usa_ofs + (usa_count * 2) = 510 bytes
  * The 510 bytes comes from the fact that the last u16 in the array has to
diff -ur 2.5.63a/fs/ntfs/namei.c 2.5.63b/fs/ntfs/namei.c
--- 2.5.63a/fs/ntfs/namei.c	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/fs/ntfs/namei.c	Mon Feb 24 18:18:19 2003
@@ -233,7 +233,7 @@
 	m = NULL;
 	ctx = NULL;
 
-	/* Check if a conversion error occured. */
+	/* Check if a conversion error occurred. */
 	if ((signed)nls_name.len < 0) {
 		err = (signed)nls_name.len;
 		goto err_out;
diff -ur 2.5.63a/fs/quota_v2.c 2.5.63b/fs/quota_v2.c
--- 2.5.63a/fs/quota_v2.c	Mon Feb 24 11:05:40 2003
+++ 2.5.63b/fs/quota_v2.c	Mon Feb 24 18:18:22 2003
@@ -415,7 +415,7 @@
 
 	if (!dquot->dq_off)
 		if ((ret = dq_insert_tree(dquot)) < 0) {
-			printk(KERN_ERR "VFS: Error %Zd occured while creating quota.\n", ret);
+			printk(KERN_ERR "VFS: Error %Zd occurred while creating quota.\n", ret);
 			return ret;
 		}
 	filp = sb_dqopt(dquot->dq_sb)->files[type];
diff -ur 2.5.63a/fs/xfs/xfs_mount.c 2.5.63b/fs/xfs/xfs_mount.c
--- 2.5.63a/fs/xfs/xfs_mount.c	Mon Feb 24 11:05:15 2003
+++ 2.5.63b/fs/xfs/xfs_mount.c	Mon Feb 24 18:18:24 2003
@@ -1023,7 +1023,7 @@
 			/*
 			 * If the xfs quota code isn't installed,
 			 * we have to reset the quotachk'd bit.
-			 * If an error occured, qm_mount_quotas code
+			 * If an error occurred, qm_mount_quotas code
 			 * has already disabled quotas. So, just finish
 			 * mounting, and get on with the boring life
 			 * without disk quotas.
diff -ur 2.5.63a/include/asm-ia64/sn/pci/pcibr_private.h 2.5.63b/include/asm-ia64/sn/pci/pcibr_private.h
--- 2.5.63a/include/asm-ia64/sn/pci/pcibr_private.h	Mon Feb 24 11:05:04 2003
+++ 2.5.63b/include/asm-ia64/sn/pci/pcibr_private.h	Mon Feb 24 18:18:26 2003
@@ -578,7 +578,7 @@
 #ifdef LATER
 	toid_t                  bserr_toutid;	/* Timeout started by errintr */
 #endif	/* LATER */
-	iopaddr_t               bserr_addr;	/* Address where error occured */
+	iopaddr_t               bserr_addr;	/* Address where error occurred */
 	uint64_t		bserr_intstat;	/* interrupts active at error dump */
     } bs_errinfo;
 
diff -ur 2.5.63a/include/asm-ia64/sn/sn2/shub_mmr.h 2.5.63b/include/asm-ia64/sn/sn2/shub_mmr.h
--- 2.5.63a/include/asm-ia64/sn/sn2/shub_mmr.h	Mon Feb 24 11:05:38 2003
+++ 2.5.63b/include/asm-ia64/sn/sn2/shub_mmr.h	Mon Feb 24 18:18:42 2003
@@ -2720,7 +2720,7 @@
 #define SH_NI0_LLP_ERR_RETRY_COUNT_MASK          0x0000000000ff0000
 
 /*   SH_NI0_LLP_ERR_RETRY_TIMEOUT                                       */
-/*   Description:  Indicates a retry timeout has occured                */
+/*   Description:  Indicates a retry timeout has occurred               */
 #define SH_NI0_LLP_ERR_RETRY_TIMEOUT_SHFT        24
 #define SH_NI0_LLP_ERR_RETRY_TIMEOUT_MASK        0x0000000001000000
 
@@ -3017,7 +3017,7 @@
 #define SH_NI1_LLP_ERR_RETRY_COUNT_MASK          0x0000000000ff0000
 
 /*   SH_NI1_LLP_ERR_RETRY_TIMEOUT                                       */
-/*   Description:  Indicates a retry timeout has occured                */
+/*   Description:  Indicates a retry timeout has occurred               */
 #define SH_NI1_LLP_ERR_RETRY_TIMEOUT_SHFT        24
 #define SH_NI1_LLP_ERR_RETRY_TIMEOUT_MASK        0x0000000001000000
 
@@ -26034,7 +26034,7 @@
 #define SH_PIO_WRITE_STATUS_0_INIT               0x8000000000000000
 
 /*   SH_PIO_WRITE_STATUS_0_MULTI_WRITE_ERROR                            */
-/*   Description:  More than one PIO write error occured                */
+/*   Description:  More than one PIO write error occurred               */
 #define SH_PIO_WRITE_STATUS_0_MULTI_WRITE_ERROR_SHFT 0
 #define SH_PIO_WRITE_STATUS_0_MULTI_WRITE_ERROR_MASK 0x0000000000000001
 
@@ -26073,7 +26073,7 @@
 #define SH_PIO_WRITE_STATUS_1_INIT               0x8000000000000000
 
 /*   SH_PIO_WRITE_STATUS_1_MULTI_WRITE_ERROR                            */
-/*   Description:  More than one PIO write error occured                */
+/*   Description:  More than one PIO write error occurred               */
 #define SH_PIO_WRITE_STATUS_1_MULTI_WRITE_ERROR_SHFT 0
 #define SH_PIO_WRITE_STATUS_1_MULTI_WRITE_ERROR_MASK 0x0000000000000001
 
diff -ur 2.5.63a/include/asm-m68knommu/MC68328.h 2.5.63b/include/asm-m68knommu/MC68328.h
--- 2.5.63a/include/asm-m68knommu/MC68328.h	Mon Feb 24 11:05:12 2003
+++ 2.5.63b/include/asm-m68knommu/MC68328.h	Mon Feb 24 18:18:49 2003
@@ -1237,10 +1237,10 @@
 #define RTCISR		WORD_REF(RTCISR_ADDR)
 
 #define RTCISR_SW	0x0001	/* Stopwatch timed out */
-#define RTCISR_MIN	0x0002	/* 1-minute interrupt has occured */
-#define RTCISR_ALM	0x0004	/* Alarm interrupt has occured */
-#define RTCISR_DAY	0x0008	/* 24-hour rollover interrupt has occured */
-#define RTCISR_1HZ	0x0010	/* 1Hz interrupt has occured */
+#define RTCISR_MIN	0x0002	/* 1-minute interrupt has occurred */
+#define RTCISR_ALM	0x0004	/* Alarm interrupt has occurred */
+#define RTCISR_DAY	0x0008	/* 24-hour rollover interrupt has occurred */
+#define RTCISR_1HZ	0x0010	/* 1Hz interrupt has occurred */
 
 /*
  * RTC Interrupt Enable Register
diff -ur 2.5.63a/include/asm-m68knommu/MC68EZ328.h 2.5.63b/include/asm-m68knommu/MC68EZ328.h
--- 2.5.63a/include/asm-m68knommu/MC68EZ328.h	Mon Feb 24 11:05:47 2003
+++ 2.5.63b/include/asm-m68knommu/MC68EZ328.h	Mon Feb 24 18:18:56 2003
@@ -1071,19 +1071,19 @@
 #define RTCISR		WORD_REF(RTCISR_ADDR)
 
 #define RTCISR_SW	0x0001	/* Stopwatch timed out */
-#define RTCISR_MIN	0x0002	/* 1-minute interrupt has occured */
-#define RTCISR_ALM	0x0004	/* Alarm interrupt has occured */
-#define RTCISR_DAY	0x0008	/* 24-hour rollover interrupt has occured */
-#define RTCISR_1HZ	0x0010	/* 1Hz interrupt has occured */
-#define RTCISR_HR	0x0020	/* 1-hour interrupt has occured */
-#define RTCISR_SAM0	0x0100	/*   4Hz /   4.6875Hz interrupt has occured */ 
-#define RTCISR_SAM1	0x0200	/*   8Hz /   9.3750Hz interrupt has occured */ 
-#define RTCISR_SAM2	0x0400	/*  16Hz /  18.7500Hz interrupt has occured */ 
-#define RTCISR_SAM3	0x0800	/*  32Hz /  37.5000Hz interrupt has occured */ 
-#define RTCISR_SAM4	0x1000	/*  64Hz /  75.0000Hz interrupt has occured */ 
-#define RTCISR_SAM5	0x2000	/* 128Hz / 150.0000Hz interrupt has occured */ 
-#define RTCISR_SAM6	0x4000	/* 256Hz / 300.0000Hz interrupt has occured */ 
-#define RTCISR_SAM7	0x8000	/* 512Hz / 600.0000Hz interrupt has occured */ 
+#define RTCISR_MIN	0x0002	/* 1-minute interrupt has occurred */
+#define RTCISR_ALM	0x0004	/* Alarm interrupt has occurred */
+#define RTCISR_DAY	0x0008	/* 24-hour rollover interrupt has occurred */
+#define RTCISR_1HZ	0x0010	/* 1Hz interrupt has occurred */
+#define RTCISR_HR	0x0020	/* 1-hour interrupt has occurred */
+#define RTCISR_SAM0	0x0100	/*   4Hz /   4.6875Hz interrupt has occurred */ 
+#define RTCISR_SAM1	0x0200	/*   8Hz /   9.3750Hz interrupt has occurred */ 
+#define RTCISR_SAM2	0x0400	/*  16Hz /  18.7500Hz interrupt has occurred */ 
+#define RTCISR_SAM3	0x0800	/*  32Hz /  37.5000Hz interrupt has occurred */ 
+#define RTCISR_SAM4	0x1000	/*  64Hz /  75.0000Hz interrupt has occurred */ 
+#define RTCISR_SAM5	0x2000	/* 128Hz / 150.0000Hz interrupt has occurred */ 
+#define RTCISR_SAM6	0x4000	/* 256Hz / 300.0000Hz interrupt has occurred */ 
+#define RTCISR_SAM7	0x8000	/* 512Hz / 600.0000Hz interrupt has occurred */ 
 
 /*
  * RTC Interrupt Enable Register
diff -ur 2.5.63a/include/asm-m68knommu/MC68VZ328.h 2.5.63b/include/asm-m68knommu/MC68VZ328.h
--- 2.5.63a/include/asm-m68knommu/MC68VZ328.h	Mon Feb 24 11:05:14 2003
+++ 2.5.63b/include/asm-m68knommu/MC68VZ328.h	Mon Feb 24 18:19:01 2003
@@ -1167,19 +1167,19 @@
 #define RTCISR		WORD_REF(RTCISR_ADDR)
 
 #define RTCISR_SW	0x0001	/* Stopwatch timed out */
-#define RTCISR_MIN	0x0002	/* 1-minute interrupt has occured */
-#define RTCISR_ALM	0x0004	/* Alarm interrupt has occured */
-#define RTCISR_DAY	0x0008	/* 24-hour rollover interrupt has occured */
-#define RTCISR_1HZ	0x0010	/* 1Hz interrupt has occured */
-#define RTCISR_HR	0x0020	/* 1-hour interrupt has occured */
-#define RTCISR_SAM0	0x0100	/*   4Hz /   4.6875Hz interrupt has occured */ 
-#define RTCISR_SAM1	0x0200	/*   8Hz /   9.3750Hz interrupt has occured */ 
-#define RTCISR_SAM2	0x0400	/*  16Hz /  18.7500Hz interrupt has occured */ 
-#define RTCISR_SAM3	0x0800	/*  32Hz /  37.5000Hz interrupt has occured */ 
-#define RTCISR_SAM4	0x1000	/*  64Hz /  75.0000Hz interrupt has occured */ 
-#define RTCISR_SAM5	0x2000	/* 128Hz / 150.0000Hz interrupt has occured */ 
-#define RTCISR_SAM6	0x4000	/* 256Hz / 300.0000Hz interrupt has occured */ 
-#define RTCISR_SAM7	0x8000	/* 512Hz / 600.0000Hz interrupt has occured */ 
+#define RTCISR_MIN	0x0002	/* 1-minute interrupt has occurred */
+#define RTCISR_ALM	0x0004	/* Alarm interrupt has occurred */
+#define RTCISR_DAY	0x0008	/* 24-hour rollover interrupt has occurred */
+#define RTCISR_1HZ	0x0010	/* 1Hz interrupt has occurred */
+#define RTCISR_HR	0x0020	/* 1-hour interrupt has occurred */
+#define RTCISR_SAM0	0x0100	/*   4Hz /   4.6875Hz interrupt has occurred */ 
+#define RTCISR_SAM1	0x0200	/*   8Hz /   9.3750Hz interrupt has occurred */ 
+#define RTCISR_SAM2	0x0400	/*  16Hz /  18.7500Hz interrupt has occurred */ 
+#define RTCISR_SAM3	0x0800	/*  32Hz /  37.5000Hz interrupt has occurred */ 
+#define RTCISR_SAM4	0x1000	/*  64Hz /  75.0000Hz interrupt has occurred */ 
+#define RTCISR_SAM5	0x2000	/* 128Hz / 150.0000Hz interrupt has occurred */ 
+#define RTCISR_SAM6	0x4000	/* 256Hz / 300.0000Hz interrupt has occurred */ 
+#define RTCISR_SAM7	0x8000	/* 512Hz / 600.0000Hz interrupt has occurred */ 
 
 /*
  * RTC Interrupt Enable Register
diff -ur 2.5.63a/include/asm-parisc/pdc_chassis.h 2.5.63b/include/asm-parisc/pdc_chassis.h
--- 2.5.63a/include/asm-parisc/pdc_chassis.h	Mon Feb 24 11:05:06 2003
+++ 2.5.63b/include/asm-parisc/pdc_chassis.h	Mon Feb 24 18:19:04 2003
@@ -116,7 +116,7 @@
 					 PDC_CHASSIS_LED_ATTN_OFF	| \
 					 PDC_CHASSIS_LED_FAULT_ON	| \
 					 PDC_CHASSIS_LED_VALID		)
-/* Unexpected reboot occured - Executing non-OS code */
+/* Unexpected reboot occurred - Executing non-OS code */
 #define PDC_CHASSIS_LSTATE_NONOS_UNEXP	(PDC_CHASSIS_LED_RUN_FLASH	| \
 					 PDC_CHASSIS_LED_ATTN_OFF	| \
 					 PDC_CHASSIS_LED_FAULT_FLASH	| \
diff -ur 2.5.63a/include/asm-s390/processor.h 2.5.63b/include/asm-s390/processor.h
--- 2.5.63a/include/asm-s390/processor.h	Mon Feb 24 11:05:31 2003
+++ 2.5.63b/include/asm-s390/processor.h	Mon Feb 24 18:19:06 2003
@@ -154,7 +154,7 @@
 }
  
 /*
- * Function to stop a processor until an interruption occured
+ * Function to stop a processor until an interruption occurred
  */
 static inline void enabled_wait(void)
 {
diff -ur 2.5.63a/include/asm-s390x/processor.h 2.5.63b/include/asm-s390x/processor.h
--- 2.5.63a/include/asm-s390x/processor.h	Mon Feb 24 11:05:40 2003
+++ 2.5.63b/include/asm-s390x/processor.h	Mon Feb 24 18:19:08 2003
@@ -168,7 +168,7 @@
 }
 
 /*
- * Function to stop a processor until an interruption occured
+ * Function to stop a processor until an interruption occurred
  */
 static inline void enabled_wait(void)
 {
diff -ur 2.5.63a/include/linux/sdla_x25.h 2.5.63b/include/linux/sdla_x25.h
--- 2.5.63a/include/linux/sdla_x25.h	Mon Feb 24 11:05:32 2003
+++ 2.5.63b/include/linux/sdla_x25.h	Mon Feb 24 18:19:11 2003
@@ -154,7 +154,7 @@
 #define X25RES_INVAL_CALL_ARG	0x3A	/* errorneous call arguments */
 #define X25RES_INVAL_CALL_DATA	0x3B	/* errorneous call user data */
 #define X25RES_ASYNC_PACKET	0x40	/* asynchronous packet received */
-#define X25RES_PROTO_VIOLATION	0x41	/* protocol violation occured */
+#define X25RES_PROTO_VIOLATION	0x41	/* protocol violation occurred */
 #define X25RES_PKT_TIMEOUT	0x42	/* X.25 packet time out */
 #define X25RES_PKT_RETRY_LIMIT	0x43	/* X.25 packet retry limit exceeded */
 /*----- Command-dependent results -----*/
diff -ur 2.5.63a/sound/pci/ali5451/ali5451.c 2.5.63b/sound/pci/ali5451/ali5451.c
--- 2.5.63a/sound/pci/ali5451/ali5451.c	Mon Feb 24 11:05:44 2003
+++ 2.5.63b/sound/pci/ali5451/ali5451.c	Mon Feb 24 18:19:13 2003
@@ -966,7 +966,7 @@
 
 	pchregs = &(codec->chregs);
 
-	// check if interrupt occured for channel
+	// check if interrupt occurred for channel
 	old  = pchregs->data.aint;
 	mask = ((unsigned int) 1L) << (channel & 0x1f);
 
diff -ur 2.5.63a/sound/pci/ens1370.c 2.5.63b/sound/pci/ens1370.c
--- 2.5.63a/sound/pci/ens1370.c	Mon Feb 24 11:05:40 2003
+++ 2.5.63b/sound/pci/ens1370.c	Mon Feb 24 18:19:18 2003
@@ -161,7 +161,7 @@
 #define   ES_1370_CSTAT		(1<<10)		/* CODEC is busy or register write in progress */
 #define   ES_1370_CBUSY         (1<<9)		/* CODEC is busy */
 #define   ES_1370_CWRIP		(1<<8)		/* CODEC register write in progress */
-#define   ES_1371_SYNC_ERR	(1<<8)		/* CODEC synchronization error occured */
+#define   ES_1371_SYNC_ERR	(1<<8)		/* CODEC synchronization error occurred */
 #define   ES_1371_VC(i)         (((i)>>6)&0x03)	/* voice code from CCB module */
 #define   ES_1370_VC(i)		(((i)>>5)&0x03)	/* voice code from CCB module */
 #define   ES_1371_MPWR          (1<<5)		/* power level interrupt pending */
@@ -172,8 +172,8 @@
 #define   ES_ADC		(1<<0)		/* ADC channel interrupt pending */
 #define ES_REG_UART_DATA 0x08	/* R/W: UART data register */
 #define ES_REG_UART_STATUS 0x09	/* R/O: UART status register */
-#define   ES_RXINT		(1<<7)		/* RX interrupt occured */
-#define   ES_TXINT		(1<<2)		/* TX interrupt occured */
+#define   ES_RXINT		(1<<7)		/* RX interrupt occurred */
+#define   ES_TXINT		(1<<2)		/* TX interrupt occurred */
 #define   ES_TXRDY		(1<<1)		/* transmitter ready */
 #define   ES_RXRDY		(1<<0)		/* receiver ready */
 #define ES_REG_UART_CONTROL 0x09	/* W/O: UART control register */
