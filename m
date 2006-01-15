Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbWAOCFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbWAOCFj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 21:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWAOCFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 21:05:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7179 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751527AbWAOCFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 21:05:35 -0500
Date: Sun, 15 Jan 2006 03:05:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: please pull from the trivial tree
Message-ID: <20060115020534.GZ29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following changes:

Adrian Bunk:
      ftape: remove some outdated information from Kconfig files
      drivers/net/{,wireless/}Kconfig: remove dead URL
      spelling: s/appropiate/appropriate/
      SOFTWARE_SUSPEND: fix a typo in the dependencies

Alex Shepard:
      Spelling fix in IPW2100 and IPW2200 Kconfig entries

Alexey Dobriyan:
      Fix "stuct", "strut", "struc" typos

Christian Kujau:
      correct email address of Manfred Spraul

Domen Puncer:
      remove unused LOCAL_END_REQUEST

Horms:
      MAINTAINERS: better list for "POSIX CLOCKS and TIMERS"

Jesper Juhl:
      return statement cleanup - kill pointless parentheses
      Spelling fix in init/Kconfig for the help of CONFIG_SWAP
      MAINTAINERS: CIFS: add linux-cifs-client@lists.samba.org list

Randy Dunlap:
      Documentation/hpet.txt typo


 Documentation/DocBook/videobook.tmpl                         |    4 
 Documentation/cachetlb.txt                                   |    2 
 Documentation/hpet.txt                                       |    2 
 Documentation/input/ff.txt                                   |    2 
 Documentation/ioctl/hdio.txt                                 |    2 
 Documentation/laptop-mode.txt                                |    2 
 Documentation/networking/sk98lin.txt                         |    2 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    2 
 Documentation/x86_64/boot-options.txt                        |    2 
 MAINTAINERS                                                  |    3 
 arch/i386/kernel/vm86.c                                      |    2 
 arch/um/include/sysdep-i386/checksum.h                       |    4 
 drivers/block/floppy.c                                       |    1 
 drivers/char/Kconfig                                         |   10 
 drivers/char/ftape/Kconfig                                   |   12 
 drivers/char/stallion.c                                      |  128 +++++-----
 drivers/net/Kconfig                                          |    4 
 drivers/net/wan/lmc/lmc_main.c                               |    2 
 drivers/net/wireless/Kconfig                                 |    8 
 drivers/s390/scsi/zfcp_erp.c                                 |    2 
 drivers/scsi/FlashPoint.c                                    |    2 
 drivers/scsi/gdth.c                                          |    2 
 fs/efs/super.c                                               |    5 
 fs/sysv/ChangeLog                                            |    2 
 fs/xfs/quota/xfs_qm.c                                        |  114 ++++----
 fs/xfs/xfs_dir_leaf.c                                        |   96 +++----
 fs/xfs/xfs_fsops.c                                           |    4 
 fs/xfs/xfs_log.c                                             |   52 ++--
 fs/xfs/xfs_mount.c                                           |   66 ++---
 fs/xfs/xfs_trans_item.c                                      |   22 -
 fs/xfs/xfs_vnodeops.c                                        |   59 ++--
 include/asm-v850/ptrace.h                                    |    2 
 include/linux/pfkeyv2.h                                      |    2 
 init/Kconfig                                                 |    2 
 ipc/msg.c                                                    |    2 
 ipc/sem.c                                                    |    2 
 ipc/util.c                                                   |    2 
 ipc/util.h                                                   |    2 
 kernel/power/Kconfig                                         |    2 
 kernel/printk.c                                              |    2 
 sound/oss/opl3sa2.c                                          |    2 
 41 files changed, 306 insertions(+), 334 deletions(-)


