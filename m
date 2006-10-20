Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946160AbWJTEeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946160AbWJTEeO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 00:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWJTEeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 00:34:14 -0400
Received: from xenotime.net ([66.160.160.81]:35815 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161021AbWJTEeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 00:34:09 -0400
Date: Thu, 19 Oct 2006 21:35:45 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-Id: <20061019213545.bf5a51c1.rdunlap@xenotime.net>
In-Reply-To: <20061020005337.GV29920@ftp.linux.org.uk>
References: <20061017005025.GF29920@ftp.linux.org.uk>
	<Pine.LNX.4.64.0610161847210.3962@g5.osdl.org>
	<20061017043726.GG29920@ftp.linux.org.uk>
	<Pine.LNX.4.64.0610170821580.3962@g5.osdl.org>
	<20061018044054.GH29920@ftp.linux.org.uk>
	<20061018091944.GA5343@martell.zuzino.mipt.ru>
	<20061018093126.GM29920@ftp.linux.org.uk>
	<Pine.LNX.4.64.0610180759070.3962@g5.osdl.org>
	<20061018160609.GO29920@ftp.linux.org.uk>
	<Pine.LNX.4.64.0610180926380.3962@g5.osdl.org>
	<20061020005337.GV29920@ftp.linux.org.uk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 01:53:37 +0100 Al Viro wrote:

> Done.  Several more in followups.

Here's about half of checking includers of linux/smp_lock.h to see
if they actually use any of its interfaces.  (most don't)

Yet to do:  fs/* and arch/*
Built only on x86_64.

---

From: Randy Dunlap <randy.dunlap@oracle.com>

Remove includes of <linux/smp_lock.h> where it is not used/needed.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/acpi/osl.c                            |    1 -
 drivers/block/acsi_slm.c                      |    1 -
 drivers/block/umem.c                          |    1 -
 drivers/char/ds1620.c                         |    1 -
 drivers/char/dsp56k.c                         |    1 -
 drivers/char/dtlk.c                           |    1 -
 drivers/char/ec3104_keyb.c                    |    1 -
 drivers/char/ftape/zftape/zftape-init.c       |    1 -
 drivers/char/hangcheck-timer.c                |    1 -
 drivers/char/ip27-rtc.c                       |    1 -
 drivers/char/lp.c                             |    1 -
 drivers/char/mem.c                            |    1 -
 drivers/char/mxser.c                          |    1 -
 drivers/char/ppdev.c                          |    1 -
 drivers/char/sysrq.c                          |    1 -
 drivers/char/vc_screen.c                      |    1 -
 drivers/char/watchdog/omap_wdt.c              |    1 -
 drivers/char/watchdog/pcwd_usb.c              |    1 -
 drivers/i2c/busses/scx200_acb.c               |    1 -
 drivers/i2c/i2c-dev.c                         |    1 -
 drivers/ieee1394/raw1394.c                    |    1 -
 drivers/infiniband/ulp/iser/iser_verbs.c      |    1 -
 drivers/input/evdev.c                         |    1 -
 drivers/input/input.c                         |    1 -
 drivers/input/joydev.c                        |    1 -
 drivers/input/misc/uinput.c                   |    1 -
 drivers/input/mousedev.c                      |    1 -
 drivers/input/tsdev.c                         |    1 -
 drivers/isdn/capi/capi.c                      |    1 -
 drivers/isdn/divert/divert_procfs.c           |    1 -
 drivers/isdn/hardware/eicon/capimain.c        |    1 -
 drivers/isdn/hardware/eicon/divamnt.c         |    1 -
 drivers/isdn/hardware/eicon/divasi.c          |    1 -
 drivers/isdn/hardware/eicon/divasmain.c       |    1 -
 drivers/isdn/hardware/eicon/platform.h        |    1 -
 drivers/isdn/hisax/hfc_usb.c                  |    1 -
 drivers/macintosh/therm_adt746x.c             |    1 -
 drivers/macintosh/therm_pm72.c                |    1 -
 drivers/macintosh/windfarm_core.c             |    1 -
 drivers/media/dvb/bt8xx/dst_common.h          |    1 -
 drivers/media/dvb/ttpci/av7110_av.c           |    1 -
 drivers/media/dvb/ttpci/av7110_ca.c           |    1 -
 drivers/media/dvb/ttpci/av7110_hw.c           |    1 -
 drivers/media/dvb/ttpci/av7110_v4l.c          |    1 -
 drivers/media/radio/dsbr100.c                 |    1 -
 drivers/media/video/cpia.h                    |    1 -
 drivers/media/video/cpia_pp.c                 |    1 -
 drivers/media/video/cx88/cx88-tvaudio.c       |    1 -
 drivers/media/video/dabusb.c                  |    1 -
 drivers/media/video/ov511.h                   |    1 -
 drivers/media/video/pvrusb2/pvrusb2-main.c    |    1 -
 drivers/media/video/saa7134/saa7134-tvaudio.c |    1 -
 drivers/media/video/se401.h                   |    1 -
 drivers/media/video/tvaudio.c                 |    1 -
 drivers/media/video/usbvideo/usbvideo.c       |    1 -
 drivers/media/video/v4l1-compat.c             |    1 -
 drivers/media/video/v4l2-common.c             |    1 -
 drivers/media/video/videodev.c                |    1 -
 drivers/mfd/ucb1x00-ts.c                      |    1 -
 drivers/net/irda/sir_dev.c                    |    1 -
 drivers/net/irda/sir_dongle.c                 |    1 -
 drivers/net/irda/vlsi_ir.c                    |    1 -
 drivers/net/ns83820.c                         |    1 -
 drivers/net/ppp_generic.c                     |    1 -
 drivers/net/wan/cosa.c                        |    1 -
 drivers/net/wireless/airo.c                   |    1 -
 drivers/net/wireless/hostap/hostap_ioctl.c    |    1 -
 drivers/parisc/lba_pci.c                      |    1 -
 drivers/pci/hotplug/acpiphp_core.c            |    1 -
 drivers/pci/hotplug/acpiphp_glue.c            |    1 -
 drivers/pci/hotplug/ibmphp_core.c             |    1 -
 drivers/pci/hotplug/ibmphp_hpc.c              |    1 -
 drivers/pci/hotplug/pci_hotplug_core.c        |    1 -
 drivers/pci/hotplug/rpaphp_core.c             |    1 -
 drivers/pci/hotplug/shpchp_ctrl.c             |    1 -
 drivers/pci/msi.c                             |    1 -
 drivers/pci/proc.c                            |    1 -
 drivers/sbus/char/bpp.c                       |    1 -
 drivers/sbus/char/rtc.c                       |    1 -
 drivers/sbus/char/vfc_dev.c                   |    1 -
 drivers/scsi/aic7xxx/aic79xx_osm.h            |    1 -
 drivers/scsi/aic7xxx/aic7xxx_osm.h            |    1 -
 drivers/scsi/dpt_i2o.c                        |    1 -
 drivers/scsi/scsi_debug.c                     |    1 -
 drivers/scsi/sg.c                             |    1 -
 drivers/serial/icom.c                         |    1 -
 drivers/usb/atm/usbatm.c                      |    1 -
 drivers/usb/class/cdc-acm.c                   |    1 -
 drivers/usb/class/usblp.c                     |    1 -
 drivers/usb/core/hub.c                        |    1 -
 drivers/usb/core/inode.c                      |    1 -
 drivers/usb/core/usb.c                        |    1 -
 drivers/usb/gadget/at91_udc.c                 |    1 -
 drivers/usb/gadget/dummy_hcd.c                |    1 -
 drivers/usb/gadget/ether.c                    |    1 -
 drivers/usb/gadget/goku_udc.c                 |    1 -
 drivers/usb/gadget/net2280.c                  |    1 -
 drivers/usb/gadget/serial.c                   |    1 -
 drivers/usb/gadget/zero.c                     |    1 -
 drivers/usb/host/ehci-hcd.c                   |    1 -
 drivers/usb/host/ohci-hcd.c                   |    1 -
 drivers/usb/host/sl811-hcd.c                  |    1 -
 drivers/usb/host/u132-hcd.c                   |    1 -
 drivers/usb/image/mdc800.c                    |    1 -
 drivers/usb/image/microtek.c                  |    1 -
 drivers/usb/input/hid-core.c                  |    1 -
 drivers/usb/input/hiddev.c                    |    1 -
 drivers/usb/input/xpad.c                      |    1 -
 drivers/usb/misc/idmouse.c                    |    1 -
 drivers/usb/misc/legousbtower.c               |    1 -
 drivers/usb/misc/rio500.c                     |    1 -
 drivers/usb/misc/sisusbvga/sisusb_con.c       |    1 -
 drivers/usb/mon/mon_main.c                    |    1 -
 drivers/usb/serial/usb-serial.c               |    1 -
 drivers/usb/storage/usb.h                     |    1 -
 drivers/video/sis/sis.h                       |    1 -
 drivers/video/sis/sis_main.c                  |    1 -
 ipc/sem.c                                     |    1 -
 ipc/util.c                                    |    1 -
 kernel/cpuset.c                               |    1 -
 kernel/exit.c                                 |    1 -
 kernel/fork.c                                 |    1 -
 kernel/itimer.c                               |    1 -
 kernel/kmod.c                                 |    1 -
 kernel/posix-timers.c                         |    1 -
 kernel/power/process.c                        |    1 -
 kernel/power/snapshot.c                       |    1 -
 kernel/power/swap.c                           |    1 -
 kernel/printk.c                               |    1 -
 kernel/signal.c                               |    1 -
 kernel/time.c                                 |    1 -
 kernel/uid16.c                                |    1 -
 net/appletalk/ddp.c                           |    1 -
 net/ax25/af_ax25.c                            |    1 -
 net/bluetooth/bnep/core.c                     |    1 -
 net/bridge/br_stp.c                           |    1 -
 net/bridge/br_stp_if.c                        |    1 -
 net/bridge/br_stp_timer.c                     |    1 -
 net/core/netpoll.c                            |    1 -
 net/core/pktgen.c                             |    1 -
 net/ipv4/af_inet.c                            |    1 -
 net/ipv4/tcp.c                                |    1 -
 net/ipv4/tcp_output.c                         |    1 -
 net/ipv6/af_inet6.c                           |    1 -
 net/ipx/af_ipx.c                              |    1 -
 net/irda/af_irda.c                            |    1 -
 net/netlink/af_netlink.c                      |    1 -
 net/unix/af_unix.c                            |    1 -
 net/x25/af_x25.c                              |    1 -
 security/capability.c                         |    1 -
 security/commoncap.c                          |    1 -
 security/selinux/hooks.c                      |    1 -
 sound/core/control.c                          |    1 -
 sound/core/hwdep.c                            |    1 -
 sound/core/oss/mixer_oss.c                    |    1 -
 sound/core/oss/pcm_oss.c                      |    1 -
 sound/core/pcm_native.c                       |    1 -
 sound/core/rawmidi.c                          |    1 -
 sound/core/seq/oss/seq_oss.c                  |    1 -
 sound/core/seq/seq_clientmgr.c                |    1 -
 sound/core/timer.c                            |    1 -
 sound/oss/emu10k1/audio.c                     |    1 -
 sound/oss/emu10k1/passthrough.c               |    1 -
 sound/oss/swarm_cs4297a.c                     |    1 -
 sound/oss/trident.c                           |    1 -
 sound/oss/via82cxxx_audio.c                   |    1 -
 166 files changed, 166 deletions(-)

--- linux-2619-rc2g2.orig/ipc/sem.c
+++ linux-2619-rc2g2/ipc/sem.c
@@ -75,7 +75,6 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/time.h>
-#include <linux/smp_lock.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/audit.h>
--- linux-2619-rc2g2.orig/ipc/util.c
+++ linux-2619-rc2g2/ipc/util.c
@@ -21,7 +21,6 @@
 #include <linux/shm.h>
 #include <linux/init.h>
 #include <linux/msg.h>
-#include <linux/smp_lock.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/capability.h>
--- linux-2619-rc2g2.orig/kernel/cpuset.c
+++ linux-2619-rc2g2/kernel/cpuset.c
@@ -42,7 +42,6 @@
 #include <linux/seq_file.h>
 #include <linux/security.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/stat.h>
 #include <linux/string.h>
--- linux-2619-rc2g2.orig/kernel/exit.c
+++ linux-2619-rc2g2/kernel/exit.c
@@ -7,7 +7,6 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/capability.h>
 #include <linux/completion.h>
--- linux-2619-rc2g2.orig/kernel/fork.c
+++ linux-2619-rc2g2/kernel/fork.c
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/unistd.h>
-#include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/completion.h>
--- linux-2619-rc2g2.orig/kernel/itimer.c
+++ linux-2619-rc2g2/kernel/itimer.c
@@ -7,7 +7,6 @@
 /* These are all the functions necessary to implement itimers */
 
 #include <linux/mm.h>
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/syscalls.h>
 #include <linux/time.h>
--- linux-2619-rc2g2.orig/kernel/kmod.c
+++ linux-2619-rc2g2/kernel/kmod.c
@@ -23,7 +23,6 @@
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 #include <linux/kmod.h>
-#include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/namespace.h>
 #include <linux/completion.h>
--- linux-2619-rc2g2.orig/kernel/posix-timers.c
+++ linux-2619-rc2g2/kernel/posix-timers.c
@@ -31,7 +31,6 @@
  * POSIX clocks & timers
  */
 #include <linux/mm.h>
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/time.h>
--- linux-2619-rc2g2.orig/kernel/power/process.c
+++ linux-2619-rc2g2/kernel/power/process.c
@@ -8,7 +8,6 @@
 
 #undef DEBUG
 
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
--- linux-2619-rc2g2.orig/kernel/power/snapshot.c
+++ linux-2619-rc2g2/kernel/power/snapshot.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/suspend.h>
-#include <linux/smp_lock.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <linux/spinlock.h>
--- linux-2619-rc2g2.orig/kernel/power/swap.c
+++ linux-2619-rc2g2/kernel/power/swap.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/smp_lock.h>
 #include <linux/file.h>
 #include <linux/utsname.h>
 #include <linux/version.h>
--- linux-2619-rc2g2.orig/kernel/printk.c
+++ linux-2619-rc2g2/kernel/printk.c
@@ -20,7 +20,6 @@
 #include <linux/mm.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
-#include <linux/smp_lock.h>
 #include <linux/console.h>
 #include <linux/init.h>
 #include <linux/module.h>
--- linux-2619-rc2g2.orig/kernel/signal.c
+++ linux-2619-rc2g2/kernel/signal.c
@@ -12,7 +12,6 @@
 
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
--- linux-2619-rc2g2.orig/kernel/time.c
+++ linux-2619-rc2g2/kernel/time.c
@@ -31,7 +31,6 @@
 #include <linux/timex.h>
 #include <linux/capability.h>
 #include <linux/errno.h>
-#include <linux/smp_lock.h>
 #include <linux/syscalls.h>
 #include <linux/security.h>
 #include <linux/fs.h>
--- linux-2619-rc2g2.orig/kernel/uid16.c
+++ linux-2619-rc2g2/kernel/uid16.c
@@ -6,7 +6,6 @@
 #include <linux/mm.h>
 #include <linux/utsname.h>
 #include <linux/mman.h>
-#include <linux/smp_lock.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/prctl.h>
--- linux-2619-rc2g2.orig/security/capability.c
+++ linux-2619-rc2g2/security/capability.c
@@ -17,7 +17,6 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/smp_lock.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/ptrace.h>
--- linux-2619-rc2g2.orig/security/commoncap.c
+++ linux-2619-rc2g2/security/commoncap.c
@@ -17,7 +17,6 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/smp_lock.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/ptrace.h>
--- linux-2619-rc2g2.orig/security/selinux/hooks.c
+++ linux-2619-rc2g2/security/selinux/hooks.c
@@ -35,7 +35,6 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/syscalls.h>
 #include <linux/file.h>
--- linux-2619-rc2g2.orig/net/appletalk/ddp.c
+++ linux-2619-rc2g2/net/appletalk/ddp.c
@@ -1839,7 +1839,6 @@ static const struct proto_ops SOCKOPS_WR
 	.sendpage	= sock_no_sendpage,
 };
 
-#include <linux/smp_lock.h>
 SOCKOPS_WRAP(atalk_dgram, PF_APPLETALK);
 
 static struct notifier_block ddp_notifier = {
--- linux-2619-rc2g2.orig/net/ax25/af_ax25.c
+++ linux-2619-rc2g2/net/ax25/af_ax25.c
@@ -23,7 +23,6 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/string.h>
-#include <linux/smp_lock.h>
 #include <linux/sockios.h>
 #include <linux/net.h>
 #include <net/ax25.h>
--- linux-2619-rc2g2.orig/net/bluetooth/bnep/core.c
+++ linux-2619-rc2g2/net/bluetooth/bnep/core.c
@@ -37,7 +37,6 @@
 #include <linux/init.h>
 #include <linux/wait.h>
 #include <linux/errno.h>
-#include <linux/smp_lock.h>
 #include <linux/net.h>
 #include <net/sock.h>
 
--- linux-2619-rc2g2.orig/net/bridge/br_stp.c
+++ linux-2619-rc2g2/net/bridge/br_stp.c
@@ -13,7 +13,6 @@
  *	2 of the License, or (at your option) any later version.
  */
 #include <linux/kernel.h>
-#include <linux/smp_lock.h>
 
 #include "br_private.h"
 #include "br_private_stp.h"
--- linux-2619-rc2g2.orig/net/bridge/br_stp_if.c
+++ linux-2619-rc2g2/net/bridge/br_stp_if.c
@@ -14,7 +14,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/smp_lock.h>
 #include <linux/etherdevice.h>
 #include <linux/rtnetlink.h>
 
--- linux-2619-rc2g2.orig/net/bridge/br_stp_timer.c
+++ linux-2619-rc2g2/net/bridge/br_stp_timer.c
@@ -15,7 +15,6 @@
 
 #include <linux/kernel.h>
 #include <linux/times.h>
-#include <linux/smp_lock.h>
 
 #include "br_private.h"
 #include "br_private_stp.h"
--- linux-2619-rc2g2.orig/net/core/netpoll.c
+++ linux-2619-rc2g2/net/core/netpoll.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2002  Red Hat, Inc.
  */
 
-#include <linux/smp_lock.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/string.h>
--- linux-2619-rc2g2.orig/net/core/pktgen.c
+++ linux-2619-rc2g2/net/core/pktgen.c
@@ -117,7 +117,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
-#include <linux/smp_lock.h>
 #include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
--- linux-2619-rc2g2.orig/net/ipv4/af_inet.c
+++ linux-2619-rc2g2/net/ipv4/af_inet.c
@@ -91,7 +91,6 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-#include <linux/smp_lock.h>
 #include <linux/inet.h>
 #include <linux/igmp.h>
 #include <linux/inetdevice.h>
--- linux-2619-rc2g2.orig/net/ipv4/tcp.c
+++ linux-2619-rc2g2/net/ipv4/tcp.c
@@ -252,7 +252,6 @@
 #include <linux/fcntl.h>
 #include <linux/poll.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/fs.h>
 #include <linux/random.h>
 #include <linux/bootmem.h>
--- linux-2619-rc2g2.orig/net/ipv4/tcp_output.c
+++ linux-2619-rc2g2/net/ipv4/tcp_output.c
@@ -40,7 +40,6 @@
 
 #include <linux/compiler.h>
 #include <linux/module.h>
-#include <linux/smp_lock.h>
 
 /* People can turn this off for buggy TCP's found in printers etc. */
 int sysctl_tcp_retrans_collapse __read_mostly = 1;
--- linux-2619-rc2g2.orig/net/ipv6/af_inet6.c
+++ linux-2619-rc2g2/net/ipv6/af_inet6.c
@@ -43,7 +43,6 @@
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/icmpv6.h>
-#include <linux/smp_lock.h>
 #include <linux/netfilter_ipv6.h>
 
 #include <net/ip.h>
--- linux-2619-rc2g2.orig/net/ipx/af_ipx.c
+++ linux-2619-rc2g2/net/ipx/af_ipx.c
@@ -1952,7 +1952,6 @@ static const struct proto_ops SOCKOPS_WR
 	.sendpage	= sock_no_sendpage,
 };
 
-#include <linux/smp_lock.h>
 SOCKOPS_WRAP(ipx_dgram, PF_IPX);
 
 static struct packet_type ipx_8023_packet_type = {
--- linux-2619-rc2g2.orig/net/irda/af_irda.c
+++ linux-2619-rc2g2/net/irda/af_irda.c
@@ -2581,7 +2581,6 @@ static const struct proto_ops SOCKOPS_WR
 };
 #endif /* CONFIG_IRDA_ULTRA */
 
-#include <linux/smp_lock.h>
 SOCKOPS_WRAP(irda_stream, PF_IRDA);
 SOCKOPS_WRAP(irda_seqpacket, PF_IRDA);
 SOCKOPS_WRAP(irda_dgram, PF_IRDA);
--- linux-2619-rc2g2.orig/net/netlink/af_netlink.c
+++ linux-2619-rc2g2/net/netlink/af_netlink.c
@@ -45,7 +45,6 @@
 #include <linux/rtnetlink.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/smp_lock.h>
 #include <linux/notifier.h>
 #include <linux/security.h>
 #include <linux/jhash.h>
--- linux-2619-rc2g2.orig/net/unix/af_unix.c
+++ linux-2619-rc2g2/net/unix/af_unix.c
@@ -111,7 +111,6 @@
 #include <net/scm.h>
 #include <linux/init.h>
 #include <linux/poll.h>
-#include <linux/smp_lock.h>
 #include <linux/rtnetlink.h>
 #include <linux/mount.h>
 #include <net/checksum.h>
--- linux-2619-rc2g2.orig/net/x25/af_x25.c
+++ linux-2619-rc2g2/net/x25/af_x25.c
@@ -1576,7 +1576,6 @@ static const struct proto_ops SOCKOPS_WR
 	.sendpage =	sock_no_sendpage,
 };
 
