Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWDQVMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWDQVMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 17:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWDQVMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 17:12:39 -0400
Received: from ns2.suse.de ([195.135.220.15]:64201 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751297AbWDQVMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 17:12:39 -0400
Date: Mon, 17 Apr 2006 14:11:28 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.6
Message-ID: <20060417211128.GA6861@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.6 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.5 and 2.6.16.6, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                        |    2 
 arch/alpha/kernel/setup.c       |   17 ++
 arch/alpha/kernel/smp.c         |    8 -
 arch/m32r/kernel/m32r_ksyms.c   |    4 
 arch/m32r/kernel/setup.c        |   12 -
 arch/m32r/kernel/smpboot.c      |   19 +-
 arch/m32r/lib/Makefile          |    4 
 arch/m32r/lib/getuser.S         |   88 -------------
 arch/m32r/lib/putuser.S         |   84 ------------
 arch/powerpc/kernel/setup_64.c  |   10 -
 arch/powerpc/kernel/signal_64.c |    2 
 drivers/block/cciss.c           |   96 +++++++-------
 drivers/char/tlclk.c            |   36 ++---
 drivers/edac/Kconfig            |    2 
 drivers/net/sky2.c              |    4 
 drivers/net/sky2.h              |    1 
 drivers/usb/serial/console.c    |    2 
 drivers/usb/storage/Kconfig     |    3 
 fs/cifs/cifsencrypt.c           |   36 +++--
 fs/ext3/resize.c                |    1 
 fs/fuse/file.c                  |    8 -
 fs/partitions/check.c           |    5 
 fs/xfs/linux-2.6/xfs_iops.c     |    3 
 include/asm-m32r/smp.h          |    3 
 include/asm-m32r/uaccess.h      |  266 +++++++++++++++++-----------------------
 include/linux/mm.h              |    5 
 include/linux/page-flags.h      |    8 +
 include/net/ip.h                |    1 
 ipc/shm.c                       |    2 
 kernel/power/process.c          |    3 
 kernel/ptrace.c                 |    7 -
 kernel/signal.c                 |    5 
 kernel/sys.c                    |   14 +-
 mm/page_alloc.c                 |   31 ++--
 net/atm/clip.c                  |   42 ++++--
 net/bridge/br_netfilter.c       |   13 +
 net/ipv4/ip_output.c            |    6 
 37 files changed, 360 insertions(+), 493 deletions(-)

Summary of changes from v2.6.16.5 to v2.6.16.6
==============================================

Ananiev, Leonid I:
      ext3: Fix missed mutex unlock

Andrew Morton:
      RLIMIT_CPU: fix handling of a zero limit

Brian Uhrain says:
      alpha: SMP boot fixes

Greg Kroah-Hartman:
      Linux 2.6.16.6

Hirokazu Takata:
      m32r: security fix of {get, put}_user macros
      m32r: Fix cpu_possible_map and cpu_present_map initialization for SMP kernel

Hugh Dickins:
      shmat: stop mprotect from giving write permission to a readonly attachment (CVE-2006-1524)

Laurent MEYER:
      powerpc: fix incorrect SA_ONSTACK behaviour for 64-bit processes

Mark Bellon:
      MPBL0010 driver sysfs permissions wide open

Mike Miller:
      cciss: bug fix for crash when running hpacucli

Miklos Szeredi:
      fuse: fix oops in fuse_send_readpages()

Nathan Scott:
      Fix utime(2) in the case that no times parameter was passed in.

Nick Piggin:
      Fix buddy list race that could lead to page lru list corruptions

Patrick McHardy:
      NETFILTER: Fix fragmentation issues with bridge netfilter

Paul Fulghum:
      USB: remove __init from usb_console_setup

Pavel Machek:
      Fix suspend with traced tasks

Randy Dunlap:
      isd200: limit to BLK_DEV_IDE
      edac_752x needs CONFIG_HOTPLUG

Roland McGrath:
      fix non-leader exec under ptrace

Stephen Hemminger:
      sky2: bad memory reference on dual port cards
      atm: clip causes unregister hang

Stephen Rothwell:
      powerpc: iSeries needs slb_initialize to be called
      Fix block device symlink name

Steve French:
      Incorrect signature sent on SMB Read