diff --git a/Documentation/DocBook/videobook.tmpl b/Documentation/DocBook/videobook.tmpl
index 3ec6c87..fdff984 100644
--- a/Documentation/DocBook/videobook.tmpl
+++ b/Documentation/DocBook/videobook.tmpl
@@ -229,7 +229,7 @@ int __init myradio_init(struct video_ini
 
 static int users = 0;
 
-static int radio_open(stuct video_device *dev, int flags)
+static int radio_open(struct video_device *dev, int flags)
 {
         if(users)
                 return -EBUSY;
@@ -949,7 +949,7 @@ int __init mycamera_init(struct video_in
 
 static int users = 0;
 
-static int camera_open(stuct video_device *dev, int flags)
+static int camera_open(struct video_device *dev, int flags)
 {
         if(users)
                 return -EBUSY;
diff --git a/Documentation/cachetlb.txt b/Documentation/cachetlb.txt
index 7eb715e..4ae4188 100644
--- a/Documentation/cachetlb.txt
+++ b/Documentation/cachetlb.txt
@@ -136,7 +136,7 @@ changes occur:
 8) void lazy_mmu_prot_update(pte_t pte)
 	This interface is called whenever the protection on
 	any user PTEs change.  This interface provides a notification
-	to architecture specific code to take appropiate action.
+	to architecture specific code to take appropriate action.
 
 
 Next, we have the cache flushing interfaces.  In general, when Linux
diff --git a/Documentation/hpet.txt b/Documentation/hpet.txt
index e524575..b7a3dc3 100644
--- a/Documentation/hpet.txt
+++ b/Documentation/hpet.txt
@@ -2,7 +2,7 @@
 
 The High Precision Event Timer (HPET) hardware is the future replacement
 for the 8254 and Real Time Clock (RTC) periodic timer functionality.
-Each HPET can have up two 32 timers.  It is possible to configure the
+Each HPET can have up to 32 timers.  It is possible to configure the
 first two timers as legacy replacements for 8254 and RTC periodic timers.
 A specification done by Intel and Microsoft can be found at
 <http://www.intel.com/hardwaredesign/hpetspec.htm>.
diff --git a/Documentation/input/ff.txt b/Documentation/input/ff.txt
index efa7dd6..c7e10ea 100644
--- a/Documentation/input/ff.txt
+++ b/Documentation/input/ff.txt
@@ -120,7 +120,7 @@ to the unique id assigned by the driver.
 some operations (removing an effect, controlling the playback).
 This if field must be set to -1 by the user in order to tell the driver to
 allocate a new effect.
-See <linux/input.h> for a description of the ff_effect stuct. You should also
+See <linux/input.h> for a description of the ff_effect struct. You should also
 find help in a few sketches, contained in files shape.fig and interactive.fig.
 You need xfig to visualize these files.
 
diff --git a/Documentation/ioctl/hdio.txt b/Documentation/ioctl/hdio.txt
index 9a7aea0..11c9be4 100644
--- a/Documentation/ioctl/hdio.txt
+++ b/Documentation/ioctl/hdio.txt
@@ -946,7 +946,7 @@ HDIO_SCAN_HWIF			register and (re)scan i
 
 	  This ioctl initializes the addresses and irq for a disk
 	  controller, probes for drives, and creates /proc/ide
-	  interfaces as appropiate.
+	  interfaces as appropriate.
 
 
 
diff --git a/Documentation/laptop-mode.txt b/Documentation/laptop-mode.txt
index f42e4c0..b18e216 100644
--- a/Documentation/laptop-mode.txt
+++ b/Documentation/laptop-mode.txt
@@ -357,7 +357,7 @@ MAX_AGE=${MAX_AGE:-'600'}
 # Read-ahead, in kilobytes
 READAHEAD=${READAHEAD:-'4096'}
 
-# Shall we remount journaled fs. with appropiate commit interval? (1=yes)
+# Shall we remount journaled fs. with appropriate commit interval? (1=yes)
 DO_REMOUNTS=${DO_REMOUNTS:-'1'}
 
 # And shall we add the "noatime" option to that as well? (1=yes)
diff --git a/Documentation/networking/sk98lin.txt b/Documentation/networking/sk98lin.txt
index f9d979e..7837c53 100644
--- a/Documentation/networking/sk98lin.txt
+++ b/Documentation/networking/sk98lin.txt
@@ -91,7 +91,7 @@ To use the driver as a module, proceed a
    with (M)
 5. Execute the command "make modules".
 6. Execute the command "make modules_install".
-   The appropiate modules will be installed.
+   The appropriate modules will be installed.
 7. Reboot your system.
 
 
diff --git a/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl b/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
index 4963d83..e651ed8 100644
--- a/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
@@ -5577,7 +5577,7 @@ struct _snd_pcm_runtime {
       <informalexample>
         <programlisting>
 <![CDATA[
-  static int mychip_suspend(strut pci_dev *pci, pm_message_t state)
+  static int mychip_suspend(struct pci_dev *pci, pm_message_t state)
   {
           /* (1) */
           struct snd_card *card = pci_get_drvdata(pci);
diff --git a/Documentation/x86_64/boot-options.txt b/Documentation/x86_64/boot-options.txt
index 72ab9b9..9c5fc15 100644
--- a/Documentation/x86_64/boot-options.txt
+++ b/Documentation/x86_64/boot-options.txt
@@ -198,6 +198,6 @@ Debugging
 
 Misc
 
-  noreplacement  Don't replace instructions with more appropiate ones
+  noreplacement  Don't replace instructions with more appropriate ones
 		 for the CPU. This may be useful on asymmetric MP systems
 		 where some CPU have less capabilities than the others.
diff --git a/MAINTAINERS b/MAINTAINERS
index 71693c5..873c3f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -549,6 +549,7 @@ S:	Maintained
 COMMON INTERNET FILE SYSTEM (CIFS)
 P:	Steve French
 M:	sfrench@samba.org
+L:	linux-cifs-client@lists.samba.org
 L:	samba-technical@lists.samba.org
 W:	http://us1.samba.org/samba/Linux_CIFS_client.html
 T:	git kernel.org:/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git
@@ -2053,7 +2054,7 @@ S:	Maintained
 POSIX CLOCKS and TIMERS
 P:	George Anzinger
 M:	george@mvista.com
-L:	netdev@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
 S:	Supported
 
 POWERPC 4xx EMAC DRIVER
diff --git a/arch/i386/kernel/vm86.c b/arch/i386/kernel/vm86.c
index 0c90ae5..f51c894 100644
--- a/arch/i386/kernel/vm86.c
+++ b/arch/i386/kernel/vm86.c
@@ -4,7 +4,7 @@
  *  Copyright (C) 1994  Linus Torvalds
  *
  *  29 dec 2001 - Fixed oopses caused by unchecked access to the vm86
- *                stack - Manfred Spraul <manfreds@colorfullife.com>
+ *                stack - Manfred Spraul <manfred@colorfullife.com>
  *
  *  22 mar 2002 - Manfred detected the stackfaults, but didn't handle
  *                them correctly. Now the emulation will be in a
diff --git a/arch/um/include/sysdep-i386/checksum.h b/arch/um/include/sysdep-i386/checksum.h
index 764ba4d..7d3d202 100644
--- a/arch/um/include/sysdep-i386/checksum.h
+++ b/arch/um/include/sysdep-i386/checksum.h
@@ -36,7 +36,7 @@ unsigned int csum_partial_copy_nocheck(c
 				       int len, int sum)
 {
 	memcpy(dst, src, len);
-	return(csum_partial(dst, len, sum));
+	return csum_partial(dst, len, sum);
 }
 
 /*
@@ -104,7 +104,7 @@ static inline unsigned short ip_fast_csu
 	: "=r" (sum), "=r" (iph), "=r" (ihl)
 	: "1" (iph), "2" (ihl)
 	: "memory");
-	return(sum);
+	return sum;
 }
 
 /*
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 374621a..d23b543 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -242,7 +242,6 @@ static int allowed_drive_mask = 0x33;
 
 static int irqdma_allocated;
 
-#define LOCAL_END_REQUEST
 #define DEVICE_NAME "floppy"
 
 #include <linux/blkdev.h>
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index d6fcd0a..4135d8c 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -881,16 +881,6 @@ config FTAPE
 	  module. To compile this driver as a module, choose M here: the
 	  module will be called ftape.
 
-	  Note that the Ftape-HOWTO is out of date (sorry) and documents the
-	  older version 2.08 of this software but still contains useful
-	  information.  There is a web page with more recent documentation at
-	  <http://www.instmath.rwth-aachen.de/~heine/ftape/>.  This page
-	  always contains the latest release of the ftape driver and useful
-	  information (backup software, ftape related patches and
-	  documentation, FAQ).  Note that the file system interface has
-	  changed quite a bit compared to previous versions of ftape.  Please
-	  read <file:Documentation/ftape.txt>.
-
 source "drivers/char/ftape/Kconfig"
 
 endmenu
diff --git a/drivers/char/ftape/Kconfig b/drivers/char/ftape/Kconfig
index 7d3ecb5..0d65189 100644
--- a/drivers/char/ftape/Kconfig
+++ b/drivers/char/ftape/Kconfig
@@ -25,17 +25,7 @@ config ZFTAPE
 	  support", above) then `zft-compressor' will be loaded
 	  automatically by zftape when needed.
 
-	  Despite its name, zftape does NOT use compression by default.  The
-	  file <file:Documentation/ftape.txt> contains a short description of
-	  the most important changes in the file system interface compared to
-	  previous versions of ftape.  The ftape home page
-	  <http://www.instmath.rwth-aachen.de/~heine/ftape/> contains
-	  further information.
-
-	  IMPORTANT NOTE: zftape can read archives created by previous
-	  versions of ftape and provide file mark support (i.e. fast skipping
-	  between tape archives) but previous version of ftape will lack file
-	  mark support when reading archives produced by zftape.
+	  Despite its name, zftape does NOT use compression by default.
 
 config ZFT_DFLT_BLK_SZ
 	int "Default block size"
diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 0e20780..bdaab69 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -738,7 +738,7 @@ static int __init stallion_module_init(v
 	stl_init();
 	restore_flags(flags);
 
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -889,7 +889,7 @@ static unsigned long stl_atol(char *str)
 		}
 		val = (val * base) + c;
 	}
-	return(val);
+	return val;
 }
 
 /*****************************************************************************/
@@ -908,7 +908,7 @@ static int stl_parsebrd(stlconf_t *confp
 #endif
 
 	if ((argp[0] == (char *) NULL) || (*argp[0] == 0))
-		return(0);
+		return 0;
 
 	for (sp = argp[0], i = 0; ((*sp != 0) && (i < 25)); sp++, i++)
 		*sp = TOLOWER(*sp);
@@ -935,7 +935,7 @@ static int stl_parsebrd(stlconf_t *confp
 	}
 	if ((argp[i] != (char *) NULL) && (*argp[i] != 0))
 		confp->irq = stl_atol(argp[i]);
-	return(1);
+	return 1;
 }
 
 /*****************************************************************************/
@@ -946,7 +946,7 @@ static int stl_parsebrd(stlconf_t *confp
 
 static void *stl_memalloc(int len)
 {
-	return((void *) kmalloc(len, GFP_KERNEL));
+	return (void *) kmalloc(len, GFP_KERNEL);
 }
 
 /*****************************************************************************/
@@ -963,12 +963,12 @@ static stlbrd_t *stl_allocbrd(void)
 	if (brdp == (stlbrd_t *) NULL) {
 		printk("STALLION: failed to allocate memory (size=%d)\n",
 			sizeof(stlbrd_t));
-		return((stlbrd_t *) NULL);
+		return (stlbrd_t *) NULL;
 	}
 
 	memset(brdp, 0, sizeof(stlbrd_t));
 	brdp->magic = STL_BOARDMAGIC;
-	return(brdp);
+	return brdp;
 }
 
 /*****************************************************************************/
@@ -988,10 +988,10 @@ static int stl_open(struct tty_struct *t
 	minordev = tty->index;
 	brdnr = MINOR2BRD(minordev);
 	if (brdnr >= stl_nrbrds)
-		return(-ENODEV);
+		return -ENODEV;
 	brdp = stl_brds[brdnr];
 	if (brdp == (stlbrd_t *) NULL)
-		return(-ENODEV);
+		return -ENODEV;
 	minordev = MINOR2PORT(minordev);
 	for (portnr = -1, panelnr = 0; (panelnr < STL_MAXPANELS); panelnr++) {
 		if (brdp->panels[panelnr] == (stlpanel_t *) NULL)
@@ -1003,11 +1003,11 @@ static int stl_open(struct tty_struct *t
 		minordev -= brdp->panels[panelnr]->nrports;
 	}
 	if (portnr < 0)
-		return(-ENODEV);
+		return -ENODEV;
 
 	portp = brdp->panels[panelnr]->ports[portnr];
 	if (portp == (stlport_t *) NULL)
-		return(-ENODEV);
+		return -ENODEV;
 
 /*
  *	On the first open of the device setup the port hardware, and
@@ -1021,7 +1021,7 @@ static int stl_open(struct tty_struct *t
 		if (portp->tx.buf == (char *) NULL) {
 			portp->tx.buf = (char *) stl_memalloc(STL_TXBUFSIZE);
 			if (portp->tx.buf == (char *) NULL)
-				return(-ENOMEM);
+				return -ENOMEM;
 			portp->tx.head = portp->tx.buf;
 			portp->tx.tail = portp->tx.buf;
 		}
@@ -1043,8 +1043,8 @@ static int stl_open(struct tty_struct *t
 	if (portp->flags & ASYNC_CLOSING) {
 		interruptible_sleep_on(&portp->close_wait);
 		if (portp->flags & ASYNC_HUP_NOTIFY)
-			return(-EAGAIN);
-		return(-ERESTARTSYS);
+			return -EAGAIN;
+		return -ERESTARTSYS;
 	}
 
 /*
@@ -1054,11 +1054,11 @@ static int stl_open(struct tty_struct *t
  */
 	if (!(filp->f_flags & O_NONBLOCK)) {
 		if ((rc = stl_waitcarrier(portp, filp)) != 0)
-			return(rc);
+			return rc;
 	}
 	portp->flags |= ASYNC_NORMAL_ACTIVE;
 
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -1115,7 +1115,7 @@ static int stl_waitcarrier(stlport_t *po
 	portp->openwaitcnt--;
 	restore_flags(flags);
 
-	return(rc);
+	return rc;
 }
 
 /*****************************************************************************/
@@ -1211,12 +1211,12 @@ static int stl_write(struct tty_struct *
 
 	if ((tty == (struct tty_struct *) NULL) ||
 	    (stl_tmpwritebuf == (char *) NULL))
-		return(0);
+		return 0;
 	portp = tty->driver_data;
 	if (portp == (stlport_t *) NULL)
-		return(0);
+		return 0;
 	if (portp->tx.buf == (char *) NULL)
-		return(0);
+		return 0;
 
 /*
  *	If copying direct from user space we must cater for page faults,
@@ -1255,7 +1255,7 @@ static int stl_write(struct tty_struct *
 	clear_bit(ASYI_TXLOW, &portp->istate);
 	stl_startrxtx(portp, -1, 1);
 
-	return(count);
+	return count;
 }
 
 /*****************************************************************************/
@@ -1336,16 +1336,16 @@ static int stl_writeroom(struct tty_stru
 #endif
 
 	if (tty == (struct tty_struct *) NULL)
-		return(0);
+		return 0;
 	portp = tty->driver_data;
 	if (portp == (stlport_t *) NULL)
-		return(0);
+		return 0;
 	if (portp->tx.buf == (char *) NULL)
-		return(0);
+		return 0;
 
 	head = portp->tx.head;
 	tail = portp->tx.tail;
-	return((head >= tail) ? (STL_TXBUFSIZE - (head - tail) - 1) : (tail - head - 1));
+	return ((head >= tail) ? (STL_TXBUFSIZE - (head - tail) - 1) : (tail - head - 1));
 }
 
 /*****************************************************************************/
@@ -1370,19 +1370,19 @@ static int stl_charsinbuffer(struct tty_
 #endif
 
 	if (tty == (struct tty_struct *) NULL)
-		return(0);
+		return 0;
 	portp = tty->driver_data;
 	if (portp == (stlport_t *) NULL)
-		return(0);
+		return 0;
 	if (portp->tx.buf == (char *) NULL)
-		return(0);
+		return 0;
 
 	head = portp->tx.head;
 	tail = portp->tx.tail;
 	size = (head >= tail) ? (head - tail) : (STL_TXBUFSIZE - (tail - head));
 	if ((size == 0) && test_bit(ASYI_TXBUSY, &portp->istate))
 		size = 1;
-	return(size);
+	return size;
 }
 
 /*****************************************************************************/
@@ -1447,7 +1447,7 @@ static int stl_setserial(stlport_t *port
 		    (sio.close_delay != portp->close_delay) ||
 		    ((sio.flags & ~ASYNC_USR_MASK) !=
 		    (portp->flags & ~ASYNC_USR_MASK)))
-			return(-EPERM);
+			return -EPERM;
 	} 
 
 	portp->flags = (portp->flags & ~ASYNC_USR_MASK) |
@@ -1457,7 +1457,7 @@ static int stl_setserial(stlport_t *port
 	portp->closing_wait = sio.closing_wait;
 	portp->custom_divisor = sio.custom_divisor;
 	stl_setport(portp, portp->tty->termios);
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -1467,12 +1467,12 @@ static int stl_tiocmget(struct tty_struc
 	stlport_t	*portp;
 
 	if (tty == (struct tty_struct *) NULL)
-		return(-ENODEV);
+		return -ENODEV;
 	portp = tty->driver_data;
 	if (portp == (stlport_t *) NULL)
-		return(-ENODEV);
+		return -ENODEV;
 	if (tty->flags & (1 << TTY_IO_ERROR))
-		return(-EIO);
+		return -EIO;
 
 	return stl_getsignals(portp);
 }
@@ -1484,12 +1484,12 @@ static int stl_tiocmset(struct tty_struc
 	int rts = -1, dtr = -1;
 
 	if (tty == (struct tty_struct *) NULL)
-		return(-ENODEV);
+		return -ENODEV;
 	portp = tty->driver_data;
 	if (portp == (stlport_t *) NULL)
-		return(-ENODEV);
+		return -ENODEV;
 	if (tty->flags & (1 << TTY_IO_ERROR))
-		return(-EIO);
+		return -EIO;
 
 	if (set & TIOCM_RTS)
 		rts = 1;
@@ -1517,15 +1517,15 @@ static int stl_ioctl(struct tty_struct *
 #endif
 
 	if (tty == (struct tty_struct *) NULL)
-		return(-ENODEV);
+		return -ENODEV;
 	portp = tty->driver_data;
 	if (portp == (stlport_t *) NULL)
-		return(-ENODEV);
+		return -ENODEV;
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
  	    (cmd != COM_GETPORTSTATS) && (cmd != COM_CLRPORTSTATS)) {
 		if (tty->flags & (1 << TTY_IO_ERROR))
-			return(-EIO);
+			return -EIO;
 	}
 
 	rc = 0;
@@ -1566,7 +1566,7 @@ static int stl_ioctl(struct tty_struct *
 		break;
 	}
 
-	return(rc);
+	return rc;
 }
 
 /*****************************************************************************/
@@ -1872,7 +1872,7 @@ static int stl_portinfo(stlport_t *portp
 		pos[(MAXLINE - 2)] = '+';
 	pos[(MAXLINE - 1)] = '\n';
 
-	return(MAXLINE);
+	return MAXLINE;
 }
 
 /*****************************************************************************/
@@ -1957,7 +1957,7 @@ static int stl_readproc(char *page, char
 
 stl_readdone:
 	*start = page;
-	return(pos - page);
+	return (pos - page);
 }
 
 /*****************************************************************************/
@@ -2349,7 +2349,7 @@ static inline int stl_initeio(stlbrd_t *
 	} else {
 		rc = 0;
 	}
-	return(rc);
+	return rc;
 }
 
 /*****************************************************************************/
@@ -3116,7 +3116,7 @@ static int __init stl_init(void)
 		return -1;
 	}
 
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -3132,7 +3132,7 @@ static int __init stl_init(void)
 static int stl_cd1400getreg(stlport_t *portp, int regnr)
 {
 	outb((regnr + portp->uartaddr), portp->ioaddr);
-	return(inb(portp->ioaddr + EREG_DATA));
+	return inb(portp->ioaddr + EREG_DATA);
 }
 
 static void stl_cd1400setreg(stlport_t *portp, int regnr, int value)
@@ -3146,9 +3146,9 @@ static int stl_cd1400updatereg(stlport_t
 	outb((regnr + portp->uartaddr), portp->ioaddr);
 	if (inb(portp->ioaddr + EREG_DATA) != value) {
 		outb(value, portp->ioaddr + EREG_DATA);
-		return(1);
+		return 1;
 	}
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -3206,7 +3206,7 @@ static int stl_cd1400panelinit(stlbrd_t 
 	}
 
 	BRDDISABLE(panelp->brdnr);
-	return(chipmask);
+	return chipmask;
 }
 
 /*****************************************************************************/
@@ -3557,7 +3557,7 @@ static int stl_cd1400getsignals(stlport_
 #else
 	sigs |= TIOCM_DSR;
 #endif
-	return(sigs);
+	return sigs;
 }
 
 /*****************************************************************************/
@@ -3830,9 +3830,9 @@ static int stl_cd1400datastate(stlport_t
 #endif
 
 	if (portp == (stlport_t *) NULL)
-		return(0);
+		return 0;
 
-	return(test_bit(ASYI_TXBUSY, &portp->istate) ? 1 : 0);
+	return test_bit(ASYI_TXBUSY, &portp->istate) ? 1 : 0;
 }
 
 /*****************************************************************************/
@@ -3912,20 +3912,20 @@ static inline int stl_cd1400breakisr(stl
 		outb((SRER + portp->uartaddr), ioaddr);
 		outb((inb(ioaddr + EREG_DATA) & ~(SRER_TXDATA | SRER_TXEMPTY)),
 			(ioaddr + EREG_DATA));
-		return(1);
+		return 1;
 	} else if (portp->brklen > 1) {
 		outb((TDR + portp->uartaddr), ioaddr);
 		outb(ETC_CMD, (ioaddr + EREG_DATA));
 		outb(ETC_STOPBREAK, (ioaddr + EREG_DATA));
 		portp->brklen = -1;
-		return(1);
+		return 1;
 	} else {
 		outb((COR2 + portp->uartaddr), ioaddr);
 		outb((inb(ioaddr + EREG_DATA) & ~COR2_ETC),
 			(ioaddr + EREG_DATA));
 		portp->brklen = 0;
 	}
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -4166,7 +4166,7 @@ static void stl_cd1400mdmisr(stlpanel_t 
 static int stl_sc26198getreg(stlport_t *portp, int regnr)
 {
 	outb((regnr | portp->uartaddr), (portp->ioaddr + XP_ADDR));
-	return(inb(portp->ioaddr + XP_DATA));
+	return inb(portp->ioaddr + XP_DATA);
 }
 
 static void stl_sc26198setreg(stlport_t *portp, int regnr, int value)
@@ -4180,9 +4180,9 @@ static int stl_sc26198updatereg(stlport_
 	outb((regnr | portp->uartaddr), (portp->ioaddr + XP_ADDR));
 	if (inb(portp->ioaddr + XP_DATA) != value) {
 		outb(value, (portp->ioaddr + XP_DATA));
-		return(1);
+		return 1;
 	}
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -4194,7 +4194,7 @@ static int stl_sc26198updatereg(stlport_
 static int stl_sc26198getglobreg(stlport_t *portp, int regnr)
 {
 	outb(regnr, (portp->ioaddr + XP_ADDR));
-	return(inb(portp->ioaddr + XP_DATA));
+	return inb(portp->ioaddr + XP_DATA);
 }
 
 #if 0
@@ -4252,7 +4252,7 @@ static int stl_sc26198panelinit(stlbrd_t
 	}
 
 	BRDDISABLE(panelp->brdnr);
-	return(chipmask);
+	return chipmask;
 }
 
 /*****************************************************************************/
@@ -4546,7 +4546,7 @@ static int stl_sc26198getsignals(stlport
 	sigs |= (ipr & IPR_DTR) ? 0: TIOCM_DTR;
 	sigs |= (ipr & IPR_RTS) ? 0: TIOCM_RTS;
 	sigs |= TIOCM_DSR;
-	return(sigs);
+	return sigs;
 }
 
 /*****************************************************************************/
@@ -4828,9 +4828,9 @@ static int stl_sc26198datastate(stlport_
 #endif
 
 	if (portp == (stlport_t *) NULL)
-		return(0);
+		return 0;
 	if (test_bit(ASYI_TXBUSY, &portp->istate))
-		return(1);
+		return 1;
 
 	save_flags(flags);
 	cli();
@@ -4839,7 +4839,7 @@ static int stl_sc26198datastate(stlport_
 	BRDDISABLE(portp->brdnr);
 	restore_flags(flags);
 
-	return((sr & SR_TXEMPTY) ? 0 : 1);
+	return (sr & SR_TXEMPTY) ? 0 : 1;
 }
 
 /*****************************************************************************/
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 5c15f3e..de46e75 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2676,10 +2676,6 @@ config SHAPER
 	  Class-Based Queueing (CBQ) scheduling support which you get if you
 	  say Y to "QoS and/or fair queueing" above.
 
-	  To set up and configure shaper devices, you need the shapecfg
-	  program, available from <ftp://shadow.cabi.net/pub/Linux/> in the
-	  shaper package.
-
 	  To compile this driver as a module, choose M here: the module
 	  will be called shaper.  If unsure, say N.
 
diff --git a/drivers/net/wan/lmc/lmc_main.c b/drivers/net/wan/lmc/lmc_main.c
index 2b948ea..40926d7 100644
--- a/drivers/net/wan/lmc/lmc_main.c
+++ b/drivers/net/wan/lmc/lmc_main.c
@@ -641,7 +641,7 @@ static void lmc_watchdog (unsigned long 
     spin_lock_irqsave(&sc->lmc_lock, flags);
 
     if(sc->check != 0xBEAFCAFE){
-        printk("LMC: Corrupt net_device stuct, breaking out\n");
+        printk("LMC: Corrupt net_device struct, breaking out\n");
 	spin_unlock_irqrestore(&sc->lmc_lock, flags);
         return;
     }
diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index c1a6e69..233a4f6 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -24,10 +24,6 @@ config NET_RADIO
 	  the tools from
 	  <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
 
-	  Some user-level drivers for scarab devices which don't require
-	  special kernel support are available from
-	  <ftp://shadow.cabi.net/pub/Linux/>.
-
 # Note : the cards are obsolete (can't buy them anymore), but the drivers
 # are not, as people are still using them...
 comment "Obsolete Wireless cards support (pre-802.11)"
@@ -160,7 +156,7 @@ config IPW2100
           <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
  
           If you want to compile the driver as a module ( = code which can be
-          inserted in and remvoed from the running kernel whenever you want),
+          inserted in and removed from the running kernel whenever you want),
           say M here and read <file:Documentation/modules.txt>.  The module
           will be called ipw2100.ko.
 	
@@ -213,7 +209,7 @@ config IPW2200
           <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
  
           If you want to compile the driver as a module ( = code which can be
-          inserted in and remvoed from the running kernel whenever you want),
+          inserted in and removed from the running kernel whenever you want),
           say M here and read <file:Documentation/modules.txt>.  The module
           will be called ipw2200.ko.
 
diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 7bdb00b..c065cb8 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -3403,7 +3403,7 @@ zfcp_erp_action_dequeue(struct zfcp_erp_
 /**
  * zfcp_erp_action_cleanup
  *
- * Register unit with scsi stack if appropiate and fix reference counts.
+ * Register unit with scsi stack if appropriate and fix reference counts.
  * Note: Temporary units are not registered with scsi stack.
  */
 static void
diff --git a/drivers/scsi/FlashPoint.c b/drivers/scsi/FlashPoint.c
index 5beed4f..8d64f0b 100644
--- a/drivers/scsi/FlashPoint.c
+++ b/drivers/scsi/FlashPoint.c
@@ -149,7 +149,7 @@ typedef SCCBMGR_INFO *      PSCCBMGR_INF
 #define PCI_BUS_CARD          0x03
 #define VESA_BUS_CARD         0x04
 
-/* SCCB struc used for both SCCB and UCB manager compiles! 
+/* SCCB struct used for both SCCB and UCB manager compiles! 
  * The UCB Manager treats the SCCB as it's 'native hardware structure' 
  */
 
diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
index a6deb01..bd3ffdf 100644
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -328,7 +328,7 @@
  * hdr_channel:x                x - number of virtual bus for host drives
  * shared_access:Y              disable driver reserve/release protocol to 
  *                              access a shared resource from several nodes, 
- *                              appropiate controller firmware required
+ *                              appropriate controller firmware required
  * shared_access:N              enable driver reserve/release protocol
  * probe_eisa_isa:Y             scan for EISA/ISA controllers
  * probe_eisa_isa:N             do not scan for EISA/ISA controllers
diff --git a/fs/efs/super.c b/fs/efs/super.c
index d8d5ea9..afc4891 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -222,12 +222,13 @@ static efs_block_t efs_validate_vh(struc
 			sblock);
 #endif
 	}
-	return(sblock);
+	return sblock;
 }
 
 static int efs_validate_super(struct efs_sb_info *sb, struct efs_super *super) {
 
-	if (!IS_EFS_MAGIC(be32_to_cpu(super->fs_magic))) return -1;
+	if (!IS_EFS_MAGIC(be32_to_cpu(super->fs_magic)))
+		return -1;
 
 	sb->fs_magic     = be32_to_cpu(super->fs_magic);
 	sb->total_blocks = be32_to_cpu(super->fs_size);
diff --git a/fs/sysv/ChangeLog b/fs/sysv/ChangeLog
index 18e3487..f403f8b 100644
--- a/fs/sysv/ChangeLog
+++ b/fs/sysv/ChangeLog
@@ -54,7 +54,7 @@ Fri Jan  4 2002  Alexander Viro  <viro@p
 	  (sysv_read_super): Likewise.
 	  (v7_read_super): Likewise.
 
-Sun Dec 30 2001  Manfred Spraul  <manfreds@colorfullife.com>
+Sun Dec 30 2001  Manfred Spraul  <manfred@colorfullife.com>
 
 	* dir.c (dir_commit_chunk): Do not set dir->i_version.
 	(sysv_readdir): Likewise.
diff --git a/fs/xfs/quota/xfs_qm.c b/fs/xfs/quota/xfs_qm.c
index 7dcdd06..8d58860 100644
--- a/fs/xfs/quota/xfs_qm.c
+++ b/fs/xfs/quota/xfs_qm.c
@@ -497,7 +497,7 @@ xfs_qm_dqflush_all(
 	int		error;
 
 	if (mp->m_quotainfo == NULL)
-		return (0);
+		return 0;
 	niters = 0;
 again:
 	xfs_qm_mplist_lock(mp);
@@ -528,7 +528,7 @@ again:
 		error = xfs_qm_dqflush(dqp, flags);
 		xfs_dqunlock(dqp);
 		if (error)
-			return (error);
+			return error;
 
 		xfs_qm_mplist_lock(mp);
 		if (recl != XFS_QI_MPLRECLAIMS(mp)) {
@@ -540,7 +540,7 @@ again:
 
 	xfs_qm_mplist_unlock(mp);
 	/* return ! busy */
-	return (0);
+	return 0;
 }
 /*
  * Release the group dquot pointers the user dquots may be
@@ -599,7 +599,7 @@ xfs_qm_dqpurge_int(
 	int		nmisses;
 
 	if (mp->m_quotainfo == NULL)
-		return (0);
+		return 0;
 
 	dqtype = (flags & XFS_QMOPT_UQUOTA) ? XFS_DQ_USER : 0;
 	dqtype |= (flags & XFS_QMOPT_PQUOTA) ? XFS_DQ_PROJ : 0;
@@ -796,7 +796,7 @@ xfs_qm_dqattach_one(
 			ASSERT(XFS_DQ_IS_LOCKED(dqp));
 	}
 #endif
-	return (error);
+	return error;
 }
 
 
@@ -897,7 +897,7 @@ xfs_qm_dqattach(
 	    (! XFS_NOT_DQATTACHED(mp, ip)) ||
 	    (ip->i_ino == mp->m_sb.sb_uquotino) ||
 	    (ip->i_ino == mp->m_sb.sb_gquotino))
-		return (0);
+		return 0;
 
 	ASSERT((flags & XFS_QMOPT_ILOCKED) == 0 ||
 	       XFS_ISLOCKED_INODE_EXCL(ip));
@@ -984,7 +984,7 @@ xfs_qm_dqattach(
 	else
 		ASSERT(XFS_ISLOCKED_INODE_EXCL(ip));
 #endif
-	return (error);
+	return error;
 }
 
 /*
@@ -1049,7 +1049,7 @@ xfs_qm_sync(
 	 */
 	if (! XFS_IS_QUOTA_ON(mp)) {
 		xfs_qm_mplist_unlock(mp);
-		return (0);
+		return 0;
 	}
 	FOREACH_DQUOT_IN_MP(dqp, mp) {
 		/*
@@ -1109,9 +1109,9 @@ xfs_qm_sync(
 		error = xfs_qm_dqflush(dqp, flush_flags);
 		xfs_dqunlock(dqp);
 		if (error && XFS_FORCED_SHUTDOWN(mp))
-			return(0);	/* Need to prevent umount failure */
+			return 0;	/* Need to prevent umount failure */
 		else if (error)
-			return (error);
+			return error;
 
 		xfs_qm_mplist_lock(mp);
 		if (recl != XFS_QI_MPLRECLAIMS(mp)) {
@@ -1124,7 +1124,7 @@ xfs_qm_sync(
 	}
 
 	xfs_qm_mplist_unlock(mp);
-	return (0);
+	return 0;
 }
 
 
@@ -1146,7 +1146,7 @@ xfs_qm_init_quotainfo(
 	 * Tell XQM that we exist as soon as possible.
 	 */
 	if ((error = xfs_qm_hold_quotafs_ref(mp))) {
-		return (error);
+		return error;
 	}
 
 	qinf = mp->m_quotainfo = kmem_zalloc(sizeof(xfs_quotainfo_t), KM_SLEEP);
@@ -1158,7 +1158,7 @@ xfs_qm_init_quotainfo(
 	if ((error = xfs_qm_init_quotainos(mp))) {
 		kmem_free(qinf, sizeof(xfs_quotainfo_t));
 		mp->m_quotainfo = NULL;
-		return (error);
+		return error;
 	}
 
 	spinlock_init(&qinf->qi_pinlock, "xfs_qinf_pin");
@@ -1232,7 +1232,7 @@ xfs_qm_init_quotainfo(
 		qinf->qi_rtbwarnlimit = XFS_QM_RTBWARNLIMIT;
 	}
 
-	return (0);
+	return 0;
 }
 
 
@@ -1332,7 +1332,7 @@ xfs_qm_dqget_noattach(
 			 */
 			ASSERT(error != ESRCH);
 			ASSERT(error != ENOENT);
-			return (error);
+			return error;
 		}
 		ASSERT(udqp);
 	}
@@ -1355,7 +1355,7 @@ xfs_qm_dqget_noattach(
 				xfs_qm_dqrele(udqp);
 			ASSERT(error != ESRCH);
 			ASSERT(error != ENOENT);
-			return (error);
+			return error;
 		}
 		ASSERT(gdqp);
 
@@ -1376,7 +1376,7 @@ xfs_qm_dqget_noattach(
 	if (udqp) ASSERT(XFS_DQ_IS_LOCKED(udqp));
 	if (gdqp) ASSERT(XFS_DQ_IS_LOCKED(gdqp));
 #endif
-	return (0);
+	return 0;
 }
 
 /*
@@ -1404,7 +1404,7 @@ xfs_qm_qino_alloc(
 				      XFS_TRANS_PERM_LOG_RES,
 				      XFS_CREATE_LOG_COUNT))) {
 		xfs_trans_cancel(tp, 0);
-		return (error);
+		return error;
 	}
 	memset(&zerocr, 0, sizeof(zerocr));
 	memset(&zeroino, 0, sizeof(zeroino));
@@ -1413,7 +1413,7 @@ xfs_qm_qino_alloc(
 				   &zerocr, 0, 1, ip, &committed))) {
 		xfs_trans_cancel(tp, XFS_TRANS_RELEASE_LOG_RES |
 				 XFS_TRANS_ABORT);
-		return (error);
+		return error;
 	}
 
 	/*
@@ -1461,9 +1461,9 @@ xfs_qm_qino_alloc(
 	if ((error = xfs_trans_commit(tp, XFS_TRANS_RELEASE_LOG_RES,
 				     NULL))) {
 		xfs_fs_cmn_err(CE_ALERT, mp, "XFS qino_alloc failed!");
-		return (error);
+		return error;
 	}
-	return (0);
+	return 0;
 }
 
 
@@ -1508,7 +1508,7 @@ xfs_qm_reset_dqcounts(
 		ddq = (xfs_disk_dquot_t *) ((xfs_dqblk_t *)ddq + 1);
 	}
 
-	return (0);
+	return 0;
 }
 
 STATIC int
@@ -1557,7 +1557,7 @@ xfs_qm_dqiter_bufs(
 		bno++;
 		firstid += XFS_QM_DQPERBLK(mp);
 	}
-	return (error);
+	return error;
 }
 
 /*
@@ -1586,7 +1586,7 @@ xfs_qm_dqiterate(
 	 * happens only at mount time which is single threaded.
 	 */
 	if (qip->i_d.di_nblocks == 0)
-		return (0);
+		return 0;
 
 	map = kmem_alloc(XFS_DQITER_MAP_SIZE * sizeof(*map), KM_SLEEP);
 
@@ -1655,7 +1655,7 @@ xfs_qm_dqiterate(
 
 	kmem_free(map, XFS_DQITER_MAP_SIZE * sizeof(*map));
 
-	return (error);
+	return error;
 }
 
 /*
@@ -1715,7 +1715,7 @@ xfs_qm_get_rtblks(
 	ifp = XFS_IFORK_PTR(ip, XFS_DATA_FORK);
 	if (!(ifp->if_flags & XFS_IFEXTENTS)) {
 		if ((error = xfs_iread_extents(NULL, ip, XFS_DATA_FORK)))
-			return (error);
+			return error;
 	}
 	rtblks = 0;
 	nextents = ifp->if_bytes / sizeof(xfs_bmbt_rec_t);
@@ -1723,7 +1723,7 @@ xfs_qm_get_rtblks(
 	for (ep = base; ep < &base[nextents]; ep++)
 		rtblks += xfs_bmbt_get_blockcount(ep);
 	*O_rtblks = (xfs_qcnt_t)rtblks;
-	return (0);
+	return 0;
 }
 
 /*
@@ -1767,7 +1767,7 @@ xfs_qm_dqusage_adjust(
 	 */
 	if ((error = xfs_iget(mp, NULL, ino, 0, XFS_ILOCK_EXCL, &ip, bno))) {
 		*res = BULKSTAT_RV_NOTHING;
-		return (error);
+		return error;
 	}
 
 	if (ip->i_d.di_mode == 0) {
@@ -1785,7 +1785,7 @@ xfs_qm_dqusage_adjust(
 	if ((error = xfs_qm_dqget_noattach(ip, &udqp, &gdqp))) {
 		xfs_iput(ip, XFS_ILOCK_EXCL);
 		*res = BULKSTAT_RV_GIVEUP;
-		return (error);
+		return error;
 	}
 
 	rtblks = 0;
@@ -1802,7 +1802,7 @@ xfs_qm_dqusage_adjust(
 			if (gdqp)
 				xfs_qm_dqput(gdqp);
 			*res = BULKSTAT_RV_GIVEUP;
-			return (error);
+			return error;
 		}
 		nblks = (xfs_qcnt_t)ip->i_d.di_nblocks - rtblks;
 	}
@@ -1847,7 +1847,7 @@ xfs_qm_dqusage_adjust(
 	 * Goto next inode.
 	 */
 	*res = BULKSTAT_RV_DIDONE;
-	return (0);
+	return 0;
 }
 
 /*
@@ -2041,7 +2041,7 @@ xfs_qm_init_quotainos(
 	XFS_QI_UQIP(mp) = uip;
 	XFS_QI_GQIP(mp) = gip;
 
-	return (0);
+	return 0;
 }
 
 
@@ -2062,7 +2062,7 @@ xfs_qm_shake_freelist(
 	int		nflushes;
 
 	if (howmany <= 0)
-		return (0);
+		return 0;
 
 	nreclaimed = 0;
 	restarts = 0;
@@ -2088,7 +2088,7 @@ xfs_qm_shake_freelist(
 			xfs_dqunlock(dqp);
 			xfs_qm_freelist_unlock(xfs_Gqm);
 			if (++restarts >= XFS_QM_RECLAIM_MAX_RESTARTS)
-				return (nreclaimed);
+				return nreclaimed;
 			XQM_STATS_INC(xqmstats.xs_qm_dqwants);
 			goto tryagain;
 		}
@@ -2163,7 +2163,7 @@ xfs_qm_shake_freelist(
 			XFS_DQ_HASH_UNLOCK(hash);
 			xfs_qm_freelist_unlock(xfs_Gqm);
 			if (++restarts >= XFS_QM_RECLAIM_MAX_RESTARTS)
-				return (nreclaimed);
+				return nreclaimed;
 			goto tryagain;
 		}
 		xfs_dqtrace_entry(dqp, "DQSHAKE: UNLINKING");
@@ -2188,7 +2188,7 @@ xfs_qm_shake_freelist(
 		dqp = nextdqp;
 	}
 	xfs_qm_freelist_unlock(xfs_Gqm);
-	return (nreclaimed);
+	return nreclaimed;
 }
 
 
@@ -2202,9 +2202,9 @@ xfs_qm_shake(int nr_to_scan, gfp_t gfp_m
 	int	ndqused, nfree, n;
 
 	if (!kmem_shake_allow(gfp_mask))
-		return (0);
+		return 0;
 	if (!xfs_Gqm)
-		return (0);
+		return 0;
 
 	nfree = xfs_Gqm->qm_dqfreelist.qh_nelems; /* free dquots */
 	/* incore dquots in all f/s's */
@@ -2213,7 +2213,7 @@ xfs_qm_shake(int nr_to_scan, gfp_t gfp_m
 	ASSERT(ndqused >= 0);
 
 	if (nfree <= ndqused && nfree < ndquot)
-		return (0);
+		return 0;
 
 	ndqused *= xfs_Gqm->qm_dqfree_ratio;	/* target # of free dquots */
 	n = nfree - ndqused - ndquot;		/* # over target */
@@ -2257,7 +2257,7 @@ xfs_qm_dqreclaim_one(void)
 			xfs_dqunlock(dqp);
 			xfs_qm_freelist_unlock(xfs_Gqm);
 			if (++restarts >= XFS_QM_RECLAIM_MAX_RESTARTS)
-				return (NULL);
+				return NULL;
 			XQM_STATS_INC(xqmstats.xs_qm_dqwants);
 			goto startagain;
 		}
@@ -2333,7 +2333,7 @@ xfs_qm_dqreclaim_one(void)
 	}
 
 	xfs_qm_freelist_unlock(xfs_Gqm);
-	return (dqpout);
+	return dqpout;
 }
 
 
@@ -2369,7 +2369,7 @@ xfs_qm_dqalloc_incore(
 			 */
 			memset(&dqp->q_core, 0, sizeof(dqp->q_core));
 			*O_dqpp = dqp;
-			return (B_FALSE);
+			return B_FALSE;
 		}
 		XQM_STATS_INC(xqmstats.xs_qm_dqreclaim_misses);
 	}
@@ -2382,7 +2382,7 @@ xfs_qm_dqalloc_incore(
 	*O_dqpp = kmem_zone_zalloc(xfs_Gqm->qm_dqzone, KM_SLEEP);
 	atomic_inc(&xfs_Gqm->qm_totaldquots);
 
-	return (B_TRUE);
+	return B_TRUE;
 }
 
 
@@ -2407,13 +2407,13 @@ xfs_qm_write_sb_changes(
 				      0,
 				      XFS_DEFAULT_LOG_COUNT))) {
 		xfs_trans_cancel(tp, 0);
-		return (error);
+		return error;
 	}
 
 	xfs_mod_sb(tp, flags);
 	(void) xfs_trans_commit(tp, 0, NULL);
 
-	return (0);
+	return 0;
 }
 
 
@@ -2463,7 +2463,7 @@ xfs_qm_vop_dqalloc(
 		if ((error = xfs_qm_dqattach(ip, XFS_QMOPT_DQALLOC |
 					    XFS_QMOPT_ILOCKED))) {
 			xfs_iunlock(ip, lockflags);
-			return (error);
+			return error;
 		}
 	}
 
@@ -2486,7 +2486,7 @@ xfs_qm_vop_dqalloc(
 						 XFS_QMOPT_DOWARN,
 						 &uq))) {
 				ASSERT(error != ENOENT);
-				return (error);
+				return error;
 			}
 			/*
 			 * Get the ilock in the right order.
@@ -2517,7 +2517,7 @@ xfs_qm_vop_dqalloc(
 				if (uq)
 					xfs_qm_dqrele(uq);
 				ASSERT(error != ENOENT);
-				return (error);
+				return error;
 			}
 			xfs_dqunlock(gq);
 			lockflags = XFS_ILOCK_SHARED;
@@ -2565,7 +2565,7 @@ xfs_qm_vop_dqalloc(
 		*O_gdqpp = gq;
 	else if (gq)
 		xfs_qm_dqrele(gq);
-	return (0);
+	return 0;
 }
 
 /*
@@ -2608,7 +2608,7 @@ xfs_qm_vop_chown(
 	xfs_dqunlock(newdq);
 	*IO_olddq = newdq;
 
-	return (prevdq);
+	return prevdq;
 }
 
 /*
@@ -2702,12 +2702,12 @@ xfs_qm_vop_rename_dqattach(
 	ip = i_tab[0];
 
 	if (! XFS_IS_QUOTA_ON(ip->i_mount))
-		return (0);
+		return 0;
 
 	if (XFS_NOT_DQATTACHED(ip->i_mount, ip)) {
 		error = xfs_qm_dqattach(ip, 0);
 		if (error)
-			return (error);
+			return error;
 	}
 	for (i = 1; (i < 4 && i_tab[i]); i++) {
 		/*
@@ -2717,11 +2717,11 @@ xfs_qm_vop_rename_dqattach(
 			if (XFS_NOT_DQATTACHED(ip->i_mount, ip)) {
 				error = xfs_qm_dqattach(ip, 0);
 				if (error)
-					return (error);
+					return error;
 			}
 		}
 	}
-	return (0);
+	return 0;
 }
 
 void
@@ -2834,7 +2834,7 @@ xfs_qm_dqhashlock_nowait(
 	int locked;
 
 	locked = mutex_trylock(&((dqp)->q_hash->qh_lock));
-	return (locked);
+	return locked;
 }
 
 int
@@ -2844,7 +2844,7 @@ xfs_qm_freelist_lock_nowait(
 	int locked;
 
 	locked = mutex_trylock(&(xqm->qm_dqfreelist.qh_lock));
-	return (locked);
+	return locked;
 }
 
 STATIC int
@@ -2855,5 +2855,5 @@ xfs_qm_mplist_nowait(
 
 	ASSERT(mp->m_quotainfo);
 	locked = mutex_trylock(&(XFS_QI_MPLLOCK(mp)));
-	return (locked);
+	return locked;
 }
diff --git a/fs/xfs/xfs_dir_leaf.c b/fs/xfs/xfs_dir_leaf.c
index 950df31..e830740 100644
--- a/fs/xfs/xfs_dir_leaf.c
+++ b/fs/xfs/xfs_dir_leaf.c
@@ -147,7 +147,7 @@ xfs_dir_shortform_create(xfs_da_args_t *
 	hdr->count = 0;
 	dp->i_d.di_size = sizeof(*hdr);
 	xfs_trans_log_inode(args->trans, dp, XFS_ILOG_CORE | XFS_ILOG_DDATA);
-	return(0);
+	return 0;
 }
 
 /*
@@ -180,7 +180,7 @@ xfs_dir_shortform_addname(xfs_da_args_t 
 		if (sfe->namelen == args->namelen &&
 		    args->name[0] == sfe->name[0] &&
 		    memcmp(args->name, sfe->name, args->namelen) == 0)
-			return(XFS_ERROR(EEXIST));
+			return XFS_ERROR(EEXIST);
 		sfe = XFS_DIR_SF_NEXTENTRY(sfe);
 	}
 
@@ -198,7 +198,7 @@ xfs_dir_shortform_addname(xfs_da_args_t 
 	dp->i_d.di_size += size;
 	xfs_trans_log_inode(args->trans, dp, XFS_ILOG_CORE | XFS_ILOG_DDATA);
 
-	return(0);
+	return 0;
 }
 
 /*
@@ -238,7 +238,7 @@ xfs_dir_shortform_removename(xfs_da_args
 	}
 	if (i < 0) {
 		ASSERT(args->oknoent);
-		return(XFS_ERROR(ENOENT));
+		return XFS_ERROR(ENOENT);
 	}
 
 	if ((base + size) != dp->i_d.di_size) {
@@ -251,7 +251,7 @@ xfs_dir_shortform_removename(xfs_da_args
 	dp->i_d.di_size -= size;
 	xfs_trans_log_inode(args->trans, dp, XFS_ILOG_CORE | XFS_ILOG_DDATA);
 
-	return(0);
+	return 0;
 }
 
 /*
@@ -390,7 +390,7 @@ xfs_dir_shortform_to_leaf(xfs_da_args_t 
 
 out:
 	kmem_free(tmpbuffer, size);
-	return(retval);
+	return retval;
 }
 
 STATIC int
@@ -596,7 +596,7 @@ xfs_dir_shortform_replace(xfs_da_args_t 
 		/* XXX - replace assert? */
 		XFS_DIR_SF_PUT_DIRINO(&args->inumber, &sf->hdr.parent);
 		xfs_trans_log_inode(args->trans, dp, XFS_ILOG_DDATA);
-		return(0);
+		return 0;
 	}
 	ASSERT(args->namelen != 1 || args->name[0] != '.');
 	sfe = &sf->list[0];
@@ -608,12 +608,12 @@ xfs_dir_shortform_replace(xfs_da_args_t 
 				(char *)&sfe->inumber, sizeof(xfs_ino_t)));
 			XFS_DIR_SF_PUT_DIRINO(&args->inumber, &sfe->inumber);
 			xfs_trans_log_inode(args->trans, dp, XFS_ILOG_DDATA);
-			return(0);
+			return 0;
 		}
 		sfe = XFS_DIR_SF_NEXTENTRY(sfe);
 	}
 	ASSERT(args->oknoent);
-	return(XFS_ERROR(ENOENT));
+	return XFS_ERROR(ENOENT);
 }
 
 /*
@@ -695,7 +695,7 @@ xfs_dir_leaf_to_shortform(xfs_da_args_t 
 
 out:
 	kmem_free(tmpbuffer, XFS_LBSIZE(dp->i_mount));
-	return(retval);
+	return retval;
 }
 
 /*
@@ -715,17 +715,17 @@ xfs_dir_leaf_to_node(xfs_da_args_t *args
 	retval = xfs_da_grow_inode(args, &blkno);
 	ASSERT(blkno == 1);
 	if (retval)
-		return(retval);
+		return retval;
 	retval = xfs_da_read_buf(args->trans, args->dp, 0, -1, &bp1,
 					      XFS_DATA_FORK);
 	if (retval)
-		return(retval);
+		return retval;
 	ASSERT(bp1 != NULL);
 	retval = xfs_da_get_buf(args->trans, args->dp, 1, -1, &bp2,
 					     XFS_DATA_FORK);
 	if (retval) {
 		xfs_da_buf_done(bp1);
-		return(retval);
+		return retval;
 	}
 	ASSERT(bp2 != NULL);
 	memcpy(bp2->data, bp1->data, XFS_LBSIZE(dp->i_mount));
@@ -738,7 +738,7 @@ xfs_dir_leaf_to_node(xfs_da_args_t *args
 	retval = xfs_da_node_create(args, 0, 1, &bp1, XFS_DATA_FORK);
 	if (retval) {
 		xfs_da_buf_done(bp2);
-		return(retval);
+		return retval;
 	}
 	node = bp1->data;
 	leaf = bp2->data;
@@ -751,7 +751,7 @@ xfs_dir_leaf_to_node(xfs_da_args_t *args
 		XFS_DA_LOGRANGE(node, &node->btree[0], sizeof(node->btree[0])));
 	xfs_da_buf_done(bp1);
 
-	return(retval);
+	return retval;
 }
 
 
@@ -776,7 +776,7 @@ xfs_dir_leaf_create(xfs_da_args_t *args,
 	ASSERT(dp != NULL);
 	retval = xfs_da_get_buf(args->trans, dp, blkno, -1, &bp, XFS_DATA_FORK);
 	if (retval)
-		return(retval);
+		return retval;
 	ASSERT(bp != NULL);
 	leaf = bp->data;
 	memset((char *)leaf, 0, XFS_LBSIZE(dp->i_mount));
@@ -791,7 +791,7 @@ xfs_dir_leaf_create(xfs_da_args_t *args,
 	xfs_da_log_buf(args->trans, bp, 0, XFS_LBSIZE(dp->i_mount) - 1);
 
 	*bpp = bp;
-	return(0);
+	return 0;
 }
 
 /*
@@ -813,10 +813,10 @@ xfs_dir_leaf_split(xfs_da_state_t *state
 	ASSERT(oldblk->magic == XFS_DIR_LEAF_MAGIC);
 	error = xfs_da_grow_inode(args, &blkno);
 	if (error)
-		return(error);
+		return error;
 	error = xfs_dir_leaf_create(args, blkno, &newblk->bp);
 	if (error)
-		return(error);
+		return error;
 	newblk->blkno = blkno;
 	newblk->magic = XFS_DIR_LEAF_MAGIC;
 
@@ -826,7 +826,7 @@ xfs_dir_leaf_split(xfs_da_state_t *state
 	xfs_dir_leaf_rebalance(state, oldblk, newblk);
 	error = xfs_da_blk_link(state, oldblk, newblk);
 	if (error)
-		return(error);
+		return error;
 
 	/*
 	 * Insert the new entry in the correct block.
@@ -842,7 +842,7 @@ xfs_dir_leaf_split(xfs_da_state_t *state
 	 */
 	oldblk->hashval = xfs_dir_leaf_lasthash(oldblk->bp, NULL);
 	newblk->hashval = xfs_dir_leaf_lasthash(newblk->bp, NULL);
