Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVAaIJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVAaIJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 03:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVAaHis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:38:48 -0500
Received: from waste.org ([216.27.176.166]:3309 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261962AbVAaHgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:36:06 -0500
Date: Sun, 30 Jan 2005 23:35:58 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] s/retreiv/retriev/g
Message-ID: <20050131073558.GK2891@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As everyone knows, the rule is: "i before e.. um.. always."

Next patch: cleanup all the rieserfs misspellings.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm2/fs/reiserfs/xattr.c
===================================================================
--- mm2.orig/fs/reiserfs/xattr.c	2005-01-26 14:55:09.000000000 -0800
+++ mm2/fs/reiserfs/xattr.c	2005-01-30 22:52:59.000000000 -0800
@@ -115,8 +115,8 @@
 }
 
 /* Returns the dentry (or NULL) referring to the root of the extended
- * attribute directory tree. If it has already been retreived, it is used.
- * Otherwise, we attempt to retreive it from disk. It may also return
+ * attribute directory tree. If it has already been retrieved, it is used.
+ * Otherwise, we attempt to retrieve it from disk. It may also return
  * a pointer-encoded error.
  */
 static inline struct dentry *
Index: mm2/net/irda/iriap.c
===================================================================
--- mm2.orig/net/irda/iriap.c	2005-01-26 14:55:33.000000000 -0800
+++ mm2/net/irda/iriap.c	2005-01-30 22:52:50.000000000 -0800
@@ -364,7 +364,7 @@
 /*
  * Function iriap_getvaluebyclass (addr, name, attr)
  *
- *    Retreive all values from attribute in all objects with given class
+ *    Retrieve all values from attribute in all objects with given class
  *    name
  */
 int iriap_getvaluebyclass_request(struct iriap_cb *self,
Index: mm2/arch/ppc64/kernel/setup.c
===================================================================
--- mm2.orig/arch/ppc64/kernel/setup.c	2005-01-26 14:54:02.000000000 -0800
+++ mm2/arch/ppc64/kernel/setup.c	2005-01-30 22:52:37.000000000 -0800
@@ -408,8 +408,8 @@
 
 	/*
 	 * Do early initializations using the flattened device
-	 * tree, like retreiving the physical memory map or
-	 * calculating/retreiving the hash table size
+	 * tree, like retrieving the physical memory map or
+	 * calculating/retrieving the hash table size
 	 */
 	early_init_devtree(__va(dt_ptr));
 
@@ -594,7 +594,7 @@
 
 	/*
 	 * Fill the ppc64_caches & systemcfg structures with informations
-	 * retreived from the device-tree. Need to be called before
+	 * retrieved from the device-tree. Need to be called before
 	 * finish_device_tree() since the later requires some of the
 	 * informations filled up here to properly parse the interrupt
 	 * tree.
Index: mm2/arch/ppc64/kernel/prom.c
===================================================================
--- mm2.orig/arch/ppc64/kernel/prom.c	2005-01-30 14:21:46.000000000 -0800
+++ mm2/arch/ppc64/kernel/prom.c	2005-01-30 22:52:19.000000000 -0800
@@ -816,7 +816,7 @@
 	/* Get pointer to OF "/chosen" node for use everywhere */
 	of_chosen = of_find_node_by_path("/chosen");
 
-	/* Retreive command line */
+	/* Retrieve command line */
 	if (of_chosen != NULL) {
 		p = (char *)get_property(of_chosen, "bootargs", &l);
 		if (p != NULL && l > 0)
@@ -892,7 +892,7 @@
 		iommu_force_on = 1;
 
 #ifdef CONFIG_PPC_PSERIES
-	/* To help early debugging via the front panel, we retreive a minimal
+	/* To help early debugging via the front panel, we retrieve a minimal
 	 * set of RTAS infos now if available
 	 */
 	{
@@ -1020,7 +1020,7 @@
 	/* By default, hash size is not set */
 	ppc64_pft_size = 0;
 
-	/* Retreive various informations from the /chosen node of the
+	/* Retrieve various informations from the /chosen node of the
 	 * device-tree, including the platform type, initrd location and
 	 * size, TCE reserve, and more ...
 	 */
@@ -1041,7 +1041,7 @@
 
 	DBG("Scanning CPUs ...\n");
 
-	/* Retreive hash table size from flattened tree */
+	/* Retrieve hash table size from flattened tree */
 	scan_flat_dt(early_init_dt_scan_cpus, NULL);
 
 	/* If hash size wasn't obtained above, we calculate it now based on
Index: mm2/drivers/net/tlan.c
===================================================================
--- mm2.orig/drivers/net/tlan.c	2005-01-26 14:54:40.000000000 -0800
+++ mm2/drivers/net/tlan.c	2005-01-30 22:52:07.000000000 -0800
@@ -2852,11 +2852,11 @@
 	 *				for this device.
 	 *		phy		The address of the PHY to be queried.
 	 *		reg		The register whose contents are to be
-	 *				retreived.
+	 *				retrieved.
 	 *		val		A pointer to a variable to store the
 	 *				retrieved value.
 	 *
-	 *	This function uses the TLAN's MII bus to retreive the contents
+	 *	This function uses the TLAN's MII bus to retrieve the contents
 	 *	of a given register on a PHY.  It sends the appropriate info
 	 *	and then reads the 16-bit register value from the MII bus via
 	 *	the TLAN SIO register.
Index: mm2/drivers/usb/serial/ftdi_sio.h
===================================================================
--- mm2.orig/drivers/usb/serial/ftdi_sio.h	2005-01-30 14:22:23.000000000 -0800
+++ mm2/drivers/usb/serial/ftdi_sio.h	2005-01-30 22:51:58.000000000 -0800
@@ -613,7 +613,7 @@
  */
 
 /* FTDI_SIO_GET_MODEM_STATUS */
-/* Retreive the current value of the modem status register */
+/* Retrieve the current value of the modem status register */
 
 #define FTDI_SIO_GET_MODEM_STATUS_REQUEST_TYPE 0xc0
 #define FTDI_SIO_GET_MODEM_STATUS_REQUEST FTDI_SIO_GET_MODEM_STATUS
Index: mm2/arch/ppc64/kernel/rtas.c
===================================================================
--- mm2.orig/arch/ppc64/kernel/rtas.c	2005-01-26 14:54:02.000000000 -0800
+++ mm2/arch/ppc64/kernel/rtas.c	2005-01-30 22:51:51.000000000 -0800
@@ -562,7 +562,7 @@
 }
 
 /*
- * Call early during boot, before mem init or bootmem, to retreive the RTAS
+ * Call early during boot, before mem init or bootmem, to retrieve the RTAS
  * informations from the device-tree and allocate the RMO buffer for userland
  * accesses.
  */
Index: mm2/drivers/usb/serial/cypress_m8.c
===================================================================
--- mm2.orig/drivers/usb/serial/cypress_m8.c	2005-01-30 14:22:23.000000000 -0800
+++ mm2/drivers/usb/serial/cypress_m8.c	2005-01-30 22:51:42.000000000 -0800
@@ -234,7 +234,7 @@
  *****************************************************************************/
 
 
-/* This function can either set or retreive the current serial line settings */
+/* This function can either set or retrieve the current serial line settings */
 static int cypress_serial_control (struct usb_serial_port *port, unsigned baud_mask, int data_bits, int stop_bits,
 				   int parity_enable, int parity_type, int reset, int cypress_request_type)
 {
@@ -333,7 +333,7 @@
 			}
 		break;
 		case CYPRESS_GET_CONFIG:
-			dbg("%s - retreiving serial line settings", __FUNCTION__);
+			dbg("%s - retrieving serial line settings", __FUNCTION__);
 			/* reset values in feature buffer */
 			memset(feature_buffer, 0, 5);
 
@@ -341,7 +341,7 @@
 						  HID_REQ_GET_REPORT, USB_DIR_IN | USB_RECIP_INTERFACE | USB_TYPE_CLASS,
 						  0x0300, 0, feature_buffer, 5, 500);
 			if (retval != 5) {
-				err("%s - failed to retreive serial line settings - %d", __FUNCTION__, retval);
+				err("%s - failed to retrieve serial line settings - %d", __FUNCTION__, retval);
 				return retval;
 			} else {
 				spin_lock_irqsave(&priv->lock, flags);
Index: mm2/drivers/video/aty/radeon_base.c
===================================================================
--- mm2.orig/drivers/video/aty/radeon_base.c	2005-01-30 14:22:23.000000000 -0800
+++ mm2/drivers/video/aty/radeon_base.c	2005-01-30 22:51:24.000000000 -0800
@@ -593,7 +593,7 @@
 }
 
 /*
- * Retreive PLL infos by different means (BIOS, Open Firmware, register probing...)
+ * Retrieve PLL infos by different means (BIOS, Open Firmware, register probing...)
  */
 static void __devinit radeon_get_pllinfo(struct radeonfb_info *rinfo)
 {
@@ -659,17 +659,17 @@
 
 #ifdef CONFIG_PPC_OF
 	/*
-	 * Retreive PLL infos from Open Firmware first
+	 * Retrieve PLL infos from Open Firmware first
 	 */
        	if (!force_measure_pll && radeon_read_xtal_OF(rinfo) == 0) {
-       		printk(KERN_INFO "radeonfb: Retreived PLL infos from Open Firmware\n");
+       		printk(KERN_INFO "radeonfb: Retrieved PLL infos from Open Firmware\n");
 		goto found;
 	}
 #endif /* CONFIG_PPC_OF */
 
 	/*
 	 * Check out if we have an X86 which gave us some PLL informations
-	 * and if yes, retreive them
+	 * and if yes, retrieve them
 	 */
 	if (!force_measure_pll && rinfo->bios_seg) {
 		u16 pll_info_block = BIOS_IN16(rinfo->fp_bios_start + 0x30);
@@ -681,7 +681,7 @@
 		rinfo->pll.ppll_min	= BIOS_IN32(pll_info_block + 0x12);
 		rinfo->pll.ppll_max	= BIOS_IN32(pll_info_block + 0x16);
 
-		printk(KERN_INFO "radeonfb: Retreived PLL infos from BIOS\n");
+		printk(KERN_INFO "radeonfb: Retrieved PLL infos from BIOS\n");
 		goto found;
 	}
 
@@ -690,7 +690,7 @@
 	 * probe them
 	 */
 	if (radeon_probe_pll_params(rinfo) == 0) {
-		printk(KERN_INFO "radeonfb: Retreived PLL infos from registers\n");
+		printk(KERN_INFO "radeonfb: Retrieved PLL infos from registers\n");
 		goto found;
 	}
 
@@ -701,7 +701,7 @@
 
 found:
 	/*
-	 * Some methods fail to retreive SCLK and MCLK values, we apply default
+	 * Some methods fail to retrieve SCLK and MCLK values, we apply default
 	 * settings in this case (200Mhz). If that really happne often, we could
 	 * fetch from registers instead...
 	 */
@@ -2300,7 +2300,7 @@
 				     == CFG_ATI_REV_A11);
 
 	/*
-	 * Map the BIOS ROM if any and retreive PLL parameters from
+	 * Map the BIOS ROM if any and retrieve PLL parameters from
 	 * the BIOS. We skip that on mobility chips as the real panel
 	 * values we need aren't in the ROM but in the BIOS image in
 	 * memory. This is definitely not the best meacnism though,
Index: mm2/drivers/char/n_hdlc.c
===================================================================
--- mm2.orig/drivers/char/n_hdlc.c	2005-01-26 14:54:22.000000000 -0800
+++ mm2/drivers/char/n_hdlc.c	2005-01-30 22:50:39.000000000 -0800
@@ -563,7 +563,7 @@
 }	/* end of n_hdlc_tty_receive() */
 
 /**
- * n_hdlc_tty_read - Called to retreive one frame of data (if available)
+ * n_hdlc_tty_read - Called to retrieve one frame of data (if available)
  * @tty - pointer to tty instance data
  * @file - pointer to open file object
  * @buf - pointer to returned data buffer
Index: mm2/scripts/kconfig/util.c
===================================================================
--- mm2.orig/scripts/kconfig/util.c	2005-01-26 14:55:35.000000000 -0800
+++ mm2/scripts/kconfig/util.c	2005-01-30 22:50:19.000000000 -0800
@@ -101,7 +101,7 @@
 	va_end(ap);
 }
 
-/* Retreive value of growable string */
+/* Retrieve value of growable string */
 const char *str_get(struct gstr *gs)
 {
 	return gs->s;

-- 
Mathematics is the supreme nostalgia of our time.
