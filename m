Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265963AbUAKTc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 14:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUAKTc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 14:32:28 -0500
Received: from gprs30.vodafone.hu ([80.244.97.80]:11888 "EHLO kian.localdomain")
	by vger.kernel.org with ESMTP id S265963AbUAKTcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 14:32:22 -0500
Subject: 2.6 and UML
From: Krisztian VASAS <iron@ironiq.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1073849631.1233.8.camel@kian.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 20:33:51 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all!

Is there any way to get work the 2.6 kernel with UML?


With 2.4.24 and all of the 2.4 kernels UML works, but with all of the
new 2.6 kernels it doesn not...


Here is the output with 2.6.1-mm2 and 2.4.24

===== Kernel: 2.6.1-mm2 =====

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
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
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


===== Kernel: 2.4.24 =====

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
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
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
 
modprobe: Can't open dependencies file
/lib/modules/2.4.23-1um/modules.dep (No such file or directory)
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
Deconfiguring network interfaces: eth0: unknown interface: No such
device
done.
Deactivating swap... done.
Unmounting local filesystems... done.
Power down.


IroNiQ
p.s.: please cc to me, because I'm not member...
-- 
Web: http://ironiq.hu
Email: iron@ironiq.hu
LinuxCounter: #331532

