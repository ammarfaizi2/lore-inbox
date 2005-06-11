Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVFKIgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVFKIgY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVFKIgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:36:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:4548 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261658AbVFKHsw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:52 -0400
Subject: [PATCH] Remove the devfs_fs_kernel.h file from the tree
In-Reply-To: <11184761113825@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:31 -0700
Message-Id: <11184761113852@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also fixes up all files that #include it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/sparc64/solaris/socksys.c          |    1 -
 arch/um/drivers/line.c                  |    1 -
 arch/um/drivers/mmapper_kern.c          |    1 -
 arch/um/drivers/ubd_kern.c              |    1 -
 drivers/block/acsi_slm.c                |    1 -
 drivers/block/cpqarray.c                |    1 -
 drivers/block/floppy.c                  |    1 -
 drivers/block/loop.c                    |    1 -
 drivers/block/nbd.c                     |    2 --
 drivers/block/paride/pg.c               |    1 -
 drivers/block/paride/pt.c               |    1 -
 drivers/block/rd.c                      |    1 -
 drivers/block/swim3.c                   |    1 -
 drivers/block/sx8.c                     |    1 -
 drivers/block/ub.c                      |    1 -
 drivers/cdrom/cdu31a.c                  |    1 -
 drivers/cdrom/cm206.c                   |    1 -
 drivers/cdrom/mcdx.c                    |    1 -
 drivers/cdrom/sbpcd.c                   |    1 -
 drivers/char/dsp56k.c                   |    1 -
 drivers/char/dtlk.c                     |    1 -
 drivers/char/ftape/zftape/zftape-init.c |    1 -
 drivers/char/ip2main.c                  |    1 -
 drivers/char/ipmi/ipmi_devintf.c        |    1 -
 drivers/char/istallion.c                |    1 -
 drivers/char/lp.c                       |    1 -
 drivers/char/mem.c                      |    1 -
 drivers/char/misc.c                     |    1 -
 drivers/char/mmtimer.c                  |    1 -
 drivers/char/ppdev.c                    |    1 -
 drivers/char/pty.c                      |    1 -
 drivers/char/raw.c                      |    1 -
 drivers/char/stallion.c                 |    1 -
 drivers/char/tipar.c                    |    1 -
 drivers/char/tty_io.c                   |    1 -
 drivers/char/vc_screen.c                |    1 -
 drivers/char/viotape.c                  |    1 -
 drivers/char/vt.c                       |    1 -
 drivers/i2c/i2c-dev.c                   |    1 -
 drivers/ide/ide-probe.c                 |    1 -
 drivers/ide/ide-tape.c                  |    1 -
 drivers/ide/ide.c                       |    1 -
 drivers/ieee1394/ieee1394_core.h        |    1 -
 drivers/ieee1394/raw1394.c              |    1 -
 drivers/ieee1394/video1394.c            |    1 -
 drivers/input/evdev.c                   |    1 -
 drivers/input/input.c                   |    1 -
 drivers/input/joydev.c                  |    1 -
 drivers/input/mousedev.c                |    1 -
 drivers/input/serio/serio_raw.c         |    1 -
 drivers/input/tsdev.c                   |    1 -
 drivers/isdn/capi/capi.c                |    1 -
 drivers/isdn/hardware/eicon/divamnt.c   |    1 -
 drivers/isdn/hardware/eicon/divasi.c    |    1 -
 drivers/isdn/hardware/eicon/divasmain.c |    1 -
 drivers/macintosh/adb.c                 |    1 -
 drivers/md/dm-ioctl.c                   |    1 -
 drivers/md/md.c                         |    1 -
 drivers/media/dvb/dvb-core/dvbdev.h     |    1 -
 drivers/media/dvb/ttpci/av7110.h        |    4 ----
 drivers/media/video/arv.c               |    1 -
 drivers/media/video/videodev.c          |    1 -
 drivers/mmc/mmc_block.c                 |    1 -
 drivers/mtd/mtd_blkdevs.c               |    1 -
 drivers/net/ppp_generic.c               |    1 -
 drivers/net/wan/cosa.c                  |    1 -
 drivers/s390/block/dasd_int.h           |    1 -
 drivers/s390/block/xpram.c              |    1 -
 drivers/s390/net/ctctty.c               |    1 -
 drivers/sbus/char/bpp.c                 |    1 -
 drivers/sbus/char/vfc.h                 |    2 --
 drivers/scsi/osst.c                     |    1 -
 drivers/scsi/scsi.c                     |    1 -
 drivers/scsi/sg.c                       |    1 -
 drivers/scsi/st.c                       |    1 -
 drivers/telephony/phonedev.c            |    1 -
 drivers/usb/core/file.c                 |    1 -
 drivers/usb/input/hiddev.c              |    1 -
 drivers/video/fbmem.c                   |    1 -
 fs/block_dev.c                          |    1 -
 fs/char_dev.c                           |    1 -
 fs/coda/psdev.c                         |    1 -
 fs/partitions/check.c                   |    1 -
 include/asm-ppc/ocp.h                   |    1 -
 include/linux/devfs_fs_kernel.h         |   10 ----------
 include/linux/fb.h                      |    1 -
 init/do_mounts.h                        |    1 -
 init/main.c                             |    1 -
 mm/shmem.c                              |    1 -
 mm/tiny-shmem.c                         |    1 -
 net/irda/irnet/irnet.h                  |    1 -
 sound/core/info.c                       |    1 -
 sound/core/sound.c                      |    1 -
 sound/oss/soundcard.c                   |    1 -
 sound/sound_core.c                      |    1 -
 95 files changed, 109 deletions(-)

