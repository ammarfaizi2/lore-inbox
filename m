Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752609AbWAHFwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbWAHFwG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 00:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbWAHFv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 00:51:56 -0500
Received: from xenotime.net ([66.160.160.81]:29131 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752603AbWAHFvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 00:51:37 -0500
Date: Sat, 7 Jan 2006 21:51:34 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH 4/4] capable/capability.h (arch/)
Message-Id: <20060107215134.747cfa36.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

arch: Use <linux/capability.h> where capable() is used.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/alpha/kernel/pci-noop.c         |    1 +
 arch/arm/common/rtctime.c            |    1 +
 arch/arm/kernel/apm.c                |    1 +
 arch/cris/arch-v10/drivers/ds1302.c  |    1 +
 arch/cris/arch-v10/drivers/pcf8563.c |    1 +
 arch/i386/kernel/apm.c               |    1 +
 arch/i386/kernel/cpu/mtrr/if.c       |    1 +
 arch/i386/kernel/ioport.c            |    1 +
 arch/i386/kernel/microcode.c         |    1 +
 arch/i386/kernel/vm86.c              |    1 +
 arch/ia64/hp/sim/simserial.c         |    1 +
 arch/ia64/ia32/sys_ia32.c            |    1 +
 arch/ia64/kernel/perfmon.c           |    1 +
 arch/ia64/kernel/salinfo.c           |    1 +
 arch/ia64/sn/kernel/tiocx.c          |    1 +
 arch/m68k/bvme6000/rtc.c             |    1 +
 arch/m68k/kernel/sys_m68k.c          |    1 +
 arch/m68k/mvme16x/rtc.c              |    1 +
 arch/mips/kernel/syscall.c           |    1 +
 arch/mips/kernel/sysirix.c           |    1 +
 arch/parisc/hpux/sys_hpux.c          |    1 +
 arch/parisc/kernel/perf.c            |    1 +
 arch/powerpc/kernel/rtas.c           |    1 +
 arch/ppc/4xx_io/serial_sicc.c        |    1 +
 arch/ppc/kernel/ppc_htab.c           |    1 +
 arch/s390/kernel/compat_linux.c      |    1 +
 arch/sparc/kernel/sys_sunos.c        |    1 +
 arch/sparc64/kernel/sys_sparc32.c    |    1 +
 arch/sparc64/kernel/sys_sunos32.c    |    1 +
 arch/sparc64/solaris/fs.c            |    1 +
 arch/x86_64/kernel/ioport.c          |    1 +
 arch/x86_64/kernel/mce.c             |    1 +
 32 files changed, 32 insertions(+)

--- linux-2615-g3.orig/arch/alpha/kernel/pci-noop.c
+++ linux-2615-g3/arch/alpha/kernel/pci-noop.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
--- linux-2615-g3.orig/arch/arm/common/rtctime.c
+++ linux-2615-g3/arch/arm/common/rtctime.c
@@ -17,6 +17,7 @@
 #include <linux/proc_fs.h>
 #include <linux/miscdevice.h>
 #include <linux/spinlock.h>
+#include <linux/capability.h>
 #include <linux/device.h>
 
 #include <asm/rtc.h>
--- linux-2615-g3.orig/arch/arm/kernel/apm.c
+++ linux-2615-g3/arch/arm/kernel/apm.c
@@ -18,6 +18,7 @@
 #include <linux/proc_fs.h>
 #include <linux/miscdevice.h>
 #include <linux/apm_bios.h>
+#include <linux/capability.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
 #include <linux/pm_legacy.h>
--- linux-2615-g3.orig/arch/cris/arch-v10/drivers/ds1302.c
+++ linux-2615-g3/arch/cris/arch-v10/drivers/ds1302.c
@@ -148,6 +148,7 @@
 #include <linux/miscdevice.h>
 #include <linux/delay.h>
 #include <linux/bcd.h>
+#include <linux/capability.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
--- linux-2615-g3.orig/arch/cris/arch-v10/drivers/pcf8563.c
+++ linux-2615-g3/arch/cris/arch-v10/drivers/pcf8563.c
@@ -28,6 +28,7 @@
 #include <linux/ioctl.h>
 #include <linux/delay.h>
 #include <linux/bcd.h>
