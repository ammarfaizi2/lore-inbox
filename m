Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWC1H5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWC1H5l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 02:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWC1H5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 02:57:40 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:64672
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751363AbWC1H5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 02:57:40 -0500
Date: Mon, 27 Mar 2006 23:56:29 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.1
Message-ID: <20060328075629.GA8083@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.1 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16 and 2.6.16.1, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                                     |    2 -
 arch/i386/kernel/cpu/cpufreq/speedstep-smi.c |    4 +-
 arch/i386/kernel/dmi_scan.c                  |    2 -
 drivers/base/cpu.c                           |    2 -
 drivers/base/firmware_class.c                |    6 ++-
 drivers/block/cciss.c                        |    2 -
 drivers/md/dm.c                              |   45 +++++++++++++++------------
 drivers/media/video/Kconfig                  |    1 
 drivers/media/video/tuner-types.c            |    4 +-
 drivers/scsi/sata_mv.c                       |    7 +++-
 drivers/video/i810/i810_main.c               |    2 -
 fs/9p/vfs_inode.c                            |    3 -
 fs/proc/proc_misc.c                          |    2 -
 fs/sysfs/dir.c                               |    1 
 fs/sysfs/inode.c                             |    6 +++
 fs/sysfs/symlink.c                           |    1 
 fs/xfs/linux-2.6/xfs_aops.c                  |    2 -
 include/linux/cpu.h                          |    2 -
 include/linux/raid/raid1.h                   |    2 -
 include/linux/rtc.h                          |    4 +-
 kernel/sched.c                               |    9 ++++-
 net/core/sock.c                              |    5 +--
 net/ipv4/ip_output.c                         |    6 ---
 23 files changed, 70 insertions(+), 50 deletions(-)

Summary of changes from v2.6.16 to v2.6.16.1
============================================

Alasdair G Kergon:
      dm: bio split bvec fix

Alexey Kuznetsov:
      TCP: Do not use inet->id of global tcp_socket when sending RST (CVE-2006-1242)

Andrew Morton:
      get_cpu_sysdev() signedness fix
      Fix speedstep-smi assembly bug in speedstep_smi_ownership

Andrey Panin:
      DMI: fix DMI onboard device discovery

Anton Blanchard:
      fix scheduler deadlock

Antonino A. Daplas:
      i810fb_cursor(): use GFP_ATOMIC

David S. Miller:
      NET: Ensure device name passed to SO_BINDTODEVICE is NULL terminated.

Greg Kroah-Hartman:
      sysfs: sysfs_remove_dir() needs to invalidate the dentry
      sysfs: fix a kobject leak in sysfs_add_link on the error path
      Linux 2.6.16.1

Hans Verkuil:
      V4L/DVB (3324): Fix Samsung tuner frequency ranges

Jeff Garzik:
      sata_mv: fix irq port status usage

Jeff Moyer:
      firmware: fix BUG: in fw_realloc_buffer

Joe Korty:
      rtc.h broke strace(1) builds

Latchesar Ionkov:
      v9fs: assign dentry ops to negative dentries

Mark Lord:
      2.6.xx: sata_mv: another critical fix

Michael Krufky:
      Kconfig: VIDEO_DECODER must select FW_LOADER

Nathan Scott:
      XFS writeout fix

Neil Brown:
      DM: Fix bug: BIO_RW_BARRIER requests to md/raid1 hang.

Neil Horman:
      proc: fix duplicate line in /proc/devices

Patrick McHardy:
      cciss: fix use-after-free in cciss_init_one

