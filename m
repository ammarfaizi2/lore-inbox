Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVE3VpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVE3VpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVE3VpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:45:00 -0400
Received: from pier.botik.ru ([193.232.174.1]:44314 "EHLO pier.botik.ru")
	by vger.kernel.org with ESMTP id S261767AbVE3Vol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 17:44:41 -0400
Message-ID: <429B9D00.1070404@namesys.com>
Date: Tue, 31 May 2005 03:08:48 +0400
From: "E.Gryaznova" <grev@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5-mm1: configuring vmware workstation modules
Content-Type: multipart/mixed;
 boundary="------------040205060102060100070107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040205060102060100070107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

I encounter this problem while configuring my evaluation copy of 
Workstation 5. I have the trial version VMware-workstation-5.0.0-13124, 
it was installed successfully and worked fine in linux-2.6.11. The 
problem occurs when I change kernel  to linux-2.6.12-rc5-mm1 and try to 
configure this kernel to load the VMWare modules:

bones:~ # /usr/bin/vmware-config.pl
Making sure services for VMware Workstation are stopped.

Stopping VMware services:
   Virtual machine monitor                                             done
   Bridged networking on /dev/vmnet0                                   done
   DHCP server on /dev/vmnet1                                          done
   Host-only networking on /dev/vmnet1                                 done
   Virtual ethernet                                                    done

Configuring fallback GTK+ 2.4 libraries.

In which directory do you want to install the mime type icons?
[/usr/share/icons]

What directory contains your desktop menu entry files? These files have a
.desktop file extension. [/usr/share/applications]

In which directory do you want to install the application's icon?
[/usr/share/pixmaps]

Trying to find a suitable vmmon module for your running kernel.

None of the pre-built vmmon modules for VMware Workstation is suitable 
for your
running kernel.  Do you want this program to try to build the vmmon 
module for
your system (you need to have a C compiler installed on your system)? [yes]

Using compiler "/usr/bin/gcc". Use environment variable CC to override.

What is the location of the directory of C header files that match your 
running
kernel? [/lib/modules/2.6.12-rc5-mm1/build/include]

Extracting the sources of the vmmon module.

Building the vmmon module.

Using 2.6.x kernel build system.
make: Entering directory `/tmp/vmware-config5/vmmon-only'
make -C /lib/modules/2.6.12-rc5-mm1/build/include/.. SUBDIRS=$PWD 
SRCROOT=$PWD/. modules
make[1]: Entering directory 
`/home/grev/kernels/2.6.12-rc5/linux-2.6.12-mm-bk'
  CC [M]  /tmp/vmware-config5/vmmon-only/linux/driver.o
  CC [M]  /tmp/vmware-config5/vmmon-only/linux/hostif.o
  CC [M]  /tmp/vmware-config5/vmmon-only/common/cpuid.o
  CC [M]  /tmp/vmware-config5/vmmon-only/common/hash.o
  CC [M]  /tmp/vmware-config5/vmmon-only/common/memtrack.o
  CC [M]  /tmp/vmware-config5/vmmon-only/common/phystrack.o
  CC [M]  /tmp/vmware-config5/vmmon-only/common/task.o
  CC [M]  /tmp/vmware-config5/vmmon-only/common/vmx86.o
  CC [M]  /tmp/vmware-config5/vmmon-only/vmcore/moduleloop.o
  LD [M]  /tmp/vmware-config5/vmmon-only/vmmon.o
  Building modules, stage 2.
  MODPOST
  CC      /tmp/vmware-config5/vmmon-only/vmmon.mod.o
  LD [M]  /tmp/vmware-config5/vmmon-only/vmmon.ko
make[1]: Leaving directory 
`/home/grev/kernels/2.6.12-rc5/linux-2.6.12-mm-bk'
cp -f vmmon.ko ./../vmmon.o
make: Leaving directory `/tmp/vmware-config5/vmmon-only'
The module loads perfectly in the running kernel.

You have already setup networking.

Would you like to skip networking setup and keep your old settings as 
they are?
(yes/no) [yes] yes

Extracting the sources of the vmnet module.

Building the vmnet module.

