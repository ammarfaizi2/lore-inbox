Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265906AbUAKPqy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 10:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUAKPqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 10:46:54 -0500
Received: from [193.6.138.45] ([193.6.138.45]:57780 "EHLO delfin.unideb.hu")
	by vger.kernel.org with ESMTP id S265906AbUAKPqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 10:46:46 -0500
Date: Sun, 11 Jan 2004 16:47:02 +0100 (CET)
From: The NeverGone <never@delfin.klte.hu>
X-X-Sender: never@localhost
To: linux-kernel@vger.kernel.org
Subject: UML (user-mode-linux) kernel-2.6.x
Message-ID: <Pine.LNX.4.58.0401111555360.3557@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hy...

I'd like to run the UML under the KERNEL 2.6, but I couldn't do it with
any of the versions. While it runs well under the kernel 2.4.24, giving
the outcome:

===== uml-log start =====

never@localhost:/mnt/rack3/uml$ linux ubd0=./root_fs_debian2.2_small
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid = 469
Linux version 2.4.23-1um (mdz@mizar) (gcc version 3.3.3 20031229
(prerelease) (Debian)) #1 Tue Dec 30 11:28:41 PST 2003
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ubd0=./root_fs_debian2.2_small root=/dev/ubd0
Calibrating delay loop... 514.41 BogoMIPS
Memory: 28704k available
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno
2)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Initializing Cryptographic API
Initializing software serial port version 1
mconsole (version 2) initialized on /home/never/.uml/xc11Mb/mconsole
Partition check:
 ubda: unknown partition table
Initializing stdio console driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
INIT: version 2.78 booting
Activating swap...
Checking root file system...
Parallelizing fsck version 1.18 (11-Nov-1999)
/dev/ubd/ubd0: clean, 5415/25688 files, 45646/102400 blocks
Calculating module dependencies... depmod: Can't open
/lib/modules/2.4.23-1um/modules.dep for writing
done.
Loading modules: cat: /etc/modules: No such file or directory

modprobe: Can't open dependencies file /lib/modules/2.4.23-1um/modules.dep
(No such file or directory)
Checking all file systems...
Parallelizing fsck version 1.18 (11-Nov-1999)
Setting kernel variables.
Mounting local filesystems...
mount: mount point /dev/pts does not exist
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: SIOCSIFADDR: No such device
eth0: unknown interface: No such device
SIOCSIFNETMASK: No such device
SIOCSIFBRDADDR: No such device
eth0: unknown interface: No such device
eth0: unknown interface: No such device
done.

Setting the System Clock using the Hardware Clock as reference...
hwclock is unable to get I/O port access:  the iopl(3) call failed.
System Clock set. Local time: Sun Jan 11 03:40:47 CET 2004

Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
Recovering nvi editor sessions... done.
INIT: Entering runlevel: 2
PAM_unix[95]: (login) session opened for user root by LOGIN(uid=0)
login[95]: ROOT LOGIN on `tty2'

INIT: Switching to runlevel: 0
INIT: Sending processes the TERM signal
INIT: Sending processes the KILL signal
Stopping internet superserver: inetd.
Saving the System Clock time to the Hardware Clock...
hwclock is unable to get I/O port access:  the iopl(3) call failed.
Hardware Clock updated to Sun Jan 11 03:41:14 CET 2004.
Stopping portmap daemon: portmap.
Stopping NFS kernel daemon: mountd nfsd.
Unexporting directories for NFS kernel daemon...done.
Stopping NFS common utilities: statd.
Stopping system log daemon: klogd syslogd.
Sending all processes the TERM signal... done.
Sending all processes the KILL signal... done.
Saving random seed... done.
Unmounting remote filesystems... done.
Deconfiguring network interfaces: eth0: unknown interface: No such device
done.
Deactivating swap... done.
Unmounting local filesystems... done.
Power down.

===== uml-log end =====

It stops running with this error under 2.6.1-mm2 (or any of the 2.6s):

===== uml-log start =====

never@localhost:/mnt/rack3/uml$ linux ubd0=./root_fs_debian2.2_small
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid = 1079
Linux version 2.4.23-1um (mdz@mizar) (gcc version 3.3.3 20031229
(prerelease) (Debian)) #1 Tue Dec 30 11:28:41 PST 2003
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ubd0=./root_fs_debian2.2_small root=/dev/ubd0
Calibrating delay loop... 506.88 BogoMIPS
Memory: 28704k available
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno
2)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Initializing Cryptographic API
Initializing software serial port version 1
mconsole (version 2) initialized on /home/never/.uml/TasBbM/mconsole
Partition check:
 ubda: unknown partition table
Initializing stdio console driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
I'm tracing myself and I can't get out

===== uml-log end =====

... and here dead.
Please correct this error.

Thx:
Kurucz "The NeverGone" Istvan :)

==============================================================
 --------- Csatlakozz:  http://arenaportal.hix.com/ ---------
 ----- http://arenazo.cjb.net/ -- http://ironiq.hu/aDP/ -----
 --- Kurucz "The NeverGone" Istvan:  never@delfin.klte.hu ---
 -------------- http://delfin.klte.hu/~ki0029/ --------------
==============================================================

