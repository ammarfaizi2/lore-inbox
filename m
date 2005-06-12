Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVFLG1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVFLG1k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 02:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVFLGZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 02:25:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261478AbVFLFjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 01:39:44 -0400
Date: Sat, 11 Jun 2005 22:39:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Linux 2.6.11.12
Message-ID: <20050612053939.GJ9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.11.12 kernel.

The diffstat and short summary of the fixes are below.  

I'll also be replying to this message with a copy of the patch between
2.6.11.11 and 2.6.11.12, as it is small enough to do so.

The updated 2.6.11.y git tree can be found at: 
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.11.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

----------

 Makefile                         |    2 +-
 arch/x86_64/kernel/apic.c        |    2 --
 arch/x86_64/kernel/ptrace.c      |    4 ++--
 arch/x86_64/kernel/smpboot.c     |    4 ----
 drivers/media/video/bttv-cards.c |    1 -
 fs/hfs/mdb.c                     |    5 +++++
 fs/hfs/super.c                   |    8 +++-----
 fs/hfsplus/super.c               |    6 +++++-
 fs/jbd/checkpoint.c              |    4 +++-
 mm/rmap.c                        |    6 +++---
 net/bridge/br_input.c            |    6 ++++--
 net/bridge/br_stp_bpdu.c         |    3 +++
 net/ipv4/netfilter/ip_queue.c    |   10 ++++++++++
 net/sched/sch_netem.c            |   13 +++++++++----
 14 files changed, 48 insertions(+), 26 deletions(-)

Summary of changes from v2.6.11.11 to v2.6.11.12
==============================================

Andi Kleen:
  x86_64: Fix ptrace boundary check
  x86_64: avoid SMP boot up race

Chris Wright:
  Linux 2.6.11.12

Colin Leroy:
  fix hfsplus oops, hfs and hfsplus leak

Harald Welte:
  Fix deadlock with ip_queue and tcp local input path.

Jan Kara:
  ext3: fix log_do_checkpoint() assertion failure

Pete Jewell:
  Fix for bttv driver (v0.9.15) for Leadtek WinFast VC100 XP capture cards

Stephen Hemminger:
  netem: duplication fix
  prevent bad forwarding table updates

William Lee Irwin III:
  try_to_unmap_cluster() passes out-of-bounds pte to pte_unmap()
