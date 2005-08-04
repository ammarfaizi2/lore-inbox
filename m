Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVHDWoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVHDWoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVHDWoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:44:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:58073 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262717AbVHDWoA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:44:00 -0400
Date: Thu, 04 Aug 2005 15:43:58 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc5-git2 on x86_64 slaughters all processes?
Message-ID: <111770000.1123195438@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-git1 works fine, but -git2 fails in a strange way. Only on my AMD64 box,
the other seem fine. Boots all the way up, then seems to slaughter any
userspace process:

------------------------------

EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 236k freed
INIT: version 2.86 booting
VM: killing process rcS
INIT: Entering runlevel: 2
VM: killing process rc
VM: killing process getty
VM: killing process getty
VM: killing process getty
VM: killing process getty
VM: killing process getty
VM: killing process getty
VM: killing process getty

Debian GNU/Linux 3.1 (none) ttyS0

(none) login: -- 0:conmux-control -- time-stamp -- Aug/04/05  2:57:24 --

-----------------------------
full bootlog for -git2 is here:
http://test.kernel.org/9966/debug/console.log

-git1's bootlog looks like this:
http://test.kernel.org/9804/debug/console.log
tail is:

-----------------------------

Freeing unused kernel memory: 236k freed
input: PS/2 Logitech Mouse on isa0060/serio1
INIT: version 2.86 booting
Activating swap.
Adding 12104968k swap on /dev/sdb3.  Priority:-1 extents:1
Checking root file system...
fsck 1.35 (28-Feb-2004)
e2fsck 1.35 (28-Feb-2004)
/dev/shm/root: clean, 268023/977280 files, 1467207/19EXT3 FS on sda1, 53897 blocks
internal journal
System time was Wed Aug  3 09:56:18 UTC 2005.
Setting the System Clock using the Hardware Clock as reference...
System Clock set. System local time is now Wed Aug  3 09:56:20 UTC 2005.
Calculating module dependencies... done.
Loading modules...
    sd_mod
FATAL: Module sd_mod not found.
    ide-cd
FATAL: Module ide_cd not found.
    ide-detect
FATAL: Module ide_detect not found.
All modules loaded.
Checking all file systems...
fsck 1.35 (28-Feb-2004)
Setting kernel variables ...
... done.
Mounting local filesystems...
Cleaning /tmp /var/run /var/lock.
Running 0dns-down to make sure resolv.conf is ok...done.
Cleaning: /etc/network/ifstate.
Kernel hotplug support not enabled.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces...done.
Starting portmap daemon: portmap.
Loading the saved-state of the serial devices... 
/dev/ttyS0 at 0x03f8 (irq = 4) is a 16550A

Setting the System Clock using the Hardware Clock as reference...
System Clock set. Local time: Wed Aug  3 02:56:22 PDT 2005

Running ntpdate to synchronize clocktg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
.
Initializing random number generator...done.
Recovering nvi editor sessions... done.
Setting up X server socket directory /tmp/.X11-unix...done.
Setting up ICE socket directory /tmp/.ICE-unix...done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting portmap daemon: portmap.
Starting MTA: exim4.
Starting file alteration monitor: FAM.
Starting internet superserver: inetd.
Starting printer spooler: lpd .
Starting OpenBSD Secure Shell server: sshd.
Setting up X font server socket directory /tmp/.font-unix...done.
Starting X font server: xfs.
Starting Xprint servers: Xprt.
Starting NFS common utilities: statd.
Starting NTP server: ntpd.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.
Starting GNOME Display Manager: gdm.
Starting staf: staf.
Not starting X display manager (xdm); it is not the default display manager.
XFree86: vm86 mode not supported on 64 bit kernel
mtrr: type mismatch for e5000000,400000 old: write-back new: write-combining

Debian GNU/Linux 3.1 elm3b6 ttyS0

elm3b6 login: -- 0:conmux-control -- time-stamp -- Aug/03/05  2:58:57 --

