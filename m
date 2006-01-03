Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWACNTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWACNTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWACNTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:19:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16141 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932252AbWACNTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:19:03 -0500
Date: Tue, 3 Jan 2006 14:19:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: please pull from the trivial tree
Message-ID: <20060103131900.GD3831@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following changes:

Adam D. Moss:
      update for Documentation/sysrq.txt

Adrian Bunk:
      remove pointers to the defunct UDF mailing list
      fs/qnx4/bitmap.c: #if 0 qnx4_new_block()
      update the email address of Randy Dunlap
      arch/arm26/nwfpe/fpmodule.c: remove kernel 2.0 #ifdef

Jim Cromie:
      Documentation/filesystems/vfs.txt: typo fix

Kees Cook:
      Documentation/SubmittingPatches: update Trivial Patch Monkey information

Matt Mackall:
      s/retreiv/retriev/g

Paolo 'Blaisorblade' Giarrusso:
      Documentation/filesystems/00-INDEX: remove entry for fat_cvf.txt


 Documentation/SubmittingPatches         |    4 ++--
 Documentation/block/biodoc.txt          |    2 +-
 Documentation/filesystems/00-INDEX      |    2 --
 Documentation/filesystems/vfs.txt       |    5 ++---
 Documentation/scsi/scsi_mid_low_api.txt |    2 +-
 Documentation/sysrq.txt                 |    6 +-----
 MAINTAINERS                             |    4 +---
 arch/arm26/nwfpe/fpmodule.c             |    3 +--
 drivers/char/n_hdlc.c                   |    2 +-
 drivers/net/tlan.c                      |    4 ++--
 drivers/usb/class/usblp.c               |    2 +-
 drivers/usb/serial/ftdi_sio.h           |    2 +-
 drivers/video/aty/radeon_base.c         |   16 ++++++++--------
 fs/ntfs/ChangeLog                       |    2 +-
 fs/qnx4/bitmap.c                        |    2 ++
 fs/reiserfs/xattr.c                     |    4 ++--
 fs/udf/balloc.c                         |    5 -----
 fs/udf/crc.c                            |    5 -----
 fs/udf/dir.c                            |    5 -----
 fs/udf/directory.c                      |    5 -----
 fs/udf/file.c                           |    5 -----
 fs/udf/fsync.c                          |    5 -----
 fs/udf/ialloc.c                         |    5 -----
 fs/udf/inode.c                          |    5 -----
 fs/udf/lowlevel.c                       |    5 -----
 fs/udf/misc.c                           |    5 -----
 fs/udf/namei.c                          |    5 -----
 fs/udf/partition.c                      |    5 -----
 fs/udf/super.c                          |    5 -----
 fs/udf/symlink.c                        |    5 -----
 fs/udf/truncate.c                       |    5 -----
 fs/udf/unicode.c                        |    5 -----
 include/linux/udf_fs.h                  |    5 -----
 include/linux/udf_fs_i.h                |    5 -----
 include/linux/udf_fs_sb.h               |    5 -----
 kernel/configs.c                        |    2 +-
 net/irda/iriap.c                        |    2 +-
 scripts/binoffset.c                     |    2 +-
 scripts/checkversion.pl                 |    2 +-
 scripts/kconfig/util.c                  |    2 +-
 scripts/patch-kernel                    |    4 ++--
 41 files changed, 34 insertions(+), 137 deletions(-)


diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 237d54c..1d47e6c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -158,7 +158,7 @@ Even if the maintainer did not respond i
 copy the maintainer when you change their code.
 
 For small patches you may want to CC the Trivial Patch Monkey
-trivial@rustcorp.com.au set up by Rusty Russell; which collects "trivial"
+trivial@kernel.org managed by Adrian Bunk; which collects "trivial"
 patches. Trivial patches must qualify for one of the following rules:
  Spelling fixes in documentation
  Spelling fixes which could break grep(1).
