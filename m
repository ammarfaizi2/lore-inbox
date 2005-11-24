Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbVKXWp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbVKXWp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 17:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbVKXWp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 17:45:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19120 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932660AbVKXWp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 17:45:28 -0500
Date: Thu, 24 Nov 2005 14:45:23 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.14.3
Message-ID: <20051124224523.GT5856@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.14.3 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.14.2 and 2.6.14.3, as it is small enough to do so.

The updated 2.6.14.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.14.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/
 
thanks,
-chris


--------

 Makefile                                     |    2 
 arch/i386/kernel/cpu/mtrr/main.c             |    8 +++
 arch/ppc64/Kconfig                           |   11 +---
 arch/x86_64/kernel/setup.c                   |    5 ++
 drivers/block/pktcdvd.c                      |    2 
 drivers/char/rtc.c                           |   65 +++++++++++++++------------
 drivers/hwmon/it87.c                         |    7 ++
 drivers/hwmon/lm78.c                         |    2 
 drivers/hwmon/w83627hf.c                     |    8 ++-
 drivers/isdn/hardware/eicon/os_4bri.c        |    3 -
 drivers/net/wan/hdlc_cisco.c                 |    6 ++
 drivers/net/wan/hdlc_fr.c                    |    4 +
 drivers/net/wan/hdlc_generic.c               |    6 ++
 fs/locks.c                                   |    2 
 include/net/ipv6.h                           |    2 
 kernel/signal.c                              |    2 
 net/ipv4/netfilter/ip_conntrack_ftp.c        |    4 -
 net/ipv4/netfilter/ip_conntrack_irc.c        |    4 -
 net/ipv4/netfilter/ip_conntrack_netlink.c    |    9 ++-
 net/ipv4/netfilter/ip_conntrack_proto_icmp.c |    3 -
 net/ipv4/netfilter/ip_conntrack_proto_tcp.c  |    6 ++
 net/ipv4/netfilter/ip_conntrack_tftp.c       |    4 -
 net/ipv4/netfilter/ip_nat_core.c             |    6 --
 net/ipv4/netfilter/ip_nat_helper_pptp.c      |   28 ++++++++++-
 net/ipv4/netfilter/ip_nat_proto_gre.c        |    4 -
 net/ipv4/netfilter/ip_nat_proto_unknown.c    |    2 
 net/ipv6/datagram.c                          |    2 
 net/ipv6/exthdrs.c                           |   22 ++++++++-
 net/ipv6/ip6_flowlabel.c                     |   12 +---
 net/ipv6/raw.c                               |    4 +
 net/ipv6/udp.c                               |    4 +
 net/netfilter/nf_queue.c                     |    2 
 32 files changed, 177 insertions(+), 74 deletions(-)

Summary of changes from v2.6.14.2 to v2.6.14.3
==============================================

Adrian Bunk:
      drivers/isdn/hardware/eicon/os_4bri.c: correct the xdiLoadFile() signature

Andi Kleen:
      x86_64/i386: Compute correct MTRR mask on early Noconas

Chris Wright:
      Linux 2.6.14.3

Harald Welte:
      PPTP helper: Fix endianness bug in GRE key / CallID NAT
      nf_queue: Fix Ooops when no queue handler registered
      ctnetlink: check if protoinfo is present
      ip_conntrack: fix ftp/irc/tftp helpers on ports >= 32768

J. Bruce Fields:
      VFS: Fix memory leak with file leases

Jean Delvare:
      hwmon: Fix lm78 VID conversion
      hwmon: Fix missing it87 fan div init

Joel Schopp:
      ppc64 memory model depends on NUMA

Krzysztof Halasa:
      Generic HDLC WAN drivers - disable netif_carrier_off()

Krzysztof Piotr Oledzki:
      ctnetlink: Fix oops when no ICMP ID info in message

Oleg Nesterov:
      Don't auto-reap traced children

Peter Osterlund:
      packet writing oops fix

Philip Craig:
      PPTP helper: fix PNS-PAC expectation call id

Rusty Rusty:
      NAT: Fix module refcount dropping too far

Takashi Iwai:
      Fix soft lockup with ALSA rtc-timer

Ville Nuorvala:
      Fix calculation of AH length during filling ancillary data.

Vlad Drukker:
      ip_conntrack TCP: Accept SYN+PUSH like SYN

Yasuyuki Kozakai:
      refcount leak of proto when ctnetlink dumping tuple

YOSHIFUJI Hideaki:
      Fix memory management error during setting up new advapi sockopts.
      Fix sending extension headers before and including routing header.

Yuan Mu:
      hwmon: Fix missing boundary check when setting W83627THF in0 limits
