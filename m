Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSKRWLq>; Mon, 18 Nov 2002 17:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264968AbSKRWLp>; Mon, 18 Nov 2002 17:11:45 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:22498 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264938AbSKRWLN>;
	Mon, 18 Nov 2002 17:11:13 -0500
Date: Mon, 18 Nov 2002 23:18:08 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] More missing includes [2/4]
Message-ID: <Pine.GSO.4.21.0211182316070.16079-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add missing #include <linux/interrupt.h>

arch/m68k/amiga/cia.c           |    1 +
arch/m68k/amiga/config.c        |    1 +
arch/m68k/apollo/config.c       |    1 +
arch/m68k/atari/stdma.c         |    1 +
arch/m68k/bvme6000/config.c     |    1 +
arch/m68k/mac/iop.c             |    1 +
arch/m68k/mvme147/config.c      |    1 +
arch/m68k/mvme16x/config.c      |    1 +
arch/m68k/q40/q40ints.c         |    1 +
drivers/block/amiflop.c         |    1 +
drivers/input/joystick/amijoy.c |    1 +
drivers/input/keyboard/amikbd.c |    1 +
drivers/input/mouse/amimouse.c  |    1 +
drivers/macintosh/via-cuda.c    |    1 +
drivers/macintosh/via-macii.c   |    1 +
drivers/macintosh/via-maciisi.c |    1 +
drivers/macintosh/via-pmu68k.c  |    1 +
drivers/parport/parport_amiga.c |    1 +
drivers/parport/parport_atari.c |    1 +
drivers/parport/parport_mfc3.c  |    1 +
drivers/scsi/blz1230.c          |    1 +
drivers/scsi/blz2060.c          |    1 +
drivers/scsi/cyberstorm.c       |    1 +
drivers/scsi/cyberstormII.c     |    1 +
drivers/scsi/fastlane.c         |    1 +
drivers/scsi/mac_esp.c          |    1 +
drivers/scsi/sun3x_esp.c        |    1 +
drivers/video/fbcon.c           |    1 +
28 files changed, 28 insertions(+)

--- linux-2.5.48/arch/m68k/amiga/cia.c	Tue Nov  5 10:09:40 2002
+++ linux-m68k-2.5.48/arch/m68k/amiga/cia.c	Mon Nov 18 15:02:53 2002
@@ -17,6 +17,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
+#include <linux/interrupt.h>
 
 #include <asm/irq.h>
 #include <asm/amigahw.h>
--- linux-2.5.48/arch/m68k/amiga/config.c	Sat Oct 12 23:50:35 2002
+++ linux-m68k-2.5.48/arch/m68k/amiga/config.c	Mon Nov 18 15:03:02 2002
@@ -21,6 +21,7 @@
 #include <linux/rtc.h>
 #include <linux/init.h>
 #include <linux/vt_kern.h>
+#include <linux/interrupt.h>
 #ifdef CONFIG_ZORRO
 #include <linux/zorro.h>
 #endif
--- linux-2.5.48/arch/m68k/apollo/config.c	Fri Aug 30 15:37:40 2002
+++ linux-m68k-2.5.48/arch/m68k/apollo/config.c	Mon Nov 18 17:37:20 2002
@@ -6,6 +6,7 @@
 #include <linux/console.h>
 #include <linux/rtc.h>
 #include <linux/vt_kern.h>
+#include <linux/interrupt.h>
 
 #include <asm/setup.h>
 #include <asm/bootinfo.h>
--- linux-2.5.48/arch/m68k/atari/stdma.c	Mon Nov 11 20:50:32 2002
+++ linux-m68k-2.5.48/arch/m68k/atari/stdma.c	Mon Nov 18 17:37:26 2002
@@ -33,6 +33,7 @@
 #include <linux/genhd.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 #include <asm/atari_stdma.h>
 #include <asm/atariints.h>
--- linux-2.5.48/arch/m68k/bvme6000/config.c	Mon Nov 11 20:50:32 2002
+++ linux-m68k-2.5.48/arch/m68k/bvme6000/config.c	Mon Nov 18 17:37:38 2002
@@ -24,6 +24,7 @@
 #include <linux/major.h>
 #include <linux/genhd.h>
 #include <linux/rtc.h>
+#include <linux/interrupt.h>
 
 #include <asm/bootinfo.h>
 #include <asm/system.h>