@@ -171,7 +171,7 @@ patches. Trivial patches must qualify fo
  since people copy, as long as it's trivial)
  Any fix by the author/maintainer of the file. (ie. patch monkey
  in re-transmission mode)
-URL: <http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/>
+URL: <http://www.kernel.org/pub/linux/kernel/people/bunk/trivial/>
 
 
 
diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
index 0fe01c8..303c57a 100644
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.txt
@@ -31,7 +31,7 @@ The following people helped with review 
 document:
 	Christoph Hellwig <hch@infradead.org>
 	Arjan van de Ven <arjanv@redhat.com>
-	Randy Dunlap <rddunlap@osdl.org>
+	Randy Dunlap <rdunlap@xenotime.net>
 	Andre Hedrick <andre@linux-ide.org>
 
 The following people helped with fixes/contributions to the bio patches
diff --git a/Documentation/filesystems/00-INDEX b/Documentation/filesystems/00-INDEX
index bcfbab8..7e17712 100644
--- a/Documentation/filesystems/00-INDEX
+++ b/Documentation/filesystems/00-INDEX
@@ -18,8 +18,6 @@ devfs/
 	- directory containing devfs documentation.
 ext2.txt
 	- info, mount options and specifications for the Ext2 filesystem.
-fat_cvf.txt
-	- info on the Compressed Volume Files extension to the FAT filesystem
 hpfs.txt
 	- info and mount options for the OS/2 HPFS.
 isofs.txt
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index ee4c0a8..e56e842 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -162,9 +162,8 @@ get_sb() method fills in is the "s_op" f
 a "struct super_operations" which describes the next level of the
 filesystem implementation.
 
-Usually, a filesystem uses generic one of the generic get_sb()
-implementations and provides a fill_super() method instead. The
-generic methods are:
+Usually, a filesystem uses one of the generic get_sb() implementations
+and provides a fill_super() method instead. The generic methods are:
 
   get_sb_bdev: mount a filesystem residing on a block device
 
diff --git a/Documentation/scsi/scsi_mid_low_api.txt b/Documentation/scsi/scsi_mid_low_api.txt
index 66565d4..3209b37 100644
--- a/Documentation/scsi/scsi_mid_low_api.txt
+++ b/Documentation/scsi/scsi_mid_low_api.txt
@@ -1433,7 +1433,7 @@ The following people have contributed to
         Christoph Hellwig <hch at infradead dot org>
         Doug Ledford <dledford at redhat dot com>
         Andries Brouwer <Andries dot Brouwer at cwi dot nl>
-        Randy Dunlap <rddunlap at osdl dot org>
+        Randy Dunlap <rdunlap at xenotime dot net>
         Alan Stern <stern at rowland dot harvard dot edu>
 
 
diff --git a/Documentation/sysrq.txt b/Documentation/sysrq.txt
index baf17b3..ad0bedf 100644
--- a/Documentation/sysrq.txt
+++ b/Documentation/sysrq.txt
@@ -202,17 +202,13 @@ you must call __handle_sysrq_nolock inst
 
 *  I have more questions, who can I ask?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-You may feel free to send email to myrdraal@deathsdoor.com, and I will
-respond as soon as possible.
- -Myrdraal
-
 And I'll answer any questions about the registration system you got, also
 responding as soon as possible.
  -Crutcher
 
 *  Credits
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-Written by Mydraal <myrdraal@deathsdoor.com>
+Written by Mydraal <vulpyne@vulpyne.net>
 Updated by Adam Sulmicki <adam@cfar.umd.edu>
 Updated by Jeremy M. Dolan <jmd@turbogeek.org> 2001/01/28 10:15:59
 Added to by Crutcher Dunnavant <crutcher+kernel@datastacks.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 6af6830..79f0efa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1465,7 +1465,6 @@ P:	Several
 L:	kernel-janitors@osdl.org
 W:	http://www.kerneljanitors.org/
 W:	http://sf.net/projects/kernel-janitor/
