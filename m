Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSLaL7e>; Tue, 31 Dec 2002 06:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSLaL7e>; Tue, 31 Dec 2002 06:59:34 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:44191 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262469AbSLaL7W>; Tue, 31 Dec 2002 06:59:22 -0500
Message-ID: <3E1188B3.E9DB59A0@wieseckel.de>
Date: Tue, 31 Dec 2002 13:08:19 +0100
From: Stefan Wieseckel <s@wieseckel.de>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.53 : fixed a few typos
References: <3E0F605E.9C124324@wieseckel.de> <1041210961.1215.24.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------13921B64ED24658BBCA4A172"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------13921B64ED24658BBCA4A172
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Can you do this versus 2.5 not 2.4 (even if you cant build/run 2.5). Non
> important fixes really want to be going into 2.5 now or they risk being
> lost again when 2.6 appears
Sure, I must have lost my head, so sorry.
The concerning patch is attached.

bye...
    Stef'
--------------13921B64ED24658BBCA4A172
Content-Type: text/plain; charset=us-ascii;
 name="typos-2.5.53.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="typos-2.5.53.diff"

--- ./linux-2.5.53/arch/ppc/boot/simple/rw4/ppc_40x.h.orig	Tue Dec 31 12:46:44 2002
+++ ./linux-2.5.53/arch/ppc/boot/simple/rw4/ppc_40x.h	Tue Dec 31 12:47:19 2002
@@ -41,9 +41,9 @@
 #define dbsr            0x3f0               /* debug status register         */
 #define dccr            0x3fa               /* data cache control reg.       */
 #define dcwr            0x3ba               /* data cache write-thru reg     */
-#define dear            0x3d5               /* data exeption address reg     */
-#define esr             0x3d4               /* execption syndrome registe    */
-#define evpr            0x3d6               /* exeption vector prefix reg    */
+#define dear            0x3d5               /* data exception address reg    */
+#define esr             0x3d4               /* exception syndrome registe    */
+#define evpr            0x3d6               /* exception vector prefix reg   */
 #define iccr            0x3fb               /* instruction cache cntrl re    */
 #define icdbdr          0x3d3               /* instr cache dbug data reg     */
 #define lrreg           0x008               /* link register                 */
--- ./linux-2.5.53/arch/ppc/iSeries/iSeries_IoMmTable.c.orig	Tue Dec 31 12:19:37 2002
+++ ./linux-2.5.53/arch/ppc/iSeries/iSeries_IoMmTable.c	Tue Dec 31 12:20:36 2002
@@ -76,8 +76,8 @@
 /*   The HvCallPci_getBarParms is used to get the size of the BAR  */
 /*   space.  It calls iSeries_IoMmTable_AllocateEntry to allocate  */
 /*   each entry.                                                   */
-/* - Loops through The Bar resourses(0 - 5) including the the ROM  */
-/*   is resource(6).                                               */
+/* - Loops through The Bar resourses(0 - 5) including the ROM is   */
+/*   resource(6).                                                  */
 /*******************************************************************/
 void iSeries_allocateDeviceBars(struct pci_dev* PciDevPtr) {
     struct resource* BarResource;
--- ./linux-2.5.53/arch/parisc/kernel/entry.S.orig	Tue Dec 31 11:18:08 2002
+++ ./linux-2.5.53/arch/parisc/kernel/entry.S	Tue Dec 31 11:18:16 2002
@@ -699,7 +699,7 @@
 	 * whatever was last stored in the task structure, which might
 	 * be inconsistant if an interrupt occured while on the gateway
 	 * page) Note that we may be "trashing" values the user put in
-	 * them, but we don't support the the user changing them.
+	 * them, but we don't support the user changing them.
 	 */
 
 	STREG   %r0,PT_SR2(%r16)
--- ./linux-2.5.53/arch/ia64/kernel/perfmon.c.orig	Tue Dec 31 11:17:11 2002
+++ ./linux-2.5.53/arch/ia64/kernel/perfmon.c	Tue Dec 31 11:17:21 2002
@@ -3308,7 +3308,7 @@
 	 * (not perfmon) by the previous task. 
 	 *
 	 * XXX: dealing with this in a lazy fashion requires modifications