-	return(error);
+	return error;
 }
 
 /*
@@ -885,7 +885,7 @@ xfs_dir_leaf_add(xfs_dabuf_t *bp, xfs_da
 		if (INT_GET(map->size, ARCH_CONVERT) >= tmp) {
 			if (!args->justcheck)
 				xfs_dir_leaf_add_work(bp, args, index, i);
-			return(0);
+			return 0;
 		}
 		sum += INT_GET(map->size, ARCH_CONVERT);
 	}
@@ -896,7 +896,7 @@ xfs_dir_leaf_add(xfs_dabuf_t *bp, xfs_da
 	 * no good and we should just give up.
 	 */
 	if (!hdr->holes && (sum < entsize))
-		return(XFS_ERROR(ENOSPC));
+		return XFS_ERROR(ENOSPC);
 
 	/*
 	 * Compact the entries to coalesce free space.
@@ -909,18 +909,18 @@ xfs_dir_leaf_add(xfs_dabuf_t *bp, xfs_da
 				(uint)sizeof(xfs_dir_leaf_entry_t) : 0,
 			args->justcheck);
 	if (error)
-		return(error);
+		return error;
 	/*
 	 * After compaction, the block is guaranteed to have only one
 	 * free region, in freemap[0].  If it is not big enough, give up.
 	 */
 	if (INT_GET(hdr->freemap[0].size, ARCH_CONVERT) <
 	    (entsize + (uint)sizeof(xfs_dir_leaf_entry_t)))