-W:	http://developer.osdl.org/rddunlap/kj-patches/
 S:	Maintained
 
 KERNEL NFSD
@@ -1486,7 +1485,7 @@ KEXEC
 P:	Eric Biederman
 P:	Randy Dunlap
 M:	ebiederm@xmission.com
-M:	rddunlap@osdl.org
+M:	rdunlap@xenotime.net
 W:	http://www.xmission.com/~ebiederm/files/kexec/
 L:	linux-kernel@vger.kernel.org
 L:	fastboot@osdl.org
@@ -2587,7 +2586,6 @@ S:	Maintained
 UDF FILESYSTEM
 P:	Ben Fennema
 M:	bfennema@falcon.csc.calpoly.edu
-L:	linux_udf@hpesjro.fc.hp.com
 W:	http://linux-udf.sourceforge.net
 S:	Maintained
 
diff --git a/arch/arm26/nwfpe/fpmodule.c b/arch/arm26/nwfpe/fpmodule.c
index 528fa71..5258c60 100644
--- a/arch/arm26/nwfpe/fpmodule.c
+++ b/arch/arm26/nwfpe/fpmodule.c
@@ -46,10 +46,9 @@ typedef struct task_struct*	PTASK;
 
 #ifdef MODULE
 void fp_send_sig(unsigned long sig, PTASK p, int priv);
-#if LINUX_VERSION_CODE > 0x20115
+
 MODULE_AUTHOR("Scott Bambrough <scottb@rebel.com>");
 MODULE_DESCRIPTION("NWFPE floating point emulator");
-#endif
 
 #else
 #define fp_send_sig	send_sig
diff --git a/drivers/char/n_hdlc.c b/drivers/char/n_hdlc.c
index c3660d8..a133a62 100644
--- a/drivers/char/n_hdlc.c
+++ b/drivers/char/n_hdlc.c
@@ -562,7 +562,7 @@ static void n_hdlc_tty_receive(struct tt
 }	/* end of n_hdlc_tty_receive() */
 
 /**
- * n_hdlc_tty_read - Called to retreive one frame of data (if available)
+ * n_hdlc_tty_read - Called to retrieve one frame of data (if available)
  * @tty - pointer to tty instance data
  * @file - pointer to open file object
  * @buf - pointer to returned data buffer
diff --git a/drivers/net/tlan.c b/drivers/net/tlan.c
index 942fae0..c2506b5 100644
--- a/drivers/net/tlan.c
+++ b/drivers/net/tlan.c
@@ -2865,11 +2865,11 @@ void TLan_PhyMonitor( struct net_device 
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
diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index 357e753..38f905d 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 1999 Michael Gee	<michael@linuxspecific.com>
  * Copyright (c) 1999 Pavel Machek	<pavel@suse.cz>
- * Copyright (c) 2000 Randy Dunlap	<rddunlap@osdl.org>
+ * Copyright (c) 2000 Randy Dunlap	<rdunlap@xenotime.net>
  * Copyright (c) 2000 Vojtech Pavlik	<vojtech@suse.cz>
  # Copyright (c) 2001 Pete Zaitcev	<zaitcev@redhat.com>
  # Copyright (c) 2001 David Paschal	<paschal@rcsis.com>
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index 773ea3e..da004dd 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -714,7 +714,7 @@ typedef enum {
  */
 
 /* FTDI_SIO_GET_MODEM_STATUS */