--- linux-2.5.48/arch/m68k/mac/iop.c	Fri Nov  8 18:14:24 2002
+++ linux-m68k-2.5.48/arch/m68k/mac/iop.c	Mon Nov 18 17:37:45 2002
@@ -111,6 +111,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/interrupt.h>
 
 #include <asm/bootinfo.h> 
 #include <asm/macintosh.h> 
--- linux-2.5.48/arch/m68k/mvme147/config.c	Fri Nov  8 18:14:24 2002
+++ linux-m68k-2.5.48/arch/m68k/mvme147/config.c	Mon Nov 18 17:37:51 2002
@@ -23,6 +23,7 @@
 #include <linux/major.h>
 #include <linux/genhd.h>
 #include <linux/rtc.h>
+#include <linux/interrupt.h>
 
 #include <asm/bootinfo.h>
 #include <asm/system.h>
--- linux-2.5.48/arch/m68k/mvme16x/config.c	Fri Aug 30 15:37:41 2002
+++ linux-m68k-2.5.48/arch/m68k/mvme16x/config.c	Mon Nov 18 17:37:56 2002
@@ -24,6 +24,7 @@
 #include <linux/major.h>
 #include <linux/genhd.h>
 #include <linux/rtc.h>
+#include <linux/interrupt.h>
 
 #include <asm/bootinfo.h>
 #include <asm/system.h>
--- linux-2.5.48/arch/m68k/q40/q40ints.c	Fri Nov  8 18:14:24 2002
+++ linux-m68k-2.5.48/arch/m68k/q40/q40ints.c	Mon Nov 18 17:38:02 2002
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/interrupt.h>
 
 #include <asm/rtc.h>
 #include <asm/ptrace.h>
--- linux-2.5.48/drivers/block/amiflop.c	Fri Nov  8 18:46:39 2002
+++ linux-m68k-2.5.48/drivers/block/amiflop.c	Mon Nov 18 15:04:31 2002
@@ -72,6 +72,7 @@
 #include <linux/amifd.h>
 #include <linux/ioport.h>
 #include <linux/buffer_head.h>
+#include <linux/interrupt.h>
 
 #include <asm/setup.h>
 #include <asm/uaccess.h>
--- linux-2.5.48/drivers/input/joystick/amijoy.c	Fri Aug  9 22:36:36 2002
+++ linux-m68k-2.5.48/drivers/input/joystick/amijoy.c	Mon Nov 18 15:04:41 2002
@@ -34,6 +34,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/interrupt.h>
 
 #include <asm/system.h>
 #include <asm/amigahw.h>
--- linux-2.5.48/drivers/input/keyboard/amikbd.c	Sat Oct 12 23:50:35 2002
+++ linux-m68k-2.5.48/drivers/input/keyboard/amikbd.c	Mon Nov 18 15:04:45 2002
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 
 #include <asm/amigaints.h>
 #include <asm/amigahw.h>
--- linux-2.5.48/drivers/input/mouse/amimouse.c	Fri Aug  9 22:36:36 2002
+++ linux-m68k-2.5.48/drivers/input/mouse/amimouse.c	Mon Nov 18 15:04:52 2002
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/interrupt.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
--- linux-2.5.48/drivers/macintosh/via-cuda.c	Sat Nov  9 22:01:20 2002
+++ linux-m68k-2.5.48/drivers/macintosh/via-cuda.c	Mon Nov 18 17:38:42 2002
@@ -18,6 +18,7 @@
 #include <linux/adb.h>
 #include <linux/cuda.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
 #ifdef CONFIG_PPC
 #include <asm/prom.h>
 #include <asm/machdep.h>
--- linux-2.5.48/drivers/macintosh/via-macii.c	Fri Nov  8 22:21:21 2002
+++ linux-m68k-2.5.48/drivers/macintosh/via-macii.c	Mon Nov 18 17:39:12 2002
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/adb.h>
+#include <linux/interrupt.h>
 #include <asm/macintosh.h>
 #include <asm/macints.h>
 #include <asm/machw.h>
--- linux-2.5.48/drivers/macintosh/via-maciisi.c	Fri Nov  8 22:41:00 2002
+++ linux-m68k-2.5.48/drivers/macintosh/via-maciisi.c	Mon Nov 18 17:39:14 2002
@@ -22,6 +22,7 @@
 #include <linux/adb.h>
 #include <linux/cuda.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <asm/macintosh.h>
 #include <asm/macints.h>
 #include <asm/machw.h>
--- linux-2.5.48/drivers/macintosh/via-pmu68k.c	Mon Nov 18 10:22:50 2002
+++ linux-m68k-2.5.48/drivers/macintosh/via-pmu68k.c	Mon Nov 18 17:39:21 2002
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 #include <linux/adb.h>
 #include <linux/pmu.h>
