Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261647AbTCKWcT>; Tue, 11 Mar 2003 17:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261648AbTCKWcT>; Tue, 11 Mar 2003 17:32:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35796 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261647AbTCKWb6>; Tue, 11 Mar 2003 17:31:58 -0500
Date: Tue, 11 Mar 2003 23:42:33 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [2.5 patch] kill useless __NO_VERSION__
Message-ID: <20030311224233.GF16212@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some months ago Rusty Russell sent a patch with the subject
"[PATCH} 2.5.33 __NO_VERSION__ useless since 2.3". Below is a patch 
against 2.5.64 that removes all remaining occurances of __NO_VERSION__ 
(compilation tested).

diffstat output:

 arch/s390x/kernel/exec32.c                    |    1 -
 drivers/char/drm/ati_pcigart.h                |    1 -
 drivers/char/drm/drm_agpsupport.h             |    1 -
 drivers/char/drm/drm_auth.h                   |    1 -
 drivers/char/drm/drm_bufs.h                   |    1 -
 drivers/char/drm/drm_context.h                |    1 -
 drivers/char/drm/drm_dma.h                    |    1 -
 drivers/char/drm/drm_drawable.h               |    1 -
 drivers/char/drm/drm_fops.h                   |    1 -
 drivers/char/drm/drm_init.h                   |    1 -
 drivers/char/drm/drm_ioctl.h                  |    1 -
 drivers/char/drm/drm_lists.h                  |    1 -
 drivers/char/drm/drm_lock.h                   |    1 -
 drivers/char/drm/drm_memory.h                 |    1 -
 drivers/char/drm/drm_os_linux.h               |    1 -
 drivers/char/drm/drm_proc.h                   |    1 -
 drivers/char/drm/drm_scatter.h                |    1 -
 drivers/char/drm/drm_stub.h                   |    1 -
 drivers/char/drm/drm_vm.h                     |    1 -
 drivers/char/drm/gamma_dma.c                  |    1 -
 drivers/char/drm/i810_dma.c                   |    1 -
 drivers/char/drm/i830_dma.c                   |    1 -
 drivers/char/drm/mga_warp.c                   |    1 -
 drivers/char/drm/sis_ds.c                     |    1 -
 drivers/char/drm/sis_mm.c                     |    1 -
 drivers/char/ftape/lowlevel/ftape_syms.c      |    1 -
 drivers/char/ftape/zftape/zftape-ctl.c        |    1 -
 drivers/char/ftape/zftape/zftape_syms.c       |    1 -
 drivers/char/rio/rioboot.c                    |    1 -
 drivers/char/rio/riocmd.c                     |    1 -
 drivers/char/rio/rioctrl.c                    |    1 -
 drivers/char/rio/rioinit.c                    |    1 -
 drivers/char/rio/riointr.c                    |    1 -
 drivers/char/rio/rioparam.c                   |    1 -
 drivers/char/rio/rioroute.c                   |    1 -
 drivers/char/rio/riotable.c                   |    1 -
 drivers/char/rio/riotty.c                     |    1 -
 drivers/fc4/fc_syms.c                         |    1 -
 drivers/ide/ide-dma.c                         |    1 -
 drivers/ide/ide-iops.c                        |    1 -
 drivers/ide/ide-lib.c                         |    1 -
 drivers/ide/ide-proc.c                        |    1 -
 drivers/ide/ide-taskfile.c                    |    1 -
 drivers/media/radio/miropcm20-rds-core.c      |    2 --
 drivers/media/video/bttv-cards.c              |    2 --
 drivers/media/video/bttv-if.c                 |    2 --
 drivers/media/video/bttv-risc.c               |    2 --
 drivers/media/video/saa7134/saa7134-i2c.c     |    2 --
 drivers/media/video/saa7134/saa7134-oss.c     |    2 --
 drivers/media/video/saa7134/saa7134-ts.c      |    2 --
 drivers/media/video/saa7134/saa7134-tvaudio.c |    2 --
 drivers/media/video/saa7134/saa7134-vbi.c     |    2 --
 drivers/media/video/saa7134/saa7134-video.c   |    2 --
 drivers/mtd/nftlmount.c                       |    1 -
 drivers/pcmcia/bulkmem.c                      |    2 --
 drivers/pcmcia/cardbus.c                      |    2 --
 drivers/pcmcia/cistpl.c                       |    2 --
 drivers/pcmcia/rsrc_mgr.c                     |    2 --
 drivers/pnp/pnpbios/proc.c                    |    1 -
 drivers/s390/net/ctctty.c                     |    1 -
 fs/autofs/inode.c                             |    1 -
 fs/autofs4/inode.c                            |    1 -
 fs/cifs/cifs_debug.c                          |    1 -
 fs/exec.c                                     |    1 -
 fs/intermezzo/cache.c                         |    1 -
 fs/intermezzo/dcache.c                        |    1 -
 fs/intermezzo/dir.c                           |    1 -
 fs/intermezzo/ext_attr.c                      |    1 -
 fs/intermezzo/file.c                          |    1 -
 fs/intermezzo/fileset.c                       |    2 --
 fs/intermezzo/inode.c                         |    1 -
 fs/intermezzo/kml.c                           |    1 -
 fs/intermezzo/kml_decode.c                    |    1 -
 fs/intermezzo/kml_reint.c                     |    1 -
 fs/intermezzo/kml_setup.c                     |    1 -
 fs/intermezzo/methods.c                       |    1 -
 fs/intermezzo/replicator.c                    |    1 -
 fs/intermezzo/super.c                         |    1 -
 fs/intermezzo/sysctl.c                        |    1 -
 fs/jffs/intrep.c                              |    1 -
 fs/jffs/jffs_fm.c                             |    1 -
 fs/lockd/lockd_syms.c                         |    1 -
 fs/proc/inode.c                               |    1 -
 sound/oss/audio_syms.c                        |    2 --
 sound/oss/emu10k1/audio.c                     |    1 -
 sound/oss/emu10k1/midi.c                      |    1 -
 sound/oss/emu10k1/mixer.c                     |    1 -
 sound/oss/emu10k1/passthrough.c               |    1 -
 sound/oss/midi_syms.c                         |    2 --
 sound/oss/nm256_audio.c                       |    1 -
 sound/oss/sequencer_syms.c                    |    2 --
 91 files changed, 109 deletions(-)