-	 * to the way the the debug registers are managed. This is will done
+	 * to the way the debug registers are managed. This is will done
 	 * in the next version of perfmon.
 	 */
 	if (ctx->ctx_fl_using_dbreg) {
--- ./linux-2.5.53/arch/ia64/sn/io/sn2/pcibr/pcibr_config.c.orig	Tue Dec 31 12:22:04 2002
+++ ./linux-2.5.53/arch/ia64/sn/io/sn2/pcibr/pcibr_config.c	Tue Dec 31 12:22:15 2002
@@ -42,7 +42,7 @@
 
 #ifdef LITTLE_ENDIAN
 /*
- * on sn-ia we need to twiddle the the addresses going out
+ * on sn-ia we need to twiddle the addresses going out
  * the pci bus because we use the unswizzled synergy space
  * (the alternative is to use the swizzled synergy space
  * and byte swap the data)
--- ./linux-2.5.53/arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c.orig	Tue Dec 31 12:22:40 2002
+++ ./linux-2.5.53/arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c	Tue Dec 31 12:22:52 2002
@@ -324,7 +324,7 @@
  
  
 /*
- * Wait for the the specified rrb to have no outstanding XIO pkts
+ * Wait for the specified rrb to have no outstanding XIO pkts
  * and for all data to be drained.  Mark the rrb as no longer being 
  * valid.
  */
--- ./linux-2.5.53/arch/ia64/sn/io/sn1/pcibr.c.orig	Tue Dec 31 11:17:42 2002
+++ ./linux-2.5.53/arch/ia64/sn/io/sn1/pcibr.c	Tue Dec 31 11:17:52 2002
@@ -7239,7 +7239,7 @@
 
 #ifdef LITTLE_ENDIAN
 /*
- * on sn-ia we need to twiddle the the addresses going out
+ * on sn-ia we need to twiddle the addresses going out
  * the pci bus because we use the unswizzled synergy space
  * (the alternative is to use the swizzled synergy space
  * and byte swap the data)
--- ./linux-2.5.53/arch/v850/kernel/entry.S.orig	Tue Dec 31 12:24:07 2002
+++ ./linux-2.5.53/arch/v850/kernel/entry.S	Tue Dec 31 12:24:22 2002
@@ -510,7 +510,7 @@
 END(ret_from_trap)
 
 /* This the initial entry point for a new child thread, with an appropriate
-   stack in place that makes it look the the child is in the middle of an
+   stack in place that makes it look the child is in the middle of an
    syscall.  This function is actually `returned to' from switch_thread
    (copy_thread makes ret_from_fork the return address in each new thread's
    saved context).  */
--- ./linux-2.5.53/fs/xfs/xfs_itable.c.orig	Tue Dec 31 12:25:43 2002
+++ ./linux-2.5.53/fs/xfs/xfs_itable.c	Tue Dec 31 12:25:52 2002
@@ -699,7 +699,7 @@
 				xfs_trans_brelse(tp, agbp);
 				agbp = NULL;
 				/*
-				 * Move up the the last inode in the current
+				 * Move up the last inode in the current
 				 * chunk.  The lookup_ge will always get
 				 * us the first inode in the next chunk.
 				 */
--- ./linux-2.5.53/fs/xfs/xfs_dir_leaf.c.orig	Tue Dec 31 12:28:28 2002
+++ ./linux-2.5.53/fs/xfs/xfs_dir_leaf.c	Tue Dec 31 12:28:57 2002
@@ -2164,7 +2164,7 @@
 }
 
 /*
- * Format a dirent64 structure and copy it out the the user's buffer.
+ * Format a dirent64 structure and copy it out the user's buffer.
  */
 int
 xfs_dir_put_dirent64_direct(xfs_dir_put_args_t *pa)
@@ -2196,7 +2196,7 @@
 }
 
 /*
- * Format a dirent64 structure and copy it out the the user's buffer.
+ * Format a dirent64 structure and copy it out the user's buffer.
  */
 int
 xfs_dir_put_dirent64_uio(xfs_dir_put_args_t *pa)
