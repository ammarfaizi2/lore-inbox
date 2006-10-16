Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWJPWzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWJPWzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbWJPWzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:55:08 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:19359 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161150AbWJPWzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:55:06 -0400
Date: Tue, 17 Oct 2006 00:50:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: akpm@osdl.org
cc: Matt LaPlante <kernel1@cyberdogtech.com>,
       Linus Torvalds <torvalds@osdl.org>, Randy Dunlap <rdunlap@xenotime.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix typos in doc and comments (1)
Message-ID: <Pine.LNX.4.61.0610170040510.30479@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Changes persistant -> persistent. www.dictionary.com does not know 
persistant (with an A), but should it be one of those things you can 
spell in more than one correct way, let me know.


Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.19-rc2/Documentation/Changes
===================================================================
--- linux-2.6.19-rc2.orig/Documentation/Changes
+++ linux-2.6.19-rc2/Documentation/Changes
@@ -201,7 +201,7 @@ udev
 ----
 udev is a userspace application for populating /dev dynamically with
 only entries for devices actually present.  udev replaces the basic
-functionality of devfs, while allowing persistant device naming for
+functionality of devfs, while allowing persistent device naming for
 devices.
 
 FUSE
Index: linux-2.6.19-rc2/Documentation/power/states.txt
===================================================================
--- linux-2.6.19-rc2.orig/Documentation/power/states.txt
+++ linux-2.6.19-rc2/Documentation/power/states.txt
@@ -62,7 +62,7 @@ setup via another operating system for i
 inconvenience, this method requires minimal work by the kernel, since
 the firmware will also handle restoring memory contents on resume. 
 
-If the kernel is responsible for persistantly saving state, a mechanism 
+If the kernel is responsible for persistently saving state, a mechanism
 called 'swsusp' (Swap Suspend) is used to write memory contents to
 free swap space. swsusp has some restrictive requirements, but should
 work in most cases. Some, albeit outdated, documentation can be found
Index: linux-2.6.19-rc2/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.19-rc2.orig/arch/um/drivers/chan_user.c
+++ linux-2.6.19-rc2/arch/um/drivers/chan_user.c
@@ -120,7 +120,7 @@ static int winch_thread(void *arg)
 	/* These are synchronization calls between various UML threads on the
 	 * host - since they are not different kernel threads, we cannot use
 	 * kernel semaphores. We don't use SysV semaphores because they are
-	 * persistant. */
+	 * persistent. */
 	count = os_read_file(pipe_fd, &c, sizeof(c));
 	if(count != sizeof(c))
 		printk("winch_thread : failed to read synchronization byte, "
Index: linux-2.6.19-rc2/drivers/message/fusion/mptbase.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/message/fusion/mptbase.c
+++ linux-2.6.19-rc2/drivers/message/fusion/mptbase.c
@@ -6185,7 +6185,7 @@ mpt_spi_log_info(MPT_ADAPTER *ioc, u32 l
 		"Abort",					/* 12h */
 		"IO Not Yet Executed",				/* 13h */
 		"IO Executed",					/* 14h */
-		"Persistant Reservation Out Not Affiliation Owner", /* 15h */
+		"Persistent Reservation Out Not Affiliation Owner", /* 15h */
 		"Open Transmit DMA Abort",			/* 16h */
 		"IO Device Missing Delay Retry",		/* 17h */
 		NULL,						/* 18h */
Index: linux-2.6.19-rc2/drivers/mtd/maps/cfi_flagadm.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/mtd/maps/cfi_flagadm.c
+++ linux-2.6.19-rc2/drivers/mtd/maps/cfi_flagadm.c
@@ -80,7 +80,7 @@ struct mtd_partition flagadm_parts[] = {
 		.size =		FLASH_PARTITION2_SIZE
 	},
 	{
-		.name =		"Persistant storage",
+		.name =		"Persistent storage",
 		.offset =	FLASH_PARTITION3_ADDR,
 		.size =		FLASH_PARTITION3_SIZE
 	}
Index: linux-2.6.19-rc2/drivers/pci/Kconfig
===================================================================
--- linux-2.6.19-rc2.orig/drivers/pci/Kconfig
+++ linux-2.6.19-rc2/drivers/pci/Kconfig
@@ -34,7 +34,7 @@ config PCI_MULTITHREAD_PROBE
 
 	  It is very unwise to use this option if you are not using a
 	  boot process that can handle devices being created in any
-	  order.  A program that can create persistant block and network
+	  order.  A program that can create persistent block and network
 	  device names (like udev) is a good idea if you wish to use
 	  this option.
 
Index: linux-2.6.19-rc2/fs/Kconfig
===================================================================
--- linux-2.6.19-rc2.orig/fs/Kconfig
+++ linux-2.6.19-rc2/fs/Kconfig
@@ -968,7 +968,7 @@ config SYSFS
 
 	Some system agents rely on the information in sysfs to operate.
 	/sbin/hotplug uses device and object attributes in sysfs to assist in
-	delegating policy decisions, like persistantly naming devices.
+	delegating policy decisions, like persistently naming devices.
 
 	sysfs is currently used by the block subsystem to mount the root
 	partition.  If sysfs is disabled you must specify the boot device on
Index: linux-2.6.19-rc2/fs/jfs/jfs_filsys.h
===================================================================
--- linux-2.6.19-rc2.orig/fs/jfs/jfs_filsys.h
+++ linux-2.6.19-rc2/fs/jfs/jfs_filsys.h
@@ -81,7 +81,7 @@
 #define	JFS_SWAP_BYTES		0x00100000	/* running on big endian computer */
 
 /* Directory index */
-#define JFS_DIR_INDEX		0x00200000	/* Persistant index for */
+#define JFS_DIR_INDEX		0x00200000	/* Persistent index for */
 						/* directory entries    */
 
 
Index: linux-2.6.19-rc2/include/linux/textsearch.h
===================================================================
--- linux-2.6.19-rc2.orig/include/linux/textsearch.h
+++ linux-2.6.19-rc2/include/linux/textsearch.h
@@ -20,7 +20,7 @@ struct ts_config;
 /**
  * struct ts_state - search state
  * @offset: offset for next match
- * @cb: control buffer, for persistant variables of get_next_block()
+ * @cb: control buffer, for persistent variables of get_next_block()
  */
 struct ts_state
 {
@@ -71,7 +71,7 @@ struct ts_config
 	 * Called repeatedly until 0 is returned. Must assign the
 	 * head of the next block of data to &*dst and return the length
 	 * of the block or 0 if at the end. consumed == 0 indicates
-	 * a new search. May store/read persistant values in state->cb.
+	 * a new search. May store/read persistent values in state->cb.
 	 */
 	unsigned int		(*get_next_block)(unsigned int consumed,
 						  const u8 **dst,
Index: linux-2.6.19-rc2/lib/textsearch.c
===================================================================
--- linux-2.6.19-rc2.orig/lib/textsearch.c
+++ linux-2.6.19-rc2/lib/textsearch.c
@@ -40,7 +40,7 @@
  *       configuration according to the specified parameters.
  *   (3) User starts the search(es) by calling _find() or _next() to
  *       fetch subsequent occurrences. A state variable is provided
- *       to the algorihtm to store persistant variables.
+ *       to the algorihtm to store persistent variables.
  *   (4) Core eventually resets the search offset and forwards the find()
  *       request to the algorithm.
  *   (5) Algorithm calls get_next_block() provided by the user continously
#<EOF>


	-`J'
-- 