--- gregkh-2.6.orig/include/asm-ppc/ocp.h	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/include/asm-ppc/ocp.h	2005-06-10 23:37:21.000000000 -0700
@@ -27,7 +27,6 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/config.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 
 #include <asm/mmu.h>
--- gregkh-2.6.orig/include/linux/fb.h	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/include/linux/fb.h	2005-06-10 23:37:21.000000000 -0700
@@ -363,7 +363,6 @@
 #include <linux/tty.h>
 #include <linux/device.h>
 #include <linux/workqueue.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/notifier.h>
 #include <linux/list.h>
 #include <asm/io.h>
--- gregkh-2.6.orig/init/do_mounts.h	2005-06-10 23:36:41.000000000 -0700
+++ gregkh-2.6/init/do_mounts.h	2005-06-10 23:37:21.000000000 -0700
@@ -1,6 +1,5 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/init.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
--- gregkh-2.6.orig/net/irda/irnet/irnet.h	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/net/irda/irnet/irnet.h	2005-06-10 23:37:21.000000000 -0700
@@ -244,7 +244,6 @@
 #include <linux/skbuff.h>
 #include <linux/tty.h>
 #include <linux/proc_fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/netdevice.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
--- gregkh-2.6.orig/init/main.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/init/main.c	2005-06-10 23:37:21.000000000 -0700
@@ -15,7 +15,6 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/kernel.h>
 #include <linux/syscalls.h>
 #include <linux/string.h>
--- gregkh-2.6.orig/mm/shmem.c	2005-06-10 23:37:16.000000000 -0700
+++ gregkh-2.6/mm/shmem.c	2005-06-10 23:37:21.000000000 -0700
@@ -26,7 +26,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
--- gregkh-2.6.orig/mm/tiny-shmem.c	2005-06-10 23:37:16.000000000 -0700
+++ gregkh-2.6/mm/tiny-shmem.c	2005-06-10 23:37:21.000000000 -0700
@@ -12,7 +12,6 @@
 
 #include <linux/fs.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/vfs.h>
 #include <linux/mount.h>
 #include <linux/file.h>