--- ./linux-2.5.53/fs/jfs/jfs_dmap.c.orig	Tue Dec 31 11:14:18 2002
+++ ./linux-2.5.53/fs/jfs/jfs_dmap.c	Tue Dec 31 11:16:06 2002
@@ -1525,7 +1525,7 @@
 		if (l2nb < budmin) {
 
 			/* search the lower level dmap control pages to get
-			 * the starting block number of the the dmap that
+			 * the starting block number of the dmap that
 			 * contains or starts off the free space.
 			 */
 			if ((rc =
--- ./linux-2.5.53/fs/jfs/jfs_imap.c.orig	Tue Dec 31 11:14:24 2002
+++ ./linux-2.5.53/fs/jfs/jfs_imap.c	Tue Dec 31 11:16:20 2002
@@ -404,7 +404,7 @@
 		return EIO;
 	}
 
-	/* locate the the disk inode requested */
+	/* locate the disk inode requested */
 	dp = (struct dinode *) mp->data;
 	dp += rel_inode;
 
@@ -1426,7 +1426,7 @@
 	inum = pip->i_ino + 1;
 	ino = inum & (INOSPERIAG - 1);
 
-	/* back off the the hint if it is outside of the iag */
+	/* back off the hint if it is outside of the iag */
 	if (ino == 0)
 		inum = pip->i_ino;
 
--- ./linux-2.5.53/fs/jfs/jfs_logmgr.c.orig	Tue Dec 31 11:14:34 2002
+++ ./linux-2.5.53/fs/jfs/jfs_logmgr.c	Tue Dec 31 11:16:33 2002
@@ -1772,7 +1772,7 @@
 /*
  * NAME:	lbmRedrive
  *
- * FUNCTION:	add a log buffer to the the log redrive list
+ * FUNCTION:	add a log buffer to the log redrive list
  *
  * PARAMETER:
  *     bp	- log buffer
--- ./linux-2.5.53/fs/befs/btree.c.orig	Tue Dec 31 12:50:11 2002
+++ ./linux-2.5.53/fs/befs/btree.c	Tue Dec 31 12:50:25 2002
@@ -618,7 +618,7 @@
  * header and then rounded up to a multiple of four to get the begining
  * of the key length index" (p.88, practical filesystem design).
  *
- * Exept that rounding up to 8 works, and rounding up to 4 doesn't.
+ * Except that rounding up to 8 works, and rounding up to 4 doesn't.
  */
 static u16 *
 befs_bt_keylen_index(befs_btree_node * node)
--- ./linux-2.5.53/fs/ext2/ext2.h.orig	Tue Dec 31 12:29:14 2002
+++ ./linux-2.5.53/fs/ext2/ext2.h	Tue Dec 31 12:29:43 2002
@@ -33,7 +33,7 @@
 
 	/*
 	 * i_next_alloc_goal is the *physical* companion to i_next_alloc_block.
-	 * it the the physical block number of the block which was most-recently
+	 * it the physical block number of the block which was most-recently
 	 * allocated to this file.  This give us the goal (target) for the next
 	 * allocation when we detect linearly ascending requests.
 	 */
--- ./linux-2.5.53/drivers/acpi/namespace/nsalloc.c.orig	Tue Dec 31 11:42:36 2002
+++ ./linux-2.5.53/drivers/acpi/namespace/nsalloc.c	Tue Dec 31 11:42:43 2002
@@ -234,7 +234,7 @@
 	else {
 #ifdef ACPI_ALPHABETIC_NAMESPACE
 		/*
-		 * Walk the list whilst searching for the the correct
+		 * Walk the list whilst searching for the correct
 		 * alphabetic placement.
 		 */
 		previous_child_node = NULL;
--- ./linux-2.5.53/drivers/acpi/namespace/nsxfobj.c.orig	Tue Dec 31 12:48:38 2002
+++ ./linux-2.5.53/drivers/acpi/namespace/nsxfobj.c	Tue Dec 31 12:48:51 2002
@@ -140,7 +140,7 @@
 	*ret_handle =
 		acpi_ns_convert_entry_to_handle (acpi_ns_get_parent_node (node));
 
-	/* Return exeption if parent is null */
+	/* Return exception if parent is null */
 
 	if (!acpi_ns_get_parent_node (node)) {
 		status = AE_NULL_ENTRY;
--- ./linux-2.5.53/drivers/net/tulip/winbond-840.c.orig	Tue Dec 31 11:37:57 2002
+++ ./linux-2.5.53/drivers/net/tulip/winbond-840.c	Tue Dec 31 11:38:07 2002
@@ -1077,7 +1077,7 @@
 		np->tx_ring[entry].length |= DescEndRing;
 
 	/* Now acquire the irq spinlock.
-	 * The difficult race is the the ordering between
+	 * The difficult race is the ordering between
 	 * increasing np->cur_tx and setting DescOwn:
 	 * - if np->cur_tx is increased first the interrupt
 	 *   handler could consider the packet as transmitted
--- ./linux-2.5.53/drivers/net/tulip/xircom_cb.c.orig	Tue Dec 31 11:38:18 2002
+++ ./linux-2.5.53/drivers/net/tulip/xircom_cb.c	Tue Dec 31 11:38:30 2002
@@ -1041,7 +1041,7 @@
 
 
 /* 
-link_status() checks the the links status and will return 0 for no link, 10 for 10mbit link and 100 for.. guess what.
+link_status() checks the links status and will return 0 for no link, 10 for 10mbit link and 100 for.. guess what.
 
 Must be called in locked state with interrupts disabled
 */
--- ./linux-2.5.53/drivers/net/e100/e100_eeprom.c.orig	Tue Dec 31 11:34:45 2002
+++ ./linux-2.5.53/drivers/net/e100/e100_eeprom.c	Tue Dec 31 11:34:57 2002
@@ -518,7 +518,7 @@
 //----------------------------------------------------------------------------------------
 // Procedure:   eeprom_wait_cmd_done
 //
-// Description: This routine waits for the the EEPROM to finish its command.  
+// Description: This routine waits for the EEPROM to finish its command.  
 //                              Specifically, it waits for EEDO (data out) to go high.
 // Returns:     true - If the command finished
 //              false - If the command never finished (EEDO stayed low)
--- ./linux-2.5.53/drivers/net/e1000/e1000_hw.c.orig	Tue Dec 31 11:35:28 2002
+++ ./linux-2.5.53/drivers/net/e1000/e1000_hw.c	Tue Dec 31 11:35:45 2002
@@ -2545,8 +2545,7 @@
  * hw - Struct containing variables accessed by shared code
  *
  * Reads the first 64 16 bit words of the EEPROM and sums the values read.
- * If the the sum of the 64 16 bit words is 0xBABA, the EEPROM's checksum is
- * valid.
+ * If the sum of the 64 16 bit words is 0xBABA, the EEPROM's checksum is valid.
  *****************************************************************************/
 int32_t
 e1000_validate_eeprom_checksum(struct e1000_hw *hw)
--- ./linux-2.5.53/drivers/net/wireless/orinoco.c.orig	Tue Dec 31 11:36:52 2002
+++ ./linux-2.5.53/drivers/net/wireless/orinoco.c	Tue Dec 31 11:37:02 2002
@@ -3467,7 +3467,7 @@
 
 	TRACE_ENTER(dev->name);
 
-	/* In theory, we could allow most of the the SET stuff to be
+	/* In theory, we could allow most of the SET stuff to be
 	 * done. In practice, the lapse of time at startup when the
 	 * card is not ready is very short, so why bother...  Note
 	 * that netif_device_present is different from up/down
--- ./linux-2.5.53/drivers/net/eepro.c.orig	Tue Dec 31 11:34:09 2002
+++ ./linux-2.5.53/drivers/net/eepro.c	Tue Dec 31 11:34:20 2002
@@ -1118,7 +1118,7 @@
 	printk (KERN_ERR "%s: transmit timed out, %s?\n", dev->name,
 		"network cable problem");
 	/* This is not a duplicate. One message for the console,
-	   one for the the log file  */
+	   one for the log file  */
 	printk (KERN_DEBUG "%s: transmit timed out, %s?\n", dev->name,
 		"network cable problem");
 	eepro_complete_selreset(ioaddr);
--- ./linux-2.5.53/drivers/s390/char/sclp_rw.c.orig	Tue Dec 31 11:46:35 2002
+++ ./linux-2.5.53/drivers/s390/char/sclp_rw.c	Tue Dec 31 11:46:51 2002
@@ -25,7 +25,7 @@
 
 /*
  * The room for the SCCB (only for writing) is not equal to a pages size
- * (as it is specified as the maximum size in the the SCLP ducumentation)
+ * (as it is specified as the maximum size in the SCLP documentation)
  * because of the additional data structure described above.
  */
 #define MAX_SCCB_ROOM (PAGE_SIZE - sizeof(struct sclp_buffer))
--- ./linux-2.5.53/drivers/s390/block/dasd_3990_erp.c.orig	Tue Dec 31 12:44:45 2002
+++ ./linux-2.5.53/drivers/s390/block/dasd_3990_erp.c	Tue Dec 31 12:44:56 2002
@@ -2427,7 +2427,7 @@
  *     - exit with permanent error
  *
  * PARAMETER
- *   erp		ERP which is in progress wiht no retry left
+ *   erp		ERP which is in progress with no retry left
  *
  * RETURN VALUES
  *   erp		modified/additional ERP
--- ./linux-2.5.53/drivers/media/dvb/frontends/ves1820.c.orig	Tue Dec 31 11:44:13 2002
+++ ./linux-2.5.53/drivers/media/dvb/frontends/ves1820.c	Tue Dec 31 11:44:28 2002
@@ -1,6 +1,6 @@
 /* 
     VES1820  - Single Chip Cable Channel Receiver driver module
-               used on the the Siemens DVB-C cards
+               used on the Siemens DVB-C cards
 
     Copyright (C) 1999 Convergence Integrated Media GmbH <ralph@convergence.de>
 
--- ./linux-2.5.53/drivers/video/skeletonfb.c.orig	Tue Dec 31 11:51:06 2002
+++ ./linux-2.5.53/drivers/video/skeletonfb.c	Tue Dec 31 11:51:16 2002
@@ -14,7 +14,7 @@
  *  of it. 
  *
  *  First the roles of struct fb_info and struct display have changed. Struct
- *  display will go away. The way the the new framebuffer console code will
+ *  display will go away. The way the new framebuffer console code will
  *  work is that it will act to translate data about the tty/console in 
  *  struct vc_data to data in a device independent way in struct fb_info. Then
  *  various functions in struct fb_ops will be called to store the device 
--- ./linux-2.5.53/drivers/isdn/hardware/eicon/divasync.h.orig	Tue Dec 31 11:43:28 2002
+++ ./linux-2.5.53/drivers/isdn/hardware/eicon/divasync.h	Tue Dec 31 11:43:38 2002
@@ -211,7 +211,7 @@
 #define SERIAL_HOOK_RING 0x85
 #define SERIAL_HOOK_DETACH 0x8f
  unsigned char Flags;           /* function refinements   */
- /* parameters passed by the the ATTACH request      */
+ /* parameters passed by the ATTACH request      */
  SERIAL_INT_CB InterruptHandler; /* called on each interrupt  */
  SERIAL_DPC_CB DeferredHandler; /* called on hook state changes */
  void   *HandlerContext; /* context for both handlers */
--- ./linux-2.5.53/drivers/isdn/hisax/elsa_ser.c.orig	Tue Dec 31 12:49:27 2002
+++ ./linux-2.5.53/drivers/isdn/hisax/elsa_ser.c	Tue Dec 31 12:49:50 2002
@@ -316,7 +316,7 @@
 			       UART_LSR_FE | UART_LSR_OE)) {
 					
 #ifdef SERIAL_DEBUG_INTR
-			printk("handling exept....");
+			printk("handling except....");
 #endif
 		}
 		*status = serial_inp(cs, UART_LSR);
--- ./linux-2.5.53/drivers/usb/media/vicam.c.orig	Tue Dec 31 11:48:05 2002
+++ ./linux-2.5.53/drivers/usb/media/vicam.c	Tue Dec 31 11:48:15 2002
@@ -24,7 +24,7 @@
  *
  * Portions of this code were also copied from usbvideo.c
  *
- * Special thanks to the the whole team at Sourceforge for help making
+ * Special thanks to the whole team at Sourceforge for help making
  * this driver become a reality.  Notably:
  * Andy Armstrong who reverse engineered the color encoding and
  * Pavel Machek and Chris Cheney who worked on reverse engineering the
--- ./linux-2.5.53/drivers/usb/misc/auerswald.c.orig	Tue Dec 31 11:48:58 2002
+++ ./linux-2.5.53/drivers/usb/misc/auerswald.c	Tue Dec 31 11:49:07 2002
@@ -1348,7 +1348,7 @@
 }
 
 
-/* remove a service from the the device
+/* remove a service from the device
    scp->id must be set! */
 static void auerswald_removeservice (pauerswald_t cp, pauerscon_t scp)
 {
--- ./linux-2.5.53/drivers/usb/host/hc_sl811_rh.c.orig	Tue Dec 31 11:41:14 2002
+++ ./linux-2.5.53/drivers/usb/host/hc_sl811_rh.c	Tue Dec 31 11:41:29 2002
@@ -165,7 +165,7 @@
 /***************************************************************************
  * Function Name : rh_int_timer_do
  * 
- * This function is called when the timer expires.  It gets the the port 
+ * This function is called when the timer expires.  It gets the port 
  * change data and pass along to the upper protocol.
  * 
  * Note:  The virtual root hub interrupt pipe are polled by the timer
@@ -283,7 +283,7 @@
 /***************************************************************************
  * Function Name : rh_submit_urb
  * 
- * This function handles all USB request to the the virtual root hub
+ * This function handles all USB request to the virtual root hub
  * 
  * Input: urb = USB request block 
  *
--- ./linux-2.5.53/drivers/message/fusion/mptscsih.c.orig	Tue Dec 31 11:45:13 2002
+++ ./linux-2.5.53/drivers/message/fusion/mptscsih.c	Tue Dec 31 11:45:23 2002
@@ -1062,7 +1062,7 @@
 	 * index = chain_idx
 	 *
 	 * Calculate the number of chain buffers needed(plus 1) per I/O 
-	 * then multiply the the maximum number of simultaneous cmds
+	 * then multiply the maximum number of simultaneous cmds
 	 *
 	 * num_sge = num sge in request frame + last chain buffer
 	 * scale = num sge per chain buffer if no chain element
--- ./linux-2.5.53/include/asm-ia64/sn/alenlist.h.orig	Tue Dec 31 12:30:25 2002
+++ ./linux-2.5.53/include/asm-ia64/sn/alenlist.h	Tue Dec 31 12:30:32 2002
@@ -15,7 +15,7 @@
 
 /*
  * An Address/Length List is used when setting up for an I/O DMA operation.
- * A driver creates an Address/Length List that describes to the the DMA 
+ * A driver creates an Address/Length List that describes to the DMA 
  * interface where in memory the DMA should go.  The bus interface sets up 
  * mapping registers, if required, and returns a suitable list of "physical 
  * addresses" or "I/O address" to the driver.  The driver then uses these 
--- ./linux-2.5.53/include/linux/ext3_fs_i.h.orig	Tue Dec 31 12:31:05 2002
+++ ./linux-2.5.53/include/linux/ext3_fs_i.h	Tue Dec 31 12:31:16 2002
@@ -52,7 +52,7 @@
 
 	/*
 	 * i_next_alloc_goal is the *physical* companion to i_next_alloc_block.
-	 * it the the physical block number of the block which was most-recently
+	 * it the physical block number of the block which was most-recently
 	 * allocated to this file.  This give us the goal (target) for the next
 	 * allocation when we detect linearly ascending requests.
 	 */
--- ./linux-2.5.53/include/linux/usb.h.orig	Tue Dec 31 12:31:33 2002
+++ ./linux-2.5.53/include/linux/usb.h	Tue Dec 31 12:31:41 2002
@@ -101,7 +101,7 @@
  * Each interface may have alternate settings.  The initial configuration
  * of a device sets the first of these, but the device driver can change
  * that setting using usb_set_interface().  Alternate settings are often
- * used to control the the use of periodic endpoints, such as by having
+ * used to control the use of periodic endpoints, such as by having
  * different endpoints use different amounts of reserved USB bandwidth.
  * All standards-conformant USB devices that use isochronous endpoints
  * will use them in non-default settings.
--- ./linux-2.5.53/include/linux/security.h.orig	Tue Dec 31 12:32:02 2002
+++ ./linux-2.5.53/include/linux/security.h	Tue Dec 31 12:32:20 2002
@@ -219,7 +219,7 @@
  *	Set the security attributes on a newly created regular file.  This hook
  *	is called after a file has been successfully created.
  *	@dir contains the inode structure of the parent directory of the new file.
- *	@dentry contains the the dentry structure for the newly created file.
+ *	@dentry contains the dentry structure for the newly created file.
  *	@mode contains the file mode.
  * @inode_link:
  *	Check permission before creating a new hard link to a file.
@@ -275,7 +275,7 @@
  *	@dir contains the inode structure of parent of the new file.
  *	@dentry contains the dentry structure of the new file.
  *	@mode contains the mode of the new file.
- *	@dev contains the the device number.
+ *	@dev contains the device number.
  *	Return 0 if permission is granted.
  * @inode_post_mknod:
  *	Set security attributes on a newly created special file (or socket or
@@ -283,7 +283,7 @@
  *	@dir contains the inode structure of parent of the new node.
  *	@dentry contains the dentry structure of the new node.
  *	@mode contains the mode of the new node.
- *	@dev contains the the device number.
+ *	@dev contains the device number.
  * @inode_rename:
  *	Check for permission to rename a file or directory.
  *	@old_dir contains the inode structure for parent of the old link.
--- ./linux-2.5.53/net/ipv4/netfilter/ip_conntrack_core.c.orig	Tue Dec 31 12:35:03 2002
+++ ./linux-2.5.53/net/ipv4/netfilter/ip_conntrack_core.c	Tue Dec 31 12:35:14 2002
@@ -984,7 +984,7 @@
 			return -EPERM;
 		}
 
-		/* choose the the oldest expectation to evict */
+		/* choose the oldest expectation to evict */
 		list_for_each(cur_item, &related_to->sibling_list) { 
 			struct ip_conntrack_expect *cur;
 
--- ./linux-2.5.53/net/rxrpc/peer.c.orig	Tue Dec 31 12:35:38 2002
+++ ./linux-2.5.53/net/rxrpc/peer.c	Tue Dec 31 12:35:45 2002
@@ -328,7 +328,7 @@
 	}
 	spin_unlock(&trans->peer_gylock);
 
-	/* wait for the the peer graveyard to be completely cleared */
+	/* wait for the peer graveyard to be completely cleared */
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	add_wait_queue(&trans->peer_gy_waitq,&myself);
 
--- ./linux-2.5.53/net/rxrpc/connection.c.orig	Tue Dec 31 12:36:15 2002
+++ ./linux-2.5.53/net/rxrpc/connection.c	Tue Dec 31 12:36:22 2002
@@ -404,7 +404,7 @@
 	}
 	spin_unlock(&peer->conn_gylock);
 
-	/* wait for the the conn graveyard to be completely cleared */
+	/* wait for the conn graveyard to be completely cleared */
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	add_wait_queue(&peer->conn_gy_waitq,&myself);
 
--- ./linux-2.5.53/net/sunrpc/svcauth.c.orig	Tue Dec 31 12:36:48 2002
+++ ./linux-2.5.53/net/sunrpc/svcauth.c	Tue Dec 31 12:38:09 2002
@@ -67,7 +67,7 @@
 }
 
 /* A reqeust, which was authenticated, has now executed.
- * Time to finalise the the credentials and verifier
+ * Time to finalise the credentials and verifier
  * and release and resources
  */
 int svc_authorise(struct svc_rqst *rqstp)
