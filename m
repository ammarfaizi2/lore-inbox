Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVLYDj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVLYDj2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 22:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVLYDj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 22:39:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750765AbVLYDj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 22:39:27 -0500
Date: Sat, 24 Dec 2005 19:39:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Ho ho ho.. Linux 2.6.15-rc7
Message-ID: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now, most of you are probably going to be totally bored out of your minds 
on Christmas day, and here's the perfect distraction. Test 2.6.15-rc7. All 
the stores will be closed, and there's really nothing better to do in 
between meals.

A number of mostly one-liners. The biggest ones are probably some s390 
qeth updates and some ipv6 fixes, the rest is just a number of small 
fixes. The shortlog gives a pretty good picture of what's going on. I 
suspect the forcedeth fix is the one most likely to affect any reasonable 
number of people, although the more relaxed usb suspend probably makes 
a big difference.

Please do give it a try, and if you have any issues/regressions, send out 
a note (even if you sent one earlier) so that we don't forget about it.

Thanks,

		Linus

---
Adrian Bunk:
      [SPARC]: Fix RTC build failure.
      include/linux/irq.h: #include <linux/smp.h>
      [SUNGEM]: Fix link error with CONFIG_HOTPLUG disabled.
      [SPARC]: introduce a SPARC Kconfig symbol

Alan Stern:
      usbcore: allow suspend/resume even if drivers don't support it

Alex Williamson:
      [ACPI] increase owner_id limit to 64 from 32

Andi Kleen:
      Fix swiotlb pci_map_sg error handling
      Fix build with CONFIG_PCI_MMCONFIG

Andreas Gruenbacher:
      nfsd: check for read-only exports before setting acls

Andrew Morton:
      Fix memory ordering problem in wake_futex()

Antonino A. Daplas:
      intelfb: Fix freeing of nonexistent resource
      intelfb: Fix oops when changing video mode

ASANO Masahiro:
      fix posix lock on NFS

Bart De Schuymer:
      [BRIDGE-NF]: Fix bridge-nf ipv6 length check

Ben Collins:
      block: Cleanup CDROMEJECT ioctl
      Fix typo in x86_64 __build_write_lock_const assembly

Benjamin Herrenschmidt:
      powerpc: g5 thermal overtemp bug

David S. Miller:
      [IPSEC]: Perform SA switchover immediately.
      [SPARC64]: Stop putting -finline-limit=XXX into CFLAGS
      [IPSEC]: Fix policy updates missed by sockets
      [SPARC]: Kill CHILD_MAX.
      [VIDEO] sbuslib: Disallow private mmaps.

David Shaohua Li:
      [ACPI] correct earlier SMP deep C-states on HT patch

Edson Seabra:
      powerpc: CPM2 interrupt handler failure after 100,000 interrupts

Frank Pavlic:
      s390: some minor qeth driver fixes
      s390: minor qeth network driver fixes
      s390: remove redundant and useless code in qeth

Hans Verkuil:
      V4L/DVB (3191): Fix CC output

Hiroyuki YAMAMORI:
      [IPV6]: Fix Temporary Address Generation

Ian McDonald:
      [DCCP]: Comment typo

Ingo Molnar:
      fix spinlock-debugging smp_processor_id() usage

James Bottomley:
      [SCSI] fix scsi_reap_target() device_del from atomic context

James.Smart@Emulex.Com:
      [SCSI] fix for fc transport recursion problem.

Jason Wessel:
      kernel/params.c: fix sysfs access with CONFIG_MODULES=n

Jean Delvare:
      V4L/DVB (3188): Fix compilation failure with gcc 2.95.3.

Knut Petersen:
      Fix framebuffer console upside-down ywrap scrolling

Kristian Slavov:
      [RTNETLINK]: Fix RTNLGRP definitions in rtnetlink.h
      [IPV6]: Fix address deletion

Kurt Huwig:
      n_r3964: fixed usage of HZ; removed bad include

Len Brown:
      [ACPI] fix build warning from owner_id patch

Linus Torvalds:
      Initialize drivers/media/video/saa7134 late
      Fix silly typo ("smb" vs "smp")
      Linux v2.6.15-rc7

Manfred Spraul:
      forcedeth: fix random memory scribbling bug
      add missing memory barriers to ipc/sem.c

Mauro Carvalho Chehab:
      V4L/DVB (3189): Fix a broken logic that didn't cover all standards.
      V4L/DVB SCM Maintainers Update

Michael Chan:
      [TG3]: Fix peer device handling
      [TG3]: Some low power fixes
      [TG3]: Add tw32_wait_f() for some sensitive registers
      [TG3]: Fix ethtool memory test

Mika Kukkonen:
      [NETROM]: Fix three if-statements in nr_state1_machine()
      [VLAN]: Add two missing checks to vlan_ioctl_handler()

Neil Brown:
      md: Change case of raid level reported in sys/mdX/md/level

Neil Horman:
      [SCTP]: Fix sctp to not return erroneous POLLOUT events.

Nicolas Pitre:
      [ARM] 3210/1: add missing memory barrier helper for NPTL support
      fix race with preempt_enable()

Olaf Hering:
      missing license for libphy.ko

Oliver Endriss:
      V4L/DVB (3181): Enable SPDIF output for DVB-S rev 2.3

Patrick McHardy:
      [NETFILTER]: Fix NAT init order
      [NETFILTER]: Fix incorrect dependency for IP6_NF_TARGET_NFQUEUE
      [XFRM]: Handle DCCP in xfrm{4,6}_decode_session

Paul Mackerras:
      powerpc: correct register usage in 64-bit syscall exit path
      powerpc: update defconfigs
      powerpc: Fix i8259 cascade on pSeries with XICS interrupt controller

Paul Walmsley:
      USB Storage: Force starget->scsi_level in usb-storage scsiglue.c

Pavel Roskin:
      orinoco_nortel: Fix incorrect PCI resource use
      orinoco_nortel: Add Symbol LA-4123 ID

Ravikiran G Thirumalai:
      x86_64/ia64 : Fix compilation error for node_to_first_cpu

Ricardo Cerqueira:
      V4L/DVB (3180): Fix tuner 100 definition for hauppauge eeprom
      V4L/DVB (3200): Fix saa7134 ALSA/OSS collisions

Russell King:
      [ARM] Fix sys_sendto and sys_recvfrom 6-arg syscalls

Thomas Renninger:
      [ACPI] fix passive cooling regression

Tom Zanussi:
      relayfs: remove warning printk() in relay_switch_subbuf()

Tony Battersby:
      fix libata inquiry VPD for ATAPI devices

Trond Myklebust:
      RPC: Do not block on skb allocation
      NFS: Fix another O_DIRECT race
      SUNRPC: Fix "EPIPE" error on mount of rpcsec_gss-protected partitions
      NLM: Fix Oops in nlmclnt_mark_reclaim()

YOSHIFUJI Hideaki:
      [IPV6]: Fix route lifetime.
      [IPV6]: Flag RTF_ANYCAST for anycast routes.
      [IPV6]: Try not to send icmp to anycast address.
      [IPV6]: Defer IPv6 device initialization until the link becomes ready.
      [IPV6]: Run DAD when the link becomes ready.
      [IPV6]: Don't select a tentative address as a source address.
      [IPV6]: Fix dead lock.