--- gregkh-2.6.orig/sound/core/info.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/sound/core/info.c	2005-06-10 23:37:21.000000000 -0700
@@ -29,7 +29,6 @@
 #include <sound/info.h>
 #include <sound/version.h>
 #include <linux/proc_fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <stdarg.h>
 
 /*
--- gregkh-2.6.orig/sound/core/sound.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/sound/core/sound.c	2005-06-10 23:37:21.000000000 -0700
@@ -31,7 +31,6 @@
 #include <sound/control.h>
 #include <sound/initval.h>
 #include <linux/kmod.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 
 #define SNDRV_OS_MINORS 256
--- gregkh-2.6.orig/sound/oss/soundcard.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/sound/oss/soundcard.c	2005-06-10 23:37:21.000000000 -0700
@@ -38,7 +38,6 @@
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/major.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
--- gregkh-2.6.orig/sound/sound_core.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/sound/sound_core.c	2005-06-10 23:37:21.000000000 -0700
@@ -44,7 +44,6 @@
 #include <linux/sound.h>
 #include <linux/major.h>
 #include <linux/kmod.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 
 #define SOUND_STEP 16
--- gregkh-2.6.orig/arch/sparc64/solaris/socksys.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/arch/sparc64/solaris/socksys.c	2005-06-10 23:37:21.000000000 -0700
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/in.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <net/sock.h>
 
--- gregkh-2.6.orig/arch/um/drivers/line.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/arch/um/drivers/line.c	2005-06-10 23:37:50.000000000 -0700
@@ -8,7 +8,6 @@
 #include "linux/list.h"
 #include "linux/kd.h"
 #include "linux/interrupt.h"
-#include "linux/devfs_fs_kernel.h"
 #include "asm/uaccess.h"
 #include "chan_kern.h"
 #include "irq_user.h"
--- gregkh-2.6.orig/arch/um/drivers/mmapper_kern.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/arch/um/drivers/mmapper_kern.c	2005-06-10 23:37:21.000000000 -0700
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <linux/kdev_t.h>
 #include <linux/time.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/module.h>
 #include <linux/mm.h> 
 #include <linux/slab.h>
--- gregkh-2.6.orig/arch/um/drivers/ubd_kern.c	2005-06-10 23:37:17.000000000 -0700
+++ gregkh-2.6/arch/um/drivers/ubd_kern.c	2005-06-10 23:38:05.000000000 -0700
@@ -25,7 +25,6 @@
 #include "linux/blkdev.h"
 #include "linux/hdreg.h"
 #include "linux/init.h"
-#include "linux/devfs_fs_kernel.h"
 #include "linux/cdrom.h"
 #include "linux/proc_fs.h"
 #include "linux/ctype.h"
--- gregkh-2.6.orig/drivers/video/fbmem.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/video/fbmem.c	2005-06-10 23:37:21.000000000 -0700
@@ -31,7 +31,6 @@
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
-#include <linux/devfs_fs_kernel.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
--- gregkh-2.6.orig/fs/block_dev.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/fs/block_dev.c	2005-06-10 23:37:21.000000000 -0700
@@ -12,7 +12,6 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/major.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 #include <linux/highmem.h>
 #include <linux/blkdev.h>
--- gregkh-2.6.orig/fs/char_dev.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/fs/char_dev.c	2005-06-10 23:37:21.000000000 -0700
@@ -14,7 +14,6 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <linux/kobject.h>
 #include <linux/kobj_map.h>
--- gregkh-2.6.orig/fs/coda/psdev.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/fs/coda/psdev.c	2005-06-10 23:37:21.000000000 -0700
@@ -28,7 +28,6 @@
 #include <linux/delay.h>
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/file.h>
--- gregkh-2.6.orig/fs/partitions/check.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/fs/partitions/check.c	2005-06-10 23:37:21.000000000 -0700
@@ -18,7 +18,6 @@
 #include <linux/fs.h>
 #include <linux/kmod.h>
 #include <linux/ctype.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include "check.h"
 
--- gregkh-2.6.orig/drivers/block/acsi_slm.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/block/acsi_slm.c	2005-06-10 23:37:21.000000000 -0700
@@ -63,7 +63,6 @@
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 
 #include <asm/pgtable.h>
--- gregkh-2.6.orig/drivers/block/cpqarray.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/block/cpqarray.c	2005-06-10 23:38:05.000000000 -0700
@@ -33,7 +33,6 @@
 #include <linux/blkpg.h>
 #include <linux/timer.h>
 #include <linux/proc_fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/init.h>
 #include <linux/hdreg.h>
 #include <linux/spinlock.h>
--- gregkh-2.6.orig/drivers/block/floppy.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/block/floppy.c	2005-06-10 23:37:21.000000000 -0700
@@ -176,7 +176,6 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
 
--- gregkh-2.6.orig/drivers/block/loop.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/block/loop.c	2005-06-10 23:38:05.000000000 -0700
@@ -63,7 +63,6 @@
 #include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
--- gregkh-2.6.orig/drivers/block/nbd.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/block/nbd.c	2005-06-10 23:38:05.000000000 -0700
@@ -56,8 +56,6 @@
 #include <linux/ioctl.h>
 #include <net/sock.h>
 
-#include <linux/devfs_fs_kernel.h>
-
 #include <asm/uaccess.h>
 #include <asm/types.h>
 
--- gregkh-2.6.orig/drivers/block/paride/pg.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/block/paride/pg.c	2005-06-10 23:37:21.000000000 -0700
@@ -156,7 +156,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mtio.h>
--- gregkh-2.6.orig/drivers/block/paride/pt.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/block/paride/pt.c	2005-06-10 23:37:21.000000000 -0700
@@ -141,7 +141,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mtio.h>
--- gregkh-2.6.orig/drivers/block/rd.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/block/rd.c	2005-06-10 23:38:05.000000000 -0700
@@ -50,7 +50,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
--- gregkh-2.6.orig/drivers/block/swim3.c	2005-06-10 23:37:16.000000000 -0700
+++ gregkh-2.6/drivers/block/swim3.c	2005-06-10 23:38:05.000000000 -0700
@@ -25,7 +25,6 @@
 #include <linux/fd.h>
 #include <linux/ioctl.h>
 #include <linux/blkdev.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <asm/io.h>
--- gregkh-2.6.orig/drivers/block/sx8.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/block/sx8.c	2005-06-10 23:38:05.000000000 -0700
@@ -18,7 +18,6 @@
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
 #include <linux/sched.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/interrupt.h>
 #include <linux/compiler.h>
 #include <linux/workqueue.h>
--- gregkh-2.6.orig/drivers/block/ub.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/block/ub.c	2005-06-10 23:38:05.000000000 -0700
@@ -28,7 +28,6 @@
 #include <linux/module.h>
 #include <linux/usb.h>
 #include <linux/blkdev.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/timer.h>
 #include <scsi/scsi.h>
 
--- gregkh-2.6.orig/drivers/ide/ide-probe.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/ide/ide-probe.c	2005-06-10 23:37:54.000000000 -0700
@@ -47,7 +47,6 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/spinlock.h>
 #include <linux/kmod.h>
 #include <linux/pci.h>
--- gregkh-2.6.orig/drivers/ide/ide-tape.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/ide/ide-tape.c	2005-06-10 23:37:21.000000000 -0700
@@ -434,7 +434,6 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/major.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/errno.h>
 #include <linux/genhd.h>
 #include <linux/slab.h>
--- gregkh-2.6.orig/drivers/ide/ide.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/ide/ide.c	2005-06-10 23:37:54.000000000 -0700
@@ -147,7 +147,6 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/completion.h>
 #include <linux/reboot.h>
 #include <linux/cdrom.h>
--- gregkh-2.6.orig/drivers/input/evdev.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/input/evdev.c	2005-06-10 23:37:21.000000000 -0700
@@ -20,7 +20,6 @@
 #include <linux/major.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 struct evdev {
 	int exist;
--- gregkh-2.6.orig/drivers/input/input.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/input/input.c	2005-06-10 23:37:21.000000000 -0700
@@ -22,7 +22,6 @@
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input core");
--- gregkh-2.6.orig/drivers/input/joydev.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/input/joydev.c	2005-06-10 23:37:21.000000000 -0700
@@ -26,7 +26,6 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Joystick device interfaces");
--- gregkh-2.6.orig/drivers/input/mousedev.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/input/mousedev.c	2005-06-10 23:37:21.000000000 -0700
@@ -24,7 +24,6 @@
 #include <linux/random.h>
 #include <linux/major.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 #include <linux/miscdevice.h>
 #endif
--- gregkh-2.6.orig/drivers/input/serio/serio_raw.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/input/serio/serio_raw.c	2005-06-10 23:37:21.000000000 -0700
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/major.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/wait.h>
 
--- gregkh-2.6.orig/drivers/input/tsdev.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/input/tsdev.c	2005-06-10 23:37:21.000000000 -0700
@@ -53,7 +53,6 @@
 #include <linux/random.h>
 #include <linux/time.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 #ifndef CONFIG_INPUT_TSDEV_SCREEN_X
 #define CONFIG_INPUT_TSDEV_SCREEN_X	240
--- gregkh-2.6.orig/drivers/char/dsp56k.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/dsp56k.c	2005-06-10 23:37:21.000000000 -0700
@@ -33,7 +33,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
 
--- gregkh-2.6.orig/drivers/char/dtlk.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/dtlk.c	2005-06-10 23:37:21.000000000 -0700
@@ -62,7 +62,6 @@
 #include <linux/init.h>		/* for __init, module_{init,exit} */
 #include <linux/poll.h>		/* for POLLIN, etc. */
 #include <linux/dtlk.h>		/* local header file for DoubleTalk values */
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 
 #ifdef TRACING