Please apply
Adrian


--- linux-2.5.64-notfull/arch/s390x/kernel/exec32.c.old	2003-03-11 23:19:03.000000000 +0100
+++ linux-2.5.64-notfull/arch/s390x/kernel/exec32.c	2003-03-11 23:19:13.000000000 +0100
@@ -21,7 +21,6 @@
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/binfmts.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include <asm/uaccess.h>
--- linux-2.5.64-notfull/drivers/media/radio/miropcm20-rds-core.c.old	2003-03-11 23:19:13.000000000 +0100
+++ linux-2.5.64-notfull/drivers/media/radio/miropcm20-rds-core.c	2003-03-11 23:19:24.000000000 +0100
@@ -13,8 +13,6 @@
  *        RDS support for MiroSound PCM20 radio
  */
 
-#define _NO_VERSION_
-
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/string.h>
--- linux-2.5.64-notfull/drivers/media/video/saa7134/saa7134-tvaudio.c.old	2003-03-11 23:19:24.000000000 +0100
+++ linux-2.5.64-notfull/drivers/media/video/saa7134/saa7134-tvaudio.c	2003-03-11 23:19:30.000000000 +0100
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
--- linux-2.5.64-notfull/drivers/media/video/saa7134/saa7134-ts.c.old	2003-03-11 23:19:30.000000000 +0100
+++ linux-2.5.64-notfull/drivers/media/video/saa7134/saa7134-ts.c	2003-03-11 23:19:35.000000000 +0100
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
--- linux-2.5.64-notfull/drivers/media/video/saa7134/saa7134-i2c.c.old	2003-03-11 23:19:35.000000000 +0100
+++ linux-2.5.64-notfull/drivers/media/video/saa7134/saa7134-i2c.c	2003-03-11 23:19:39.000000000 +0100
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
--- linux-2.5.64-notfull/drivers/media/video/saa7134/saa7134-video.c.old	2003-03-11 23:19:39.000000000 +0100
+++ linux-2.5.64-notfull/drivers/media/video/saa7134/saa7134-video.c	2003-03-11 23:19:45.000000000 +0100
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
--- linux-2.5.64-notfull/drivers/media/video/saa7134/saa7134-oss.c.old	2003-03-11 23:19:45.000000000 +0100
+++ linux-2.5.64-notfull/drivers/media/video/saa7134/saa7134-oss.c	2003-03-11 23:19:50.000000000 +0100
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
--- linux-2.5.64-notfull/drivers/media/video/saa7134/saa7134-vbi.c.old	2003-03-11 23:19:50.000000000 +0100
+++ linux-2.5.64-notfull/drivers/media/video/saa7134/saa7134-vbi.c	2003-03-11 23:19:55.000000000 +0100
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
--- linux-2.5.64-notfull/drivers/media/video/bttv-if.c.old	2003-03-11 23:19:55.000000000 +0100
+++ linux-2.5.64-notfull/drivers/media/video/bttv-if.c	2003-03-11 23:19:59.000000000 +0100
@@ -25,8 +25,6 @@
     
 */
 