+#include <linux/capability.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
--- linux-2615-g3.orig/arch/ia64/hp/sim/simserial.c
+++ linux-2615-g3/arch/ia64/hp/sim/simserial.c
@@ -26,6 +26,7 @@
 #include <linux/fcntl.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/capability.h>
 #include <linux/console.h>
 #include <linux/module.h>
 #include <linux/serial.h>
--- linux-2615-g3.orig/arch/ia64/ia32/sys_ia32.c
+++ linux-2615-g3/arch/ia64/ia32/sys_ia32.c
@@ -48,6 +48,7 @@
 #include <linux/ptrace.h>
 #include <linux/stat.h>
 #include <linux/ipc.h>
+#include <linux/capability.h>
 #include <linux/compat.h>
 #include <linux/vfs.h>
 #include <linux/mman.h>
--- linux-2615-g3.orig/arch/ia64/kernel/perfmon.c
+++ linux-2615-g3/arch/ia64/kernel/perfmon.c
@@ -38,6 +38,7 @@
 #include <linux/pagemap.h>
 #include <linux/mount.h>
 #include <linux/bitops.h>
+#include <linux/capability.h>
 #include <linux/rcupdate.h>
 
 #include <asm/errno.h>
--- linux-2615-g3.orig/arch/ia64/kernel/salinfo.c
+++ linux-2615-g3/arch/ia64/kernel/salinfo.c
@@ -29,6 +29,7 @@
  *   Replace some NR_CPUS by cpus_online, for hotplug cpu.
  */
 
+#include <linux/capability.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/module.h>
--- linux-2615-g3.orig/arch/ia64/sn/kernel/tiocx.c
+++ linux-2615-g3/arch/ia64/sn/kernel/tiocx.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/proc_fs.h>
+#include <linux/capability.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <asm/system.h>
--- linux-2615-g3.orig/arch/m68k/bvme6000/rtc.c
+++ linux-2615-g3/arch/m68k/bvme6000/rtc.c
@@ -11,6 +11,7 @@
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/capability.h>
 #include <linux/fcntl.h>
 #include <linux/init.h>
 #include <linux/poll.h>
--- linux-2615-g3.orig/arch/m68k/kernel/sys_m68k.c
+++ linux-2615-g3/arch/m68k/kernel/sys_m68k.c
@@ -6,6 +6,7 @@
  * platform.
  */
 
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
--- linux-2615-g3.orig/arch/m68k/mvme16x/rtc.c
+++ linux-2615-g3/arch/m68k/mvme16x/rtc.c
@@ -11,6 +11,7 @@
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/capability.h>
 #include <linux/fcntl.h>
 #include <linux/init.h>
 #include <linux/poll.h>
--- linux-2615-g3.orig/arch/mips/kernel/syscall.c
+++ linux-2615-g3/arch/mips/kernel/syscall.c
@@ -9,6 +9,7 @@
  */
 #include <linux/config.h>
 #include <linux/a.out.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
 #include <linux/mm.h>
--- linux-2615-g3.orig/arch/mips/kernel/sysirix.c
+++ linux-2615-g3/arch/mips/kernel/sysirix.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/binfmts.h>
+#include <linux/capability.h>
 #include <linux/highuid.h>
 #include <linux/pagemap.h>
 #include <linux/mm.h>
--- linux-2615-g3.orig/arch/parisc/hpux/sys_hpux.c
+++ linux-2615-g3/arch/parisc/hpux/sys_hpux.c
@@ -22,6 +22,7 @@
  *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/capability.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
--- linux-2615-g3.orig/arch/parisc/kernel/perf.c
+++ linux-2615-g3/arch/parisc/kernel/perf.c
@@ -42,6 +42,7 @@
  *  on every box. 
  */
 
+#include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/miscdevice.h>
--- linux-2615-g3.orig/arch/powerpc/kernel/rtas.c
+++ linux-2615-g3/arch/powerpc/kernel/rtas.c
@@ -17,6 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/capability.h>
 #include <linux/delay.h>
 
 #include <asm/prom.h>
