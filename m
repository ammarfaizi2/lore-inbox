Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbUKFQSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbUKFQSs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 11:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbUKFQSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 11:18:48 -0500
Received: from jade.aracnet.com ([216.99.193.136]:64164 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261413AbUKFQSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 11:18:43 -0500
Date: Sat, 06 Nov 2004 08:18:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.9-mjb1
Message-ID: <214010000.1099757914@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset is meant to be pretty stable, not so much a testing ground.

1. Better performance & resource consumption, particularly on larger machines.
2. Diagnosis tools (kgdb, early_printk, etc).

I'd be very interested in feedback from anyone willing to test on any 
platform, however large or small.

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.9/patch-2.6.9-mjb1.bz2

Pending:

config_page_offset
per_node_rss
local_balance_exec
reluctance in cross-node balance (less_bouncy)
sched tunables patch
Child runs first (akpm)
Netdump

Present in this patch:

-mjb						Martin J. Bligh
	Add a tag to the makefile

kgdb						Various
	Stolen from akpm's 2.6.9-mm1, includes fixes

kgdboe_netpoll					Matt Mackall et al.
	Kgdb over ethernet support that works with the netpoll infrastructure

kgdb_x86_64_support				Jim Houston
	Support kgdb on x86_64

kgdb_ia64_support				Robert Picco
	Support kgdb on ia64

ppc64_reloc_hide				Anton Blanchard / Paul Mackerras
	PPC 64 fixups

confighz					Andrew Morton / Dave Hansen
	Make HZ a config option of 100 Hz or 1000 Hz

numameminfo					Martin Bligh / Keith Mannthey
	Expose NUMA meminfo information under /proc/meminfo.numa

disable preempt					Martin J. Bligh
	I broke preempt somehow, temporarily disable it to stop accidents

aiofix2						Mingming Cao
	fixed a bug in ioctx_alloc()

percpu_real_loadavg				Dave Hansen / Martin J. Bligh
	Tell me what the real load average is, and tell me per cpu.

irqbal_fast					Adam Litke
	Balance IRQs more readily

kcg						Adam Litke
	Acylic call graphs from the kernel. Wheeeeeeeeeeeee!

kcg_gcc_detect					Adam Litke
	Detect older gcc versions that don't work with mcount, and crap out

numa_mem_equals 				Dave Hansen
	mem= command line parameter NUMA awareness.

autoswap					Con Kolivas
	Auto-tune swapiness

kswapd_divide_by_zero				Hugh Dickins
	Fix divide_by_zero error

protocol254					Paul Mackerras / Omkhar 
	Allow protocol 254

slabtune					Dave McCracken
	Take slab in bigger bites on larger machines

fasync_lock_rcu					Manfred Spraul
	Use RCU for fasync_lock

vma_statistics					Martin J. Bligh
	Provide per VMA stats

physnode_map					Martin J. Bligh
	Hack around problem of missing area in physnode_map

sched_tunables					R. Love / Darren Hart
	Provide sched tunables to play with on a rainy day.

schedstats-tools				Rick Lindsley
	Grub around in lotsa scheduler statistics


