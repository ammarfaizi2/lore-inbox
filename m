Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263128AbVHEVWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbVHEVWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbVHEVWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:22:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263122AbVHEVWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:22:20 -0400
Date: Fri, 5 Aug 2005 14:22:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, stable@kernel.org
Subject: Linux 2.6.12.4
Message-ID: <20050805212211.GC7991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.12.4 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.12.3 and 2.6.12.4, as it is small enough to do so.

The updated 2.6.12.y git tree can be found at:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.12.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

----------

 Makefile                                   |    4 ++--
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c |    8 +++++---
 arch/i386/kernel/process.c                 |    2 ++
 arch/x86_64/ia32/syscall32.c               |    7 ++++++-
 drivers/char/rocket.c                      |    3 ++-
 drivers/scsi/qla2xxx/qla_init.c            |    4 +++-
 fs/bio.c                                   |    1 +
 include/linux/skbuff.h                     |    2 +-
 net/8021q/vlan.c                           |    8 ++++++++
 net/ipv4/netfilter/ip_conntrack_core.c     |    3 +++
 net/ipv4/netfilter/ip_nat_proto_tcp.c      |    3 ++-
 net/ipv4/netfilter/ip_nat_proto_udp.c      |    3 ++-
 net/ipv6/netfilter/ip6_queue.c             |    2 ++
 net/xfrm/xfrm_user.c                       |    3 +++
 14 files changed, 42 insertions(+), 11 deletions(-)

Summary of changes from v2.6.12.3 to v2.6.12.4
==============================================

Andrew Morton:
  Fw: bio_clone fix

Andrew Vasquez:
  qla2xxx: Correct handling of fc_remote_port_add() failure case.

Chris Wright:
  Linux 2.6.12.4

Dave Jones:
  Fix powernow oops on dual-core athlon

Herbert Xu:
  Fix possible overflow of sock->sk_policy

Michal Ostrowski:
  rocket.c: Fix ldisc ref count handling

Paolo 'Blaisorblade' Giarrusso:
  sys_get_thread_area does not clear the returned argument

Patrick McHardy:
  Wait until all references to ip_conntrack_untracked are dropped on unload
  Fix potential memory corruption in NAT code (aka memory NAT)
  Fix deadlock in ip6_queue
  Fix signedness issues in net/core/filter.c

Siddha, Suresh B:
  x86_64 memleak from malicious 32bit elf program

Tom Rini:
  kbuild: build TAGS problem with O=

Tommy Christensen:
  Fix early vlan adding leads to not functional device