--- gregkh-2.6.orig/drivers/char/lp.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/lp.c	2005-06-10 23:37:21.000000000 -0700
@@ -120,7 +120,6 @@
 #include <linux/major.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/slab.h>
 #include <linux/fcntl.h>
 #include <linux/delay.h>
--- gregkh-2.6.orig/drivers/char/mem.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/mem.c	2005-06-10 23:37:21.000000000 -0700
@@ -20,7 +20,6 @@
 #include <linux/tty.h>
 #include <linux/capability.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
 #include <linux/device.h>
 #include <linux/backing-dev.h>
--- gregkh-2.6.orig/drivers/char/pty.c	2005-06-10 23:37:16.000000000 -0700
+++ gregkh-2.6/drivers/char/pty.c	2005-06-10 23:37:44.000000000 -0700
@@ -24,7 +24,6 @@
 #include <linux/major.h>
 #include <linux/mm.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/sysctl.h>
 
 #include <asm/uaccess.h>
--- gregkh-2.6.orig/drivers/char/vc_screen.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/vc_screen.c	2005-06-10 23:37:21.000000000 -0700
@@ -26,7 +26,6 @@
 #include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/tty.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
--- gregkh-2.6.orig/drivers/i2c/i2c-dev.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/i2c/i2c-dev.c	2005-06-10 23:37:21.000000000 -0700
@@ -34,7 +34,6 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
--- gregkh-2.6.orig/drivers/media/dvb/dvb-core/dvbdev.h	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/media/dvb/dvb-core/dvbdev.h	2005-06-10 23:37:21.000000000 -0700
@@ -27,7 +27,6 @@
 #include <linux/poll.h>
 #include <linux/fs.h>
 #include <linux/list.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 
 #define DVB_MAJOR 212
