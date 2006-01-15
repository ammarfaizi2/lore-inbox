Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751873AbWAOHAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbWAOHAh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 02:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbWAOHAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 02:00:37 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51842 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751873AbWAOHAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 02:00:36 -0500
Date: Sat, 14 Jan 2006 23:04:40 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.15.1
Message-ID: <20060115070440.GH3335@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.15.1 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.15 and 2.6.15.1, as it is small enough to do so.

The updated 2.6.15.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.15.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile                                |    2 
 arch/ppc/boot/simple/Makefile           |    2 
 arch/sparc64/Kconfig                    |    2 
 arch/sparc64/kernel/entry.S             |    7 --
 arch/sparc64/kernel/systbls.S           |    2 
 drivers/char/moxa.c                     |    2 
 drivers/net/skge.c                      |   80 +++++++++++++++++++-------------
 drivers/video/aty/atyfb_base.c          |    2 
 drivers/video/console/vgacon.c          |    8 ++-
 fs/ufs/super.c                          |    4 +
 kernel/workqueue.c                      |   16 ++++--
 net/bridge/br_stp_if.c                  |    2 
 net/bridge/netfilter/ebt_ip.c           |    3 +
 net/core/net-sysfs.c                    |   28 +++++++----
 net/ipv4/netfilter/ip_nat_helper_pptp.c |   59 +++++++++++------------
 net/netlink/af_netlink.c                |    4 -
 16 files changed, 131 insertions(+), 92 deletions(-)

Summary of changes from v2.6.15 to v2.6.15.1
==============================================

Adrian Bunk:
      arch/sparc64/Kconfig: fix HUGETLB_PAGE_SIZE_64K dependencies

Alan Cox:
      moxa serial: add proper capability check

Andrey Borzenkov:
      fix /sys/class/net/<if>/wireless without dev->get_wireless_stats

Bart De Schuymer:
      Don't match tcp/udp source/destination port for IP fragments

Chris Wright:
      Linux 2.6.15.1

David S. Miller:
      Fix sys_fstat64() entry in 64-bit syscall table.

Evgeniy Polyakov:
      UFS: inode->i_sem is not released in error path

Kirill Korotaev:
      netlink oops fix due to incorrect error code

Luis F. Ortiz:
      Fix onboard video on SPARC Blade 100 for 2.6.{13,14,15}

Martin Murray:
      Fix DoS in netlink_rcv_skb() (CVE-2006-0035)

Nathan Lynch:
      fix workqueue oops during cpu offline

Patrick McHardy:
      Fix crash in ip_nat_pptp (CVE-2006-0036)
      Fix another crash in ip_nat_pptp (CVE-2006-0037)

Peter Korsgaard:
      ppc32: Re-add embed_config.c to ml300/ep405

Richard Mortimer:
      Fix ptrace/strace

Samuel Thibault:
      vgacon: fix doublescan mode

Stephen Hemminger:
      BRIDGE: Fix faulty check in br_stp_recalculate_bridge_id()
      skge: handle out of memory on ring changes

