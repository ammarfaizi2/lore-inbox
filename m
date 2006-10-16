Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161127AbWJPWAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbWJPWAU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbWJPWAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:00:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:22156 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161127AbWJPWAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:00:18 -0400
Date: Mon, 16 Oct 2006 14:57:01 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.17.14
Message-ID: <20061016215701.GA12407@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.17.14 kernel.

Unless something major comes up, this is the last release of the 2.6.17
kernel branch.

I'll also be replying to this message with a copy of the patch between
2.6.17.13 and 2.6.17.14, as it is small enough to do so.

The updated 2.6.17.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                               |    2 -
 arch/sparc64/kernel/time.c             |    2 -
 arch/sparc64/mm/init.c                 |    3 --
 drivers/ide/ide-iops.c                 |    4 ++
 drivers/input/mouse/logips2pp.c        |    3 --
 drivers/media/dvb/dvb-core/dvb_net.c   |    3 +-
 drivers/media/dvb/frontends/cx24123.c  |    4 +-
 drivers/media/video/msp3400-driver.c   |    2 +
 drivers/media/video/msp3400-driver.h   |    1 
 drivers/media/video/msp3400-kthreads.c |    7 ++--
 drivers/mmc/mmc_block.c                |   49 ++-------------------------------
 drivers/net/pcmcia/xirc2ps_cs.c        |   18 +++++++++---
 drivers/pci/quirks.c                   |    1 
 drivers/scsi/ahci.c                    |    6 ++++
 fs/ext3/inode.c                        |    2 -
 fs/lockd/svcsubs.c                     |   15 ++++++----
 fs/nfs/file.c                          |    8 ++++-
 fs/nfs/nfs4proc.c                      |   10 +++---
 fs/sysfs/file.c                        |    5 ---
 include/linux/nfs_fs.h                 |    6 +++-
 include/linux/sunrpc/xprt.h            |    2 -
 net/sched/cls_basic.c                  |    2 -
 22 files changed, 73 insertions(+), 82 deletions(-)

Summary of changes from v2.6.17.13 to v2.6.17.14
================================================

Ang Way Chuang:
      dvb-core: Proper handling ULE SNDU length of 0 (CVE-2006-4623)

Badari Pulavarty:
      ext3 sequential read regression fix

Chuck Lever:
      SUNRPC: avoid choosing an IPMI port for RPC traffic

David Miller:
      PKT_SCHED: cls_basic: Use unsigned int when generating handle

David S. Miller:
      SPARC64: Fix serious bug in sched_clock() on sparc64
      Fix sparc64 ramdisk handling

Greg Kroah-Hartman:
      Linux 2.6.17.14

Hans Verkuil:
      V4L: Fix msp343xG handling regression

Hidetoshi Seto:
      sysfs: remove duplicated dput in sysfs_update_file

Joerg Ahrens:
      xirc2ps_cs: Cannot reset card in atomic context

Linus Torvalds:
      Add PIIX4 APCI quirk for the 440MX chipset too

Michael-Luke Jones:
      Backport: Old IDE, fix SATA detection for cabling

Nikita Danilov:
      NFS: Fix a potential deadlock in nfs_release_page

Pierre Ossman:
      MMC: Always use a sector size of 512 bytes

Roberto Castagnola:
      Input: logips2pp - fix button mapping for MX300

Tejun Heo:
      ahci: do not fail softreset if PHY reports no device

Trond Myklebust:
      LOCKD: Fix a deadlock in nlm_traverse_files()
      NFS: More page cache revalidation fixups

Yeasah Pell:
      DVB: cx24123: fix PLL divisor setup

