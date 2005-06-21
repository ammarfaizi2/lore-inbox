Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVFUHNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVFUHNR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFUHNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:13:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:56547 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261996AbVFUGa5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:57 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove the devfs_fs_kernel.h file from the tree
In-Reply-To: <1119335443465@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:43 -0700
Message-Id: <11193354432387@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove the devfs_fs_kernel.h file from the tree

Also fixes up all files that #include it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8e645603e0aec2d8f73367861b43f740e313d28d
tree e7f39d4cc38e18f92b120674237c969bc999a06b
parent e20dfbef237b25d9bf7f74a82956b0f5cda6cde5
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:36 -0700

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
 drivers/scsi/ch.c                       |    1 -
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
 96 files changed, 0 insertions(+), 110 deletions(-)

diff --git a/arch/sparc64/solaris/socksys.c b/arch/sparc64/solaris/socksys.c
--- a/arch/sparc64/solaris/socksys.c
+++ b/arch/sparc64/solaris/socksys.c
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/in.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <net/sock.h>
 
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -8,7 +8,6 @@
 #include "linux/list.h"
 #include "linux/kd.h"
 #include "linux/interrupt.h"
-#include "linux/devfs_fs_kernel.h"
 #include "asm/uaccess.h"
 #include "chan_kern.h"
 #include "irq_user.h"
diff --git a/arch/um/drivers/mmapper_kern.c b/arch/um/drivers/mmapper_kern.c
--- a/arch/um/drivers/mmapper_kern.c
+++ b/arch/um/drivers/mmapper_kern.c
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <linux/kdev_t.h>
 #include <linux/time.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/module.h>
 #include <linux/mm.h> 
 #include <linux/slab.h>
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -25,7 +25,6 @@
 #include "linux/blkdev.h"
 #include "linux/hdreg.h"
 #include "linux/init.h"
-#include "linux/devfs_fs_kernel.h"
 #include "linux/cdrom.h"
 #include "linux/proc_fs.h"
 #include "linux/ctype.h"
diff --git a/drivers/block/acsi_slm.c b/drivers/block/acsi_slm.c
--- a/drivers/block/acsi_slm.c
+++ b/drivers/block/acsi_slm.c
@@ -65,7 +65,6 @@ not be guaranteed. There are several way
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 
 #include <asm/pgtable.h>
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -33,7 +33,6 @@
 #include <linux/blkpg.h>
 #include <linux/timer.h>
 #include <linux/proc_fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/init.h>
 #include <linux/hdreg.h>
 #include <linux/spinlock.h>
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -176,7 +176,6 @@ static int print_unex = 1;
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -63,7 +63,6 @@
 #include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -56,8 +56,6 @@
 #include <linux/ioctl.h>
 #include <net/sock.h>
 
-#include <linux/devfs_fs_kernel.h>
-
 #include <asm/uaccess.h>
 #include <asm/types.h>
 
