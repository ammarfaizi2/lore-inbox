Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWIHWHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWIHWHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWIHWHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:07:52 -0400
Received: from ns2.suse.de ([195.135.220.15]:27858 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751087AbWIHWHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:07:51 -0400
Date: Fri, 8 Sep 2006 15:07:41 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.17.12
Message-ID: <20060908220741.GA26950@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.17.12 kernel.

I'll also be replying to this message with a copy of the patch between
2.6.17.11 and 2.6.17.12, as it is small enough to do so.

The updated 2.6.17.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                            |    2 
 arch/ia64/sn/kernel/xpc_channel.c   |    4 -
 arch/ia64/sn/kernel/xpc_main.c      |   28 +++++----
 arch/ia64/sn/kernel/xpc_partition.c |   24 ++------
 arch/sparc64/mm/generic.c           |    2 
 drivers/ide/pci/via82cxxx.c         |    3 -
 drivers/md/dm-exception-store.c     |   65 ++++++++++++++---------
 drivers/md/dm-ioctl.c               |   34 ++++++++----
 drivers/md/dm-raid1.c               |   67 ++++++++++++-----------
 drivers/md/dm-snap.c                |    6 +-
 drivers/md/dm.c                     |  101 +++++++++++++++++++++++++-----------
 drivers/net/sky2.c                  |  101 +++++++++++++++++++++---------------
 drivers/net/sky2.h                  |   17 +++++-
 drivers/net/tg3.c                   |   12 ++--
 drivers/net/tg3.h                   |    1 
 drivers/net/wireless/spectrum_cs.c  |    2 
 drivers/usb/host/uhci-q.c           |    2 
 fs/binfmt_elf.c                     |   15 ++---
 fs/ext2/super.c                     |   41 ++++++++++++++
 fs/locks.c                          |    6 +-
 include/asm-ia64/mman.h             |    2 
 include/asm-ia64/sn/xp.h            |   22 ++++++-
 include/asm-ia64/sn/xpc.h           |    4 +
 include/linux/netfilter_bridge.h    |   16 ++++-
 include/linux/skbuff.h              |   15 +++++
 kernel/futex.c                      |    1 
 kernel/stop_machine.c               |    1 
 lib/ts_bm.c                         |   11 +--
 net/bridge/br_forward.c             |   10 ++-
 net/core/pktgen.c                   |    4 +
 net/ipv4/ip_output.c                |    4 -
 net/ipv4/tcp_output.c               |    1 
 net/ipv6/exthdrs.c                  |   29 +++++-----
 net/ipv6/ip6_output.c               |    2 
 net/sctp/socket.c                   |   10 ++-
 35 files changed, 437 insertions(+), 228 deletions(-)


Summary of changes from v2.6.17.11 to v2.6.17.12
================================================

Alan Cox:
      Missing PCI id update for VIA IDE

Alan Stern:
      uhci-hcd: fix list access bug

Alasdair G Kergon:
      dm snapshot: unify chunk_size

Chen-Li Tien:
      PKTGEN: Fix oops when used with balance-tlb bonding

Christian Borntraeger:
      bug in futex unqueue_me

Daniel Kobras:
      dm: Fix deadlock under high i/o load in raid1 setup.

David S. Miller:
      SPARC64: Fix X server crashes on sparc64
      PKTGEN: Make sure skb->{nh,h} are initialized in fill_packet_ipv6() too.

Ernie Petrides:
      binfmt_elf: fix checks for bad address

Fernando Vazquez:
      fix compilation error on IA64

Greg Kroah-Hartman:
      Linux 2.6.17.12

Herbert Xu:
      Fix output framentation of paged-skbs

Jeff Mahoney:
      dm: fix idr minor allocation
      dm: move idr_pre_get
      dm: change minor_lock to spinlock
      dm: add DMF_FREEING
      dm: fix mapped device ref counting
      dm: add module ref counting
      dm: fix block device initialisation

Michael Chan:
      TG3: Disable TSO by default

Michael Rash:
      TEXTSEARCH: Fix Boyer Moore initialization bug

Neil Brown:
      Have ext2 reject file handles with bad inode numbers early.
      dm: mirror sector offset fix

Richard Purdie:
      spectrum_cs: Fix firmware uploading errors

Robin Holt:
      Silent data corruption caused by XPC

Sridhar Samudrala:
      SCTP: Fix sctp_primitive_ABORT() call in sctp_close().

Stephen Hemminger:
      bridge-netfilter: don't overwrite memory outside of skb
      Allow per-route window scale limiting
      sky2: accept flow control
      sky2: clear status IRQ after empty
      sky2: use dev_alloc_skb for receive buffers
      sky2: MSI test timing
      sky2: fix fiber support
      sky2: version 1.6.1

Trond Myklebust:
      fcntl(F_SETSIG) fix

Yingchao Zhou:
      Remove redundant up() in stop_machine()

YOSHIFUJI Hideaki:
      IPV6 OOPS'er triggerable by any user