-		return(XFS_ERROR(ENOSPC));
+		return XFS_ERROR(ENOSPC);
 
 	if (!args->justcheck)
 		xfs_dir_leaf_add_work(bp, args, index, 0);
-	return(0);
+	return 0;
 }
 
 /*
@@ -1072,7 +1072,7 @@ xfs_dir_leaf_compact(xfs_trans_t *trans,
 	kmem_free(tmpbuffer, lbsize);
 	if (musthave || justcheck)
 		kmem_free(tmpbuffer2, lbsize);
-	return(rval);
+	return rval;
 }
 
 /*
@@ -1292,7 +1292,7 @@ xfs_dir_leaf_figure_balance(xfs_da_state
 
 	*countarg = count;
 	*namebytesarg = totallen;
-	return(foundit);
+	return foundit;
 }
 
 /*========================================================================
@@ -1334,7 +1334,7 @@ xfs_dir_leaf_toosmall(xfs_da_state_t *st
 		INT_GET(leaf->hdr.namebytes, ARCH_CONVERT);
 	if (bytes > (state->blocksize >> 1)) {
 		*action = 0;	/* blk over 50%, don't try to join */
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -1353,13 +1353,13 @@ xfs_dir_leaf_toosmall(xfs_da_state_t *st
 		error = xfs_da_path_shift(state, &state->altpath, forward,
 						 0, &retval);
 		if (error)
-			return(error);
+			return error;
 		if (retval) {
 			*action = 0;
 		} else {
 			*action = 2;
 		}
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -1381,7 +1381,7 @@ xfs_dir_leaf_toosmall(xfs_da_state_t *st
 							    blkno, -1, &bp,
 							    XFS_DATA_FORK);
 		if (error)
-			return(error);
+			return error;
 		ASSERT(bp != NULL);
 
 		leaf = (xfs_dir_leafblock_t *)info;
@@ -1402,7 +1402,7 @@ xfs_dir_leaf_toosmall(xfs_da_state_t *st
 	}
 	if (i >= 2) {
 		*action = 0;
-		return(0);
+		return 0;
 	}
 	xfs_da_buf_done(bp);
 
@@ -1419,13 +1419,13 @@ xfs_dir_leaf_toosmall(xfs_da_state_t *st
 						 0, &retval);
 	}
 	if (error)