--- ./linux-2.5.53/Documentation/DocBook/journal-api.tmpl.orig	Tue Dec 31 12:16:55 2002
+++ ./linux-2.5.53/Documentation/DocBook/journal-api.tmpl	Tue Dec 31 12:17:07 2002
@@ -113,7 +113,7 @@
 
 You still need to actually journal your filesystem changes, this
 is done by wrapping them into transactions. Additionally you
-also need to wrap the modification of each of the the buffers
+also need to wrap the modification of each of the buffers
 with calls to the journal layer, so it knows what the modifications
 you are actually making are. To do this use  journal_start() which
 returns a transaction handle.
@@ -125,7 +125,7 @@
 are nestable calls, so you can reenter a transaction if necessary,
 but remember you must call journal_stop() the same number of times as
 journal_start() before the transaction is completed (or more accurately
-leaves the the update phase). Ext3/VFS makes use of this feature to simplify 
+leaves the update phase). Ext3/VFS makes use of this feature to simplify 
 quota support.
 </para>
 
--- ./linux-2.5.53/Documentation/networking/bonding.txt.orig	Tue Dec 31 12:17:34 2002
+++ ./linux-2.5.53/Documentation/networking/bonding.txt	Tue Dec 31 12:17:50 2002
@@ -144,7 +144,7 @@
 are propagated during the enslave process.
 
 If running SNMP agents, the bonding driver should be loaded before any network 