-#include <linux/smp_lock.h>
 SOCKOPS_WRAP(x25_proto, AF_X25);
 
 static struct packet_type x25_packet_type = {
--- linux-2619-rc2g2.orig/sound/core/control.c
+++ linux-2619-rc2g2/sound/core/control.c
@@ -22,7 +22,6 @@
 #include <sound/driver.h>
 #include <linux/threads.h>
 #include <linux/interrupt.h>
-#include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/time.h>
--- linux-2619-rc2g2.orig/sound/core/hwdep.c
+++ linux-2619-rc2g2/sound/core/hwdep.c
@@ -22,7 +22,6 @@
 #include <sound/driver.h>
 #include <linux/major.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/mutex.h>
--- linux-2619-rc2g2.orig/sound/core/oss/mixer_oss.c
+++ linux-2619-rc2g2/sound/core/oss/mixer_oss.c
@@ -21,7 +21,6 @@
 
 #include <sound/driver.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/string.h>
--- linux-2619-rc2g2.orig/sound/core/oss/pcm_oss.c
+++ linux-2619-rc2g2/sound/core/oss/pcm_oss.c
@@ -28,7 +28,6 @@
 
 #include <sound/driver.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/vmalloc.h>
--- linux-2619-rc2g2.orig/sound/core/pcm_native.c
+++ linux-2619-rc2g2/sound/core/pcm_native.c
@@ -21,7 +21,6 @@
 
 #include <sound/driver.h>
 #include <linux/mm.h>
-#include <linux/smp_lock.h>
 #include <linux/file.h>
 #include <linux/slab.h>
 #include <linux/time.h>
--- linux-2619-rc2g2.orig/sound/core/rawmidi.c
+++ linux-2619-rc2g2/sound/core/rawmidi.c
@@ -23,7 +23,6 @@
 #include <sound/core.h>
 #include <linux/major.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/time.h>
--- linux-2619-rc2g2.orig/sound/core/seq/oss/seq_oss.c
+++ linux-2619-rc2g2/sound/core/seq/oss/seq_oss.c
@@ -22,7 +22,6 @@
 
 #include <sound/driver.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <sound/core.h>
--- linux-2619-rc2g2.orig/sound/core/seq/seq_clientmgr.c
+++ linux-2619-rc2g2/sound/core/seq/seq_clientmgr.c
@@ -23,7 +23,6 @@
 
 #include <sound/driver.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/minors.h>
--- linux-2619-rc2g2.orig/sound/core/timer.c
+++ linux-2619-rc2g2/sound/core/timer.c
@@ -22,7 +22,6 @@
 #include <sound/driver.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/mutex.h>
--- linux-2619-rc2g2.orig/sound/oss/emu10k1/audio.c
+++ linux-2619-rc2g2/sound/oss/emu10k1/audio.c
@@ -36,7 +36,6 @@
 #include <linux/bitops.h>
 #include <asm/io.h>
 #include <linux/sched.h>
-#include <linux/smp_lock.h>
 
 #include "hwaccess.h"
 #include "cardwo.h"
--- linux-2619-rc2g2.orig/sound/oss/emu10k1/passthrough.c
+++ linux-2619-rc2g2/sound/oss/emu10k1/passthrough.c
@@ -35,7 +35,6 @@
 #include <linux/bitops.h>
 #include <asm/io.h>
 #include <linux/sched.h>
-#include <linux/smp_lock.h>
 
 #include "hwaccess.h"
 #include "cardwo.h"
--- linux-2619-rc2g2.orig/sound/oss/swarm_cs4297a.c
+++ linux-2619-rc2g2/sound/oss/swarm_cs4297a.c
@@ -75,7 +75,6 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/poll.h>
-#include <linux/smp_lock.h>
 #include <linux/mutex.h>
 
 #include <asm/byteorder.h>
--- linux-2619-rc2g2.orig/sound/oss/trident.c
+++ linux-2619-rc2g2/sound/oss/trident.c
@@ -207,7 +207,6 @@
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/spinlock.h>
-#include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
 #include <linux/bitops.h>
 #include <linux/proc_fs.h>
--- linux-2619-rc2g2.orig/sound/oss/via82cxxx_audio.c
+++ linux-2619-rc2g2/sound/oss/via82cxxx_audio.c
@@ -32,7 +32,6 @@
 #include <linux/poll.h>
 #include <linux/soundcard.h>
 #include <linux/ac97_codec.h>
-#include <linux/smp_lock.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
--- linux-2619-rc2g2.orig/drivers/acpi/osl.c
+++ linux-2619-rc2g2/drivers/acpi/osl.c
@@ -30,7 +30,6 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/kmod.h>
 #include <linux/delay.h>
--- linux-2619-rc2g2.orig/drivers/block/acsi_slm.c
+++ linux-2619-rc2g2/drivers/block/acsi_slm.c
@@ -65,7 +65,6 @@ not be guaranteed. There are several way
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 
 #include <asm/pgtable.h>
 #include <asm/system.h>
--- linux-2619-rc2g2.orig/drivers/block/umem.c
+++ linux-2619-rc2g2/drivers/block/umem.c
@@ -45,7 +45,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/smp_lock.h>
 #include <linux/timer.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
--- linux-2619-rc2g2.orig/drivers/char/ds1620.c
+++ linux-2619-rc2g2/drivers/char/ds1620.c
@@ -5,7 +5,6 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/miscdevice.h>
-#include <linux/smp_lock.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/capability.h>
--- linux-2619-rc2g2.orig/drivers/char/dsp56k.c
+++ linux-2619-rc2g2/drivers/char/dsp56k.c
@@ -33,7 +33,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/device.h>
 
 #include <asm/atarihw.h>
--- linux-2619-rc2g2.orig/drivers/char/dtlk.c
+++ linux-2619-rc2g2/drivers/char/dtlk.c
@@ -62,7 +62,6 @@
 #include <linux/init.h>		/* for __init, module_{init,exit} */
 #include <linux/poll.h>		/* for POLLIN, etc. */
 #include <linux/dtlk.h>		/* local header file for DoubleTalk values */
-#include <linux/smp_lock.h>
 
 #ifdef TRACING
 #define TRACE_TEXT(str) printk(str);
--- linux-2619-rc2g2.orig/drivers/char/ec3104_keyb.c
+++ linux-2619-rc2g2/drivers/char/ec3104_keyb.c
@@ -41,7 +41,6 @@
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
 #include <linux/kbd_kern.h>
-#include <linux/smp_lock.h>
 #include <linux/bitops.h>
 
 #include <asm/keyboard.h>
--- linux-2619-rc2g2.orig/drivers/char/ftape/zftape/zftape-init.c
+++ linux-2619-rc2g2/drivers/char/ftape/zftape/zftape-init.c
@@ -31,7 +31,6 @@
 #include <linux/kmod.h>
 #endif
 #include <linux/fcntl.h>
-#include <linux/smp_lock.h>
 
 #include <linux/zftape.h>
 #include <linux/init.h>
--- linux-2619-rc2g2.orig/drivers/char/hangcheck-timer.c
+++ linux-2619-rc2g2/drivers/char/hangcheck-timer.c
@@ -44,7 +44,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/reboot.h>
-#include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <asm/uaccess.h>
--- linux-2619-rc2g2.orig/drivers/char/ip27-rtc.c
+++ linux-2619-rc2g2/drivers/char/ip27-rtc.c
@@ -35,7 +35,6 @@
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
-#include <linux/smp_lock.h>
 
 #include <asm/m48t35.h>
 #include <asm/sn/ioc3.h>
--- linux-2619-rc2g2.orig/drivers/char/lp.c
+++ linux-2619-rc2g2/drivers/char/lp.c
@@ -118,7 +118,6 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/sched.h>
-#include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/fcntl.h>
 #include <linux/delay.h>
--- linux-2619-rc2g2.orig/drivers/char/mem.c
+++ linux-2619-rc2g2/drivers/char/mem.c
@@ -18,7 +18,6 @@
 #include <linux/raw.h>
 #include <linux/tty.h>
 #include <linux/capability.h>
-#include <linux/smp_lock.h>
 #include <linux/ptrace.h>
 #include <linux/device.h>
 #include <linux/highmem.h>
--- linux-2619-rc2g2.orig/drivers/char/mxser.c
+++ linux-2619-rc2g2/drivers/char/mxser.c
@@ -54,7 +54,6 @@
 #include <linux/gfp.h>
 #include <linux/ioport.h>
 #include <linux/mm.h>
-#include <linux/smp_lock.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
 
--- linux-2619-rc2g2.orig/drivers/char/ppdev.c
+++ linux-2619-rc2g2/drivers/char/ppdev.c
@@ -66,7 +66,6 @@
 #include <linux/poll.h>
 #include <linux/major.h>
 #include <linux/ppdev.h>
-#include <linux/smp_lock.h>
 #include <linux/device.h>
 #include <asm/uaccess.h>
 
--- linux-2619-rc2g2.orig/drivers/char/sysrq.c
+++ linux-2619-rc2g2/drivers/char/sysrq.c
@@ -24,7 +24,6 @@
 #include <linux/sysrq.h>
 #include <linux/kbd_kern.h>
 #include <linux/quotaops.h>
-#include <linux/smp_lock.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
--- linux-2619-rc2g2.orig/drivers/char/vc_screen.c
+++ linux-2619-rc2g2/drivers/char/vc_screen.c
@@ -33,7 +33,6 @@
 #include <linux/selection.h>
 #include <linux/kbd_kern.h>
 #include <linux/console.h>
-#include <linux/smp_lock.h>
 #include <linux/device.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
--- linux-2619-rc2g2.orig/drivers/char/watchdog/pcwd_usb.c
+++ linux-2619-rc2g2/drivers/char/watchdog/pcwd_usb.c
@@ -37,7 +37,6 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/fs.h>
-#include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <asm/uaccess.h>
 #include <linux/usb.h>
--- linux-2619-rc2g2.orig/drivers/char/watchdog/omap_wdt.c
+++ linux-2619-rc2g2/drivers/char/watchdog/omap_wdt.c
@@ -34,7 +34,6 @@
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/reboot.h>
-#include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
--- linux-2619-rc2g2.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2619-rc2g2/drivers/i2c/busses/scx200_acb.c
@@ -28,7 +28,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/smp_lock.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
--- linux-2619-rc2g2.orig/drivers/i2c/i2c-dev.c
+++ linux-2619-rc2g2/drivers/i2c/i2c-dev.c
@@ -30,7 +30,6 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/i2c.h>
--- linux-2619-rc2g2.orig/drivers/ieee1394/raw1394.c
+++ linux-2619-rc2g2/drivers/ieee1394/raw1394.c
@@ -35,7 +35,6 @@
 #include <linux/poll.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/vmalloc.h>
 #include <linux/cdev.h>
--- linux-2619-rc2g2.orig/drivers/infiniband/ulp/iser/iser_verbs.c
+++ linux-2619-rc2g2/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -35,7 +35,6 @@
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/smp_lock.h>
 #include <linux/delay.h>
 #include <linux/version.h>
 
--- linux-2619-rc2g2.orig/drivers/input/evdev.c
+++ linux-2619-rc2g2/drivers/input/evdev.c
@@ -18,7 +18,6 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/major.h>
-#include <linux/smp_lock.h>
 #include <linux/device.h>
 #include <linux/compat.h>
 
--- linux-2619-rc2g2.orig/drivers/input/input.c
+++ linux-2619-rc2g2/drivers/input/input.c
@@ -12,7 +12,6 @@
 
 #include <linux/init.h>
 #include <linux/sched.h>
-#include <linux/smp_lock.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/random.h>
--- linux-2619-rc2g2.orig/drivers/input/joydev.c
+++ linux-2619-rc2g2/drivers/input/joydev.c
@@ -24,7 +24,6 @@
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/device.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
--- linux-2619-rc2g2.orig/drivers/input/misc/uinput.c
+++ linux-2619-rc2g2/drivers/input/misc/uinput.c
@@ -34,7 +34,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
-#include <linux/smp_lock.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/uinput.h>
--- linux-2619-rc2g2.orig/drivers/input/mousedev.c
+++ linux-2619-rc2g2/drivers/input/mousedev.c
@@ -19,7 +19,6 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/input.h>
-#include <linux/smp_lock.h>
 #include <linux/random.h>
 #include <linux/major.h>
 #include <linux/device.h>
--- linux-2619-rc2g2.orig/drivers/input/tsdev.c
+++ linux-2619-rc2g2/drivers/input/tsdev.c
@@ -48,7 +48,6 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/major.h>
-#include <linux/smp_lock.h>
 #include <linux/random.h>
 #include <linux/time.h>
 #include <linux/device.h>
--- linux-2619-rc2g2.orig/drivers/isdn/capi/capi.c
+++ linux-2619-rc2g2/drivers/isdn/capi/capi.c
@@ -19,7 +19,6 @@
 #include <linux/fs.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
-#include <linux/smp_lock.h>
 #include <linux/timer.h>
 #include <linux/wait.h>
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
--- linux-2619-rc2g2.orig/drivers/isdn/divert/divert_procfs.c
+++ linux-2619-rc2g2/drivers/isdn/divert/divert_procfs.c
@@ -11,7 +11,6 @@
 
 #include <linux/module.h>
 #include <linux/poll.h>
-#include <linux/smp_lock.h>
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #else
--- linux-2619-rc2g2.orig/drivers/isdn/hardware/eicon/capimain.c
+++ linux-2619-rc2g2/drivers/isdn/hardware/eicon/capimain.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
-#include <linux/smp_lock.h>
 #include <linux/skbuff.h>
 
 #include "os_capi.h"
--- linux-2619-rc2g2.orig/drivers/isdn/hardware/eicon/divamnt.c
+++ linux-2619-rc2g2/drivers/isdn/hardware/eicon/divamnt.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/smp_lock.h>
 #include <linux/poll.h>
 #include <asm/uaccess.h>
 
--- linux-2619-rc2g2.orig/drivers/isdn/hardware/eicon/divasi.c
+++ linux-2619-rc2g2/drivers/isdn/hardware/eicon/divasi.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/smp_lock.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/skbuff.h>
--- linux-2619-rc2g2.orig/drivers/isdn/hardware/eicon/divasmain.c
+++ linux-2619-rc2g2/drivers/isdn/hardware/eicon/divasmain.c
@@ -18,7 +18,6 @@
 #include <linux/ioport.h>
 #include <linux/workqueue.h>
 #include <linux/pci.h>
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/poll.h>
--- linux-2619-rc2g2.orig/drivers/isdn/hardware/eicon/platform.h
+++ linux-2619-rc2g2/drivers/isdn/hardware/eicon/platform.h
@@ -26,7 +26,6 @@
 #include <linux/vmalloc.h>
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
-#include <linux/smp_lock.h>
 #include <linux/delay.h>
 #include <linux/list.h>
 #include <asm/types.h>
--- linux-2619-rc2g2.orig/drivers/isdn/hisax/hfc_usb.c
+++ linux-2619-rc2g2/drivers/isdn/hisax/hfc_usb.c
@@ -37,7 +37,6 @@
 #include <linux/kernel_stat.h>
 #include <linux/usb.h>
 #include <linux/kernel.h>
-#include <linux/smp_lock.h>
 #include <linux/sched.h>
 #include "hisax.h"
 #include "hisax_if.h"
--- linux-2619-rc2g2.orig/drivers/macintosh/therm_adt746x.c
+++ linux-2619-rc2g2/drivers/macintosh/therm_adt746x.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
-#include <linux/smp_lock.h>
 #include <linux/wait.h>
 #include <linux/suspend.h>
 #include <linux/kthread.h>
--- linux-2619-rc2g2.orig/drivers/macintosh/therm_pm72.c
+++ linux-2619-rc2g2/drivers/macintosh/therm_pm72.c
@@ -117,7 +117,6 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
-#include <linux/smp_lock.h>
 #include <linux/wait.h>
 #include <linux/reboot.h>
 #include <linux/kmod.h>
--- linux-2619-rc2g2.orig/drivers/macintosh/windfarm_core.c
+++ linux-2619-rc2g2/drivers/macintosh/windfarm_core.c
@@ -27,7 +27,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
-#include <linux/smp_lock.h>
 #include <linux/kthread.h>
 #include <linux/jiffies.h>
 #include <linux/reboot.h>
--- linux-2619-rc2g2.orig/drivers/media/dvb/bt8xx/dst_common.h
+++ linux-2619-rc2g2/drivers/media/dvb/bt8xx/dst_common.h
@@ -22,7 +22,6 @@
 #ifndef DST_COMMON_H
 #define DST_COMMON_H
 
-#include <linux/smp_lock.h>
 #include <linux/dvb/frontend.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
--- linux-2619-rc2g2.orig/drivers/media/dvb/ttpci/av7110_av.c
+++ linux-2619-rc2g2/drivers/media/dvb/ttpci/av7110_av.c
@@ -33,7 +33,6 @@
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
-#include <linux/smp_lock.h>
 #include <linux/fs.h>
 
 #include "av7110.h"
--- linux-2619-rc2g2.orig/drivers/media/dvb/ttpci/av7110_ca.c
+++ linux-2619-rc2g2/drivers/media/dvb/ttpci/av7110_ca.c
@@ -35,7 +35,6 @@
 #include <linux/fs.h>
 #include <linux/timer.h>
 #include <linux/poll.h>
-#include <linux/smp_lock.h>
 
 #include "av7110.h"
 #include "av7110_hw.h"
--- linux-2619-rc2g2.orig/drivers/media/dvb/ttpci/av7110_hw.c
+++ linux-2619-rc2g2/drivers/media/dvb/ttpci/av7110_hw.c
@@ -34,7 +34,6 @@
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
-#include <linux/smp_lock.h>
 #include <linux/fs.h>
 
 #include "av7110.h"
--- linux-2619-rc2g2.orig/drivers/media/dvb/ttpci/av7110_v4l.c
+++ linux-2619-rc2g2/drivers/media/dvb/ttpci/av7110_v4l.c
@@ -32,7 +32,6 @@
 #include <linux/fs.h>
 #include <linux/timer.h>
 #include <linux/poll.h>
-#include <linux/smp_lock.h>
 
 #include "av7110.h"
 #include "av7110_hw.h"
--- linux-2619-rc2g2.orig/drivers/media/radio/dsbr100.c
+++ linux-2619-rc2g2/drivers/media/radio/dsbr100.c
@@ -79,7 +79,6 @@
 #include <linux/videodev2.h>
 #include <media/v4l2-common.h>
 #include <linux/usb.h>
-#include <linux/smp_lock.h>
 
 /*
  * Version Information
--- linux-2619-rc2g2.orig/drivers/media/video/cpia.h
+++ linux-2619-rc2g2/drivers/media/video/cpia.h
@@ -47,7 +47,6 @@
 #include <linux/videodev.h>
 #include <media/v4l2-common.h>
 #include <linux/list.h>
-#include <linux/smp_lock.h>
 #include <linux/mutex.h>
 
 struct cpia_camera_ops
--- linux-2619-rc2g2.orig/drivers/media/video/cpia_pp.c
+++ linux-2619-rc2g2/drivers/media/video/cpia_pp.c
@@ -34,7 +34,6 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
-#include <linux/smp_lock.h>
 #include <linux/sched.h>
 
 #include <linux/kmod.h>
--- linux-2619-rc2g2.orig/drivers/media/video/cx88/cx88-tvaudio.c
+++ linux-2619-rc2g2/drivers/media/video/cx88/cx88-tvaudio.c
@@ -50,7 +50,6 @@
 #include <linux/interrupt.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
 
--- linux-2619-rc2g2.orig/drivers/media/video/dabusb.c
+++ linux-2619-rc2g2/drivers/media/video/dabusb.c
@@ -37,7 +37,6 @@
 #include <asm/atomic.h>
 #include <linux/delay.h>
 #include <linux/usb.h>
-#include <linux/smp_lock.h>
 #include <linux/mutex.h>
 
 #include "dabusb.h"
--- linux-2619-rc2g2.orig/drivers/media/video/ov511.h
+++ linux-2619-rc2g2/drivers/media/video/ov511.h
@@ -4,7 +4,6 @@
 #include <asm/uaccess.h>
 #include <linux/videodev.h>
 #include <media/v4l2-common.h>
-#include <linux/smp_lock.h>
 #include <linux/usb.h>
 #include <linux/mutex.h>
 
--- linux-2619-rc2g2.orig/drivers/media/video/pvrusb2/pvrusb2-main.c
+++ linux-2619-rc2g2/drivers/media/video/pvrusb2/pvrusb2-main.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/smp_lock.h>
 #include <linux/usb.h>
 #include <linux/videodev2.h>
 
--- linux-2619-rc2g2.orig/drivers/media/video/saa7134/saa7134-tvaudio.c
+++ linux-2619-rc2g2/drivers/media/video/saa7134/saa7134-tvaudio.c
@@ -27,7 +27,6 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/smp_lock.h>
 #include <asm/div64.h>
 
 #include "saa7134-reg.h"
--- linux-2619-rc2g2.orig/drivers/media/video/se401.h
+++ linux-2619-rc2g2/drivers/media/video/se401.h
@@ -5,7 +5,6 @@
 #include <asm/uaccess.h>
 #include <linux/videodev.h>
 #include <media/v4l2-common.h>
-#include <linux/smp_lock.h>
 #include <linux/mutex.h>
 
 #define se401_DEBUG	/* Turn on debug messages */
--- linux-2619-rc2g2.orig/drivers/media/video/tvaudio.c
+++ linux-2619-rc2g2/drivers/media/video/tvaudio.c
@@ -27,7 +27,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/kthread.h>
 
 #include <media/tvaudio.h>
--- linux-2619-rc2g2.orig/drivers/media/video/usbvideo/usbvideo.c
+++ linux-2619-rc2g2/drivers/media/video/usbvideo/usbvideo.c
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/mm.h>
-#include <linux/smp_lock.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
--- linux-2619-rc2g2.orig/drivers/media/video/v4l1-compat.c
+++ linux-2619-rc2g2/drivers/media/video/v4l1-compat.c
@@ -23,7 +23,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/smp_lock.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/file.h>
--- linux-2619-rc2g2.orig/drivers/media/video/v4l2-common.c
+++ linux-2619-rc2g2/drivers/media/video/v4l2-common.c
@@ -48,7 +48,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/smp_lock.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/errno.h>
--- linux-2619-rc2g2.orig/drivers/media/video/videodev.c
+++ linux-2619-rc2g2/drivers/media/video/videodev.c
@@ -31,7 +31,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/smp_lock.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/errno.h>
--- linux-2619-rc2g2.orig/drivers/mfd/ucb1x00-ts.c
+++ linux-2619-rc2g2/drivers/mfd/ucb1x00-ts.c
@@ -21,7 +21,6 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/smp.h>
-#include <linux/smp_lock.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
--- linux-2619-rc2g2.orig/drivers/net/irda/sir_dev.c
+++ linux-2619-rc2g2/drivers/net/irda/sir_dev.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/delay.h>
 
 #include <net/irda/irda.h>
--- linux-2619-rc2g2.orig/drivers/net/irda/sir_dongle.c
+++ linux-2619-rc2g2/drivers/net/irda/sir_dongle.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/kmod.h>
 #include <linux/mutex.h>
 
--- linux-2619-rc2g2.orig/drivers/net/irda/vlsi_ir.c
+++ linux-2619-rc2g2/drivers/net/irda/vlsi_ir.c
@@ -44,7 +44,6 @@ MODULE_LICENSE("GPL");
 #include <linux/time.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 
--- linux-2619-rc2g2.orig/drivers/net/ns83820.c
+++ linux-2619-rc2g2/drivers/net/ns83820.c
@@ -104,7 +104,6 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/delay.h>
-#include <linux/smp_lock.h>
 #include <linux/workqueue.h>
 #include <linux/init.h>
 #include <linux/ip.h>	/* for iph */
--- linux-2619-rc2g2.orig/drivers/net/ppp_generic.c
+++ linux-2619-rc2g2/drivers/net/ppp_generic.c
@@ -40,7 +40,6 @@
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/spinlock.h>
-#include <linux/smp_lock.h>
 #include <linux/rwsem.h>
 #include <linux/stddef.h>
 #include <linux/device.h>
--- linux-2619-rc2g2.orig/drivers/net/wan/cosa.c
+++ linux-2619-rc2g2/drivers/net/wan/cosa.c
@@ -90,7 +90,6 @@
 #include <linux/ioport.h>
 #include <linux/netdevice.h>
 #include <linux/spinlock.h>
-#include <linux/smp_lock.h>
 #include <linux/device.h>
 
 #undef COSA_SLOW_IO	/* for testing purposes only */
--- linux-2619-rc2g2.orig/drivers/net/wireless/airo.c
+++ linux-2619-rc2g2/drivers/net/wireless/airo.c
@@ -25,7 +25,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
-#include <linux/smp_lock.h>
 
 #include <linux/sched.h>
 #include <linux/ptrace.h>
--- linux-2619-rc2g2.orig/drivers/net/wireless/hostap/hostap_ioctl.c
+++ linux-2619-rc2g2/drivers/net/wireless/hostap/hostap_ioctl.c
@@ -1,7 +1,6 @@
 /* ioctl() (mostly Linux Wireless Extensions) routines for Host AP driver */
 
 #include <linux/types.h>
-#include <linux/smp_lock.h>
 #include <linux/ethtool.h>
 #include <net/ieee80211_crypt.h>
 
--- linux-2619-rc2g2.orig/drivers/parisc/lba_pci.c
+++ linux-2619-rc2g2/drivers/parisc/lba_pci.c
@@ -38,7 +38,6 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 
 #include <asm/byteorder.h>
 #include <asm/pdc.h>
--- linux-2619-rc2g2.orig/drivers/pci/hotplug/acpiphp_core.c
+++ linux-2619-rc2g2/drivers/pci/hotplug/acpiphp_core.c
@@ -39,7 +39,6 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
-#include <linux/smp_lock.h>
 #include "pci_hotplug.h"
 #include "acpiphp.h"
 
--- linux-2619-rc2g2.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-2619-rc2g2/drivers/pci/hotplug/acpiphp_glue.c
@@ -45,7 +45,6 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/smp_lock.h>
 #include <linux/mutex.h>
 
 #include "../pci.h"
--- linux-2619-rc2g2.orig/drivers/pci/hotplug/ibmphp_core.c
+++ linux-2619-rc2g2/drivers/pci/hotplug/ibmphp_core.c
@@ -34,7 +34,6 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/wait.h>
-#include <linux/smp_lock.h>
 #include "../pci.h"
 #include "../../../arch/i386/pci/pci.h"	/* for struct irq_routing_table */
 #include "ibmphp.h"
--- linux-2619-rc2g2.orig/drivers/pci/hotplug/ibmphp_hpc.c
+++ linux-2619-rc2g2/drivers/pci/hotplug/ibmphp_hpc.c
@@ -32,7 +32,6 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
 
--- linux-2619-rc2g2.orig/drivers/pci/hotplug/pci_hotplug_core.c
+++ linux-2619-rc2g2/drivers/pci/hotplug/pci_hotplug_core.c
@@ -34,7 +34,6 @@
 #include <linux/list.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
--- linux-2619-rc2g2.orig/drivers/pci/hotplug/rpaphp_core.c
+++ linux-2619-rc2g2/drivers/pci/hotplug/rpaphp_core.c
@@ -28,7 +28,6 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
-#include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <asm/eeh.h>       /* for eeh_add_device() */
 #include <asm/rtas.h>		/* rtas_call */
--- linux-2619-rc2g2.orig/drivers/pci/hotplug/shpchp_ctrl.c
+++ linux-2619-rc2g2/drivers/pci/hotplug/shpchp_ctrl.c
@@ -30,7 +30,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/smp_lock.h>
 #include <linux/pci.h>
 #include <linux/workqueue.h>
 #include "../pci.h"
--- linux-2619-rc2g2.orig/drivers/pci/msi.c
+++ linux-2619-rc2g2/drivers/pci/msi.c
@@ -12,7 +12,6 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/smp_lock.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/msi.h>
--- linux-2619-rc2g2.orig/drivers/pci/proc.c
+++ linux-2619-rc2g2/drivers/pci/proc.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
--- linux-2619-rc2g2.orig/drivers/sbus/char/bpp.c
+++ linux-2619-rc2g2/drivers/sbus/char/bpp.c
@@ -15,7 +15,6 @@
 #include <linux/fs.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
-#include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
--- linux-2619-rc2g2.orig/drivers/sbus/char/rtc.c
+++ linux-2619-rc2g2/drivers/sbus/char/rtc.c
@@ -19,7 +19,6 @@
 #include <linux/fcntl.h>
 #include <linux/poll.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <asm/io.h>
 #include <asm/mostek.h>
 #include <asm/system.h>
--- linux-2619-rc2g2.orig/drivers/sbus/char/vfc_dev.c
+++ linux-2619-rc2g2/drivers/sbus/char/vfc_dev.c
@@ -21,7 +21,6 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
-#include <linux/smp_lock.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
--- linux-2619-rc2g2.orig/drivers/scsi/aic7xxx/aic79xx_osm.h
+++ linux-2619-rc2g2/drivers/scsi/aic7xxx/aic79xx_osm.h
@@ -47,7 +47,6 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/slab.h>
--- linux-2619-rc2g2.orig/drivers/scsi/aic7xxx/aic7xxx_osm.h
+++ linux-2619-rc2g2/drivers/scsi/aic7xxx/aic7xxx_osm.h
@@ -64,7 +64,6 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/slab.h>
--- linux-2619-rc2g2.orig/drivers/scsi/dpt_i2o.c
+++ linux-2619-rc2g2/drivers/scsi/dpt_i2o.c
@@ -55,7 +55,6 @@ MODULE_DESCRIPTION("Adaptec I2O RAID Dri
 #include <linux/sched.h>
 #include <linux/reboot.h>
 #include <linux/spinlock.h>
-#include <linux/smp_lock.h>
 #include <linux/dma-mapping.h>
 
 #include <linux/timer.h>
--- linux-2619-rc2g2.orig/drivers/scsi/scsi_debug.c
+++ linux-2619-rc2g2/drivers/scsi/scsi_debug.c
@@ -37,7 +37,6 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
-#include <linux/smp_lock.h>
 #include <linux/vmalloc.h>
 #include <linux/moduleparam.h>
 
--- linux-2619-rc2g2.orig/drivers/scsi/sg.c
+++ linux-2619-rc2g2/drivers/scsi/sg.c
@@ -41,7 +41,6 @@ static int sg_version_num = 30534;	/* 2 
 #include <linux/fcntl.h>
 #include <linux/init.h>
 #include <linux/poll.h>
-#include <linux/smp_lock.h>
 #include <linux/moduleparam.h>
 #include <linux/cdev.h>
 #include <linux/seq_file.h>
--- linux-2619-rc2g2.orig/drivers/serial/icom.c
+++ linux-2619-rc2g2/drivers/serial/icom.c
@@ -48,7 +48,6 @@
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
 #include <linux/smp.h>
-#include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/kobject.h>
 #include <linux/firmware.h>
--- linux-2619-rc2g2.orig/drivers/video/sis/sis.h
+++ linux-2619-rc2g2/drivers/video/sis/sis.h
@@ -51,7 +51,6 @@
 #include <linux/ioctl32.h>
 #define SIS_OLD_CONFIG_COMPAT
 #else
-#include <linux/smp_lock.h>
 #define SIS_NEW_CONFIG_COMPAT
 #endif
 #endif	/* CONFIG_COMPAT */
--- linux-2619-rc2g2.orig/drivers/video/sis/sis_main.c
+++ linux-2619-rc2g2/drivers/video/sis/sis_main.c
@@ -37,7 +37,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
-#include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/string.h>
--- linux-2619-rc2g2.orig/drivers/usb/atm/usbatm.c
+++ linux-2619-rc2g2/drivers/usb/atm/usbatm.c
@@ -77,7 +77,6 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/stat.h>
 #include <linux/timer.h>
 #include <linux/wait.h>
--- linux-2619-rc2g2.orig/drivers/usb/class/cdc-acm.c
+++ linux-2619-rc2g2/drivers/usb/class/cdc-acm.c
@@ -59,7 +59,6 @@
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
 #include <linux/module.h>
-#include <linux/smp_lock.h>
 #include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include <linux/usb.h>
--- linux-2619-rc2g2.orig/drivers/usb/class/usblp.c
+++ linux-2619-rc2g2/drivers/usb/class/usblp.c
@@ -49,7 +49,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/smp_lock.h>
 #include <linux/signal.h>
 #include <linux/poll.h>
 #include <linux/init.h>
--- linux-2619-rc2g2.orig/drivers/usb/core/hub.c
+++ linux-2619-rc2g2/drivers/usb/core/hub.c
@@ -16,7 +16,6 @@
 #include <linux/sched.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/ioctl.h>
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
--- linux-2619-rc2g2.orig/drivers/usb/core/inode.c
+++ linux-2619-rc2g2/drivers/usb/core/inode.c
@@ -36,7 +36,6 @@
 #include <linux/usb.h>
 #include <linux/namei.h>
 #include <linux/usbdevice_fs.h>
-#include <linux/smp_lock.h>
 #include <linux/parser.h>
 #include <linux/notifier.h>
 #include <asm/byteorder.h>
--- linux-2619-rc2g2.orig/drivers/usb/core/usb.c
+++ linux-2619-rc2g2/drivers/usb/core/usb.c
@@ -30,7 +30,6 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
-#include <linux/smp_lock.h>
 #include <linux/usb.h>
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
--- linux-2619-rc2g2.orig/drivers/usb/gadget/at91_udc.c
+++ linux-2619-rc2g2/drivers/usb/gadget/at91_udc.c
@@ -32,7 +32,6 @@
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/list.h>
--- linux-2619-rc2g2.orig/drivers/usb/gadget/dummy_hcd.c
+++ linux-2619-rc2g2/drivers/usb/gadget/dummy_hcd.c
@@ -42,7 +42,6 @@
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/timer.h>
--- linux-2619-rc2g2.orig/drivers/usb/gadget/ether.c
+++ linux-2619-rc2g2/drivers/usb/gadget/ether.c
@@ -29,7 +29,6 @@
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/timer.h>
--- linux-2619-rc2g2.orig/drivers/usb/gadget/goku_udc.c
+++ linux-2619-rc2g2/drivers/usb/gadget/goku_udc.c
@@ -31,7 +31,6 @@
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/timer.h>
--- linux-2619-rc2g2.orig/drivers/usb/gadget/net2280.c
+++ linux-2619-rc2g2/drivers/usb/gadget/net2280.c
@@ -55,7 +55,6 @@
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/timer.h>
--- linux-2619-rc2g2.orig/drivers/usb/gadget/serial.c
+++ linux-2619-rc2g2/drivers/usb/gadget/serial.c
@@ -23,7 +23,6 @@
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/timer.h>
--- linux-2619-rc2g2.orig/drivers/usb/gadget/zero.c
+++ linux-2619-rc2g2/drivers/usb/gadget/zero.c
@@ -68,7 +68,6 @@
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/timer.h>
--- linux-2619-rc2g2.orig/drivers/usb/host/ehci-hcd.c
+++ linux-2619-rc2g2/drivers/usb/host/ehci-hcd.c
@@ -24,7 +24,6 @@
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/timer.h>
--- linux-2619-rc2g2.orig/drivers/usb/host/ohci-hcd.c
+++ linux-2619-rc2g2/drivers/usb/host/ohci-hcd.c
@@ -82,7 +82,6 @@
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/timer.h>
--- linux-2619-rc2g2.orig/drivers/usb/host/sl811-hcd.c
+++ linux-2619-rc2g2/drivers/usb/host/sl811-hcd.c
@@ -38,7 +38,6 @@
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/timer.h>
--- linux-2619-rc2g2.orig/drivers/usb/host/u132-hcd.c
+++ linux-2619-rc2g2/drivers/usb/host/u132-hcd.c
@@ -42,7 +42,6 @@
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/timer.h>
--- linux-2619-rc2g2.orig/drivers/usb/image/mdc800.c
+++ linux-2619-rc2g2/drivers/usb/image/mdc800.c
@@ -94,7 +94,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/smp_lock.h>
 #include <linux/wait.h>
 #include <linux/mutex.h>
 
--- linux-2619-rc2g2.orig/drivers/usb/image/microtek.c
+++ linux-2619-rc2g2/drivers/usb/image/microtek.c
@@ -129,7 +129,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/smp_lock.h>
 #include <linux/usb.h>
 #include <linux/proc_fs.h>
 
--- linux-2619-rc2g2.orig/drivers/usb/input/hid-core.c
+++ linux-2619-rc2g2/drivers/usb/input/hid-core.c
@@ -20,7 +20,6 @@
 #include <linux/sched.h>
 #include <linux/list.h>
 #include <linux/mm.h>
-#include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <asm/unaligned.h>
 #include <asm/byteorder.h>
--- linux-2619-rc2g2.orig/drivers/usb/input/hiddev.c
+++ linux-2619-rc2g2/drivers/usb/input/hiddev.c
@@ -29,7 +29,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/input.h>
 #include <linux/usb.h>
 #include "hid.h"
--- linux-2619-rc2g2.orig/drivers/usb/input/xpad.c
+++ linux-2619-rc2g2/drivers/usb/input/xpad.c
@@ -62,7 +62,6 @@
 #include <linux/stat.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/smp_lock.h>
 #include <linux/usb/input.h>
 
 #define DRIVER_VERSION "v0.0.6"
--- linux-2619-rc2g2.orig/drivers/usb/misc/idmouse.c
+++ linux-2619-rc2g2/drivers/usb/misc/idmouse.c
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <linux/mutex.h>
 #include <asm/uaccess.h>
--- linux-2619-rc2g2.orig/drivers/usb/misc/legousbtower.c
+++ linux-2619-rc2g2/drivers/usb/misc/legousbtower.c
@@ -80,7 +80,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <linux/mutex.h>
 #include <asm/uaccess.h>
--- linux-2619-rc2g2.orig/drivers/usb/misc/rio500.c
+++ linux-2619-rc2g2/drivers/usb/misc/rio500.c
@@ -39,7 +39,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/usb.h>
-#include <linux/smp_lock.h>
 #include <linux/wait.h>
 
 #include "rio500_usb.h"
--- linux-2619-rc2g2.orig/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ linux-2619-rc2g2/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -63,7 +63,6 @@
 #include <linux/selection.h>
 #include <linux/spinlock.h>
 #include <linux/kref.h>
-#include <linux/smp_lock.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/vmalloc.h>
--- linux-2619-rc2g2.orig/drivers/usb/mon/mon_main.c
+++ linux-2619-rc2g2/drivers/usb/mon/mon_main.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/usb.h>
 #include <linux/debugfs.h>
-#include <linux/smp_lock.h>
 #include <linux/notifier.h>
 #include <linux/mutex.h>
 
--- linux-2619-rc2g2.orig/drivers/usb/serial/usb-serial.c
+++ linux-2619-rc2g2/drivers/usb/serial/usb-serial.c
@@ -28,7 +28,6 @@
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
-#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <linux/usb.h>
 #include <linux/usb/serial.h>
--- linux-2619-rc2g2.orig/drivers/usb/storage/usb.h
+++ linux-2619-rc2g2/drivers/usb/storage/usb.h
@@ -47,7 +47,6 @@
 #include <linux/usb.h>
 #include <linux/usb_usual.h>
 #include <linux/blkdev.h>
-#include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <linux/mutex.h>
 #include <scsi/scsi_host.h>
