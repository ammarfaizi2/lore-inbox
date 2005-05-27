Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVE0QEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVE0QEy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 12:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVE0QEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 12:04:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:13712 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262475AbVE0QEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 12:04:42 -0400
Date: Fri, 27 May 2005 09:04:37 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Linux 2.6.11.11
Message-ID: <20050527160437.GL23013@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.11.11 kernel.

The diffstat and short summary of the fixes are below.  

I'll also be replying to this message with a copy of the patch between
2.6.11.10 and 2.6.11.11, as it is small enough to do so.

The updated 2.6.11.y git tree can be found at: 
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.11.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

----------

 Makefile                              |    2 -
 arch/ppc64/kernel/pSeries_iommu.c     |   55 +++++++++++++++++++++++++++++++
 arch/x86_64/kernel/ptrace.c           |   13 +++++--
 arch/x86_64/mm/fault.c                |   11 +++++-
 arch/x86_64/mm/ioremap.c              |    2 -
 drivers/ide/ide-disk.c                |    4 +-
 drivers/net/3c59x.c                   |    9 +++--
 drivers/usb/serial/visor.c            |   38 +++++++++++++++------
 drivers/video/matrox/matroxfb_accel.c |   14 ++++++--
 drivers/video/matrox/matroxfb_base.h  |    4 +-
 fs/ext3/balloc.c                      |    3 +
 include/asm-x86_64/processor.h        |    4 +-
 include/linux/err.h                   |    4 +-
 mm/mmap.c                             |   59 +++++++++++++++++-----------------
 net/bridge/netfilter/ebtables.c       |    3 +
 net/rose/rose_route.c                 |    3 +
 sound/usb/usbaudio.c                  |    2 -
 sound/usb/usx2y/usbusx2y.c            |   11 ++++--
 18 files changed, 173 insertions(+), 68 deletions(-)

Summary of changes from v2.6.11.10 to v2.6.11.11
==============================================

Andi Kleen:
  o x86_64: Don't look up struct page pointer of physical address in iounmap
  o x86_64: When checking vmalloc mappings don't use pte_page
  o x86_64: Add a guard page at the end of the 47bit address space
  o x86_64: Fix canonical checking for segment registers in ptrace
  o x86_64: check if ptrace RIP is canonical

Bart De Schuymer:
  o Fix smp race

Bartlomiej Zolnierkiewicz:
  o ide-disk: Fix LBA8 DMA

Chris Wright:
  o Linux 2.6.11.11

Daniel Ritz:
  o 3c59x: only put the device into D3 when we're actually using WOL

Greg Kroah-Hartman:
  o USB: fix bug in visor driver with throttle/unthrottle causing oopses

Gregor Jasny:
  o usbusx2y: prevent oops & dead keyboard on usb unplugging while the device is being used
  o usbaudio: prevent oops & dead keyboard on usb unplugging while the device is being used

Linus Torvalds:
  o Fix get_unmapped_area sanity tests

Mingming Cao:
  o ext3: fix race between ext3 make block reservation and reservation window discard

Olof Johansson:
  o PPC64: Fix LPAR IOMMU setup code for p630

Petr Vandrovec:
  o Fix matroxfb on big-endian hardware

Ralf Bächle:
  o Fix minor security hole