Using 2.6.x kernel build system.
make: Entering directory `/tmp/vmware-config5/vmnet-only'
make -C /lib/modules/2.6.12-rc5-mm1/build/include/.. SUBDIRS=$PWD 
SRCROOT=$PWD/. modules
make[1]: Entering directory 
`/home/grev/kernels/2.6.12-rc5/linux-2.6.12-mm-bk'
  CC [M]  /tmp/vmware-config5/vmnet-only/driver.o
  CC [M]  /tmp/vmware-config5/vmnet-only/hub.o
  CC [M]  /tmp/vmware-config5/vmnet-only/userif.o
/tmp/vmware-config5/vmnet-only/userif.c: In function 
`VNetUserIfMapUint32Ptr':
/tmp/vmware-config5/vmnet-only/userif.c:152: warning: `verify_area' is 
deprecated (declared at include/asm/uaccess.h:105)
/tmp/vmware-config5/vmnet-only/userif.c:153: warning: `verify_area' is 
deprecated (declared at include/asm/uaccess.h:105)
  CC [M]  /tmp/vmware-config5/vmnet-only/netif.o
  CC [M]  /tmp/vmware-config5/vmnet-only/bridge.o
/tmp/vmware-config5/vmnet-only/bridge.c: In function `VNetBridgeUp':
/tmp/vmware-config5/vmnet-only/bridge.c:716: warning: passing arg 3 of 
`sk_alloc' makes pointer from integer without a cast
/tmp/vmware-config5/vmnet-only/bridge.c:716: warning: passing arg 4 of 
`sk_alloc' makes integer from pointer without a cast
  CC [M]  /tmp/vmware-config5/vmnet-only/procfs.o
  LD [M]  /tmp/vmware-config5/vmnet-only/vmnet.o
  Building modules, stage 2.
  MODPOST
  CC      /tmp/vmware-config5/vmnet-only/vmnet.mod.o
  LD [M]  /tmp/vmware-config5/vmnet-only/vmnet.ko
make[1]: Leaving directory 
`/home/grev/kernels/2.6.12-rc5/linux-2.6.12-mm-bk'
cp -f vmnet.ko ./../vmnet.o
make: Leaving directory `/tmp/vmware-config5/vmnet-only'
The module loads perfectly in the running kernel.

Starting VMware services:
   Virtual machine monitor                                             done
   Virtual ethernet                                                    done
   Bridged networking on /dev/vmnet0

---------
The kernel fails here with the following kgdb trace (attached).
I can provide more information if it is nedeed.

Thanks,
Lena







--------------040205060102060100070107
Content-Type: text/plain;
 name="2.6.12-rc5-mm1.kgdb.trace"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.12-rc5-mm1.kgdb.trace"

vmmon: module license 'unspecified' taints kernel.
/dev/vmmon[1748]: VMMON CPUID: Unrecognized CPU
/dev/vmmon[1748]: Module vmmon: registered with major=10 minor=165
/dev/vmmon[1748]: Module vmmon: initialized
/dev/vmmon[1752]: Module vmmon: unloaded
/dev/vmmon[1915]: VMMON CPUID: Unrecognized CPU
/dev/vmmon[1915]: Module vmmon: registered with major=10 minor=165
/dev/vmmon[1915]: Module vmmon: initialized
/dev/vmnet: open called by PID 1935 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: enabling the bridge
Uhhuh. NMI received for unknown reason 00 on CPU 1.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
kgdb : time out, proceeding without sync
Some cpus not stopped, see 'kgdb_info' for details

Program received signal SIGEMT, Emulation trap.
sk_alloc (family=16, priority=32, prot=0x1, zero_it=0) at net/core/sock.c:627
627             kmem_cache_t *slab = prot->slab;
(gdb) bt
#0  sk_alloc (family=16, priority=32, prot=0x1, zero_it=0) at net/core/sock.c:627
#1  0xf93c0a93 in ?? ()
(gdb) info threads
  69 Thread 32769 (swapper)  0xc042fb6e in schedule () at kernel/sched.c:1628
