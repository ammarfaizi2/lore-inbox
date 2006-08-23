Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbWHWVbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbWHWVbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 17:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWHWVbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 17:31:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:50654 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965212AbWHWVbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 17:31:09 -0400
Date: Wed, 23 Aug 2006 14:31:08 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.17.11
Message-ID: <20060823213108.GA12308@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.17.11 kernel.

I'll also be replying to this message with a copy of the patch between
2.6.17.10 and 2.6.17.11, as it is small enough to do so.

The updated 2.6.17.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                        |    2 -
 arch/ia64/kernel/sys_ia64.c     |   28 +++++++++++++++------------
 arch/sparc/kernel/sys_sparc.c   |   27 ++++++++++++++------------
 arch/sparc64/kernel/sys_sparc.c |   36 +++++++++++++++++++----------------
 drivers/char/tpm/tpm_tis.c      |    1 
 drivers/ieee1394/ohci1394.c     |    4 +--
 drivers/md/dm-mpath.c           |    3 +-
 drivers/md/raid1.c              |    4 ++-
 drivers/net/sky2.c              |    4 +--
 drivers/pci/quirks.c            |    2 -
 drivers/serial/Kconfig          |    1 
 fs/befs/linuxvfs.c              |   11 ++++++++--
 fs/ext3/super.c                 |   40 +++++++++++++++++++++++++++++++++++++++
 include/asm-generic/mman.h      |    6 +++++
 include/asm-ia64/mman.h         |    6 +++++
 include/asm-sparc/mman.h        |    6 +++++
 include/asm-sparc64/mman.h      |    6 +++++
 kernel/timer.c                  |   41 ++++++----------------------------------
 lib/spinlock_debug.c            |   10 +++++----
 mm/mmap.c                       |   13 ++++++++++--
 mm/swapfile.c                   |    3 +-
 net/bridge/netfilter/ebt_ulog.c |    3 ++
 net/core/dst.c                  |    3 --
 net/core/rtnetlink.c            |   15 +++++++++++++-
 net/ipv4/fib_semantics.c        |   12 +++++------
 net/ipv4/netfilter/arp_tables.c |    3 +-
 net/ipv4/netfilter/ip_tables.c  |    3 +-
 net/ipv4/netfilter/ipt_ULOG.c   |    5 ++++
 net/ipv4/route.c                |    2 -
 net/ipx/af_ipx.c                |    3 +-
 net/netfilter/nfnetlink_log.c   |    3 ++
 31 files changed, 202 insertions(+), 104 deletions(-)

Summary of changes from v2.6.17.10 to v2.6.17.11
================================================

Alexey Kuznetsov:
      Fix ipv4 routing locking bug

Andrew Morton:
      disable debugging version of write_lock()

Daniel Ritz:
      PCI: fix ICH6 quirks

Danny Tholen:
      1394: fix for recently added firewire patch that breaks things on ppc

David Miller:
      Fix IFLA_ADDRESS handling

Diego Calleja:
      Fix BeFS slab corruption

Dmitry Mishin:
      Fix timer race in dst GC code

Eric Sandeen:
      Have ext3 reject file handles with bad inode numbers early

Greg Kroah-Hartman:
      Linux 2.6.17.11

Kirill Korotaev:
      Kill HASH_HIGHMEM from route cache hash sizing
      sys_getppid oopses on debug kernel
      IA64: local DoS with corrupted ELFs

Kylene Jo Hall:
      tpm: interrupt clear fix

Mark Huang:
      ulog: fix panic on SMP kernels

Michal Miroslaw:
      dm: BUG/OOPS fix

NeilBrown:
      MD: Fix a potential NULL dereference in md/raid1

Olaf Hering:
      SERIAL: icom: select FW_LOADER

Patrick McHardy:
      ip_tables: fix table locking in ipt_do_table

Rafael J. Wysocki:
      swsusp: Fix swap_type_of

Stephen Hemminger:
      sky2: phy power problem on 88e805x
      ipx: header length validation needed