-		return(error);
+		return error;
 	if (retval) {
 		*action = 0;
 	} else {
 		*action = 1;
 	}
-	return(0);
+	return 0;
 }
 
 /*
@@ -1575,8 +1575,8 @@ xfs_dir_leaf_remove(xfs_trans_t *trans, 
 	tmp += INT_GET(leaf->hdr.count, ARCH_CONVERT) * ((uint)sizeof(xfs_dir_leaf_name_t) - 1);
 	tmp += INT_GET(leaf->hdr.namebytes, ARCH_CONVERT);
 	if (tmp < mp->m_dir_magicpct)
-		return(1);			/* leaf is < 37% full */
-	return(0);
+		return 1;			/* leaf is < 37% full */
+	return 0;
 }
 
 /*
@@ -1732,7 +1732,7 @@ xfs_dir_leaf_lookup_int(xfs_dabuf_t *bp,
 	if ((probe == INT_GET(leaf->hdr.count, ARCH_CONVERT)) || (INT_GET(entry->hashval, ARCH_CONVERT) != hashval)) {
 		*index = probe;
 		ASSERT(args->oknoent);
-		return(XFS_ERROR(ENOENT));
+		return XFS_ERROR(ENOENT);
 	}
 
 	/*
@@ -1745,14 +1745,14 @@ xfs_dir_leaf_lookup_int(xfs_dabuf_t *bp,
 		    memcmp(args->name, namest->name, args->namelen) == 0) {
 			XFS_DIR_SF_GET_DIRINO(&namest->inumber, &args->inumber);
 			*index = probe;
-			return(XFS_ERROR(EEXIST));
+			return XFS_ERROR(EEXIST);
 		}
 		entry++;
 		probe++;
 	}
 	*index = probe;
 	ASSERT(probe == INT_GET(leaf->hdr.count, ARCH_CONVERT) || args->oknoent);
-	return(XFS_ERROR(ENOENT));
+	return XFS_ERROR(ENOENT);
 }
 
 /*========================================================================
@@ -1890,9 +1890,9 @@ xfs_dir_leaf_order(xfs_dabuf_t *leaf1_bp
 	      INT_GET(leaf1->entries[ 0 ].hashval, ARCH_CONVERT)) ||
 	     (INT_GET(leaf2->entries[ INT_GET(leaf2->hdr.count, ARCH_CONVERT)-1 ].hashval, ARCH_CONVERT) <
 	      INT_GET(leaf1->entries[ INT_GET(leaf1->hdr.count, ARCH_CONVERT)-1 ].hashval, ARCH_CONVERT)))) {
-		return(1);
+		return 1;
 	}
-	return(0);
+	return 0;
 }
 
 /*
@@ -1942,7 +1942,7 @@ xfs_dir_leaf_getdents_int(
 	leaf = bp->data;
 	if (INT_GET(leaf->hdr.info.magic, ARCH_CONVERT) != XFS_DIR_LEAF_MAGIC) {
 		*eobp = 1;
-		return(XFS_ERROR(ENOENT));	/* XXX wrong code */
+		return XFS_ERROR(ENOENT);	/* XXX wrong code */
 	}
 
 	want_entno = XFS_DA_COOKIE_ENTRY(mp, uio->uio_offset);