--- gregkh-2.6.orig/drivers/media/dvb/ttpci/av7110.h	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/media/dvb/ttpci/av7110.h	2005-06-10 23:37:21.000000000 -0700
@@ -6,10 +6,6 @@
 #include <linux/netdevice.h>
 #include <linux/i2c.h>
 
-#ifdef CONFIG_DEVFS_FS
-#include <linux/devfs_fs_kernel.h>
-#endif
-
 #include <linux/dvb/video.h>
 #include <linux/dvb/audio.h>
 #include <linux/dvb/dmx.h>
--- gregkh-2.6.orig/drivers/media/video/arv.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/media/video/arv.c	2005-06-10 23:37:21.000000000 -0700
@@ -20,7 +20,6 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/delay.h>
--- gregkh-2.6.orig/drivers/media/video/videodev.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/media/video/videodev.c	2005-06-10 23:37:57.000000000 -0700
@@ -26,7 +26,6 @@
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/semaphore.h>
--- gregkh-2.6.orig/drivers/net/ppp_generic.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/net/ppp_generic.c	2005-06-10 23:37:21.000000000 -0700
@@ -28,7 +28,6 @@
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/list.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/netdevice.h>
 #include <linux/poll.h>
 #include <linux/ppp_defs.h>
--- gregkh-2.6.orig/drivers/net/wan/cosa.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/net/wan/cosa.c	2005-06-10 23:37:21.000000000 -0700
@@ -85,7 +85,6 @@
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
--- gregkh-2.6.orig/drivers/s390/block/dasd_int.h	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/s390/block/dasd_int.h	2005-06-10 23:37:21.000000000 -0700
@@ -54,7 +54,6 @@
 #include <linux/module.h>
 #include <linux/wait.h>
 #include <linux/blkdev.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/genhd.h>
 #include <linux/hdreg.h>
 #include <linux/interrupt.h>
