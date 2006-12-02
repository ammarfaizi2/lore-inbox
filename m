Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162439AbWLBAsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162439AbWLBAsI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 19:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162441AbWLBAsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 19:48:08 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47768 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162439AbWLBAsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 19:48:04 -0500
Date: Fri, 1 Dec 2006 16:51:18 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.18.5
Message-ID: <20061202005118.GF1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.18.5 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.18.4 and 2.6.18.5, as it is small enough to do so.
                                                                                
The updated 2.6.18.y git tree can be found at:                                  
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y.git 
and can be browsed at the normal kernel.org git web browser:                    
        www.kernel.org/git/                                                     

thanks,
-chris

--------

 Makefile                                      |    2 
 arch/alpha/Kconfig                            |    2 
 arch/i386/kernel/microcode.c                  |    9 --
 arch/ia64/sn/kernel/bte.c                     |    9 +-
 block/scsi_ioctl.c                            |    3 
 drivers/char/agp/generic.c                    |    2 
 drivers/char/agp/intel-agp.c                  |    2 
 drivers/media/Kconfig                         |    1 
 drivers/net/tg3.c                             |    4 -
 drivers/net/wireless/bcm43xx/bcm43xx_main.c   |   18 ++++
 drivers/pcmcia/ds.c                           |    5 +
 drivers/scsi/scsi_lib.c                       |    1 
 fs/fuse/dir.c                                 |   52 +++++++++----
 include/linux/netfilter_ipv4.h                |    2 
 net/bluetooth/hci_sock.c                      |   11 +-
 net/dccp/ipv6.c                               |    2 
 net/ieee80211/softmac/ieee80211softmac_io.c   |    2 
 net/ipv4/ipvs/ip_vs_core.c                    |   10 ++
 net/ipv4/netfilter.c                          |    9 +-
 net/ipv4/netfilter/arp_tables.c               |   39 ++++++---
 net/ipv4/netfilter/ip_conntrack_helper_h323.c |    4 -
 net/ipv4/netfilter/ip_nat_standalone.c        |    3 
 net/ipv4/netfilter/ip_tables.c                |  103 +++++++++++++-------------
 net/ipv4/netfilter/iptable_mangle.c           |    3 
 net/ipv4/udp.c                                |   19 +++-
 net/ipv6/netfilter/ip6_tables.c               |   53 ++++++-------
 net/ipv6/udp.c                                |    7 -
 net/netfilter/Kconfig                         |    6 +
 28 files changed, 231 insertions(+), 152 deletions(-)

Summary of changes from v2.6.18.4 to v2.6.18.5
============================================

Chris Wright:
      Linux 2.6.18.5

Daniel Ritz:
      pcmcia: fix 'rmmod pcmcia' with unbound devices

David S. Miller:
      BLUETOOTH: Fix unaligned access in hci_send_to_sock.

Fernando J. Pereda:
      alpha: Fix ALPHA_EV56 dependencies typo

Ira W. Snyder:
      TG3: Add missing unlock in tg3_open() error path.

Laurent Riffard:
      softmac: fix a slab corruption in WEP restricted key association

Linus Torvalds:
      AGP: Allocate AGP pages with GFP_DMA32 by default

Maciej W. Rozycki:
      V4L: Do not enable VIDEO_V4L2 unconditionally

Michael Buesch:
      bcm43xx: Drain TX status before starting IRQs

Miklos Szeredi:
      fuse: fix Oops in lookup

Olaf Kirch:
      UDP: Make udp_encap_rcv use pskb_may_pull

Patrick McHardy:
      NETFILTER: Missing check for CAP_NET_ADMIN in iptables compat layer
      NETFILTER: ip_tables: compat error way cleanup
      NETFILTER: ip_tables: fix module refcount leaks in compat error paths
      NETFILTER: Missed and reordered checks in {arp,ip,ip6}_tables
      NETFILTER: arp_tables: missing unregistration on module unload
      NETFILTER: Honour source routing for LVS-NAT
      NETFILTER: Kconfig: fix xt_physdev dependencies
      NETFILTER: xt_CONNSECMARK: fix Kconfig dependencies
      NETFILTER: H.323 conntrack: fix crash with CONFIG_IP_NF_CT_ACCT

Robin Holt:
      IA64: bte_unaligned_copy() transfers one extra cache line.

Shaohua Li:
      x86 microcode: don't check the size

Tejun Heo:
      scsi: clear garbage after CDBs on SG_IO

YOSHIFUJI Hideaki:
      IPV6: Fix address/interface handling in UDP and DCCP, according to the scoping architecture.

