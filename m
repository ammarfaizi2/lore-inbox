Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWEAToU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWEAToU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWEAToT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:44:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:10902 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932205AbWEAToT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:44:19 -0400
Date: Mon, 1 May 2006 12:42:47 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.12
Message-ID: <20060501194247.GA17240@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.12
kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.11 and 2.6.16.12, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Documentation/dvb/get_dvb_firmware |    8 -
 Makefile                           |    2 
 arch/alpha/lib/strncpy.S           |    8 -
 arch/i386/kernel/vm86.c            |   12 ++
 arch/mips/kernel/branch.c          |    2 
 arch/mips/mm/c-r4k.c               |    3 
 arch/x86_64/ia32/Makefile          |    4 
 arch/x86_64/kernel/pci-gart.c      |    4 
 block/genhd.c                      |  103 ++---------------------
 drivers/char/cs5535_gpio.c         |    5 -
 drivers/char/snsc.c                |    3 
 drivers/char/sonypi.c              |    3 
 drivers/char/tipar.c               |    2 
 drivers/md/dm-snap.c               |    6 +
 drivers/md/dm.c                    |    5 -
 drivers/md/kcopyd.c                |   17 +++
 drivers/media/dvb/dvb-usb/cxusb.c  |   17 ++-
 drivers/media/video/saa7127.c      |    1 
 drivers/net/e1000/e1000_main.c     |    1 
 drivers/usb/serial/option.c        |    4 
 fs/char_dev.c                      |   87 ++-----------------
 fs/compat.c                        |    4 
 fs/proc/proc_misc.c                |  163 ++++++++-----------------------------
 fs/reiserfs/xattr_acl.c            |    5 -
 include/asm-i386/i387.h            |    4 
 include/asm-i386/pgtable-2level.h  |    3 
 include/asm-i386/pgtable-3level.h  |   20 ++++
 include/asm-i386/pgtable.h         |    4 
 include/asm-mips/bitops.h          |   14 ++-
 include/asm-mips/byteorder.h       |    4 
 include/asm-mips/interrupt.h       |    8 +
 include/asm-mips/r4kcache.h        |    2 
 include/linux/cpumask.h            |    1 
 include/linux/fs.h                 |   15 ---
 kernel/auditsc.c                   |    5 -
 35 files changed, 196 insertions(+), 353 deletions(-)

Summary of changes from v2.6.16.11 to v2.6.16.12
================================================

Alasdair G Kergon:
      dm snapshot: fix kcopyd destructor

Andi Kleen:
      x86_64: Pass -32 to the assembler when compiling the 32bit vsyscall pages

Andrew Morton:
      for_each_possible_cpu
      Simplify proc/devices and fix early termination regression

Arnaud MAZIN:
      sonypi: correct detection of new ICH7-based laptops

Atsushi Nemoto:
      MIPS: Fix tx49_blast_icache32_page_indexed.

Auke Kok:
      NET: e1000: Update truesize with the length of the packet for packet split

Chuck Ebbert:
      i386: fix broken FP exception handling

Daniel Drake:
      tipar oops fix

Eric Sesterhenn:
      USB: fix array overrun in drivers/usb/serial/option.c

Greg Howard:
      Altix snsc: duplicate kobject fix

Greg Kroah-Hartman:
      Linux 2.6.16.12

Ivan Kokshaysky:
      Alpha: strncpy() fix

James Morris:
      LSM: add missing hook to do_compat_readv_writev()

Jan Kara:
      Fix reiserfs deadlock

Jason Baron:
      make vm86 call audit_syscall_exit

Jose Alberto Reguero:
      fix saa7129 support in saa7127 module for pvr350 tv out

Jun'ichi Nomura:
      dm flush queue EINTR

Michael Krufky:
      get_dvb_firmware: download nxt2002 firmware from new driver location
      cxusb-bluebird: bug-fix: power down corrupts frontend

Mike Waychison:
      x86_64: Fix a race in the free_iommu path.

Ralf Baechle:
      MIPS: Use "R" constraint for cache_op.
      MIPS: R2 build fixes for gcc < 3.4.

Thayumanavar Sachithanantham:
      cs5535_gpio.c: call cdev_del() during module_exit to unmap kobject references and other cleanups

Win Treese:
      MIPS: Fix branch emulation for floating-point exceptions.

Zachary Amsden:
      x86/PAE: Fix pte_clear for the >4GB RAM case