-/* Retreive the current value of the modem status register */
+/* Retrieve the current value of the modem status register */
 
 #define FTDI_SIO_GET_MODEM_STATUS_REQUEST_TYPE 0xc0
 #define FTDI_SIO_GET_MODEM_STATUS_REQUEST FTDI_SIO_GET_MODEM_STATUS
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 4f01ccc..156db84 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -594,7 +594,7 @@ static int __devinit radeon_probe_pll_pa
 }
 
 /*
- * Retreive PLL infos by different means (BIOS, Open Firmware, register probing...)
+ * Retrieve PLL infos by different means (BIOS, Open Firmware, register probing...)
  */
 static void __devinit radeon_get_pllinfo(struct radeonfb_info *rinfo)
 {
@@ -660,17 +660,17 @@ static void __devinit radeon_get_pllinfo
 
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
@@ -682,7 +682,7 @@ static void __devinit radeon_get_pllinfo
 		rinfo->pll.ppll_min	= BIOS_IN32(pll_info_block + 0x12);
 		rinfo->pll.ppll_max	= BIOS_IN32(pll_info_block + 0x16);
 
-		printk(KERN_INFO "radeonfb: Retreived PLL infos from BIOS\n");
+		printk(KERN_INFO "radeonfb: Retrieved PLL infos from BIOS\n");
 		goto found;
 	}
 
@@ -691,7 +691,7 @@ static void __devinit radeon_get_pllinfo
 	 * probe them
 	 */
 	if (radeon_probe_pll_params(rinfo) == 0) {
-		printk(KERN_INFO "radeonfb: Retreived PLL infos from registers\n");
+		printk(KERN_INFO "radeonfb: Retrieved PLL infos from registers\n");
 		goto found;
 	}
 
@@ -702,7 +702,7 @@ static void __devinit radeon_get_pllinfo
 
 found:
 	/*
-	 * Some methods fail to retreive SCLK and MCLK values, we apply default
+	 * Some methods fail to retrieve SCLK and MCLK values, we apply default
 	 * settings in this case (200Mhz). If that really happne often, we could
 	 * fetch from registers instead...
 	 */
@@ -2393,7 +2393,7 @@ static int radeonfb_pci_register (struct
 	       rinfo->mapped_vram/1024);
 
 	/*
-	 * Map the BIOS ROM if any and retreive PLL parameters from
+	 * Map the BIOS ROM if any and retrieve PLL parameters from
 	 * the BIOS. We skip that on mobility chips as the real panel
 	 * values we need aren't in the ROM but in the BIOS image in
 	 * memory. This is definitely not the best meacnism though,
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 50a7749..02f4409 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -884,7 +884,7 @@ ToDo/Notes:
 
 	- Add handling for initialized_size != data_size in compressed files.
 	- Reduce function local stack usage from 0x3d4 bytes to just noise in
-	  fs/ntfs/upcase.c. (Randy Dunlap <rddunlap@osdl.ord>)
+	  fs/ntfs/upcase.c. (Randy Dunlap <rdunlap@xenotime.net>)
 	- Remove compiler warnings for newer gcc.
 	- Pages are no longer kmapped by mm/filemap.c::generic_file_write()
 	  around calls to ->{prepare,commit}_write.  Adapt NTFS appropriately
diff --git a/fs/qnx4/bitmap.c b/fs/qnx4/bitmap.c
index 9912539..46efbf5 100644
--- a/fs/qnx4/bitmap.c
+++ b/fs/qnx4/bitmap.c
@@ -23,10 +23,12 @@
 #include <linux/buffer_head.h>
 #include <linux/bitops.h>
 
+#if 0
 int qnx4_new_block(struct super_block *sb)
 {
 	return 0;
 }
+#endif  /*  0  */
 
 static void count_bits(register const char *bmPart, register int size,
 		       int *const tf)
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 72e1207..02091ea 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -115,8 +115,8 @@ static struct dentry *__get_xa_root(stru
 }
 
 /* Returns the dentry (or NULL) referring to the root of the extended
- * attribute directory tree. If it has already been retreived, it is used.
- * Otherwise, we attempt to retreive it from disk. It may also return
+ * attribute directory tree. If it has already been retrieved, it is used.
+ * Otherwise, we attempt to retrieve it from disk. It may also return
  * a pointer-encoded error.
  */
 static inline struct dentry *get_xa_root(struct super_block *s)
diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index b9ded26..6598a50 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *	Block allocation handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/crc.c b/fs/udf/crc.c
index d95c6e3..1b82a4a 100644
--- a/fs/udf/crc.c
+++ b/fs/udf/crc.c
@@ -14,11 +14,6 @@
  *
  *	AT&T gives permission for the free use of the CRC source code.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index 82440b7..f522252 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *  Directory handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 9a61ecc..fe751a2 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *	Directory related functions
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 01f520c..8a38828 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *  File handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *  E-mail regarding any portion of the Linux UDF file system should be
- *  directed to the development team mailing list (run by majordomo):
- *    linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *  This file is distributed under the terms of the GNU General Public
  *  License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/fsync.c b/fs/udf/fsync.c
index 2dde6b8..5887d78 100644
--- a/fs/udf/fsync.c
+++ b/fs/udf/fsync.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *  Fsync handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *  E-mail regarding any portion of the Linux UDF file system should be
- *  directed to the development team mailing list (run by majordomo):
- *      linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *  This file is distributed under the terms of the GNU General Public
  *  License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index a7e5d40..c9b707b 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *	Inode allocation handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index b83890b..4014f17 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *  Inode handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *  E-mail regarding any portion of the Linux UDF file system should be
- *  directed to the development team mailing list (run by majordomo):
- *    linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *  This file is distributed under the terms of the GNU General Public
  *  License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/lowlevel.c b/fs/udf/lowlevel.c
index 2da5087..0842161 100644
--- a/fs/udf/lowlevel.c
+++ b/fs/udf/lowlevel.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *  Low Level Device Routines for the UDF filesystem
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index fd321f9..cc8ca32 100644
--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *	Miscellaneous routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index ac191ed..ca732e7 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *      Inode name handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *      E-mail regarding any portion of the Linux UDF file system should be
- *      directed to the development team mailing list (run by majordomo):
- *              linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *      This file is distributed under the terms of the GNU General Public
  *      License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/partition.c b/fs/udf/partition.c
index 4d36f26..dabf2b8 100644
--- a/fs/udf/partition.c
+++ b/fs/udf/partition.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *      Partition handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *      E-mail regarding any portion of the Linux UDF file system should be
- *      directed to the development team mailing list (run by majordomo):
- *              linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *      This file is distributed under the terms of the GNU General Public
  *      License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 15bd4f2..4a6f49a 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -14,11 +14,6 @@
  *    http://www.ecma.ch/
  *    http://www.iso.org/
  *
- * CONTACTS
- *  E-mail regarding any portion of the Linux UDF file system should be
- *  directed to the development team mailing list (run by majordomo):
- *	  linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *  This file is distributed under the terms of the GNU General Public
  *  License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index 43f3051..674bb40 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *	Symlink handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 7dc8a55..e1b0e8c 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -4,11 +4,6 @@
  * PURPOSE
  *	Truncate handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
index 5a80efd..706c92e 100644
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -11,11 +11,6 @@
  *	UTF-8 is explained in the IETF RFC XXXX.
  *		ftp://ftp.internic.net/rfc/rfcxxxx.txt
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team's mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/include/linux/udf_fs.h b/include/linux/udf_fs.h
index 46e2bb9..36c684e 100644
--- a/include/linux/udf_fs.h
+++ b/include/linux/udf_fs.h
@@ -13,11 +13,6 @@
  *    http://www.osta.org/ *    http://www.ecma.ch/
  *    http://www.iso.org/
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/include/linux/udf_fs_i.h b/include/linux/udf_fs_i.h
index 62b15a4..1e75084 100644
--- a/include/linux/udf_fs_i.h
+++ b/include/linux/udf_fs_i.h
@@ -3,11 +3,6 @@
  *
  * This file is intended for the Linux kernel/module. 
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/include/linux/udf_fs_sb.h b/include/linux/udf_fs_sb.h
index 1966a6d..b15ff2e 100644
--- a/include/linux/udf_fs_sb.h
+++ b/include/linux/udf_fs_sb.h
@@ -3,11 +3,6 @@
  * 
  * This include file is for the Linux kernel/module.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
