Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWETXGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWETXGx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 19:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWETXGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 19:06:53 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:6531 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964802AbWETXGw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 19:06:52 -0400
Date: Sat, 20 May 2006 16:09:13 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.17
Message-ID: <20060520230912.GJ23243@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.17
kernel.  Couple security relevant patches in there, the SCTP patches
came in post review cycle.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.16 and 2.6.16.17, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile                        |    2 -
 block/elevator.c                |    8 ++++-
 block/ll_rw_blk.c               |   17 ++++++++++-
 drivers/block/ub.c              |   18 ++++++------
 drivers/char/pcmcia/cm4000_cs.c |   10 ++++--
 drivers/char/pcmcia/cm4040_cs.c |   11 ++++---
 drivers/i2c/busses/scx200_acb.c |    4 --
 drivers/md/raid10.c             |    2 -
 drivers/net/tg3.c               |    8 +++--
 drivers/net/via-rhine.c         |    6 ++++
 drivers/pci/pci-acpi.c          |   60 +++++++++++++++++++++++-----------------
 drivers/pci/quirks.c            |   22 ++++++++++++--
 fs/compat.c                     |    2 -
 fs/locks.c                      |   30 ++++++++++----------
 fs/smbfs/request.c              |    4 ++
 include/net/sctp/sctp.h         |    6 ++--
 kernel/ptrace.c                 |   57 ++++++++++++++++++++++++++------------
 mm/mempolicy.c                  |    1 
 mm/shmem.c                      |    1 
 mm/vmscan.c                     |   11 +++++++
 net/ipv4/netfilter/arp_tables.c |    2 -
 net/ipv4/netfilter/ip_tables.c  |    2 -
 net/ipv6/netfilter/ip6_tables.c |    2 -
 net/sctp/sm_statefuns.c         |    6 ++++
 security/selinux/ss/services.c  |    4 ++
 25 files changed, 200 insertions(+), 96 deletions(-)

Summary of changes from v2.6.16.16 to v2.6.16.17
================================================

Alexey Dobriyan:
      fs/compat.c: fix 'if (a |= b )' typo

Carl-Daniel Hailfinger:
      smbus unhiding kills thermal management

Chris Wedgwood:
      PCI quirk: VIA IRQ fixup should only run for VIA southbridges
      VIA quirk fixup, additional PCI IDs

Chris Wright:
      Netfilter: do_add_counters race, possible oops or info leak (CVE-2006-0039)
      Linux 2.6.16.17

Christoph Lameter:
      Remove cond_resched in gather_stats()
      page migration: Fix fallback behavior for dirty pages

Craig Brind:
      via-rhine: zero pad short packets on Rhine I ethernet cards

Harald Welte:
      Fix udev device creation

Jan Niehusmann:
      smbfs: Fix slab corruption in samba error path

Jean Delvare:
      scx200_acb: Fix resource name use after free

Jens Axboe:
      limit request_fn recursion

Karsten Keil:
      TG3: ethtool always report port is TP.

Kristen Accardi:
      PCI: correctly allocate return buffers for osc calls

Lee Schermerhorn:
      add migratepage address space op to shmem

Linus Torvalds:
      Fix ptrace_attach()/ptrace_traceme()/de_thread() race
      ptrace_attach: fix possible deadlock schenario with irqs

NeilBrown:
      md: Avoid oops when attempting to fix read errors on raid10

Pete Zaitcev:
      USB: ub oops in block_uevent

Serge E. Hallyn:
      selinux: check for failed kmalloc in security_sid_to_context()

Trond Myklebust:
      fs/locks.c: Fix sys_flock() race

Vladislav Yasevich:
      SCTP: Respect the real chunk length when walking parameters (CVE-2006-1858)
      SCTP: Validate the parameter length in HB-ACK chunk (CVE-2006-1857)