diff --git a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c
+++ b/drivers/block/paride/pg.c
@@ -156,7 +156,6 @@ enum {D_PRT, D_PRO, D_UNI, D_MOD, D_SLV,
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mtio.h>
diff --git a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c
+++ b/drivers/block/paride/pt.c
@@ -141,7 +141,6 @@ static int (*drives[4])[6] = {&drive0, &
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mtio.h>
diff --git a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c
+++ b/drivers/block/rd.c
@@ -50,7 +50,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -25,7 +25,6 @@
 #include <linux/fd.h>
 #include <linux/ioctl.h>
 #include <linux/blkdev.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <asm/io.h>
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -18,7 +18,6 @@
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
 #include <linux/sched.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/interrupt.h>
 #include <linux/compiler.h>
 #include <linux/workqueue.h>
diff --git a/drivers/block/ub.c b/drivers/block/ub.c
--- a/drivers/block/ub.c
+++ b/drivers/block/ub.c
@@ -28,7 +28,6 @@
 #include <linux/module.h>
 #include <linux/usb.h>
 #include <linux/blkdev.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/timer.h>
 #include <scsi/scsi.h>
 
diff --git a/drivers/cdrom/cdu31a.c b/drivers/cdrom/cdu31a.c
--- a/drivers/cdrom/cdu31a.c
+++ b/drivers/cdrom/cdu31a.c
@@ -161,7 +161,6 @@
 #include <linux/hdreg.h>
 #include <linux/genhd.h>
 #include <linux/ioport.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/init.h>
diff --git a/drivers/cdrom/cm206.c b/drivers/cdrom/cm206.c
--- a/drivers/cdrom/cm206.c
+++ b/drivers/cdrom/cm206.c
@@ -187,7 +187,6 @@ History:
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/cdrom.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/ioport.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
diff --git a/drivers/cdrom/mcdx.c b/drivers/cdrom/mcdx.c
--- a/drivers/cdrom/mcdx.c
+++ b/drivers/cdrom/mcdx.c
@@ -74,7 +74,6 @@ static const char *mcdx_c_version
 #include <linux/major.h>
 #define MAJOR_NR MITSUMI_X_CDROM_MAJOR
 #include <linux/blkdev.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include "mcdx.h"
 
diff --git a/drivers/cdrom/sbpcd.c b/drivers/cdrom/sbpcd.c
--- a/drivers/cdrom/sbpcd.c
+++ b/drivers/cdrom/sbpcd.c
@@ -371,7 +371,6 @@
 #include <linux/kernel.h>
 #include <linux/cdrom.h>
 #include <linux/ioport.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/major.h>
 #include <linux/string.h>
 #include <linux/vmalloc.h>
diff --git a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
--- a/drivers/char/dsp56k.c
+++ b/drivers/char/dsp56k.c
@@ -33,7 +33,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
 
diff --git a/drivers/char/dtlk.c b/drivers/char/dtlk.c
--- a/drivers/char/dtlk.c
+++ b/drivers/char/dtlk.c
@@ -62,7 +62,6 @@
 #include <linux/init.h>		/* for __init, module_{init,exit} */
 #include <linux/poll.h>		/* for POLLIN, etc. */
 #include <linux/dtlk.h>		/* local header file for DoubleTalk values */
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 
 #ifdef TRACING
diff --git a/drivers/char/ftape/zftape/zftape-init.c b/drivers/char/ftape/zftape/zftape-init.c
--- a/drivers/char/ftape/zftape/zftape-init.c
+++ b/drivers/char/ftape/zftape/zftape-init.c
@@ -33,7 +33,6 @@
 #endif
 #include <linux/fcntl.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <linux/zftape.h>
 #include <linux/init.h>
diff --git a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c
+++ b/drivers/char/ip2main.c
@@ -91,7 +91,6 @@
 #include <linux/module.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -40,7 +40,6 @@
 #include <linux/poll.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/ipmi.h>
 #include <asm/semaphore.h>
 #include <linux/init.h>
diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -39,7 +39,6 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 #include <linux/wait.h>
 
diff --git a/drivers/char/lp.c b/drivers/char/lp.c
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -120,7 +120,6 @@
 #include <linux/major.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/slab.h>
 #include <linux/fcntl.h>
 #include <linux/delay.h>
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -20,7 +20,6 @@
 #include <linux/tty.h>
 #include <linux/capability.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
 #include <linux/device.h>
 #include <linux/backing-dev.h>
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -44,7 +44,6 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/stat.h>
 #include <linux/init.h>
 #include <linux/device.h>
diff --git a/drivers/char/mmtimer.c b/drivers/char/mmtimer.c
--- a/drivers/char/mmtimer.c
+++ b/drivers/char/mmtimer.c
@@ -25,7 +25,6 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/mmtimer.h>
 #include <linux/miscdevice.h>
 #include <linux/posix-timers.h>
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -60,7 +60,6 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/ioctl.h>
 #include <linux/parport.h>
 #include <linux/ctype.h>
diff --git a/drivers/char/pty.c b/drivers/char/pty.c
--- a/drivers/char/pty.c
+++ b/drivers/char/pty.c
@@ -24,7 +24,6 @@
 #include <linux/major.h>
 #include <linux/mm.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/sysctl.h>
 
 #include <asm/uaccess.h>
diff --git a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -10,7 +10,6 @@
 
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/module.h>
diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -40,7 +40,6 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 
diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c
+++ b/drivers/char/tipar.c
@@ -56,7 +56,6 @@
 #include <linux/ioport.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
-#include <linux/devfs_fs_kernel.h>	/* DevFs support */
 #include <linux/parport.h>		/* Our code depend on parport */
 #include <linux/device.h>
 
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -101,7 +101,6 @@
 #include <linux/kbd_kern.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <linux/kmod.h>
 
diff --git a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
--- a/drivers/char/vc_screen.c
+++ b/drivers/char/vc_screen.c
@@ -26,7 +26,6 @@
 #include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/tty.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -44,7 +44,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/fs.h>
 #include <linux/cdev.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/major.h>
 #include <linux/completion.h>
 #include <linux/proc_fs.h>
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -79,7 +79,6 @@
 #include <linux/mm.h>
 #include <linux/console.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
 #include <linux/tiocl.h>
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -35,7 +35,6 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -47,7 +47,6 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/spinlock.h>
 #include <linux/kmod.h>
 #include <linux/pci.h>
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -434,7 +434,6 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/major.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/errno.h>
 #include <linux/genhd.h>
 #include <linux/slab.h>
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -147,7 +147,6 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/completion.h>
 #include <linux/reboot.h>
 #include <linux/cdrom.h>
diff --git a/drivers/ieee1394/ieee1394_core.h b/drivers/ieee1394/ieee1394_core.h
--- a/drivers/ieee1394/ieee1394_core.h
+++ b/drivers/ieee1394/ieee1394_core.h
@@ -3,7 +3,6 @@
 #define _IEEE1394_CORE_H
 
 #include <linux/slab.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
 #include "hosts.h"
diff --git a/drivers/ieee1394/raw1394.c b/drivers/ieee1394/raw1394.c
--- a/drivers/ieee1394/raw1394.c
+++ b/drivers/ieee1394/raw1394.c
@@ -41,7 +41,6 @@
 #include <linux/cdev.h>
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include "csr1212.h"
 #include "ieee1394.h"
diff --git a/drivers/ieee1394/video1394.c b/drivers/ieee1394/video1394.c
--- a/drivers/ieee1394/video1394.c
+++ b/drivers/ieee1394/video1394.c
@@ -54,7 +54,6 @@
 #include <linux/poll.h>
 #include <linux/smp_lock.h>
 #include <linux/delay.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/bitops.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -20,7 +20,6 @@
 #include <linux/major.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 struct evdev {
 	int exist;
diff --git a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -22,7 +22,6 @@
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input core");
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -26,7 +26,6 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Joystick device interfaces");
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -24,7 +24,6 @@
 #include <linux/random.h>
 #include <linux/major.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 #include <linux/miscdevice.h>
 #endif
diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/major.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/wait.h>
 
diff --git a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c
+++ b/drivers/input/tsdev.c
@@ -53,7 +53,6 @@
 #include <linux/random.h>
 #include <linux/time.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 #ifndef CONFIG_INPUT_TSDEV_SCREEN_X
 #define CONFIG_INPUT_TSDEV_SCREEN_X	240
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -39,7 +39,6 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/moduleparam.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/isdn/capiutil.h>
 #include <linux/isdn/capicmd.h>
 #if defined(CONFIG_ISDN_CAPI_CAPIFS) || defined(CONFIG_ISDN_CAPI_CAPIFS_MODULE)
diff --git a/drivers/isdn/hardware/eicon/divamnt.c b/drivers/isdn/hardware/eicon/divamnt.c
--- a/drivers/isdn/hardware/eicon/divamnt.c
+++ b/drivers/isdn/hardware/eicon/divamnt.c
@@ -17,7 +17,6 @@
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <linux/poll.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 
 #include "platform.h"
diff --git a/drivers/isdn/hardware/eicon/divasi.c b/drivers/isdn/hardware/eicon/divasi.c
--- a/drivers/isdn/hardware/eicon/divasi.c
+++ b/drivers/isdn/hardware/eicon/divasi.c
@@ -19,7 +19,6 @@
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/skbuff.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 
 #include "platform.h"
diff --git a/drivers/isdn/hardware/eicon/divasmain.c b/drivers/isdn/hardware/eicon/divasmain.c
--- a/drivers/isdn/hardware/eicon/divasmain.c
+++ b/drivers/isdn/hardware/eicon/divasmain.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <linux/ioport.h>
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -36,7 +36,6 @@
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/device.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/dm-ioctl.h>
 
 #include <asm/uaccess.h>
diff --git a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -34,7 +34,6 @@
 #include <linux/linkage.h>
 #include <linux/raid/md.h>
 #include <linux/sysctl.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
 #include <linux/suspend.h>
 
diff --git a/drivers/media/dvb/dvb-core/dvbdev.h b/drivers/media/dvb/dvb-core/dvbdev.h
--- a/drivers/media/dvb/dvb-core/dvbdev.h
+++ b/drivers/media/dvb/dvb-core/dvbdev.h
@@ -27,7 +27,6 @@
 #include <linux/poll.h>
 #include <linux/fs.h>
 #include <linux/list.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 
 #define DVB_MAJOR 212
diff --git a/drivers/media/dvb/ttpci/av7110.h b/drivers/media/dvb/ttpci/av7110.h
--- a/drivers/media/dvb/ttpci/av7110.h
+++ b/drivers/media/dvb/ttpci/av7110.h
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
diff --git a/drivers/media/video/arv.c b/drivers/media/video/arv.c
--- a/drivers/media/video/arv.c
+++ b/drivers/media/video/arv.c
@@ -20,7 +20,6 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/delay.h>
diff --git a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -26,7 +26,6 @@
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/semaphore.h>
diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -27,7 +27,6 @@
 #include <linux/hdreg.h>
 #include <linux/kdev_t.h>
 #include <linux/blkdev.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/protocol.h>
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
-#include <linux/devfs_fs_kernel.h>
 
 static LIST_HEAD(blktrans_majors);
 
diff --git a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
--- a/drivers/net/ppp_generic.c
+++ b/drivers/net/ppp_generic.c
@@ -28,7 +28,6 @@
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/list.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/netdevice.h>
 #include <linux/poll.h>
 #include <linux/ppp_defs.h>
diff --git a/drivers/net/wan/cosa.c b/drivers/net/wan/cosa.c
--- a/drivers/net/wan/cosa.c
+++ b/drivers/net/wan/cosa.c
@@ -85,7 +85,6 @@
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -54,7 +54,6 @@
 #include <linux/module.h>
 #include <linux/wait.h>
 #include <linux/blkdev.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/genhd.h>
 #include <linux/hdreg.h>
 #include <linux/interrupt.h>
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -36,7 +36,6 @@
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
 #include <linux/sysdev.h>
 #include <linux/bio.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 
 #define XPRAM_NAME	"xpram"
diff --git a/drivers/s390/net/ctctty.c b/drivers/s390/net/ctctty.c
--- a/drivers/s390/net/ctctty.c
+++ b/drivers/s390/net/ctctty.c
@@ -29,7 +29,6 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <asm/uaccess.h>
-#include <linux/devfs_fs_kernel.h>
 #include "ctctty.h"
 #include "ctcdbug.h"
 
diff --git a/drivers/sbus/char/bpp.c b/drivers/sbus/char/bpp.c
--- a/drivers/sbus/char/bpp.c
+++ b/drivers/sbus/char/bpp.c
@@ -20,7 +20,6 @@
 #include <linux/timer.h>
 #include <linux/ioport.h>
 #include <linux/major.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
diff --git a/drivers/sbus/char/vfc.h b/drivers/sbus/char/vfc.h
--- a/drivers/sbus/char/vfc.h
+++ b/drivers/sbus/char/vfc.h
@@ -1,8 +1,6 @@
 #ifndef _LINUX_VFC_H_
 #define _LINUX_VFC_H_
 
-#include <linux/devfs_fs_kernel.h>
-
 /*
  * The control register for the vfc is at offset 0x4000
  * The first field ram bank is located at offset 0x5000
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -20,7 +20,6 @@
 #include <linux/interrupt.h>
 #include <linux/blkdev.h>
 #include <linux/completion.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/ioctl32.h>
 #include <linux/compat.h>
 #include <linux/chio.h>			/* here are all the ioctls */
diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -48,7 +48,6 @@ static const char * osst_version = "0.99
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
 #include <linux/moduleparam.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/dma.h>
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -48,7 +48,6 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/completion.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/unistd.h>
 #include <linux/spinlock.h>
 #include <linux/kmod.h>
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -44,7 +44,6 @@ static int sg_version_num = 30533;	/* 2 
 #include <linux/poll.h>
 #include <linux/smp_lock.h>
 #include <linux/moduleparam.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/cdev.h>
 #include <linux/seq_file.h>
 #include <linux/blkdev.h>
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -35,7 +35,6 @@ static char *verstr = "20050501";
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
 #include <linux/moduleparam.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/cdev.h>
 #include <linux/delay.h>
 
diff --git a/drivers/telephony/phonedev.c b/drivers/telephony/phonedev.c
--- a/drivers/telephony/phonedev.c
+++ b/drivers/telephony/phonedev.c
@@ -28,7 +28,6 @@
 
 #include <linux/kmod.h>
 #include <linux/sem.h>
-#include <linux/devfs_fs_kernel.h>
 
 #define PHONE_NUM_DEVICES	256
 
diff --git a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c
+++ b/drivers/usb/core/file.c
@@ -17,7 +17,6 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 
diff --git a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c
+++ b/drivers/usb/input/hiddev.c
@@ -35,7 +35,6 @@
 #include <linux/usb.h>
 #include "hid.h"
 #include <linux/hiddev.h>
-#include <linux/devfs_fs_kernel.h>
 
 #ifdef CONFIG_USB_DYNAMIC_MINORS
 #define HIDDEV_MINOR_BASE	0
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -31,7 +31,6 @@
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
-#include <linux/devfs_fs_kernel.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
diff --git a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -12,7 +12,6 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/major.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 #include <linux/highmem.h>
 #include <linux/blkdev.h>
diff --git a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -14,7 +14,6 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include <linux/kobject.h>
 #include <linux/kobj_map.h>
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -28,7 +28,6 @@
 #include <linux/delay.h>
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/file.h>
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -18,7 +18,6 @@
 #include <linux/fs.h>
 #include <linux/kmod.h>
 #include <linux/ctype.h>
-#include <linux/devfs_fs_kernel.h>
 
 #include "check.h"
 
diff --git a/include/asm-ppc/ocp.h b/include/asm-ppc/ocp.h
--- a/include/asm-ppc/ocp.h
+++ b/include/asm-ppc/ocp.h
@@ -27,7 +27,6 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/config.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 
 #include <asm/mmu.h>
diff --git a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
deleted file mode 100644
--- a/include/linux/devfs_fs_kernel.h
+++ /dev/null
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
diff --git a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -363,7 +363,6 @@ struct fb_cursor {
 #include <linux/tty.h>
 #include <linux/device.h>
 #include <linux/workqueue.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/notifier.h>
 #include <linux/list.h>
 #include <asm/io.h>
diff --git a/init/do_mounts.h b/init/do_mounts.h
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -1,6 +1,5 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/init.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
diff --git a/init/main.c b/init/main.c
--- a/init/main.c
+++ b/init/main.c
@@ -15,7 +15,6 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/kernel.h>
 #include <linux/syscalls.h>
 #include <linux/string.h>
diff --git a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -26,7 +26,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
diff --git a/mm/tiny-shmem.c b/mm/tiny-shmem.c
--- a/mm/tiny-shmem.c
+++ b/mm/tiny-shmem.c
@@ -12,7 +12,6 @@
 
 #include <linux/fs.h>
 #include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/vfs.h>
 #include <linux/mount.h>
 #include <linux/file.h>
diff --git a/net/irda/irnet/irnet.h b/net/irda/irnet/irnet.h
--- a/net/irda/irnet/irnet.h
+++ b/net/irda/irnet/irnet.h
@@ -244,7 +244,6 @@
 #include <linux/skbuff.h>
 #include <linux/tty.h>
 #include <linux/proc_fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/netdevice.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
diff --git a/sound/core/info.c b/sound/core/info.c
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -29,7 +29,6 @@
 #include <sound/info.h>
 #include <sound/version.h>
 #include <linux/proc_fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <stdarg.h>
 
 /*
diff --git a/sound/core/sound.c b/sound/core/sound.c
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -31,7 +31,6 @@
 #include <sound/control.h>
 #include <sound/initval.h>
 #include <linux/kmod.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 
 #define SNDRV_OS_MINORS 256
diff --git a/sound/oss/soundcard.c b/sound/oss/soundcard.c
--- a/sound/oss/soundcard.c
+++ b/sound/oss/soundcard.c
@@ -38,7 +38,6 @@
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/major.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
diff --git a/sound/sound_core.c b/sound/sound_core.c
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -44,7 +44,6 @@
 #include <linux/sound.h>
 #include <linux/major.h>
 #include <linux/kmod.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 
 #define SOUND_STEP 16