@@ -2000,7 +2000,7 @@ xfs_dir_leaf_getdents_int(
 		 * the node code will be setting uio_offset anyway.
 		 */
 		*eobp = 0;
-		return(0);
+		return 0;
 	}
 	xfs_dir_trace_g_due("leaf: hash found", dp, uio, entry);
 
@@ -2057,7 +2057,7 @@ xfs_dir_leaf_getdents_int(
 			retval = xfs_da_read_buf(dp->i_transp, dp, thishash,
 						 nextda, &bp2, XFS_DATA_FORK);
 			if (retval)
-				return(retval);
+				return retval;
 
 			ASSERT(bp2 != NULL);
 
@@ -2073,7 +2073,7 @@ xfs_dir_leaf_getdents_int(
 						     leaf2);
 				xfs_da_brelse(dp->i_transp, bp2);
 
-				return(XFS_ERROR(EFSCORRUPTED));
+				return XFS_ERROR(EFSCORRUPTED);
 			}
 
 			nexthash = INT_GET(leaf2->entries[0].hashval,
@@ -2139,7 +2139,7 @@ xfs_dir_leaf_getdents_int(
 
 			xfs_dir_trace_g_du("leaf: E-O-B", dp, uio);
 
-			return(retval);
+			return retval;
 		}
 	}
 
@@ -2149,7 +2149,7 @@ xfs_dir_leaf_getdents_int(
 
 	xfs_dir_trace_g_du("leaf: E-O-F", dp, uio);
 
-	return(0);
+	return 0;
 }
 
 /*
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 163031c..b4d971b 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -501,7 +501,7 @@ xfs_reserve_blocks(
 	if (inval == (__uint64_t *)NULL) {
 		outval->resblks = mp->m_resblks;
 		outval->resblks_avail = mp->m_resblks_avail;
-		return(0);
+		return 0;
 	}
 
 	request = *inval;
@@ -537,7 +537,7 @@ xfs_reserve_blocks(
 	outval->resblks = mp->m_resblks;
 	outval->resblks_avail = mp->m_resblks_avail;
 	XFS_SB_UNLOCK(mp, s);
-	return(0);
+	return 0;
 }
 
 void
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 3d9a36e..9176995 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -403,7 +403,7 @@ xfs_log_release_iclog(xfs_mount_t *mp,
 
 	if (xlog_state_release_iclog(log, iclog)) {
 		xfs_force_shutdown(mp, XFS_LOG_IO_ERROR);
-		return(EIO);
+		return EIO;
 	}
 
 	return 0;
@@ -556,7 +556,7 @@ xfs_log_unmount(xfs_mount_t *mp)
 
 	error = xfs_log_unmount_write(mp);
 	xfs_log_unmount_dealloc(mp);
-	return (error);
+	return error;
 }
 
 /*
@@ -728,7 +728,7 @@ xfs_log_write(xfs_mount_t *	mp,
 	if ((error = xlog_write(mp, reg, nentries, tic, start_lsn, NULL, 0))) {
 		xfs_force_shutdown(mp, XFS_LOG_IO_ERROR);
 	}
-	return (error);
+	return error;
 }	/* xfs_log_write */
 
 
@@ -836,7 +836,7 @@ xfs_log_need_covered(xfs_mount_t *mp)
 		needed = 1;
 	}
 	LOG_UNLOCK(log, s);
-	return(needed);
+	return needed;
 }
 
 /******************************************************************************
@@ -1003,7 +1003,7 @@ xlog_bdstrat_cb(struct xfs_buf *bp)
 	XFS_BUF_ERROR(bp, EIO);
 	XFS_BUF_STALE(bp);
 	xfs_biodone(bp);
-	return (XFS_ERROR(EIO));
+	return XFS_ERROR(EIO);
 
 
 }
@@ -1263,7 +1263,7 @@ xlog_commit_record(xfs_mount_t  *mp,
 			       iclog, XLOG_COMMIT_TRANS))) {
 		xfs_force_shutdown(mp, XFS_LOG_IO_ERROR);
 	}
-	return (error);
+	return error;
 }	/* xlog_commit_record */
 
 
@@ -1460,7 +1460,7 @@ xlog_sync(xlog_t		*log,
 	if ((error = XFS_bwrite(bp))) {
 		xfs_ioerror_alert("xlog_sync", log->l_mp, bp,
 				  XFS_BUF_ADDR(bp));
-		return (error);
+		return error;
 	}
 	if (split) {
 		bp		= iclog->ic_log->l_xbuf;
@@ -1498,10 +1498,10 @@ xlog_sync(xlog_t		*log,
 		if ((error = XFS_bwrite(bp))) {
 			xfs_ioerror_alert("xlog_sync (split)", log->l_mp,
 					  bp, XFS_BUF_ADDR(bp));
-			return (error);
+			return error;
 		}
 	}
-	return (0);
+	return 0;
 }	/* xlog_sync */
 
 
@@ -1798,7 +1798,7 @@ xlog_write(xfs_mount_t *	mp,
     for (index = 0; index < nentries; ) {
 	if ((error = xlog_state_get_iclog_space(log, len, &iclog, ticket,
 					       &contwr, &log_offset)))
-		return (error);
+		return error;
 
 	ASSERT(log_offset <= iclog->ic_size - 1);
 	ptr = (__psint_t) ((char *)iclog->ic_datap+log_offset);
@@ -1903,7 +1903,7 @@ xlog_write(xfs_mount_t *	mp,
 		    xlog_state_finish_copy(log, iclog, record_cnt, data_cnt);
 		    record_cnt = data_cnt = 0;
 		    if ((error = xlog_state_release_iclog(log, iclog)))
-			    return (error);
+			    return error;
 		    break;			/* don't increment index */
 	    } else {				/* copied entire region */
 		index++;
@@ -1917,7 +1917,7 @@ xlog_write(xfs_mount_t *	mp,
 			ASSERT(flags & XLOG_COMMIT_TRANS);
 			*commit_iclog = iclog;
 		    } else if ((error = xlog_state_release_iclog(log, iclog)))
-			   return (error);
+			   return error;
 		    if (index == nentries)
 			    return 0;		/* we are done */
 		    else
@@ -1934,7 +1934,7 @@ xlog_write(xfs_mount_t *	mp,
 	*commit_iclog = iclog;
 	return 0;
     }
-    return (xlog_state_release_iclog(log, iclog));
+    return xlog_state_release_iclog(log, iclog);
 }	/* xlog_write */
 
 
@@ -2050,7 +2050,7 @@ xlog_get_lowest_lsn(
 	    }
 	    lsn_log = lsn_log->ic_next;
 	} while (lsn_log != log->l_iclog);
-	return(lowest_lsn);
+	return lowest_lsn;
 }
 
 
@@ -2402,7 +2402,7 @@ restart:
 		if (iclog->ic_refcnt == 1) {
 			LOG_UNLOCK(log, s);
 			if ((error = xlog_state_release_iclog(log, iclog)))
-				return (error);
+				return error;
 		} else {
 			iclog->ic_refcnt--;
 			LOG_UNLOCK(log, s);
@@ -2569,7 +2569,7 @@ xlog_regrant_write_log_space(xlog_t	   *
 	XLOG_TIC_RESET_RES(tic);
 
 	if (tic->t_cnt > 0)
-		return (0);
+		return 0;
 
 #ifdef DEBUG
 	if (log->l_flags & XLOG_ACTIVE_RECOVERY)
@@ -2667,7 +2667,7 @@ redo:
 	xlog_trace_loggrant(log, tic, "xlog_regrant_write_log_space: exit");
 	xlog_verify_grant_head(log, 1);
 	GRANT_UNLOCK(log, s);
-	return (0);
+	return 0;
 
 
  error_return:
@@ -2837,7 +2837,7 @@ xlog_state_release_iclog(xlog_t		*log,
 	if (sync) {
 		return xlog_sync(log, iclog);
 	}
-	return (0);
+	return 0;
 
 }	/* xlog_state_release_iclog */
 
@@ -3127,7 +3127,7 @@ try_again:
     } while (iclog != log->l_iclog);
 
     LOG_UNLOCK(log, s);
-    return (0);
+    return 0;
 }	/* xlog_state_sync */
 
 
@@ -3545,12 +3545,12 @@ xlog_state_ioerror(
 			ic->ic_state = XLOG_STATE_IOERROR;
 			ic = ic->ic_next;
 		} while (ic != iclog);
-		return (0);
+		return 0;
 	}
 	/*
 	 * Return non-zero, if state transition has already happened.
 	 */