* 68 Thread 32768 (swapper)  0xc042fb6e in schedule () at kernel/sched.c:1628
  67 Thread 1935 (vmnet-bridge)  sk_alloc (family=16, priority=32, prot=0x1, zero_it=0) at net/core/sock.c:627
  66 Thread 1934 (vmware)  do_wait (pid=-1, options=1011273829, infop=0x0, stat_addr=0xbf918908, ru=0x0)
    at kernel/exit.c:1457
  65 Thread 1911 (vmware)  do_wait (pid=-1, options=1035669605, infop=0x0, stat_addr=0xbf918c58, ru=0x0)
    at kernel/exit.c:1457
  64 Thread 1452 (vmware-config.p)  do_wait (pid=1911, options=1036873829, infop=0x0, stat_addr=0xbfa327c4, ru=0x0)
    at kernel/exit.c:1457
  63 Thread 1420 (bash)  do_wait (pid=-1, options=1036988517, infop=0x0, stat_addr=0xbff92228, ru=0x0) at kernel/exit.c:1457
  62 Thread 1419 (sshd)  0xc016ac8b in do_select (n=11, fds=0xf58d5f88, timeout=0xf58d5f84) at fs/select.c:261
  61 Thread 1418 (mingetty)  0xc032f171 in read_chan (tty=0x0, file=0xf58603e0,
    buf=0xbfaee2ab <Address 0xbfaee2ab out of bounds>, nr=1) at drivers/char/n_tty.c:1312
  60 Thread 1417 (mingetty)  0xc032f171 in read_chan (tty=0x0, file=0xf5860340,
    buf=0xbfc114db <Address 0xbfc114db out of bounds>, nr=1) at drivers/char/n_tty.c:1312
  59 Thread 1416 (mingetty)  0xc032f171 in read_chan (tty=0x0, file=0xf5ef1a80,
    buf=0xbfc6014b <Address 0xbfc6014b out of bounds>, nr=1) at drivers/char/n_tty.c:1312
  58 Thread 1415 (mingetty)  0xc032f171 in read_chan (tty=0x0, file=0xf5ef1620,
    buf=0xbfad870b <Address 0xbfad870b out of bounds>, nr=1) at drivers/char/n_tty.c:1312
  57 Thread 1414 (mingetty)  0xc032f171 in read_chan (tty=0x0, file=0xf7cfe580,
    buf=0xbfec2cfb <Address 0xbfec2cfb out of bounds>, nr=1) at drivers/char/n_tty.c:1312
  56 Thread 1413 (mingetty)  0xc032f171 in read_chan (tty=0x0, file=0xf587a900, buf=0xbf9c303b "", nr=1)
    at drivers/char/n_tty.c:1312
  55 Thread 1390 (nscd)  0xc03b73bf in wait_for_packet (sk=0xf5853898, err=0xf58afec0, timeo_p=0xf58afea0)
    at net/core/datagram.c:101
  54 Thread 1389 (nscd)  0xc03b73bf in wait_for_packet (sk=0xc01303cb, err=0xf58adec0, timeo_p=0xf58adea0)
    at net/core/datagram.c:101
  53 Thread 1388 (nscd)  0xc03b73bf in wait_for_packet (sk=0xf5853558, err=0xf58d3ec0, timeo_p=0xf58d3ea0)
    at net/core/datagram.c:101
  52 Thread 1387 (nscd)  0xc03b73bf in wait_for_packet (sk=0xc01303cb, err=0xf705fec0, timeo_p=0xf705fea0)
    at net/core/datagram.c:101
  51 Thread 1386 (nscd)  0xc03b73bf in wait_for_packet (sk=0xf6f78000, err=0xf6f79ec0, timeo_p=0xf6f79ea0)
    at net/core/datagram.c:101
  50 Thread 1385 (nscd)  0xc016b1ba in do_poll (nfds=0, list=0xf5f27e80, wait=0xf70a1f98, timeout=134) at fs/select.c:454
  49 Thread 1384 (nscd)  0xc03b73bf in wait_for_packet (sk=0xc01303cb, err=0xf6f7bec0, timeo_p=0xf6f7bea0)
    at net/core/datagram.c:101
  48 Thread 1382 (cron)  0xc012535e in sys_nanosleep (rqtp=0x0, rmtp=0xbffdeb48) at kernel/timer.c:1205
  47 Thread 951 (cupsd)  0xc016ac8b in do_select (n=6, fds=0xf58fbf88, timeout=0xf58fbf84) at fs/select.c:261
  46 Thread 918 (sshd)  0xc016ac8b in do_select (n=6, fds=0xf58abf88, timeout=0xf58abf84) at fs/select.c:261
  45 Thread 891 (qmgr)  0xc016ac8b in do_select (n=7, fds=0xf70a3f88, timeout=0xf70a3f84) at fs/select.c:261
  44 Thread 890 (pickup)  0xc016ac8b in do_select (n=7, fds=0xf705df88, timeout=0xf705df84) at fs/select.c:261
  43 Thread 877 (master)  0xc016ac8b in do_select (n=79, fds=0xf70cbf88, timeout=0xf70cbf84) at fs/select.c:261
  42 Thread 819 (portmap)  0xc016b1ba in do_poll (nfds=0, list=0xf5f27620, wait=0xf70a5f98, timeout=134) at fs/select.c:454
  41 Thread 797 (resmgrd)  0xc016b1ba in do_poll (nfds=0, list=0xf6374560, wait=0xf5e69f98, timeout=130) at fs/select.c:454
  40 Thread 784 (klogd)  0xc042fb6e in schedule () at kernel/sched.c:1628
  39 Thread 781 (syslogd)  0xc016ac8b in do_select (n=1, fds=0xf5c9df88, timeout=0xf5c9df84) at fs/select.c:261
  38 Thread 38 (reiserfs/1)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  37 Thread 37 (reiserfs/0)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  36 Thread 36 (kirqd)  balanced_irq (unused=0x0) at arch/i386/kernel/io_apic.c:579
  35 Thread 35 (kmirrord/1)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  34 Thread 34 (kmirrord/0)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  33 Thread 33 (kcryptd/1)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  32 Thread 32 (kcryptd/0)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  31 Thread 31 (kgameportd)  0xc0384d5b in gameport_thread (nothing=0x0) at drivers/input/gameport/gameport.c:441
  30 Thread 30 (kseriod)  0xc034877b in serio_thread (nothing=0x0) at drivers/input/serio/serio.c:346
  29 Thread 29 (cqueue/1)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  28 Thread 28 (cqueue/0)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  27 Thread 27 (xfsbufd)  pagebuf_daemon (data=0x0) at fs/xfs/linux-2.6/xfs_buf.c:1793
  26 Thread 26 (xfsdatad/1)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  25 Thread 25 (xfsdatad/0)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  24 Thread 24 (xfslogd/1)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  23 Thread 23 (xfslogd/0)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  22 Thread 22 (jfsSync)  jfs_sync (arg=0x0) at thread_info.h:89
  21 Thread 21 (jfsCommit)  jfs_lazycommit (arg=0x0) at thread_info.h:89
  20 Thread 20 (jfsCommit)  jfs_lazycommit (arg=0x0) at thread_info.h:89
  19 Thread 19 (jfsIO)  jfsIOWait (arg=0x0) at thread_info.h:89
  18 Thread 18 (aio/1)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  17 Thread 17 (aio/0)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  16 Thread 16 (kswapd0)  kswapd (p=0x0) at mm/vmscan.c:1278
  15 Thread 15 (pdflush)  __pdflush (my_work=0x0) at mm/pdflush.c:113
  14 Thread 14 (pdflush)  __pdflush (my_work=0x0) at mm/pdflush.c:113
  13 Thread 13 (kblockd/1)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  12 Thread 12 (kblockd/0)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  11 Thread 11 (kthread)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  10 Thread 10 (khelper)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  9 Thread 9 (events/1)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  8 Thread 8 (events/0)  worker_thread (__cwq=0x0) at kernel/workqueue.c:211
  7 Thread 7 (watchdog/1)  0xc012559a in msleep_interruptible (msecs=0) at kernel/timer.c:1612
  6 Thread 6 (ksoftirqd/1)  0xc0121161 in ksoftirqd (__bind_cpu=0x0) at kernel/softirq.c:361
  5 Thread 5 (migration/1)  migration_thread (data=0x0) at thread_info.h:89
  4 Thread 4 (watchdog/0)  0xc012559a in msleep_interruptible (msecs=0) at kernel/timer.c:1612
  3 Thread 3 (ksoftirqd/0)  0xc0121161 in ksoftirqd (__bind_cpu=0x0) at kernel/softirq.c:361
  2 Thread 2 (migration/0)  migration_thread (data=0x0) at thread_info.h:89
  1 Thread 1 (init)  0xc016ac8b in do_select (n=11, fds=0xc195ff88, timeout=0xc195ff84) at fs/select.c:261
(gdb) print kgdb_info
$2 = {used_malloc = 0, called_from = 0xc01141bc, entry_tsc = 749724996968, errcode = 0, vector = 14, print_debug_info = 0,
  hold_on_sstep = 1, cpus_waiting = {{task = 0x0, pid = 0, hold = 0, regs = 0x0}, {task = 0x0, pid = 0, hold = 0,
      regs = 0x0}}}
(gdb)

--------------040205060102060100070107--