--- gregkh-2.6.orig/drivers/s390/block/xpram.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/s390/block/xpram.c	2005-06-10 23:38:05.000000000 -0700
@@ -36,7 +36,6 @@
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
 #include <linux/sysdev.h>
 #include <linux/bio.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 
 #define XPRAM_NAME	"xpram"
--- gregkh-2.6.orig/drivers/s390/net/ctctty.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/s390/net/ctctty.c	2005-06-10 23:37:44.000000000 -0700
@@ -29,7 +29,6 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <asm/uaccess.h>
-#include <linux/devfs_fs_kernel.h>
 #include "ctctty.h"
 #include "ctcdbug.h"
 
--- gregkh-2.6.orig/drivers/char/ftape/zftape/zftape-init.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/ftape/zftape/zftape-init.c	2005-06-10 23:37:21.000000000 -0700
@@ -33,7 +33,6 @@
 #endif
 #include <linux/fcntl.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <linux/zftape.h>
 #include <linux/init.h>
--- gregkh-2.6.orig/drivers/char/ip2main.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/ip2main.c	2005-06-10 23:37:44.000000000 -0700
@@ -91,7 +91,6 @@
 #include <linux/module.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
--- gregkh-2.6.orig/drivers/char/ipmi/ipmi_devintf.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/ipmi/ipmi_devintf.c	2005-06-10 23:37:21.000000000 -0700
@@ -40,7 +40,6 @@
 #include <linux/poll.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/ipmi.h>
 #include <asm/semaphore.h>
 #include <linux/init.h>
--- gregkh-2.6.orig/drivers/char/istallion.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/istallion.c	2005-06-10 23:37:21.000000000 -0700
@@ -39,7 +39,6 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 #include <linux/wait.h>
 
--- gregkh-2.6.orig/drivers/char/misc.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/misc.c	2005-06-10 23:38:09.000000000 -0700
@@ -44,7 +44,6 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/stat.h>
 #include <linux/init.h>
 #include <linux/device.h>
--- gregkh-2.6.orig/drivers/char/mmtimer.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/char/mmtimer.c	2005-06-10 23:38:09.000000000 -0700
@@ -25,7 +25,6 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/mmtimer.h>
 #include <linux/miscdevice.h>
 #include <linux/posix-timers.h>
--- gregkh-2.6.orig/drivers/char/ppdev.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/ppdev.c	2005-06-10 23:37:21.000000000 -0700
@@ -60,7 +60,6 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/ioctl.h>
 #include <linux/parport.h>
 #include <linux/ctype.h>
--- gregkh-2.6.orig/drivers/char/raw.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/raw.c	2005-06-10 23:37:21.000000000 -0700
@@ -10,7 +10,6 @@
 
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/module.h>
--- gregkh-2.6.orig/drivers/char/stallion.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/stallion.c	2005-06-10 23:37:44.000000000 -0700
@@ -40,7 +40,6 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 
--- gregkh-2.6.orig/drivers/char/tipar.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/tipar.c	2005-06-10 23:37:21.000000000 -0700
@@ -56,7 +56,6 @@
 #include <linux/ioport.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
-#include <linux/devfs_fs_kernel.h>	/* DevFs support */
 #include <linux/parport.h>		/* Our code depend on parport */
 #include <linux/device.h>
 
--- gregkh-2.6.orig/drivers/char/tty_io.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/tty_io.c	2005-06-10 23:37:36.000000000 -0700
@@ -101,7 +101,6 @@
 #include <linux/kbd_kern.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <linux/kmod.h>
 
--- gregkh-2.6.orig/drivers/char/viotape.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/char/viotape.c	2005-06-10 23:37:21.000000000 -0700
@@ -44,7 +44,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/fs.h>
 #include <linux/cdev.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/major.h>
 #include <linux/completion.h>
 #include <linux/proc_fs.h>
--- gregkh-2.6.orig/drivers/char/vt.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/char/vt.c	2005-06-10 23:37:44.000000000 -0700
@@ -79,7 +79,6 @@
 #include <linux/mm.h>
 #include <linux/console.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
 #include <linux/tiocl.h>