-	return (1);
+	return 1;
 }
 
 /*
@@ -3587,7 +3587,7 @@ xfs_log_force_umount(
 	    log->l_flags & XLOG_ACTIVE_RECOVERY) {
 		mp->m_flags |= XFS_MOUNT_FS_SHUTDOWN;
 		XFS_BUF_DONE(mp->m_sb_bp);
-		return (0);
+		return 0;
 	}
 
 	/*
@@ -3596,7 +3596,7 @@ xfs_log_force_umount(
 	 */
 	if (logerror && log->l_iclog->ic_state & XLOG_STATE_IOERROR) {
 		ASSERT(XLOG_FORCED_SHUTDOWN(log));
-		return (1);
+		return 1;
 	}
 	retval = 0;
 	/*
@@ -3678,7 +3678,7 @@ xfs_log_force_umount(
 	}
 #endif
 	/* return non-zero if log IOERROR transition had already happened */
-	return (retval);
+	return retval;
 }
 
 STATIC int
@@ -3692,8 +3692,8 @@ xlog_iclogs_empty(xlog_t *log)
 		 * any language.
 		 */
 		if (iclog->ic_header.h_num_logops)
-			return(0);
+			return 0;
 		iclog = iclog->ic_next;
 	} while (iclog != log->l_iclog);
