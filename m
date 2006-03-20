Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWCTGXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWCTGXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWCTGXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:23:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750809AbWCTGXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:23:07 -0500
Date: Sun, 19 Mar 2006 22:23:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.16
Message-ID: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1089296769-1142835784=:3622"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1089296769-1142835784=:3622
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Ok, it's being mirrored out right now, the git tree should already be all 
there, the tar-file and patches are still uploading.

Not a lot of changes since -rc6, but there's various random one-liners 
here and there (a number of Coverity bugs found, for example), and there 
are small MIPS and PowerPC updates.

Appended is the shortlog from 2.6.16-rc6, the full log (from 2.6.15) is on 
the web/ftp-sites. 

It looks like both Fedora and SuSE end up using a kernel that is pretty 
close to this 2.6.16 release, so let's all hope it's good. Give it a good 
testing, please,

		Linus

---
Adrian Bunk:
      [TG3] tg3_bus_string(): remove dead code
      SUNRPC: fix a NULL pointer dereference in net/sunrpc/clnt.c
      fs/namespace.c:dup_namespace(): fix a use after free

Al Viro:
      Fix ext2 readdir f_pos re-validation logic

Albrecht Dreß:
      [ARM] 3358/1: [S3C2410] add missing SPI DMA resources

Alessandro Zummo:
      [ARM] 3354/1: NAS100d: fix power led handling
      [ARM] 3355/1: NSLU2: remove propmt depends
      [ARM] 3350/1: Enable 1-wire on ARM

Alexey Kuznetsov:
      [NET]: Fix race condition in sk_wait_event().

Andi Kleen:
      x86-64: Fix up handling of non canonical user RIPs

Andrea Arcangeli:
      Remove obsolete CREDITS address

Andreas Herrmann:
      [SCSI] zfcp: correctly set this_id for hosts
      [SCSI] scsi_transport_fc: fix FC_HOST_NUM_ATTRS
      [SCSI] zfcp: fix device registration issues

Atsushi Nemoto:
      [MIPS] local_r4k_flush_cache_page fix

Ben Dooks:
      [ARM] 3363/1: [cleanup] process.c - fix warnings
      [ARM] 3364/1: [cleanup] warning fix - definitions for enable_hlt and disable_hlt
      [ARM] 3365/1: [cleanup] header for compat.c exported functions
      [ARM] 3362/1: [cleanup] - duplicate decleration of mem_fclk_21285

Benjamin Herrenschmidt:
      macintosh: correct AC Power info in /proc/pmu/info
      powerpc: enable NAP only on cpus who support it to avoid memory corruption

Brian Haley:
      [IPV6]: fix ipv6_saddr_score struct element

Catalin Marinas:
      [ARM] 3356/1: Workaround for the ARM1136 I-cache invalidation problem

Christoph Lameter:
      page migration: fail if page is in a vma flagged VM_LOCKED
      Page migration documentation update
      Consistent capabilites associated with MPOL_MOVE_ALL
      page migration: Fail with error if swap not setup
      time_interpolator: add __read_mostly
      fix race in pagevec_strip?

Dave Jones:
      [TUN]: Fix leak in tun_get_user()

Dave Kleikamp:
      JFS: Take logsync lock before testing mp->lsn

Dave Peterson:
      EDAC: disable sysfs interface

David Brownell:
      mtd_dataflash, fix block vs page erase

David S. Miller:
      [TCP]: Fix tcp_tso_should_defer() when limit>=65536
      e1000 endianness bugs

Dominik Brodowski:
      [SCSI] scsi: aha152x pcmcia driver needs spi transport

Eric Van Hensbergen:
      v9fs: fix overzealous dropping of dentry which breaks dcache

Eric W. Biederman:
      unshare: Use rcu_assign_pointer when setting sighand

GOTO Masanori:
      Fix sigaltstack corruption among cloned threads

Greg Smith:
      "s390: multiple subchannel sets support" fix

Gregor Maier:
      [NETFILTER]: Fix wrong option spelling in Makefile for CONFIG_BRIDGE_EBT_ULOG

Herbert Xu:
      [TCP]: Fix zero port problem in IPv6