-#define __NO_VERSION__ 1
-
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
--- linux-2.5.64-notfull/drivers/media/video/bttv-cards.c.old	2003-03-11 23:19:59.000000000 +0100
+++ linux-2.5.64-notfull/drivers/media/video/bttv-cards.c	2003-03-11 23:20:03.000000000 +0100
@@ -24,8 +24,6 @@
     
 */
 
-#define __NO_VERSION__ 1
-
 #include <linux/version.h>
 #include <linux/delay.h>
 #include <linux/module.h>
--- linux-2.5.64-notfull/drivers/media/video/bttv-risc.c.old	2003-03-11 23:20:03.000000000 +0100
+++ linux-2.5.64-notfull/drivers/media/video/bttv-risc.c	2003-03-11 23:20:08.000000000 +0100
@@ -23,8 +23,6 @@
 
 */
 
-#define __NO_VERSION__ 1
-
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
--- linux-2.5.64-notfull/drivers/s390/net/ctctty.c.old	2003-03-11 23:20:08.000000000 +0100
+++ linux-2.5.64-notfull/drivers/s390/net/ctctty.c	2003-03-11 23:20:12.000000000 +0100
@@ -22,7 +22,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/tty.h>
--- linux-2.5.64-notfull/drivers/fc4/fc_syms.c.old	2003-03-11 23:20:12.000000000 +0100
+++ linux-2.5.64-notfull/drivers/fc4/fc_syms.c	2003-03-11 23:20:15.000000000 +0100
@@ -2,7 +2,6 @@
  * We should not even be trying to compile this if we are not doing
  * a module.
  */
-#define __NO_VERSION__
 #include <linux/config.h>
 #include <linux/module.h>
 
--- linux-2.5.64-notfull/drivers/char/rio/riointr.c.old	2003-03-11 23:20:15.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/rio/riointr.c	2003-03-11 23:20:21.000000000 +0100
@@ -34,7 +34,6 @@
 #endif
 
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
--- linux-2.5.64-notfull/drivers/char/rio/rioboot.c.old	2003-03-11 23:20:21.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/rio/rioboot.c	2003-03-11 23:20:25.000000000 +0100
@@ -34,7 +34,6 @@
 static char *_rioboot_c_sccs_ = "@(#)rioboot.c	1.3";
 #endif
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
--- linux-2.5.64-notfull/drivers/char/rio/rioinit.c.old	2003-03-11 23:20:25.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/rio/rioinit.c	2003-03-11 23:20:30.000000000 +0100
@@ -33,7 +33,6 @@
 static char *_rioinit_c_sccs_ = "@(#)rioinit.c	1.3";
 #endif
 
-#define __NO_VERSION__
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/slab.h>
--- linux-2.5.64-notfull/drivers/char/rio/riocmd.c.old	2003-03-11 23:20:30.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/rio/riocmd.c	2003-03-11 23:20:34.000000000 +0100
@@ -34,7 +34,6 @@
 static char *_riocmd_c_sccs_ = "@(#)riocmd.c	1.2";
 #endif
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
--- linux-2.5.64-notfull/drivers/char/rio/riotty.c.old	2003-03-11 23:20:34.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/rio/riotty.c	2003-03-11 23:20:38.000000000 +0100
@@ -36,7 +36,6 @@
 
 #define __EXPLICIT_DEF_H__
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
--- linux-2.5.64-notfull/drivers/char/rio/rioctrl.c.old	2003-03-11 23:20:38.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/rio/rioctrl.c	2003-03-11 23:20:41.000000000 +0100
@@ -34,7 +34,6 @@
 #endif
 
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
--- linux-2.5.64-notfull/drivers/char/rio/rioroute.c.old	2003-03-11 23:20:41.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/rio/rioroute.c	2003-03-11 23:20:44.000000000 +0100
@@ -33,7 +33,6 @@
 static char *_rioroute_c_sccs_ = "@(#)rioroute.c	1.3";
 #endif
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
--- linux-2.5.64-notfull/drivers/char/rio/riotable.c.old	2003-03-11 23:20:44.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/rio/riotable.c	2003-03-11 23:20:47.000000000 +0100
@@ -33,7 +33,6 @@
 static char *_riotable_c_sccs_ = "@(#)riotable.c	1.2";
 #endif
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
--- linux-2.5.64-notfull/drivers/char/rio/rioparam.c.old	2003-03-11 23:20:47.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/rio/rioparam.c	2003-03-11 23:20:50.000000000 +0100
@@ -34,7 +34,6 @@
 static char *_rioparam_c_sccs_ = "@(#)rioparam.c	1.3";
 #endif
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
--- linux-2.5.64-notfull/drivers/char/ftape/lowlevel/ftape_syms.c.old	2003-03-11 23:20:50.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/ftape/lowlevel/ftape_syms.c	2003-03-11 23:20:55.000000000 +0100
@@ -26,7 +26,6 @@
  */
 
 #include <linux/config.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include <linux/ftape.h>
