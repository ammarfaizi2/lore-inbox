Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUCMQL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 11:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUCMQL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 11:11:26 -0500
Received: from hera.kernel.org ([63.209.29.2]:14034 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263124AbUCMQLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 11:11:09 -0500
Date: Sat, 13 Mar 2004 13:10:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.26-pre3
Message-ID: <Pine.LNX.4.44.0403131308220.19678-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes the third pre release of 2.4.26.

It contains a bunch of NFS client fixes, IA64/32-bit PPC updates, sisfb 
update, amongst others.

Enjoy


Summary of changes from v2.4.26-pre2 to v2.4.26-pre3
============================================

<andikies:t-online.de>:
  o sb16 sample size fix

<dan:geefour.netx4.com>:
  o Updates to the bootloader code due to changes from immap to cpm2
  o Add the RPC/EP 8260 board to the configuration for testing the new cpm2 updates.

<hjm:redhat.com>:
  o Fix LVM snapshot oversized sector calculation

<jbaron:redhat.com>:
  o mremap NULL pointer dereference fix

<mlord:pobox.com>:
  o Fix vmalloc() spinlocking issues introduced by the "error handling fixes"

Adrian Bunk:
  o agpgart_be.c: remove duplicate PCI_DEVICE_ID_SI_651

Andrew Morton:
  o [CRYPTO]: arc4.c compile fix for older gcc's

Arun Sharma:
  o ia64: Fix and optimize sys32_rt_sigtimedwait()

Bjorn Helgaas:
  o ia64: (acpi_hp_csr_space): Export only if CONFIG_ACPI
  o ia64: Tidy up MCA printk's
  o ia64: (desc_abi): Check for Linux ABI # (3) instead of SysV4 ABI # (0)
  o ia64: unwind: Add some UNW_DEBUG stuff and remove KDB bits to follow 2.6
  o ia64: Use __builtin_trap() in BUG() when available
  o ia64: Remove obsolete sigcontext comment

David Mosberger:
  o ia64: Drop copyright notices on header files which are either entirely trivial
  o ia64: Back-port from libunwind: fix off-by-one error in kernel-unwinder
  o ia64: Fix bug in ia64_get_scratch_nat_bits()/ia64_put_scratch_nat_bits()

David S. Miller:
  o [TIGON3]: tg3_phy_copper_begin() tweaks
  o [TIGON3]: Allow MAC address changing even when iface is up
  o [TIGON3]: Always force PHY reset after major hw config changes
  o [TIGON3]: Update driver version and reldate

David Stevens:
  o [IPV4]: Add sysctl for per-socket limit on number of mcast src filters
  o [IPV4/IPV6]: Add sysctl limits for mcast src filters

Grant Grundler:
  o [TIGON3]: Consolidate MMIO write flushing using tg3_f() macro

Keith Owens:
  o ia64: Avoid deadlock when using printk() for MCA and INIT records
  o ia64: Delete all MCA/INIT/etc record printing code, moved to salinfo_decode in user space.
  o ia64: Mark MCA variables and functions static where possible
  o ia64: Delete dead variables and functions from mca.c
  o ia64: Reorder mca.c to remove the need for forward declarations and to consolidate related code.
  o ia64: Synchronize mca.c with 2.6.  White space, comment, #ifdef, etc
  o ia64: MCA, salinfo: calculate irq_safe once and pass it around
  o ia64: Correct "did we recover from MCA" test and move up a level
  o ia64: Periodically check for outstanding MCA or INIT records
  o ia64: remove include/asm-ia64/offset.hs in "make mrproper"
  o ia64: Delete redundant ia64_mca_check_errors
  o ia64: update unwind with 2.6 fixes
  o ia64: add OEM data decode for SGI MCA handler
  o ia64: copy SAL records so we don't drop them when events occur fast

Kumar Gala:
  o [PPC32] imported in CPM 8260_io drivers from linuxppc_2_4_devel tree
  o [PPC32] Added support ADS 8272 board
  o [PPC32] Renamed 8260 CPM handling to CPM2.  This is to allow reuse of CPM2 code between PQ2 and PQ3 devices.  8xx is considered CPM1
  o [PPC32] Renamed 8260 CPM handling to CPM2.  This allows reuse of CPM2 code between PQ2 and PQ3 devices.  8xx is considered CPM1

Marcelo Tosatti:
  o Ogawa Hirofumi: fix FAT over NFSv2
  o Change LAN media MAINTAINERS entry to Orphan
  o Changed EXTRAVERSION to -pre3

Patrick McHardy:
  o [PKT_SCHED]: Fix ipv6 ECN marking in RED scheduler

Thomas Winischhofer:
  o sisfb update

Trond Myklebust:
  o A patch to fix an Oops in the locking code
  o Slight optimization to the NFS writes
  o A patch by Greg Banks that increases the supported NLM cookie size. This is needed in order to work correctly with Apple and FreeBSD clients.
  o A patch by Patrice Dumas that ensures that the server index blocks uniquely by using the client address in addition to the value of the NLM cookie field.
  o A patch by Greg Banks to help fix the "VFS: Busy inodes after unmount." problem that occurs if autofs expires the mountpoint while an NFS sillydelete is still pending.
  o I have a feeling the second race case of your test is that you are interrupting the fcntl(F_SETLK) call while it is on the wire. If you do that, then the server may record the lock as taken, but the client will never receive the reply, and so will not know that it must clean up locks...

Wensong Zhang:
  o [IPVS]: Code tidy up


