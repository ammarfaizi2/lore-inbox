Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVCZF2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVCZF2B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 00:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVCZF2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 00:28:00 -0500
Received: from hera.kernel.org ([209.128.68.125]:54741 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261996AbVCZF1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 00:27:13 -0500
Date: Fri, 25 Mar 2005 21:46:31 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.30-rc2
Message-ID: <20050326004631.GC17637@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the second release candidate for v2.4.30.

It contains a bunch of security updates (ext2 mkdir leak, af_bluetooth range
checking, isofs corrupt media, load_elf_library DoS), an ia64 update, another 
round of networking fixes, amongst others.

If nothing terrible shows up, this will become v2.4.30.

Please help with testing!

Summary of changes from v2.4.30-rc1 to v2.4.30-rc2
============================================

<davem:sunset.davemloft.net>:
  o [TG3]: Add missing CHIPREV_5750_{A,B}X defines
  o [TG3]: Missing counter bump in tigon3_4gb_hwbug_workaround()
  o [TG3]: Update driver version and reldate

<magnus.damm:gmail.com>:
  o eepro100: fix module parameter description typo

<mlafon:arkoon.net>:
  o CAN-2005-0400: ext2 mkdir() directory entry random kernel memory leak

<relf:os2.ru>:
  o fs/hpfs/*: fix HPFS support under 64-bit kernel

<sj-netfilter:cookinglinux.org>:
  o [NETFILTER]: Fix another DECLARE_MUTEX in header file

Bjorn Helgaas:
  o ia64: force all kernel sections into one and the same segment
  o ia64: round iommu allocations to power-of-two sizes
  o ia64: fix perfmon typo in /proc/pal/CPU*/processor_info w.r.t. BERR
  o ia64: add missing syscall-slot
  o ia64: Update defconfigs

Chris Wright:
  o isofs: Some more defensive checks to keep corrupt isofs images from corrupting memory/oopsing

Dave Kleikamp:
  o JFS: remove aops from directory inodes

David Mosberger:
  o Fix pte_modify() bug which allowed mprotect() to change too many bits
  o ia64: Fix _PAGE_CHG_MASK so PROT_NONE works again.  Caught by Linus

Greg Banks:
  o link_path_walk refcount problem allows umount of active filesystem

Herbert Xu:
  o [CRYPTO]: Mark myself as co-maintainer
  o [NETLINK]: Fix multicast bind/autobind race
  o CAN-2005-0794: Potential DOS in load_elf_library

Keith Owens:
  o [IA64] Sanity check unw_unwind_to_user
  o [IA64] Tighten up unw_unwind_to_user check

Linus Torvalds:
  o isofs: Handle corupted rock-ridge info slightly better
  o isofs: more "corrupted iso image" error cases

Marcel Holtmann:
  o CAN-2005-0750: Fix af_bluetooth range checking bug, discovered by Ilja van Sprundel <ilja@suresec.org>

Marcelo Tosatti:
  o Change VERSION to 2.4.30-rc2

Michael Chan:
  o [TG3]: Add 5705_plus flag
  o [TG3]: Flush status block in tg3_interrupt()
  o [TG3]: Add unstable PLL workaround for 5750
  o [TG3]: Fix jumbo frames phy settings
  o [TG3]: Fix ethtool set functions
  o [TG3]: Add Broadcom copyright

Neil Brown:
  o nlm: fix f_count leak
  o [PATCH md: allow degraded raid1 array to resync after an unclean shutdown

Pablo Neira:
  o [NETFILTER]: Fix DECLARE_MUTEX in header file

Patrick McHardy:
  o [NETFILTER]: fix return values of ipt_recent checkentry
  o [NETFILTER]: Fix ip_ct_selective_cleanup(), and rename ip_ct_iterate_cleanup()
  o [NETFILTER]: Fix cleanup in ipt_recent
  o [NETFILTER]: Fix ip6tables ESP matching with "-p all"
  o [NETFILTER]: Fix refreshing of overlapping expectations
  o [NETFILTER]: Fix IP/TCP option logging
  o [TUN]: Fix check for underflow

Pete Zaitcev:
  o USB: fix oops in serial_write
  o USB: Fix baud selection in mct_u232

Simon Horman:
  o [IPVS]: Fix comment typos
  o Backport v2.6 ATM copy-to-user signedness fix
  o earlyquirk.o is needed for CONFIG_ACPI_BOOT

Stephen Hemminger:
  o [TCP]: BIC not binary searching correctly

Wensong Zhang:
  o [IPVS]: Update mark->cw in the WRR scheduler while service is updated

Yanmin Zhang:
  o [IA64] clean up ptrace corner cases