Hong Liu:
      ieee80211: Fix QoS is not active problem

Hugh Dickins:
      fix free swap cache latency

Jesse Brandeburg:
      e100: fix eeh on pseries during ethtool -t

John Rose:
      powerpc: properly configure DDR/P5IOC children devs

Kevin Corry:
      dm stripe: Fix bounds

Linus Torvalds:
      Revert "x86-64: Fix up handling of non canonical user RIPs"
      Linux 2.6.16

Maneesh Soni:
      Plug kdump shutdown race window

Markus Rechberger:
      Fixed em28xx based system lockup

Matej Kupljen:
      [MIPS] Simple patch to power off DBAU1200

Matthew Wilcox:
      [SCSI] Add Brownie to blacklist

Michael Chan:
      [TG3]: 40-bit DMA workaround part 2

Michael Ellerman:
      powerpc: Clarify wording for CRASH_DUMP Kconfig option

Michael Hunold:
      Restore tuning capabilities in V4L2 MXB driver

Michael Krufky:
      Kconfig: swap VIDEO_CX88_ALSA and VIDEO_CX88_DVB

Michael Neuling:
      powerpc: RTC memory corruption

Nathan Scott:
      Fix a direct I/O locking issue revealed by the new mutex code.

Olaf Hering:
      powerpc: correct cacheflush loop in zImage
      powerpc/64: enable CONFIG_BLK_DEV_SL82C105
      powerpc: remove duplicate EXPORT_SYMBOLS

Oleg Nesterov:
      disable unshare(CLONE_VM) for now

Patrick McHardy:
      [NETFILTER]: nfnetlink_queue: fix possible NULL-ptr dereference
      [NET_SCHED]: act_api: fix skb leak in error path
      [XFRM]: Fix leak in ah6_input
      [NETLINK]: Fix use-after-free in netlink_recvmsg
      [TCP]: tcp_highspeed: fix AIMD table out-of-bounds access
      [IPV4/6]: Fix UFO error propagation
      [NETFILTER]: arp_tables: fix NULL pointer dereference

Paul Mackerras:
      powerpc: Disallow lparcfg being a module
      powerpc: Fix problem with time going backwards
      powerpc: update defconfigs

Pavel Machek:
      [ARM] 3357/1: enable frontlight on collie

Peter Staubach:
      nfsservctl(): remove user-triggerable printk

Ralf Baechle:
      Update MAINTAINERS entry for MIPS.
      [MIPS] Get rid of the IP22-specific code in arclib.
      [MIPS] SB1: Fix interrupt disable hazard.
      [MIPS] Work around bad code generation for <asm/io.h>.
      [MIPS] Protect more of timer_interrupt() by xtime_lock.
      [MIPS] Sibyte: Fix M_SCD_TIMER_INIT and M_SCD_TIMER_CNT wrong field width.
      [MIPS] Sibyte: Fix interrupt timer off by one bug.
      [MIPS] Sibyte: Fix race in sb1250_gettimeoffset().
      [MIPS] SB1: Check for -mno-sched-prolog if building corelis debug kernel.

Ralf Baechle DL5RB:
      [AX.25]: Fix potencial memory hole.

Roman Zippel:
      posix-timers: fix requeue accounting when signal is ignored

Russell King:
      [ARM] Fix muldi3.S
      [ARM] iwmmxt thread state alignment
      [ARM] Fix "thead" typo

Sam Ravnborg:
      kbuild: fix buffer overflow in modpost

Scott Bardone:
      [netdrvr] fix array overflows in Chelsio driver

Sergei Shtylylov:
      [MIPS] Fix DBAu1550 software power off.

Srivatsa Vaddagiri:
      x86: check for online cpus before bringing them up

Tejun Heo:
      ahci: fix NULL pointer dereference detected by Coverity

Trond Myklebust:
      NFS: Fix a potential panic in O_DIRECT
      NFSv4: fix mount segfault on errors returned that are < -1000
      SUNRPC: Fix potential deadlock in RPC code
      NLM: Ensure we do not Oops in the case of an unlock

Zhu Yi:
      ieee80211: Fix CCMP decryption problem when QoS is enabled

--21872808-1089296769-1142835784=:3622--