-	return(1);
+	return 1;
 }
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 6088e14..62188ea 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -646,7 +646,7 @@ xfs_mountfs(
 
 	if (mp->m_sb_bp == NULL) {
 		if ((error = xfs_readsb(mp))) {
-			return (error);
+			return error;
 		}
 	}
 	xfs_mount_common(mp, sbp);
@@ -889,7 +889,7 @@ xfs_mountfs(
 	 * For client case we are done now
 	 */
 	if (mfsi_flags & XFS_MFSI_CLIENT) {
-		return(0);
+		return 0;
 	}
 
 	/*
@@ -1182,7 +1182,7 @@ xfs_unmountfs_writesb(xfs_mount_t *mp)
 			xfs_fs_cmn_err(CE_ALERT, mp, "Superblock write error detected while unmounting.  Filesystem may not be marked shared readonly");
 	}
 	xfs_buf_relse(sbp);
-	return (error);
+	return error;
 }
 
 /*
@@ -1257,19 +1257,19 @@ xfs_mod_incore_sb_unlocked(xfs_mount_t *
 		lcounter += delta;
 		if (lcounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_icount = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_IFREE:
 		lcounter = (long long)mp->m_sb.sb_ifree;
 		lcounter += delta;
 		if (lcounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_ifree = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_FDBLOCKS:
 
 		lcounter = (long long)mp->m_sb.sb_fdblocks;
@@ -1296,101 +1296,101 @@ xfs_mod_incore_sb_unlocked(xfs_mount_t *
 				if (rsvd) {
 					lcounter = (long long)mp->m_resblks_avail + delta;
 					if (lcounter < 0) {
-						return (XFS_ERROR(ENOSPC));
+						return XFS_ERROR(ENOSPC);
 					}
 					mp->m_resblks_avail = lcounter;
-					return (0);
+					return 0;
 				} else {	/* not reserved */
-					return (XFS_ERROR(ENOSPC));
+					return XFS_ERROR(ENOSPC);
 				}
 			}
 		}
 
 		mp->m_sb.sb_fdblocks = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_FREXTENTS:
 		lcounter = (long long)mp->m_sb.sb_frextents;
 		lcounter += delta;
 		if (lcounter < 0) {
-			return (XFS_ERROR(ENOSPC));
+			return XFS_ERROR(ENOSPC);
 		}
 		mp->m_sb.sb_frextents = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_DBLOCKS:
 		lcounter = (long long)mp->m_sb.sb_dblocks;
 		lcounter += delta;
 		if (lcounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_dblocks = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_AGCOUNT:
 		scounter = mp->m_sb.sb_agcount;
 		scounter += delta;
 		if (scounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_agcount = scounter;
-		return (0);
+		return 0;
 	case XFS_SBS_IMAX_PCT:
 		scounter = mp->m_sb.sb_imax_pct;
 		scounter += delta;
 		if (scounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_imax_pct = scounter;
-		return (0);
+		return 0;
 	case XFS_SBS_REXTSIZE:
 		scounter = mp->m_sb.sb_rextsize;
 		scounter += delta;
 		if (scounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_rextsize = scounter;
-		return (0);
+		return 0;
 	case XFS_SBS_RBMBLOCKS:
 		scounter = mp->m_sb.sb_rbmblocks;
 		scounter += delta;
 		if (scounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_rbmblocks = scounter;
-		return (0);
+		return 0;
 	case XFS_SBS_RBLOCKS:
 		lcounter = (long long)mp->m_sb.sb_rblocks;
 		lcounter += delta;
 		if (lcounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_rblocks = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_REXTENTS:
 		lcounter = (long long)mp->m_sb.sb_rextents;
 		lcounter += delta;
 		if (lcounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_rextents = lcounter;
-		return (0);
+		return 0;
 	case XFS_SBS_REXTSLOG:
 		scounter = mp->m_sb.sb_rextslog;
 		scounter += delta;
 		if (scounter < 0) {
 			ASSERT(0);
-			return (XFS_ERROR(EINVAL));
+			return XFS_ERROR(EINVAL);
 		}
 		mp->m_sb.sb_rextslog = scounter;
-		return (0);
+		return 0;
 	default:
 		ASSERT(0);
-		return (XFS_ERROR(EINVAL));
+		return XFS_ERROR(EINVAL);
 	}
 }
 
@@ -1409,7 +1409,7 @@ xfs_mod_incore_sb(xfs_mount_t *mp, xfs_s
 	s = XFS_SB_LOCK(mp);
 	status = xfs_mod_incore_sb_unlocked(mp, field, delta, rsvd);
 	XFS_SB_UNLOCK(mp, s);
-	return (status);
+	return status;
 }
 
 /*
@@ -1470,7 +1470,7 @@ xfs_mod_incore_sb_batch(xfs_mount_t *mp,
 		}
 	}
 	XFS_SB_UNLOCK(mp, s);
-	return (status);
+	return status;
 }
 
 /*
@@ -1500,7 +1500,7 @@ xfs_getsb(
 	}
 	XFS_BUF_HOLD(bp);
 	ASSERT(XFS_BUF_ISDONE(bp));
-	return (bp);
+	return bp;
 }
 
 /*
diff --git a/fs/xfs/xfs_trans_item.c b/fs/xfs/xfs_trans_item.c
index 486147e..1117d60 100644
--- a/fs/xfs/xfs_trans_item.c
+++ b/fs/xfs/xfs_trans_item.c
@@ -78,7 +78,7 @@ xfs_trans_add_item(xfs_trans_t *tp, xfs_
 		lidp->lid_size = 0;
 		lip->li_desc = lidp;
 		lip->li_mountp = tp->t_mountp;
-		return (lidp);
+		return lidp;
 	}
 
 	/*
@@ -119,7 +119,7 @@ xfs_trans_add_item(xfs_trans_t *tp, xfs_
 	lidp->lid_size = 0;
 	lip->li_desc = lidp;
 	lip->li_mountp = tp->t_mountp;
-	return (lidp);
+	return lidp;
 }
 
 /*
@@ -180,7 +180,7 @@ xfs_trans_find_item(xfs_trans_t	*tp, xfs
 {
 	ASSERT(lip->li_desc != NULL);
 
-	return (lip->li_desc);
+	return lip->li_desc;
 }
 
 
@@ -219,10 +219,10 @@ xfs_trans_first_item(xfs_trans_t *tp)
 			continue;
 		}
 
-		return (XFS_LIC_SLOT(licp, i));
+		return XFS_LIC_SLOT(licp, i);
 	}
 	cmn_err(CE_WARN, "xfs_trans_first_item() -- no first item");
-	return(NULL);
+	return NULL;
 }
 
 
@@ -252,7 +252,7 @@ xfs_trans_next_item(xfs_trans_t *tp, xfs
 			continue;
 		}
 
-		return (XFS_LIC_SLOT(licp, i));
+		return XFS_LIC_SLOT(licp, i);
 	}
 
 	/*
@@ -261,7 +261,7 @@ xfs_trans_next_item(xfs_trans_t *tp, xfs
 	 * If there is no next chunk, return NULL.
 	 */
 	if (licp->lic_next == NULL) {
-		return (NULL);
+		return NULL;
 	}
 
 	licp = licp->lic_next;
@@ -271,7 +271,7 @@ xfs_trans_next_item(xfs_trans_t *tp, xfs
 			continue;
 		}
 
-		return (XFS_LIC_SLOT(licp, i));
+		return XFS_LIC_SLOT(licp, i);
 	}
 	ASSERT(0);
 	/* NOTREACHED */
@@ -425,7 +425,7 @@ xfs_trans_unlock_chunk(
 		}
 	}
 
-	return (freed);
+	return freed;
 }
 
 
@@ -478,7 +478,7 @@ xfs_trans_add_busy(xfs_trans_t *tp, xfs_
 		 */
 		lbsp->lbc_ag = ag;
 		lbsp->lbc_idx = idx;
-		return (lbsp);
+		return lbsp;
 	}
 
 	/*
@@ -512,7 +512,7 @@ xfs_trans_add_busy(xfs_trans_t *tp, xfs_
 	tp->t_busy_free--;
 	lbsp->lbc_ag = ag;
 	lbsp->lbc_idx = idx;
-	return (lbsp);
+	return lbsp;
 }
 
 
diff --git a/fs/xfs/xfs_vnodeops.c b/fs/xfs/xfs_vnodeops.c
index 8076cc9..eaab355 100644
--- a/fs/xfs/xfs_vnodeops.c
+++ b/fs/xfs/xfs_vnodeops.c
@@ -338,7 +338,7 @@ xfs_setattr(
 		code = XFS_QM_DQVOPALLOC(mp, ip, uid, gid, projid, qflags,
 					 &udqp, &gdqp);
 		if (code)
-			return (code);
+			return code;
 	}
 
 	/*
@@ -1027,11 +1027,8 @@ xfs_readlink(
 
 	}
 
-
 error_return:
-
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
-
 	return error;
 }
 
@@ -1206,7 +1203,7 @@ xfs_inactive_free_eofblocks(
 	last_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_MAXIOFFSET(mp));
 	map_len = last_fsb - end_fsb;
 	if (map_len <= 0)
-		return (0);
+		return 0;
 
 	nimaps = 1;
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
@@ -1221,7 +1218,7 @@ xfs_inactive_free_eofblocks(
 		 * Attach the dquots to the inode up front.
 		 */
 		if ((error = XFS_QM_DQATTACH(mp, ip, 0)))
-			return (error);
+			return error;
 
 		/*
 		 * There are blocks after the end of file.
@@ -1249,7 +1246,7 @@ xfs_inactive_free_eofblocks(
 			ASSERT(XFS_FORCED_SHUTDOWN(mp));
 			xfs_trans_cancel(tp, 0);
 			xfs_iunlock(ip, XFS_IOLOCK_EXCL);
-			return (error);
+			return error;
 		}
 
 		xfs_ilock(ip, XFS_ILOCK_EXCL);
@@ -1277,7 +1274,7 @@ xfs_inactive_free_eofblocks(
 		}
 		xfs_iunlock(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
 	}
-	return (error);
+	return error;
 }
 
 /*
@@ -1455,7 +1452,7 @@ xfs_inactive_symlink_local(
 	if (error) {
 		xfs_trans_cancel(*tpp, 0);
 		*tpp = NULL;
-		return (error);
+		return error;
 	}
 	xfs_ilock(ip, XFS_ILOCK_EXCL | XFS_IOLOCK_EXCL);
 
@@ -1468,7 +1465,7 @@ xfs_inactive_symlink_local(
 				  XFS_DATA_FORK);
 		ASSERT(ip->i_df.if_bytes == 0);
 	}
-	return (0);
+	return 0;
 }
 
 /*
@@ -1494,7 +1491,7 @@ xfs_inactive_attrs(
 	if (error) {
 		*tpp = NULL;
 		xfs_iunlock(ip, XFS_IOLOCK_EXCL);
-		return (error); /* goto out*/
+		return error; /* goto out */
 	}
 
 	tp = xfs_trans_alloc(mp, XFS_TRANS_INACTIVE);
@@ -1507,7 +1504,7 @@ xfs_inactive_attrs(
 		xfs_trans_cancel(tp, 0);
 		*tpp = NULL;
 		xfs_iunlock(ip, XFS_IOLOCK_EXCL);
-		return (error);
+		return error;
 	}
 
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
@@ -1518,7 +1515,7 @@ xfs_inactive_attrs(
 	ASSERT(ip->i_d.di_anextents == 0);
 
 	*tpp = tp;
-	return (0);
+	return 0;
 }
 
 STATIC int
@@ -1557,7 +1554,7 @@ xfs_release(
 		    (!(ip->i_d.di_flags &
 				(XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)))) {
 			if ((error = xfs_inactive_free_eofblocks(mp, ip)))
-				return (error);
+				return error;
 			/* Update linux inode block count after free above */
 			LINVFS_GET_IP(vp)->i_blocks = XFS_FSB_TO_BB(mp,
 				ip->i_d.di_nblocks + ip->i_delayed_blks);
@@ -1638,7 +1635,7 @@ xfs_inactive(
 				(XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)) ||
 		      (ip->i_delayed_blks != 0)))) {
 			if ((error = xfs_inactive_free_eofblocks(mp, ip)))
-				return (VN_INACTIVE_CACHE);
+				return VN_INACTIVE_CACHE;
 			/* Update linux inode block count after free above */
 			LINVFS_GET_IP(vp)->i_blocks = XFS_FSB_TO_BB(mp,
 				ip->i_d.di_nblocks + ip->i_delayed_blks);
@@ -1649,7 +1646,7 @@ xfs_inactive(
 	ASSERT(ip->i_d.di_nlink == 0);
 
 	if ((error = XFS_QM_DQATTACH(mp, ip, 0)))
-		return (VN_INACTIVE_CACHE);
+		return VN_INACTIVE_CACHE;
 
 	tp = xfs_trans_alloc(mp, XFS_TRANS_INACTIVE);
 	if (truncate) {
@@ -1672,7 +1669,7 @@ xfs_inactive(
 			ASSERT(XFS_FORCED_SHUTDOWN(mp));
 			xfs_trans_cancel(tp, 0);
 			xfs_iunlock(ip, XFS_IOLOCK_EXCL);
-			return (VN_INACTIVE_CACHE);
+			return VN_INACTIVE_CACHE;
 		}
 
 		xfs_ilock(ip, XFS_ILOCK_EXCL);
@@ -1693,7 +1690,7 @@ xfs_inactive(
 			xfs_trans_cancel(tp,
 				XFS_TRANS_RELEASE_LOG_RES | XFS_TRANS_ABORT);
 			xfs_iunlock(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
-			return (VN_INACTIVE_CACHE);
+			return VN_INACTIVE_CACHE;
 		}
 	} else if ((ip->i_d.di_mode & S_IFMT) == S_IFLNK) {
 
@@ -1707,7 +1704,7 @@ xfs_inactive(
 
 		if (error) {
 			ASSERT(tp == NULL);
-			return (VN_INACTIVE_CACHE);
+			return VN_INACTIVE_CACHE;
 		}
 
 		xfs_trans_ijoin(tp, ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
@@ -1720,7 +1717,7 @@ xfs_inactive(
 		if (error) {
 			ASSERT(XFS_FORCED_SHUTDOWN(mp));
 			xfs_trans_cancel(tp, 0);
-			return (VN_INACTIVE_CACHE);
+			return VN_INACTIVE_CACHE;
 		}
 
 		xfs_ilock(ip, XFS_ILOCK_EXCL | XFS_IOLOCK_EXCL);
@@ -1742,7 +1739,7 @@ xfs_inactive(
 		 * cancelled, and the inode is unlocked. Just get out.
 		 */
 		 if (error)
-			 return (VN_INACTIVE_CACHE);
+			 return VN_INACTIVE_CACHE;
 	} else if (ip->i_afp) {
 		xfs_idestroy_fork(ip, XFS_ATTR_FORK);
 	}
@@ -2049,8 +2046,8 @@ std_return:
  abort_return:
 	cancel_flags |= XFS_TRANS_ABORT;
 	/* FALLTHROUGH */
- error_return:
 
+ error_return:
 	if (tp != NULL)
 		xfs_trans_cancel(tp, cancel_flags);
 
@@ -2724,9 +2721,9 @@ std_return:
  abort_return:
 	cancel_flags |= XFS_TRANS_ABORT;
 	/* FALLTHROUGH */
+
  error_return:
 	xfs_trans_cancel(tp, cancel_flags);
-
 	goto std_return;
 }
 /*
@@ -3199,10 +3196,12 @@ std_return:
 	}
 	return error;
 
- error1:
+error1:
 	xfs_bmap_cancel(&free_list);
 	cancel_flags |= XFS_TRANS_ABORT;
- error_return:
+	/* FALLTHROUGH */
+
+error_return:
 	xfs_trans_cancel(tp, cancel_flags);
 	goto std_return;
 }
@@ -3618,9 +3617,9 @@ xfs_rwlock(
 	if (locktype == VRWLOCK_WRITE) {
 		xfs_ilock(ip, XFS_IOLOCK_EXCL);
 	} else if (locktype == VRWLOCK_TRY_READ) {
-		return (xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED));
+		return xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED);
 	} else if (locktype == VRWLOCK_TRY_WRITE) {
-		return (xfs_ilock_nowait(ip, XFS_IOLOCK_EXCL));
+		return xfs_ilock_nowait(ip, XFS_IOLOCK_EXCL);
 	} else {
 		ASSERT((locktype == VRWLOCK_READ) ||
 		       (locktype == VRWLOCK_WRITE_DIRECT));
@@ -3868,7 +3867,7 @@ xfs_finish_reclaim(
 			xfs_ifunlock(ip);
 			xfs_iunlock(ip, XFS_ILOCK_EXCL);
 		}
-		return(1);
+		return 1;
 	}
 	ip->i_flags |= XFS_IRECLAIM;
 	write_unlock(&ih->ih_lock);
@@ -4045,7 +4044,7 @@ xfs_alloc_file_space(
 			offset, end_dmi_offset - offset,
 			0, NULL);
 		if (error)
-			return(error);
+			return error;
 	}
 
 	/*
@@ -4305,7 +4304,7 @@ xfs_free_file_space(
 				offset, end_dmi_offset - offset,
 				AT_DELAY_FLAG(attr_flags), NULL);
 		if (error)
-			return(error);
+			return error;
 	}
 
 	ASSERT(attr_flags & ATTR_NOLOCK ? attr_flags & ATTR_DMI : 1);
diff --git a/include/asm-v850/ptrace.h b/include/asm-v850/ptrace.h
index 7bf72bb..4f35cf2 100644
--- a/include/asm-v850/ptrace.h
+++ b/include/asm-v850/ptrace.h
@@ -92,7 +92,7 @@ struct pt_regs
 /* The number of bytes used to store each register.  */
 #define _PT_REG_SIZE	4
 
-/* Offset of a general purpose register in a stuct pt_regs.  */
+/* Offset of a general purpose register in a struct pt_regs.  */
 #define PT_GPR(num)	((num) * _PT_REG_SIZE)
 
 /* Offsets of various special registers & fields in a struct pt_regs.  */
diff --git a/include/linux/pfkeyv2.h b/include/linux/pfkeyv2.h
index 6351c40..bac0fb3 100644
--- a/include/linux/pfkeyv2.h
+++ b/include/linux/pfkeyv2.h
@@ -104,7 +104,7 @@ struct sadb_prop {
 /* followed by:
 	struct sadb_comb sadb_combs[(sadb_prop_len +
 		sizeof(uint64_t) - sizeof(struct sadb_prop)) /
-		sizeof(strut sadb_comb)]; */
+		sizeof(struct sadb_comb)]; */
 
 struct sadb_comb {
 	uint8_t		sadb_comb_auth;
diff --git a/init/Kconfig b/init/Kconfig
index 25f4d74..7efa729 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -99,7 +99,7 @@ config SWAP
 	default y
 	help
 	  This option allows you to choose whether you want to have support
-	  for socalled swap devices or swap files in your kernel that are
+	  for so called swap devices or swap files in your kernel that are
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
diff --git a/ipc/msg.c b/ipc/msg.c
index a91b647..fbf7570 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -12,7 +12,7 @@
  *
  * mostly rewritten, threaded and wake-one semantics added
  * MSGMAX limit removed, sysctl's added
- * (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
+ * (c) 1999 Manfred Spraul <manfred@colorfullife.com>
  */
 
 #include <linux/capability.h>
diff --git a/ipc/sem.c b/ipc/sem.c
index 46bb8a6..31fd402 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -56,7 +56,7 @@
  * /proc/sysvipc/sem support (c) 1999 Dragos Acostachioaie <dragos@iname.com>
  *
  * SMP-threaded, sysctl's added
- * (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
+ * (c) 1999 Manfred Spraul <manfred@colorfullife.com>
  * Enforced range limit on SEM_UNDO
  * (c) 2001 Red Hat Inc <alan@redhat.com>
  * Lockless wakeup
diff --git a/ipc/util.c b/ipc/util.c
index 38b9a0a..8626219 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -7,7 +7,7 @@
  *            Occurs in several places in the IPC code.
  *            Chris Evans, <chris@ferret.lmh.ox.ac.uk>
  * Nov 1999 - ipc helper functions, unified SMP locking
- *	      Manfred Spraul <manfreds@colorfullife.com>
+ *	      Manfred Spraul <manfred@colorfullife.com>
  * Oct 2002 - One lock per IPC id. RCU ipc_free for lock-free grow_ary().
  *            Mingming Cao <cmm@us.ibm.com>
  */
diff --git a/ipc/util.h b/ipc/util.h
index fc9a28b..efaff3e 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -2,7 +2,7 @@
  * linux/ipc/util.h
  * Copyright (C) 1999 Christoph Rohland
  *
- * ipc helper functions (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
+ * ipc helper functions (c) 1999 Manfred Spraul <manfred@colorfullife.com>
  */
 
 #ifndef _IPC_UTIL_H
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 5ec248c..9fd8d4f 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -38,7 +38,7 @@ config PM_DEBUG
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FVR || PPC32) && !SMP)
+	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.
diff --git a/kernel/printk.c b/kernel/printk.c
index 2251be8..13ced0f 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -11,7 +11,7 @@
  * Ted Ts'o, 2/11/93.
  * Modified for sysctl support, 1/8/97, Chris Horn.
  * Fixed SMP synchronization, 08/08/99, Manfred Spraul
- *     manfreds@colorfullife.com
+ *     manfred@colorfullife.com
  * Rewrote bits to get rid of console_lock
  *	01Mar01 Andrew Morton <andrewm@uow.edu.au>
  */
diff --git a/sound/oss/opl3sa2.c b/sound/oss/opl3sa2.c
index 5cecdbc..0e161c6 100644
--- a/sound/oss/opl3sa2.c
+++ b/sound/oss/opl3sa2.c
@@ -530,7 +530,7 @@ static void __init attach_opl3sa2_mss(st
 	if (hw_config->slots[0] != -1) {
 		/* Did the MSS driver install? */
 		if(num_mixers == (initial_mixers + 1)) {
-			/* The MSS mixer is installed, reroute mixers appropiately */
+			/* The MSS mixer is installed, reroute mixers appropriately */
 			AD1848_REROUTE(SOUND_MIXER_LINE1, SOUND_MIXER_CD);
 			AD1848_REROUTE(SOUND_MIXER_LINE2, SOUND_MIXER_SYNTH);
 			AD1848_REROUTE(SOUND_MIXER_LINE3, SOUND_MIXER_LINE);