--- gregkh-2.6.orig/drivers/isdn/capi/capi.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/isdn/capi/capi.c	2005-06-10 23:37:44.000000000 -0700
@@ -39,7 +39,6 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/moduleparam.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/isdn/capiutil.h>
 #include <linux/isdn/capicmd.h>
 #if defined(CONFIG_ISDN_CAPI_CAPIFS) || defined(CONFIG_ISDN_CAPI_CAPIFS_MODULE)
--- gregkh-2.6.orig/drivers/isdn/hardware/eicon/divamnt.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/isdn/hardware/eicon/divamnt.c	2005-06-10 23:37:21.000000000 -0700
@@ -17,7 +17,6 @@
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <linux/poll.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 
 #include "platform.h"
--- gregkh-2.6.orig/drivers/isdn/hardware/eicon/divasi.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/isdn/hardware/eicon/divasi.c	2005-06-10 23:37:21.000000000 -0700
@@ -19,7 +19,6 @@
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/skbuff.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 
 #include "platform.h"
--- gregkh-2.6.orig/drivers/isdn/hardware/eicon/divasmain.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/isdn/hardware/eicon/divasmain.c	2005-06-10 23:37:21.000000000 -0700
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <linux/ioport.h>
--- gregkh-2.6.orig/drivers/scsi/osst.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/scsi/osst.c	2005-06-10 23:38:05.000000000 -0700
@@ -48,7 +48,6 @@
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
 #include <linux/moduleparam.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/dma.h>
--- gregkh-2.6.orig/drivers/scsi/scsi.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/scsi/scsi.c	2005-06-10 23:37:21.000000000 -0700
@@ -48,7 +48,6 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/completion.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/unistd.h>
 #include <linux/spinlock.h>
 #include <linux/kmod.h>
--- gregkh-2.6.orig/drivers/scsi/sg.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/scsi/sg.c	2005-06-10 23:37:21.000000000 -0700
@@ -44,7 +44,6 @@
 #include <linux/poll.h>
 #include <linux/smp_lock.h>
 #include <linux/moduleparam.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/cdev.h>
 #include <linux/seq_file.h>
 #include <linux/blkdev.h>
--- gregkh-2.6.orig/drivers/scsi/st.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/scsi/st.c	2005-06-10 23:38:05.000000000 -0700
@@ -34,7 +34,6 @@
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
 #include <linux/moduleparam.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/cdev.h>
 #include <linux/delay.h>
 
--- gregkh-2.6.orig/drivers/usb/core/file.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/usb/core/file.c	2005-06-10 23:37:39.000000000 -0700
@@ -17,7 +17,6 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 
--- gregkh-2.6.orig/drivers/usb/input/hiddev.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/usb/input/hiddev.c	2005-06-10 23:37:39.000000000 -0700
@@ -35,7 +35,6 @@
 #include <linux/usb.h>
 #include "hid.h"
 #include <linux/hiddev.h>
-#include <linux/devfs_fs_kernel.h>
 
 #ifdef CONFIG_USB_DYNAMIC_MINORS
 #define HIDDEV_MINOR_BASE	0
--- gregkh-2.6.orig/drivers/cdrom/cdu31a.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/cdu31a.c	2005-06-10 23:37:21.000000000 -0700
@@ -161,7 +161,6 @@
 #include <linux/hdreg.h>
 #include <linux/genhd.h>
 #include <linux/ioport.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/init.h>
--- gregkh-2.6.orig/drivers/cdrom/cm206.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/cm206.c	2005-06-10 23:37:21.000000000 -0700
@@ -187,7 +187,6 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/cdrom.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/ioport.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
--- gregkh-2.6.orig/drivers/cdrom/mcdx.c	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/mcdx.c	2005-06-10 23:37:21.000000000 -0700
@@ -74,7 +74,6 @@
 #include <linux/major.h>
 #define MAJOR_NR MITSUMI_X_CDROM_MAJOR
 #include <linux/blkdev.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include "mcdx.h"
 
--- gregkh-2.6.orig/drivers/cdrom/sbpcd.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/sbpcd.c	2005-06-10 23:38:05.000000000 -0700
@@ -371,7 +371,6 @@
 #include <linux/kernel.h>
 #include <linux/cdrom.h>
 #include <linux/ioport.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/major.h>
 #include <linux/string.h>
 #include <linux/vmalloc.h>