--- linux-2615-g3.orig/arch/i386/kernel/apm.c
+++ linux-2615-g3/arch/i386/kernel/apm.c
@@ -219,6 +219,7 @@
 #include <linux/sched.h>
 #include <linux/pm.h>
 #include <linux/pm_legacy.h>
+#include <linux/capability.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
--- linux-2615-g3.orig/arch/i386/kernel/cpu/mtrr/if.c
+++ linux-2615-g3/arch/i386/kernel/cpu/mtrr/if.c
@@ -1,5 +1,6 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/capability.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
--- linux-2615-g3.orig/arch/i386/kernel/ioport.c
+++ linux-2615-g3/arch/i386/kernel/ioport.c
@@ -7,6 +7,7 @@
 
 #include <linux/sched.h>
 #include <linux/kernel.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
--- linux-2615-g3.orig/arch/i386/kernel/microcode.c
+++ linux-2615-g3/arch/i386/kernel/microcode.c
@@ -70,6 +70,7 @@
  */
 
 //#define DEBUG /* pr_debug */
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/sched.h>
--- linux-2615-g3.orig/arch/i386/kernel/vm86.c
+++ linux-2615-g3/arch/i386/kernel/vm86.c
@@ -30,6 +30,7 @@
  *
  */
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
--- linux-2615-g3.orig/arch/ppc/4xx_io/serial_sicc.c
+++ linux-2615-g3/arch/ppc/4xx_io/serial_sicc.c
@@ -47,6 +47,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/capability.h>
 #include <linux/circ_buf.h>
 #include <linux/serial.h>
 #include <linux/console.h>
--- linux-2615-g3.orig/arch/ppc/kernel/ppc_htab.c
+++ linux-2615-g3/arch/ppc/kernel/ppc_htab.c
@@ -16,6 +16,7 @@
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/sysctl.h>
+#include <linux/capability.h>
 #include <linux/ctype.h>
 #include <linux/threads.h>
 #include <linux/smp_lock.h>
--- linux-2615-g3.orig/arch/s390/kernel/compat_linux.c
+++ linux-2615-g3/arch/s390/kernel/compat_linux.c
@@ -55,6 +55,7 @@
 #include <linux/syscalls.h>
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
+#include <linux/capability.h>
 #include <linux/compat.h>
 #include <linux/vfs.h>
 #include <linux/ptrace.h>
--- linux-2615-g3.orig/arch/sparc/kernel/sys_sunos.c
+++ linux-2615-g3/arch/sparc/kernel/sys_sunos.c
@@ -30,6 +30,7 @@
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
--- linux-2615-g3.orig/arch/sparc64/kernel/sys_sparc32.c
+++ linux-2615-g3/arch/sparc64/kernel/sys_sparc32.c
@@ -11,6 +11,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/capability.h>
 #include <linux/fs.h> 
 #include <linux/mm.h> 
 #include <linux/file.h> 
--- linux-2615-g3.orig/arch/sparc64/kernel/sys_sunos32.c
+++ linux-2615-g3/arch/sparc64/kernel/sys_sunos32.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/types.h>
+#include <linux/capability.h>
 #include <linux/compat.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
--- linux-2615-g3.orig/arch/sparc64/solaris/fs.c
+++ linux-2615-g3/arch/sparc64/solaris/fs.c
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/mm.h>
--- linux-2615-g3.orig/arch/x86_64/kernel/ioport.c
+++ linux-2615-g3/arch/x86_64/kernel/ioport.c
@@ -7,6 +7,7 @@
 
 #include <linux/sched.h>
 #include <linux/kernel.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
--- linux-2615-g3.orig/arch/x86_64/kernel/mce.c
+++ linux-2615-g3/arch/x86_64/kernel/mce.c
@@ -15,6 +15,7 @@
 #include <linux/sysdev.h>
 #include <linux/miscdevice.h>
 #include <linux/fs.h>
+#include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
 #include <linux/ctype.h>


---