-drivers participating in a bond. This requirement is due to the the interface 
+drivers participating in a bond. This requirement is due to the interface 
 index (ipAdEntIfIndex) being associated to the first interface found with a 
 given IP address. That is, there is only one ipAdEntIfIndex for each IP 
 address. For example, if eth0 and eth1 are slaves of bond0 and the driver for 
--- ./linux-2.5.53/Documentation/kbuild/kconfig-language.txt.orig	Tue Dec 31 12:18:29 2002
+++ ./linux-2.5.53/Documentation/kbuild/kconfig-language.txt	Tue Dec 31 12:18:39 2002
@@ -159,7 +159,7 @@
 
 The other way to generate the menu structure is done by analyzing the
 dependencies. If a menu entry somehow depends on the previous entry, it
-can be made a submenu of it. First the the previous (parent) symbol must
+can be made a submenu of it. First the previous (parent) symbol must
 be part of the dependency list and then one of these two condititions
 must be true:
 - the child entry must become invisible, if the parent is set to 'n'
--- ./linux-2.5.53/Documentation/kbuild/makefiles.txt.orig	Tue Dec 31 12:42:51 2002
+++ ./linux-2.5.53/Documentation/kbuild/makefiles.txt	Tue Dec 31 12:43:23 2002
@@ -519,7 +519,7 @@
 
 A Makefile is only responsible for building objects in its own
 directory. Files in subdirectories should be taken care of by