--- linux-2.5.64-notfull/drivers/char/ftape/zftape/zftape_syms.c.old	2003-03-11 23:20:55.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/ftape/zftape/zftape_syms.c	2003-03-11 23:20:59.000000000 +0100
@@ -24,7 +24,6 @@
  *      the ftape floppy tape driver exports 
  */		 
 
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include <linux/zftape.h>
--- linux-2.5.64-notfull/drivers/char/ftape/zftape/zftape-ctl.c.old	2003-03-11 23:20:59.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/ftape/zftape/zftape-ctl.c	2003-03-11 23:21:03.000000000 +0100
@@ -27,7 +27,6 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/fcntl.h>
 
--- linux-2.5.64-notfull/drivers/char/drm/drm_agpsupport.h.old	2003-03-11 23:21:03.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_agpsupport.h	2003-03-11 23:21:09.000000000 +0100
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 #include <linux/module.h>
 
--- linux-2.5.64-notfull/drivers/char/drm/drm_context.h.old	2003-03-11 23:21:09.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_context.h	2003-03-11 23:22:24.000000000 +0100
@@ -33,7 +33,6 @@
  *		needed by SiS driver's memory management.
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #if __HAVE_CTX_BITMAP
--- linux-2.5.64-notfull/drivers/char/drm/i830_dma.c.old	2003-03-11 23:22:24.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/i830_dma.c	2003-03-11 23:22:28.000000000 +0100
@@ -31,7 +31,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include "i830.h"
 #include "drmP.h"
 #include "drm.h"
