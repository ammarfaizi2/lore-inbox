Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUHNGGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUHNGGr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 02:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUHNGGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 02:06:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:58753 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265996AbUHNGFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 02:05:45 -0400
Date: Fri, 13 Aug 2004 23:05:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.8
Message-ID: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The major patches since -rc4 were some sparc64 and parsic updates, but 
there's some network driver and SATA updates and a few ARM patches too. 
And a use-after-free fix in MTD.

		Linus


Summary of changes from v2.6.8-rc4 to v2.6.8
============================================

<jwboyer:infradead.org>:
  o Restore physmap configure-time settings according to user requests

<sm0407:nurfuerspam.de>:
  o cdrom: MO-drive open write fix

Aaron Grothe:
  o [CRYPTO]: Add Khazad algorithm

Andrew Chew:
  o [libata sata_nv] support for hardware, bug fixes
  o [libata] unmap MMIO region _after_ last possible usage

Andrew Morton:
  o bk-netdev-axnet_cs-fix
  o bk-netdev-hp-plus-fix

Catalin Marinas:
  o [ARM PATCH] 2012/1: Use -malignment-traps instead of
    -mshort-load-bytes if gcc supports it

Dave Hansen:
  o 4kstacks: fix compile with gcc 2.95

David S. Miller:
  o [SPARC64]: Eliminate costly sdivx from gettimeofday
  o [SPARC64]: Implement tlb flush batching just like ppc64
  o [SPARC64]: Need flush_tlb_pending() in switch_to()
  o [SPARC64]: Kill TLB rtrap debug code
  o [SPARC64]: Update defconfig
  o [SPARC64]: Always record actual PC when kernel profiling
  o [SPARC64]: Make clear_user_page more leight weight
  o [SPARC64]: Fix up copy_page just like clear_page
  o [SPARC64]: Remove memcpy Ultra3 PCACHE patching trick
  o [SPARC64]: Use saner local label names in Ultra3 copies
  o [SPARC64]: More entropy in add_timer_randomness
  o [SPARC64]: Fix spitfire bugs in tlb flush and copy_page changes
  o [SPARC64]: Kill swapper_space test in arch/sparc64/mm/tlb.c
  o [SPARC64]: Change TIF_BLKCOMMIT into a fault code
  o [SPARC64]: Update defconfig
  o [SPARC64]: Fix non-SMP build

David Woodhouse:
  o Fix use-after-free bug in MTD partitioning code
  o Cosmetic MTD changes -- update email address and idents
  o M-Systems DiskOnChip driver update
  o RedBoot flash partitioning: use vmalloc for buffer
  o Export new mtd_erase_callback() function
  o Fix MTD partitioning modular build

Eugene Surovegin:
  o [IPSEC]: Add missing flow_cache_genid update to
    xfrm_policy_delete()

Jens Axboe:
  o export kblockd_schedule_work()
  o setup queue before elevator_init()

Linus Torvalds:
  o Be a bit more anal about allowing SCSI commands to be sent
  o Pass done file pointer to block device ioctl's
  o Allow non-root users certain raw commands if they are deemed safe
  o Linux 2.6.8

Marc Singer:
  o [ARM PATCH] 2001/1: lh7a40x IDE cleanup
  o [ARM PATCH] 2002/1: lh7a40x Timer fixup

Margit Schubert-While:
  o prism54 Clarification to Viro's patch
  o prism54 URGENT - Fix IRQ handling
  o prism54 Fix memory leaks
  o prism54 Fix supported rates reporting

Martin Devera:
  o [PKT_SCHED]: Fix borrowing fairness in htb

Mathieu LESNIAK:
  o wrong mac address with netgear FA311 ethernet card

Matthew Wilcox:
  o Remove fcntl f_op
  o PA-RISC update
  o lasi_82596 update

Neil Brown:
  o Fix unsigned underflow in xdr decoding

Patrick McHardy:
  o [PKT_SCHED]: Disable local bh's when grabbing qdisc_tree_lock in
    tc_dump_tfilter

Pawel Sikora:
  o [NET]: Kill stray NET_FASTROUTE references

Roger Luethi:
  o via-rhine: Really call rhine_power_init()

Russell King:
  o [PCMCIA] pd6729: add MODULE_DESCRIPTION and MODULE_AUTHOR, fix
    comment style

Simon Kelley:
  o Atmel wireless bigendian fix

Stephen Hemminger:
  o [VLAN]: Propagate ethtool/mii ioctls to the real device
  o [VLAN]: Mirror real devices carrier and hotplug state
  o [VLAN]: Use RCU for group operations
  o [VLAN]: Fix device refcount bug
  o [BRIDGE]: Fix problems with filtering and defragmentation

Tom Rini:
  o Remove CONFIG_SERIAL_8250_MANY_PORTS from Ebony / Ocotea
  o ppc32: Fix warning on CONFIG_PPC32 && CONFIG_6xx