-Makefiles in the these subdirs. The build system will automatically
+the Makefiles in these subdirs. The build system will automatically
 invoke make recursively in subdirectories, provided you let it know of
 them.
 
--- ./linux-2.5.53/sound/core/init.c.orig	Tue Dec 31 12:39:46 2002
+++ ./linux-2.5.53/sound/core/init.c	Tue Dec 31 12:39:53 2002
@@ -588,7 +588,7 @@
  *  This function removes the file formerly added to the card via
  *  #snd_card_file_add function.
  *  If all files are removed and the release of the card is
- *  scheduled, it will wake up the the thread to call #snd_card_free
+ *  scheduled, it will wake up the thread to call #snd_card_free
  *  (see #snd_card_free_in_thread function).
  *
  *  Returns zero or a negative error code.
--- ./linux-2.5.53/scripts/docproc.c.orig	Tue Dec 31 12:38:30 2002
+++ ./linux-2.5.53/scripts/docproc.c	Tue Dec 31 12:38:38 2002
@@ -199,7 +199,7 @@
  * Document all external or internal functions in a file.
  * Call kernel-doc with following parameters:
  * kernel-doc -docbook -nofunction function_name1 filename
- * function names are obtained from all the the src files
+ * function names are obtained from all the src files
  * by find_export_symbols.
  * intfunc uses -nofunction
  * extfunc uses -function
--- ./linux-2.5.53/mm/mmap.c.orig	Tue Dec 31 12:33:43 2002
+++ ./linux-2.5.53/mm/mmap.c	Tue Dec 31 12:33:52 2002
@@ -1059,7 +1059,7 @@
 
 /*
  * Split a vma into two pieces at address 'addr', a new vma is allocated
- * either for the first part or the the tail.
+ * either for the first part or the tail.
  */
 int split_vma(struct mm_struct * mm, struct vm_area_struct * vma,
 	      unsigned long addr, int new_below)

--------------13921B64ED24658BBCA4A172--