--- gregkh-2.6.orig/drivers/ieee1394/ieee1394_core.h	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/ieee1394/ieee1394_core.h	2005-06-10 23:37:21.000000000 -0700
@@ -3,7 +3,6 @@
 #define _IEEE1394_CORE_H
 
 #include <linux/slab.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
 #include "hosts.h"
--- gregkh-2.6.orig/drivers/ieee1394/raw1394.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/ieee1394/raw1394.c	2005-06-10 23:37:21.000000000 -0700
@@ -41,7 +41,6 @@
 #include <linux/cdev.h>
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include "csr1212.h"
 #include "ieee1394.h"
--- gregkh-2.6.orig/drivers/ieee1394/video1394.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/ieee1394/video1394.c	2005-06-10 23:37:21.000000000 -0700
@@ -54,7 +54,6 @@
 #include <linux/poll.h>
 #include <linux/smp_lock.h>
 #include <linux/delay.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/bitops.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
--- gregkh-2.6.orig/drivers/macintosh/adb.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/macintosh/adb.c	2005-06-10 23:37:21.000000000 -0700
@@ -36,7 +36,6 @@
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
--- gregkh-2.6.orig/drivers/md/dm-ioctl.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/md/dm-ioctl.c	2005-06-10 23:38:09.000000000 -0700
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/dm-ioctl.h>
 
 #include <asm/uaccess.h>
--- gregkh-2.6.orig/drivers/md/md.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/md/md.c	2005-06-10 23:38:05.000000000 -0700
@@ -34,7 +34,6 @@
 #include <linux/linkage.h>
 #include <linux/raid/md.h>
 #include <linux/sysctl.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
 #include <linux/suspend.h>
 
--- gregkh-2.6.orig/drivers/mmc/mmc_block.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/mmc/mmc_block.c	2005-06-10 23:38:05.000000000 -0700
@@ -27,7 +27,6 @@
 #include <linux/hdreg.h>
 #include <linux/kdev_t.h>
 #include <linux/blkdev.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/protocol.h>
--- gregkh-2.6.orig/drivers/mtd/mtd_blkdevs.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/mtd/mtd_blkdevs.c	2005-06-10 23:38:05.000000000 -0700
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
-#include <linux/devfs_fs_kernel.h>
 
 static LIST_HEAD(blktrans_majors);
 
--- gregkh-2.6.orig/drivers/sbus/char/bpp.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/sbus/char/bpp.c	2005-06-10 23:37:21.000000000 -0700
@@ -20,7 +20,6 @@
 #include <linux/timer.h>
 #include <linux/ioport.h>
 #include <linux/major.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
--- gregkh-2.6.orig/drivers/sbus/char/vfc.h	2005-06-10 23:29:02.000000000 -0700
+++ gregkh-2.6/drivers/sbus/char/vfc.h	2005-06-10 23:37:21.000000000 -0700
@@ -1,8 +1,6 @@
 #ifndef _LINUX_VFC_H_
 #define _LINUX_VFC_H_
 
-#include <linux/devfs_fs_kernel.h>
-
 /*
  * The control register for the vfc is at offset 0x4000
  * The first field ram bank is located at offset 0x5000
--- gregkh-2.6.orig/drivers/telephony/phonedev.c	2005-06-10 23:37:20.000000000 -0700
+++ gregkh-2.6/drivers/telephony/phonedev.c	2005-06-10 23:37:21.000000000 -0700
@@ -28,7 +28,6 @@
 
 #include <linux/kmod.h>
 #include <linux/sem.h>
-#include <linux/devfs_fs_kernel.h>
 
 #define PHONE_NUM_DEVICES	256
 
--- gregkh-2.6.orig/include/linux/devfs_fs_kernel.h	2005-06-10 23:37:20.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,10 +0,0 @@
-#ifndef _LINUX_DEVFS_FS_KERNEL_H
-#define _LINUX_DEVFS_FS_KERNEL_H
-
-#include <linux/fs.h>
-#include <linux/config.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
-#include <asm/semaphore.h>
-
-#endif				/*  _LINUX_DEVFS_FS_KERNEL_H  */