diff --git a/kernel/configs.c b/kernel/configs.c
index 986f7af..009e1eb 100644
--- a/kernel/configs.c
+++ b/kernel/configs.c
@@ -3,7 +3,7 @@
  * Echo the kernel .config file used to build the kernel
  *
  * Copyright (C) 2002 Khalid Aziz <khalid_aziz@hp.com>
- * Copyright (C) 2002 Randy Dunlap <rddunlap@osdl.org>
+ * Copyright (C) 2002 Randy Dunlap <rdunlap@xenotime.net>
  * Copyright (C) 2002 Al Stone <ahs3@fc.hp.com>
  * Copyright (C) 2002 Hewlett-Packard Company
  *
diff --git a/net/irda/iriap.c b/net/irda/iriap.c
index b8bb78a..254f907 100644
--- a/net/irda/iriap.c
+++ b/net/irda/iriap.c
@@ -364,7 +364,7 @@ static void iriap_disconnect_request(str
 /*
  * Function iriap_getvaluebyclass (addr, name, attr)
  *
- *    Retreive all values from attribute in all objects with given class
+ *    Retrieve all values from attribute in all objects with given class
  *    name
  */
 int iriap_getvaluebyclass_request(struct iriap_cb *self,
diff --git a/scripts/binoffset.c b/scripts/binoffset.c
index 591309d..1a2e39b 100644
--- a/scripts/binoffset.c
+++ b/scripts/binoffset.c
@@ -1,6 +1,6 @@
 /***************************************************************************
  * binoffset.c
- * (C) 2002 Randy Dunlap <rddunlap@osdl.org>
+ * (C) 2002 Randy Dunlap <rdunlap@xenotime.net>
 
 #   This program is free software; you can redistribute it and/or modify
 #   it under the terms of the GNU General Public License as published by
diff --git a/scripts/checkversion.pl b/scripts/checkversion.pl
index df10db6..9f84e56 100755
--- a/scripts/checkversion.pl
+++ b/scripts/checkversion.pl
@@ -3,7 +3,7 @@
 # checkversion find uses of LINUX_VERSION_CODE, KERNEL_VERSION, or
 # UTS_RELEASE without including <linux/version.h>, or cases of
 # including <linux/version.h> that don't need it.
-# Copyright (C) 2003, Randy Dunlap <rddunlap@osdl.org>
+# Copyright (C) 2003, Randy Dunlap <rdunlap@xenotime.net>
 
 $| = 1;
 
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 1fa4c0b..4556014 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -101,7 +101,7 @@ void str_printf(struct gstr *gs, const c
 	va_end(ap);
 }
 
-/* Retreive value of growable string */
+/* Retrieve value of growable string */
 const char *str_get(struct gstr *gs)
 {
 	return gs->s;
diff --git a/scripts/patch-kernel b/scripts/patch-kernel
index f2d47ca..67e4b18 100755
--- a/scripts/patch-kernel
+++ b/scripts/patch-kernel
@@ -45,7 +45,7 @@
 # update usage message;
 # fix some whitespace damage;
 # be smarter about stopping when current version is larger than requested;
-#	Randy Dunlap <rddunlap@osdl.org>, 2004-AUG-18.
+#	Randy Dunlap <rdunlap@xenotime.net>, 2004-AUG-18.
 #
 # Add better support for (non-incremental) 2.6.x.y patches;
 # If an ending version number if not specified, the script automatically
@@ -56,7 +56,7 @@
 # patch-kernel does not normally support reverse patching, but does so when
 # applying EXTRAVERSION (x.y) patches, so that moving from 2.6.11.y to 2.6.11.z
 # is easy and handled by the script (reverse 2.6.11.y and apply 2.6.11.z).
-#	Randy Dunlap <rddunlap@osdl.org>, 2005-APR-08.
+#	Randy Dunlap <rdunlap@xenotime.net>, 2005-APR-08.
 
 PNAME=patch-kernel
 