--- linux-2.5.48/drivers/parport/parport_amiga.c	Tue Oct  9 10:54:48 2001
+++ linux-m68k-2.5.48/drivers/parport/parport_amiga.c	Mon Nov 18 15:04:59 2002
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/parport.h>
 #include <linux/ioport.h>
+#include <linux/interrupt.h>
 #include <asm/setup.h>
 #include <asm/amigahw.h>
 #include <asm/irq.h>
--- linux-2.5.48/drivers/parport/parport_atari.c	Mon Nov 11 20:50:33 2002
+++ linux-m68k-2.5.48/drivers/parport/parport_atari.c	Mon Nov 18 17:39:30 2002
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/parport.h>
+#include <linux/interrupt.h>
 #include <asm/setup.h>
 #include <asm/atarihw.h>
 #include <asm/irq.h>
--- linux-2.5.48/drivers/parport/parport_mfc3.c	Sat May 25 20:05:17 2002
+++ linux-m68k-2.5.48/drivers/parport/parport_mfc3.c	Mon Nov 18 15:05:07 2002
@@ -59,6 +59,7 @@
 #include <linux/delay.h>
 #include <linux/mc6821.h>
 #include <linux/zorro.h>
+#include <linux/interrupt.h>
 #include <asm/setup.h>
 #include <asm/amigahw.h>
 #include <asm/irq.h>
--- linux-2.5.48/drivers/scsi/blz1230.c	Mon Nov 11 21:23:24 2002
+++ linux-m68k-2.5.48/drivers/scsi/blz1230.c	Mon Nov 18 17:39:38 2002
@@ -25,6 +25,7 @@
 #include <linux/blk.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
+#include <linux/interrupt.h>
 
 #include "scsi.h"
 #include "hosts.h"
--- linux-2.5.48/drivers/scsi/blz2060.c	Mon Nov 11 21:23:24 2002
+++ linux-m68k-2.5.48/drivers/scsi/blz2060.c	Mon Nov 18 17:39:45 2002
@@ -25,6 +25,7 @@
 #include <linux/blk.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
+#include <linux/interrupt.h>
 
 #include "scsi.h"
 #include "hosts.h"
--- linux-2.5.48/drivers/scsi/cyberstorm.c	Mon Nov 11 21:23:24 2002
+++ linux-m68k-2.5.48/drivers/scsi/cyberstorm.c	Mon Nov 18 17:39:50 2002
@@ -28,6 +28,7 @@
 #include <linux/blk.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
+#include <linux/interrupt.h>
 
 #include "scsi.h"
 #include "hosts.h"
--- linux-2.5.48/drivers/scsi/cyberstormII.c	Mon Nov 11 21:23:24 2002
+++ linux-m68k-2.5.48/drivers/scsi/cyberstormII.c	Mon Nov 18 17:39:58 2002
@@ -24,6 +24,7 @@
 #include <linux/blk.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
+#include <linux/interrupt.h>
 
 #include "scsi.h"
 #include "hosts.h"
--- linux-2.5.48/drivers/scsi/fastlane.c	Mon Nov 11 21:23:24 2002
+++ linux-m68k-2.5.48/drivers/scsi/fastlane.c	Mon Nov 18 17:40:25 2002
@@ -33,6 +33,7 @@
 #include <linux/blk.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
+#include <linux/interrupt.h>
 
 #include "scsi.h"
 #include "hosts.h"
--- linux-2.5.48/drivers/scsi/mac_esp.c	Mon Nov 11 21:23:24 2002
+++ linux-m68k-2.5.48/drivers/scsi/mac_esp.c	Mon Nov 18 17:40:28 2002
@@ -23,6 +23,7 @@
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 #include "scsi.h"
 #include "hosts.h"
--- linux-2.5.48/drivers/scsi/sun3x_esp.c	Mon Nov 11 21:23:24 2002
+++ linux-m68k-2.5.48/drivers/scsi/sun3x_esp.c	Mon Nov 18 17:40:33 2002
@@ -13,6 +13,7 @@
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 
 #include "scsi.h"
 #include "hosts.h"
--- linux-2.5.48/drivers/video/fbcon.c	Mon Nov 11 10:27:58 2002
+++ linux-m68k-2.5.48/drivers/video/fbcon.c	Mon Nov 18 15:05:23 2002
@@ -75,6 +75,7 @@
 #include <linux/selection.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 #include <asm/irq.h>
 #include <asm/system.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