--- linux-2.5.64-notfull/drivers/char/drm/drm_proc.h.old	2003-03-11 23:22:28.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_proc.h	2003-03-11 23:22:31.000000000 +0100
@@ -33,7 +33,6 @@
  *    the problem with the proc files not outputting all their information.
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 static int	   DRM(name_info)(char *buf, char **start, off_t offset,
--- linux-2.5.64-notfull/drivers/char/drm/drm_memory.h.old	2003-03-11 23:22:31.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_memory.h	2003-03-11 23:22:33.000000000 +0100
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include <linux/config.h>
 #include "drmP.h"
 #include <linux/wrapper.h>
--- linux-2.5.64-notfull/drivers/char/drm/drm_bufs.h.old	2003-03-11 23:22:33.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_bufs.h	2003-03-11 23:22:36.000000000 +0100
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include <linux/vmalloc.h>
 #include "drmP.h"
 
--- linux-2.5.64-notfull/drivers/char/drm/drm_ioctl.h.old	2003-03-11 23:22:36.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_ioctl.h	2003-03-11 23:22:39.000000000 +0100
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 
--- linux-2.5.64-notfull/drivers/char/drm/i810_dma.c.old	2003-03-11 23:22:39.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/i810_dma.c	2003-03-11 23:22:42.000000000 +0100
@@ -30,7 +30,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include "i810.h"
 #include "drmP.h"
 #include "drm.h"
--- linux-2.5.64-notfull/drivers/char/drm/mga_warp.c.old	2003-03-11 23:22:42.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/mga_warp.c	2003-03-11 23:22:44.000000000 +0100
@@ -27,7 +27,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "mga.h"
 #include "drmP.h"
 #include "drm.h"
--- linux-2.5.64-notfull/drivers/char/drm/drm_fops.h.old	2003-03-11 23:22:44.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_fops.h	2003-03-11 23:22:48.000000000 +0100
@@ -30,7 +30,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 #include <linux/poll.h>
 
--- linux-2.5.64-notfull/drivers/char/drm/drm_scatter.h.old	2003-03-11 23:22:48.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_scatter.h	2003-03-11 23:22:52.000000000 +0100
@@ -27,7 +27,6 @@
  *   Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include <linux/config.h>
 #include <linux/vmalloc.h>
 #include "drmP.h"
--- linux-2.5.64-notfull/drivers/char/drm/drm_dma.h.old	2003-03-11 23:22:52.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_dma.h	2003-03-11 23:22:55.000000000 +0100
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #include <linux/interrupt.h>	/* For task queue support */
--- linux-2.5.64-notfull/drivers/char/drm/drm_lock.h.old	2003-03-11 23:22:55.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_lock.h	2003-03-11 23:22:58.000000000 +0100
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 int DRM(block)(struct inode *inode, struct file *filp, unsigned int cmd,
--- linux-2.5.64-notfull/drivers/char/drm/sis_mm.c.old	2003-03-11 23:22:58.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/sis_mm.c	2003-03-11 23:23:01.000000000 +0100
@@ -28,7 +28,6 @@
  * 
  */
 
-#define __NO_VERSION__
 #include "sis.h"
 #include <linux/sisfb.h>
 #include "drmP.h"
--- linux-2.5.64-notfull/drivers/char/drm/drm_drawable.h.old	2003-03-11 23:23:01.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_drawable.h	2003-03-11 23:23:04.000000000 +0100
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 int DRM(adddraw)(struct inode *inode, struct file *filp,
--- linux-2.5.64-notfull/drivers/char/drm/drm_stub.h.old	2003-03-11 23:23:04.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_stub.h	2003-03-11 23:23:07.000000000 +0100
@@ -28,7 +28,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #define DRM_STUB_MAXCARDS 16	/* Enough for one machine */
--- linux-2.5.64-notfull/drivers/char/drm/drm_lists.h.old	2003-03-11 23:23:07.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_lists.h	2003-03-11 23:23:11.000000000 +0100
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #if __HAVE_DMA_WAITLIST
--- linux-2.5.64-notfull/drivers/char/drm/drm_init.h.old	2003-03-11 23:23:11.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_init.h	2003-03-11 23:23:14.000000000 +0100
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #if 0
--- linux-2.5.64-notfull/drivers/char/drm/drm_auth.h.old	2003-03-11 23:23:14.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_auth.h	2003-03-11 23:23:17.000000000 +0100
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 static int DRM(hash_magic)(drm_magic_t magic)
--- linux-2.5.64-notfull/drivers/char/drm/ati_pcigart.h.old	2003-03-11 23:23:17.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/ati_pcigart.h	2003-03-11 23:23:20.000000000 +0100
@@ -27,7 +27,6 @@
  *   Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #if PAGE_SIZE == 65536
--- linux-2.5.64-notfull/drivers/char/drm/sis_ds.c.old	2003-03-11 23:23:20.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/sis_ds.c	2003-03-11 23:23:23.000000000 +0100
@@ -28,7 +28,6 @@
  * 
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
--- linux-2.5.64-notfull/drivers/char/drm/drm_os_linux.h.old	2003-03-11 23:23:23.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_os_linux.h	2003-03-11 23:23:27.000000000 +0100
@@ -1,4 +1,3 @@
-#define __NO_VERSION__
 
 #include <linux/interrupt.h>	/* For task queue support */
 #include <linux/delay.h>
--- linux-2.5.64-notfull/drivers/char/drm/gamma_dma.c.old	2003-03-11 23:23:27.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/gamma_dma.c	2003-03-11 23:23:30.000000000 +0100
@@ -29,7 +29,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include "gamma.h"
 #include "drmP.h"
 #include "drm.h"
--- linux-2.5.64-notfull/drivers/char/drm/drm_vm.h.old	2003-03-11 23:23:30.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/drm/drm_vm.h	2003-03-11 23:23:33.000000000 +0100
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 struct vm_operations_struct   DRM(vm_ops) = {
--- linux-2.5.64-notfull/drivers/mtd/nftlmount.c.old	2003-03-11 23:23:33.000000000 +0100
+++ linux-2.5.64-notfull/drivers/mtd/nftlmount.c	2003-03-11 23:23:35.000000000 +0100
@@ -21,7 +21,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#define __NO_VERSION__
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <asm/errno.h>
--- linux-2.5.64-notfull/drivers/pcmcia/cardbus.c.old	2003-03-11 23:23:35.000000000 +0100
+++ linux-2.5.64-notfull/drivers/pcmcia/cardbus.c	2003-03-11 23:23:40.000000000 +0100
@@ -46,8 +46,6 @@
  */
 
 
-#define __NO_VERSION__
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
--- linux-2.5.64-notfull/drivers/pcmcia/cistpl.c.old	2003-03-11 23:23:40.000000000 +0100
+++ linux-2.5.64-notfull/drivers/pcmcia/cistpl.c	2003-03-11 23:23:45.000000000 +0100
@@ -31,8 +31,6 @@
     
 ======================================================================*/
 
-#define __NO_VERSION__
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
--- linux-2.5.64-notfull/drivers/pcmcia/rsrc_mgr.c.old	2003-03-11 23:23:45.000000000 +0100
+++ linux-2.5.64-notfull/drivers/pcmcia/rsrc_mgr.c	2003-03-11 23:23:50.000000000 +0100
@@ -31,8 +31,6 @@
     
 ======================================================================*/
 
-#define __NO_VERSION__
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
--- linux-2.5.64-notfull/drivers/pcmcia/bulkmem.c.old	2003-03-11 23:23:50.000000000 +0100
+++ linux-2.5.64-notfull/drivers/pcmcia/bulkmem.c	2003-03-11 23:23:54.000000000 +0100
@@ -31,8 +31,6 @@
     
 ======================================================================*/
 
-#define __NO_VERSION__
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
--- linux-2.5.64-notfull/drivers/ide/ide-taskfile.c.old	2003-03-11 23:23:54.000000000 +0100
+++ linux-2.5.64-notfull/drivers/ide/ide-taskfile.c	2003-03-11 23:23:57.000000000 +0100
@@ -27,7 +27,6 @@
  */
 
 #include <linux/config.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
--- linux-2.5.64-notfull/drivers/ide/ide-iops.c.old	2003-03-11 23:23:57.000000000 +0100
+++ linux-2.5.64-notfull/drivers/ide/ide-iops.c	2003-03-11 23:24:00.000000000 +0100
@@ -7,7 +7,6 @@
  */
 
 #include <linux/config.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
--- linux-2.5.64-notfull/drivers/ide/ide-dma.c.old	2003-03-11 23:24:00.000000000 +0100
+++ linux-2.5.64-notfull/drivers/ide/ide-dma.c	2003-03-11 23:24:05.000000000 +0100
@@ -75,7 +75,6 @@
  */
 
 #include <linux/config.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
--- linux-2.5.64-notfull/drivers/ide/ide-proc.c.old	2003-03-11 23:24:05.000000000 +0100
+++ linux-2.5.64-notfull/drivers/ide/ide-proc.c	2003-03-11 23:24:13.000000000 +0100
@@ -57,7 +57,6 @@
  */
 
 #include <linux/config.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include <asm/uaccess.h>
--- linux-2.5.64-notfull/drivers/ide/ide-lib.c.old	2003-03-11 23:24:13.000000000 +0100
+++ linux-2.5.64-notfull/drivers/ide/ide-lib.c	2003-03-11 23:24:16.000000000 +0100
@@ -1,5 +1,4 @@
 #include <linux/config.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
--- linux-2.5.64-notfull/drivers/pnp/pnpbios/proc.c.old	2003-03-11 23:24:16.000000000 +0100
+++ linux-2.5.64-notfull/drivers/pnp/pnpbios/proc.c	2003-03-11 23:24:20.000000000 +0100
@@ -19,7 +19,6 @@
  */
 
 //#include <pcmcia/config.h>
-#define __NO_VERSION__
 //#include <pcmcia/k_compat.h>
 
 #include <linux/module.h>
--- linux-2.5.64-notfull/fs/cifs/cifs_debug.c.old	2003-03-11 23:24:20.000000000 +0100
+++ linux-2.5.64-notfull/fs/cifs/cifs_debug.c	2003-03-11 23:24:23.000000000 +0100
@@ -22,7 +22,6 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <asm/uaccess.h>
--- linux-2.5.64-notfull/fs/intermezzo/kml.c.old	2003-03-11 23:24:23.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/kml.c	2003-03-11 23:24:26.000000000 +0100
@@ -1,7 +1,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
--- linux-2.5.64-notfull/fs/intermezzo/inode.c.old	2003-03-11 23:24:26.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/inode.c	2003-03-11 23:24:29.000000000 +0100
@@ -24,7 +24,6 @@
  * Super block/filesystem wide operations
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
--- linux-2.5.64-notfull/fs/intermezzo/sysctl.c.old	2003-03-11 23:24:29.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/sysctl.c	2003-03-11 23:24:32.000000000 +0100
@@ -21,7 +21,6 @@
  *  Sysctrl entries for Intermezzo!
  */
 
-#define __NO_VERSION__
 #include <linux/config.h> /* for CONFIG_PROC_FS */
 #include <linux/module.h>
 #include <linux/sched.h>
--- linux-2.5.64-notfull/fs/intermezzo/dir.c.old	2003-03-11 23:24:32.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/dir.c	2003-03-11 23:24:36.000000000 +0100
@@ -42,7 +42,6 @@
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include "intermezzo_fs.h"
--- linux-2.5.64-notfull/fs/intermezzo/fileset.c.old	2003-03-11 23:24:36.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/fileset.c	2003-03-11 23:24:40.000000000 +0100
@@ -22,8 +22,6 @@
  *
  */
 
-#define __NO_VERSION__
-
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
--- linux-2.5.64-notfull/fs/intermezzo/cache.c.old	2003-03-11 23:24:40.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/cache.c	2003-03-11 23:24:43.000000000 +0100
@@ -20,7 +20,6 @@
  *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
--- linux-2.5.64-notfull/fs/intermezzo/kml_setup.c.old	2003-03-11 23:24:43.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/kml_setup.c	2003-03-11 23:24:46.000000000 +0100
@@ -1,7 +1,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
--- linux-2.5.64-notfull/fs/intermezzo/replicator.c.old	2003-03-11 23:24:46.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/replicator.c	2003-03-11 23:24:49.000000000 +0100
@@ -23,7 +23,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
--- linux-2.5.64-notfull/fs/intermezzo/ext_attr.c.old	2003-03-11 23:24:49.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/ext_attr.c	2003-03-11 23:24:52.000000000 +0100
@@ -22,7 +22,6 @@
  * Extended attribute handling for presto.
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
--- linux-2.5.64-notfull/fs/intermezzo/file.c.old	2003-03-11 23:24:52.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/file.c	2003-03-11 23:24:55.000000000 +0100
@@ -47,7 +47,6 @@
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include <linux/fsfilter.h>
--- linux-2.5.64-notfull/fs/intermezzo/dcache.c.old	2003-03-11 23:24:55.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/dcache.c	2003-03-11 23:24:58.000000000 +0100
@@ -31,7 +31,6 @@
  * with heavy changes by Linus Torvalds
  */
 
-#define __NO_VERSION__
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
--- linux-2.5.64-notfull/fs/intermezzo/kml_reint.c.old	2003-03-11 23:24:58.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/kml_reint.c	2003-03-11 23:25:01.000000000 +0100
@@ -22,7 +22,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
--- linux-2.5.64-notfull/fs/intermezzo/kml_decode.c.old	2003-03-11 23:25:01.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/kml_decode.c	2003-03-11 23:25:04.000000000 +0100
@@ -5,7 +5,6 @@
  *
  * Copyright (C) 2001 Mountainview Data, Inc.
  */
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
--- linux-2.5.64-notfull/fs/intermezzo/methods.c.old	2003-03-11 23:25:04.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/methods.c	2003-03-11 23:25:08.000000000 +0100
@@ -42,7 +42,6 @@
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include <linux/fsfilter.h>
--- linux-2.5.64-notfull/fs/intermezzo/super.c.old	2003-03-11 23:25:08.000000000 +0100
+++ linux-2.5.64-notfull/fs/intermezzo/super.c	2003-03-11 23:25:11.000000000 +0100
@@ -44,7 +44,6 @@
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include "intermezzo_fs.h"
--- linux-2.5.64-notfull/fs/autofs4/inode.c.old	2003-03-11 23:25:11.000000000 +0100
+++ linux-2.5.64-notfull/fs/autofs4/inode.c	2003-03-11 23:25:18.000000000 +0100
@@ -16,7 +16,6 @@
 #include <linux/pagemap.h>
 #include <asm/bitops.h>
 #include "autofs_i.h"
-#define __NO_VERSION__
 #include <linux/module.h>
 
 static void ino_lnkfree(struct autofs_info *ino)
--- linux-2.5.64-notfull/fs/lockd/lockd_syms.c.old	2003-03-11 23:25:18.000000000 +0100
+++ linux-2.5.64-notfull/fs/lockd/lockd_syms.c	2003-03-11 23:25:21.000000000 +0100
@@ -8,7 +8,6 @@
  * Copyright (C) 1997 Olaf Kirch <okir@monad.swb.de>
  */
 
-#define __NO_VERSION__
 #include <linux/config.h>
 #include <linux/module.h>
 
--- linux-2.5.64-notfull/fs/proc/inode.c.old	2003-03-11 23:25:21.000000000 +0100
+++ linux-2.5.64-notfull/fs/proc/inode.c	2003-03-11 23:25:24.000000000 +0100
@@ -13,7 +13,6 @@
 #include <linux/file.h>
 #include <linux/limits.h>
 #include <linux/init.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
--- linux-2.5.64-notfull/fs/autofs/inode.c.old	2003-03-11 23:25:24.000000000 +0100
+++ linux-2.5.64-notfull/fs/autofs/inode.c	2003-03-11 23:25:27.000000000 +0100
@@ -16,7 +16,6 @@
 #include <linux/file.h>
 #include <asm/bitops.h>
 #include "autofs_i.h"
-#define __NO_VERSION__
 #include <linux/module.h>
 
 static void autofs_put_super(struct super_block *sb)
--- linux-2.5.64-notfull/fs/exec.c.old	2003-03-11 23:25:27.000000000 +0100
+++ linux-2.5.64-notfull/fs/exec.c	2003-03-11 23:25:30.000000000 +0100
@@ -38,7 +38,6 @@
 #include <linux/binfmts.h>
 #include <linux/swap.h>
 #include <linux/utsname.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/namei.h>
 #include <linux/proc_fs.h>
--- linux-2.5.64-notfull/fs/jffs/jffs_fm.c.old	2003-03-11 23:25:30.000000000 +0100
+++ linux-2.5.64-notfull/fs/jffs/jffs_fm.c	2003-03-11 23:25:33.000000000 +0100
@@ -16,7 +16,6 @@
  * Copyright (C) 2000  Alexander Larsson (alex@cendio.se), Cendio Systems AB
  *
  */
-#define __NO_VERSION__
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include <linux/jffs.h>
--- linux-2.5.64-notfull/fs/jffs/intrep.c.old	2003-03-11 23:25:33.000000000 +0100
+++ linux-2.5.64-notfull/fs/jffs/intrep.c	2003-03-11 23:25:37.000000000 +0100
@@ -55,7 +55,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/slab.h>
--- linux-2.5.64-notfull/sound/oss/emu10k1/audio.c.old	2003-03-11 23:25:37.000000000 +0100
+++ linux-2.5.64-notfull/sound/oss/emu10k1/audio.c	2003-03-11 23:25:40.000000000 +0100
@@ -30,7 +30,6 @@
  **********************************************************************
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
--- linux-2.5.64-notfull/sound/oss/emu10k1/passthrough.c.old	2003-03-11 23:25:40.000000000 +0100
+++ linux-2.5.64-notfull/sound/oss/emu10k1/passthrough.c	2003-03-11 23:25:43.000000000 +0100
@@ -29,7 +29,6 @@
  **********************************************************************
  */
                        
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
--- linux-2.5.64-notfull/sound/oss/emu10k1/mixer.c.old	2003-03-11 23:25:43.000000000 +0100
+++ linux-2.5.64-notfull/sound/oss/emu10k1/mixer.c	2003-03-11 23:25:46.000000000 +0100
@@ -30,7 +30,6 @@
  **********************************************************************
  */
 
-#define __NO_VERSION__		/* Kernel version only defined once */
 #include <linux/module.h>
 #include <linux/version.h>
 #include <asm/uaccess.h>
--- linux-2.5.64-notfull/sound/oss/emu10k1/midi.c.old	2003-03-11 23:25:46.000000000 +0100
+++ linux-2.5.64-notfull/sound/oss/emu10k1/midi.c	2003-03-11 23:25:49.000000000 +0100
@@ -29,7 +29,6 @@
  **********************************************************************
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/version.h>
--- linux-2.5.64-notfull/sound/oss/midi_syms.c.old	2003-03-11 23:25:49.000000000 +0100
+++ linux-2.5.64-notfull/sound/oss/midi_syms.c	2003-03-11 23:27:06.000000000 +0100
@@ -1,9 +1,7 @@
 /*
  * Exported symbols for midi driver.
- * __NO_VERSION__ because this is still part of sound.o.
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 
 char midi_syms_symbol;
--- linux-2.5.64-notfull/sound/oss/audio_syms.c.old	2003-03-11 23:27:12.000000000 +0100
+++ linux-2.5.64-notfull/sound/oss/audio_syms.c	2003-03-11 23:27:19.000000000 +0100
@@ -1,9 +1,7 @@
 /*
  * Exported symbols for audio driver.
- * __NO_VERSION__ because this is still part of sound.o.
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 
 char audio_syms_symbol;
--- linux-2.5.64-notfull/sound/oss/sequencer_syms.c.old	2003-03-11 23:27:22.000000000 +0100
+++ linux-2.5.64-notfull/sound/oss/sequencer_syms.c	2003-03-11 23:27:26.000000000 +0100
@@ -1,9 +1,7 @@
 /*
  * Exported symbols for sequencer driver.
- * __NO_VERSION__ because this is still part of sound.o.
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 
 char sequencer_syms_symbol;
--- linux-2.5.64-notfull/sound/oss/nm256_audio.c.old	2003-03-11 23:27:31.000000000 +0100
+++ linux-2.5.64-notfull/sound/oss/nm256_audio.c	2003-03-11 23:27:34.000000000 +0100
@@ -19,7 +19,6 @@
  *		Ported to 2.4 PCI API.
  */
 
-#define __NO_VERSION__
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
