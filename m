Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263391AbUKZWwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263391AbUKZWwM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbUKZWs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:48:59 -0500
Received: from mail.charite.de ([160.45.207.131]:33671 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S262831AbUKZWrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 17:47:24 -0500
Date: Fri, 26 Nov 2004 23:47:22 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Out of memory, but no OOM Killer? (2.6.9-ac11)
Message-ID: <20041126224722.GK30987@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rsync seems to want lots of memory, yet the OOM killer doesn't strike.
Subsequently, that machine died an ugly death until delivered by a
power-cycle.

Why doesn't the OOM killer reap rsync?
...
Nov 26 05:58:19 backup-in -- MARK --
Nov 26 06:02:04 backup-in kernel: rsync: page allocation failure. order:3, mode:0x20
Nov 26 06:02:04 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:02:04 backup-in kernel: rsync: page allocation failure. order:3, mode:0x20
Nov 26 06:02:04 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:02:08 backup-in kernel: rsync: page allocation failure. order:3, mode:0x20
Nov 26 06:02:08 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:02:08 backup-in kernel: rsync: page allocation failure. order:3, mode:0x20
Nov 26 06:02:08 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:02:08 backup-in kernel: rsync: page allocation failure. order:3, mode:0x20
Nov 26 06:02:08 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:02:08 backup-in kernel: rsync: page allocation failure. order:3, mode:0x20
Nov 26 06:02:08 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:02:08 backup-in kernel: rsync: page allocation failure. order:3, mode:0x20
Nov 26 06:02:08 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:02:08 backup-in kernel: rsync: page allocation failure. order:3, mode:0x20
Nov 26 06:02:08 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:02:08 backup-in kernel: rsync: page allocation failure. order:3, mode:0x20
Nov 26 06:02:08 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:02:08 backup-in kernel: rsync: page allocation failure. order:3, mode:0x20
Nov 26 06:02:08 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:02:17 backup-in kernel: printk: 32 messages suppressed.
Nov 26 06:02:17 backup-in kernel: pdflush: page allocation failure. order:3, mode:0x20
Nov 26 06:02:17 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:02:17 backup-in kernel: pdflush: page allocation failure. order:3, mode:0x20
Nov 26 06:02:17 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:03:33 backup-in kernel: printk: 11 messages suppressed.
Nov 26 06:03:33 backup-in kernel: pdflush: page allocation failure. order:3, mode:0x20
Nov 26 06:03:33 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:03:33 backup-in kernel: pdflush: page allocation failure. order:3, mode:0x20
Nov 26 06:03:33 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:03:33 backup-in kernel: pdflush: page allocation failure. order:3, mode:0x20
Nov 26 06:03:33 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:03:33 backup-in kernel: pdflush: page allocation failure. order:3, mode:0x20
Nov 26 06:03:33 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:03:33 backup-in kernel: pdflush: page allocation failure. order:3, mode:0x20
Nov 26 06:03:33 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:03:33 backup-in kernel: pdflush: page allocation failure. order:3, mode:0x20
Nov 26 06:03:33 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:03:33 backup-in kernel: pdflush: page allocation failure. order:3, mode:0x20
Nov 26 06:03:33 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:03:33 backup-in kernel: pdflush: page allocation failure. order:3, mode:0x20
Nov 26 06:03:33 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:04:08 backup-in kernel: swapper: page allocation failure. order:3, mode:0x20
Nov 26 06:04:08 backup-in kernel:  [__alloc_pages+576/908] __alloc_pages+0x240/0x38c
Nov 26 06:04:08 backup-in kernel:  [__get_free_pages+24/49] __get_free_pages+0x18/0x31
Nov 26 06:04:08 backup-in kernel:  [kmem_getpages+30/201] kmem_getpages+0x1e/0xc9
Nov 26 06:04:08 backup-in kernel:  [cache_grow+188/390] cache_grow+0xbc/0x186
Nov 26 06:04:08 backup-in kernel:  [cache_alloc_refill+468/532] cache_alloc_refill+0x1d4/0x214
Nov 26 06:04:08 backup-in kernel:  [__kmalloc+122/124] __kmalloc+0x7a/0x7c
Nov 26 06:04:08 backup-in kernel:  [alloc_skb+83/252] alloc_skb+0x53/0xfc
Nov 26 06:04:08 backup-in kernel:  [pg0+545011501/1068684288] e1000_alloc_rx_buffers+0x47/0xe8 [e1000]
Nov 26 06:04:08 backup-in kernel:  [pg0+545010700/1068684288] e1000_clean_rx_irq+0x184/0x45e [e1000]
Nov 26 06:04:08 backup-in kernel:  [pg0+545010212/1068684288] e1000_clean_tx_irq+0x1a0/0x204 [e1000]
Nov 26 06:04:08 backup-in kernel:  [pg0+545009728/1068684288] e1000_intr+0x3e/0x82 [e1000]
Nov 26 06:04:08 backup-in kernel:  [handle_IRQ_event+60/110] handle_IRQ_event+0x3c/0x6e
Nov 26 06:04:08 backup-in kernel:  [do_IRQ+222/422] do_IRQ+0xde/0x1a6
Nov 26 06:04:08 backup-in kernel:  =======================
Nov 26 06:04:08 backup-in kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Nov 26 06:04:08 backup-in kernel:  [default_idle+0/44] default_idle+0x0/0x2c
Nov 26 06:04:08 backup-in kernel:  [default_idle+41/44] default_idle+0x29/0x2c
Nov 26 06:04:08 backup-in kernel:  [cpu_idle+46/60] cpu_idle+0x2e/0x3c
Nov 26 06:04:08 backup-in kernel:  [start_kernel+356/383] start_kernel+0x164/0x17f
Nov 26 06:04:08 backup-in kernel:  [unknown_bootoption+0/374] unknown_bootoption+0x0/0x176
Nov 26 06:04:08 backup-in kernel: swapper: page allocation failure. order:3, mode:0x20
Nov 26 06:04:08 backup-in kernel:  [__alloc_pages+576/908] __alloc_pages+0x240/0x38c
Nov 26 06:04:08 backup-in kernel:  [__get_free_pages+24/49] __get_free_pages+0x18/0x31
Nov 26 06:04:08 backup-in kernel:  [kmem_getpages+30/201] kmem_getpages+0x1e/0xc9
Nov 26 06:04:08 backup-in kernel:  [cache_grow+188/390] cache_grow+0xbc/0x186
Nov 26 06:04:08 backup-in kernel:  [cache_alloc_refill+468/532] cache_alloc_refill+0x1d4/0x214
Nov 26 06:04:08 backup-in kernel:  [__kmalloc+122/124] __kmalloc+0x7a/0x7c
Nov 26 06:04:08 backup-in kernel:  [alloc_skb+83/252] alloc_skb+0x53/0xfc
Nov 26 06:04:08 backup-in kernel:  [pg0+545011501/1068684288] e1000_alloc_rx_buffers+0x47/0xe8 [e1000]
Nov 26 06:04:08 backup-in kernel:  [pg0+545010700/1068684288] e1000_clean_rx_irq+0x184/0x45e [e1000]
Nov 26 06:04:08 backup-in kernel:  [pg0+545010212/1068684288] e1000_clean_tx_irq+0x1a0/0x204 [e1000]
Nov 26 06:04:08 backup-in kernel:  [pg0+545009728/1068684288] e1000_intr+0x3e/0x82 [e1000]
Nov 26 06:04:08 backup-in kernel:  [handle_IRQ_event+60/110] handle_IRQ_event+0x3c/0x6e
Nov 26 06:04:08 backup-in kernel:  [do_IRQ+222/422] do_IRQ+0xde/0x1a6
Nov 26 06:04:08 backup-in kernel:  =======================
Nov 26 06:04:08 backup-in kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Nov 26 06:04:08 backup-in kernel:  [default_idle+0/44] default_idle+0x0/0x2c
Nov 26 06:04:08 backup-in kernel:  [default_idle+41/44] default_idle+0x29/0x2c
Nov 26 06:04:08 backup-in kernel:  [cpu_idle+46/60] cpu_idle+0x2e/0x3c
Nov 26 06:04:08 backup-in kernel:  [start_kernel+356/383] start_kernel+0x164/0x17f
Nov 26 06:04:08 backup-in kernel:  [unknown_bootoption+0/374] unknown_bootoption+0x0/0x176
Nov 26 06:04:08 backup-in kernel: klogd: page allocation failure. order:3, mode:0x20
Nov 26 06:04:08 backup-in kernel: Stack pointer is garbage, not printing trace
Nov 26 06:04:08 backup-in kernel: klogd: page allocation failure. order:3, mode:0x20

... and it goes on like that for hours...

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
