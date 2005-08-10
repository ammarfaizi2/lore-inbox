Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbVHJTPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVHJTPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 15:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbVHJTPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 15:15:37 -0400
Received: from dsl3-63-249-67-204.cruzio.com ([63.249.67.204]:24467 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S1030190AbVHJTPg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 15:15:36 -0400
Date: Wed, 10 Aug 2005 12:15:19 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200508101915.j7AJFJXe004888@cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: BUGS: Real-Time Preemption 2.6.13-rc5-RT-V0.7.52-16 with CONFIG_DEBUG_SLAB
Cc: mingo@elte.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is 2.6.13-rc5-RT-V0.7.52-16 SMP with CONFIG_DEBUG_SLAB set.
How may I help?

messages:

Aug 10 11:31:56 cichlid kernel: Linux version 2.6.13-rc5-RT-V0.7.52-16-smp-5-slabdebug (root@athlon) (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #5 SMP Wed Aug 10 10:36:09 PDT 2005
...
Aug 10 11:31:57 cichlid kernel: Kernel command line: ro root=LABEL=/ rhgb vga=791 pci=noacpi noapic acpi=ht
...
Aug 10 11:32:25 cichlid kernel: BUG: scheduling with irqs disabled: IRQ 14/0x20000000/206
Aug 10 11:32:25 cichlid kernel: IRQ 14/206[CPU#0]: BUG in FREE_WAITER at kernel/rt.c:1140
Aug 10 11:32:25 cichlid kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20 (20)
Aug 10 11:32:25 cichlid kernel:  [<c0103ef1>] dump_stack+0x1e/0x20 (20)
Aug 10 11:32:25 cichlid kernel:  [__WARN_ON+94/118] __WARN_ON+0x5e/0x76 (44)
Aug 10 11:32:25 cichlid kernel:  [<c0120588>] __WARN_ON+0x5e/0x76 (44)
Aug 10 11:32:25 cichlid kernel:  [__down_mutex+626/1578] __down_mutex+0x272/0x62a (124)
Aug 10 11:32:25 cichlid kernel:  [<c02f4c12>] __down_mutex+0x272/0x62a (124)
Aug 10 11:32:25 cichlid kernel:  [_spin_lock+31/68] __lock_text_start+0x1f/0x44 (28)
Aug 10 11:32:25 cichlid kernel:  [<c02f66cf>] __lock_text_start+0x1f/0x44 (28)
Aug 10 11:32:25 cichlid kernel:  [__kmalloc+135/410] __kmalloc+0x87/0x19a (40)
Aug 10 11:32:25 cichlid kernel:  [<c01517d2>] __kmalloc+0x87/0x19a (40)
Aug 10 11:32:25 cichlid kernel:  [soft_cursor+99/412] soft_cursor+0x63/0x19c (64)
Aug 10 11:32:25 cichlid kernel:  [<c01dd847>] soft_cursor+0x63/0x19c (64)
Aug 10 11:32:26 cichlid kernel:  [bit_cursor+733/1400] bit_cursor+0x2dd/0x578 (164)
Aug 10 11:32:26 cichlid kernel:  [<c01d668a>] bit_cursor+0x2dd/0x578 (164)
Aug 10 11:32:26 cichlid kernel:  [fbcon_cursor+404/593] fbcon_cursor+0x194/0x251 (76)
Aug 10 11:32:26 cichlid kernel:  [<c01d215f>] fbcon_cursor+0x194/0x251 (76)
Aug 10 11:32:26 cichlid kernel:  [hide_cursor+35/58] hide_cursor+0x23/0x3a (20)
Aug 10 11:32:26 cichlid kernel:  [<c020f51b>] hide_cursor+0x23/0x3a (20)
Aug 10 11:32:26 cichlid kernel:  [vt_console_print+602/664] vt_console_print+0x25a/0x298 (48)
Aug 10 11:32:26 cichlid kernel:  [<c0212300>] vt_console_print+0x25a/0x298 (48)
Aug 10 11:32:26 cichlid kernel:  [__call_console_drivers+87/92] __call_console_drivers+0x57/0x5c (32)
Aug 10 11:32:26 cichlid kernel:  [<c011f9b0>] __call_console_drivers+0x57/0x5c (32)
Aug 10 11:32:26 cichlid kernel:  [_call_console_drivers+121/123] _call_console_drivers+0x79/0x7b (24)
Aug 10 11:32:26 cichlid kernel:  [<c011fa2e>] _call_console_drivers+0x79/0x7b (24)
Aug 10 11:32:26 cichlid kernel:  [call_console_drivers+165/348] call_console_drivers+0xa5/0x15c (36)
Aug 10 11:32:26 cichlid kernel:  [<c011fad5>] call_console_drivers+0xa5/0x15c (36)
Aug 10 11:32:26 cichlid kernel:  [release_console_sem+46/235] release_console_sem+0x2e/0xeb (32)
Aug 10 11:32:26 cichlid kernel:  [<c011ffaf>] release_console_sem+0x2e/0xeb (32)
Aug 10 11:32:26 cichlid kernel:  [vprintk+366/595] vprintk+0x16e/0x253 (120)
Aug 10 11:32:26 cichlid kernel:  [<c011fde8>] vprintk+0x16e/0x253 (120)
Aug 10 11:32:26 cichlid kernel:  [printk+24/26] printk+0x18/0x1a (16)
Aug 10 11:32:26 cichlid kernel:  [<c011fc78>] printk+0x18/0x1a (16)
Aug 10 11:32:26 cichlid kernel:  [schedule+137/274] schedule+0x89/0x112 (28)
Aug 10 11:32:26 cichlid kernel:  [<c02f3db5>] schedule+0x89/0x112 (28)
Aug 10 11:32:26 cichlid kernel:  [__down_mutex+1156/1578] __down_mutex+0x484/0x62a (124)
Aug 10 11:32:26 cichlid kernel:  [<c02f4e24>] __down_mutex+0x484/0x62a (124)
Aug 10 11:32:26 cichlid kernel:  [_spin_lock_irqsave+31/73] _spin_lock_irqsave+0x1f/0x49 (28)
Aug 10 11:32:26 cichlid kernel:  [<c02f682b>] _spin_lock_irqsave+0x1f/0x49 (28)
Aug 10 11:32:27 cichlid kernel:  [__wake_up+21/95] __wake_up+0x15/0x5f (44)
Aug 10 11:32:27 cichlid kernel:  [__wake_up_bit+52/58] __wake_up_bit+0x34/0x3a (24)
Aug 10 11:32:27 cichlid kernel:  [<c0135471>] __wake_up_bit+0x34/0x3a (24)
Aug 10 11:32:27 cichlid kernel:  [wake_up_bit+23/27] wake_up_bit+0x17/0x1b (16)
Aug 10 11:32:27 cichlid kernel:  [<c013548e>] wake_up_bit+0x17/0x1b (16)
Aug 10 11:32:27 cichlid kernel:  [unlock_buffer+17/19] unlock_buffer+0x11/0x13 (8)
Aug 10 11:32:27 cichlid kernel:  [<c0169431>] unlock_buffer+0x11/0x13 (8)
Aug 10 11:32:27 cichlid kernel:  [end_buffer_async_write+96/486] end_buffer_async_write+0x60/0x1e6 (68)
Aug 10 11:32:27 cichlid kernel:  [<c0169e66>] end_buffer_async_write+0x60/0x1e6 (68)
Aug 10 11:32:27 cichlid kernel:  [end_bio_bh_io_sync+47/102] end_bio_bh_io_sync+0x2f/0x66 (20)
Aug 10 11:32:27 cichlid kernel:  [<c016ce27>] end_bio_bh_io_sync+0x2f/0x66 (20)
Aug 10 11:32:27 cichlid kernel:  [bio_endio+78/120] bio_endio+0x4e/0x78 (32)
Aug 10 11:32:27 cichlid kernel:  [<c016e579>] bio_endio+0x4e/0x78 (32)
Aug 10 11:32:27 cichlid kernel:  [__end_that_request_first+212/586] __end_that_request_first+0xd4/0x24a (52)
Aug 10 11:32:27 cichlid kernel:  [<c022ad53>] __end_that_request_first+0xd4/0x24a (52)
Aug 10 11:32:28 cichlid kernel:  [end_that_request_first+34/36] end_that_request_first+0x22/0x24 (20)
Aug 10 11:32:28 cichlid kernel:  [<c022aeeb>] end_that_request_first+0x22/0x24 (20)
Aug 10 11:32:28 cichlid kernel:  [__ide_end_request+88/393] __ide_end_request+0x58/0x189 (36)
Aug 10 11:32:28 cichlid kernel:  [<c0239098>] __ide_end_request+0x58/0x189 (36)
Aug 10 11:32:28 cichlid kernel:  [ide_end_request+124/149] ide_end_request+0x7c/0x95 (40)
Aug 10 11:32:28 cichlid kernel:  [<c0239245>] ide_end_request+0x7c/0x95 (40)
Aug 10 11:32:28 cichlid kernel:  [ide_dma_intr+139/206] ide_dma_intr+0x8b/0xce (32)
Aug 10 11:32:28 cichlid kernel:  [<c0242214>] ide_dma_intr+0x8b/0xce (32)
Aug 10 11:32:28 cichlid kernel:  [ide_intr+164/317] ide_intr+0xa4/0x13d (36)
Aug 10 11:32:28 cichlid kernel:  [<c023afee>] ide_intr+0xa4/0x13d (36)
Aug 10 11:32:28 cichlid kernel:  [handle_IRQ_event+101/218] handle_IRQ_event+0x65/0xda (52)
Aug 10 11:32:28 cichlid kernel:  [<c0145cdb>] handle_IRQ_event+0x65/0xda (52)
Aug 10 11:32:28 cichlid kernel:  [do_hardirq+78/232] do_hardirq+0x4e/0xe8 (44)
Aug 10 11:32:28 cichlid kernel:  [<c0146440>] do_hardirq+0x4e/0xe8 (44)
Aug 10 11:32:28 cichlid kernel:  [do_irqd+204/467] do_irqd+0xcc/0x1d3 (40)
Aug 10 11:32:28 cichlid kernel:  [<c01465a6>] do_irqd+0xcc/0x1d3 (40)
Aug 10 11:32:28 cichlid kernel:  [kthread+165/205] kthread+0xa5/0xcd (48)
Aug 10 11:32:28 cichlid kernel:  [<c0134f1b>] kthread+0xa5/0xcd (48)
Aug 10 11:32:28 cichlid kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb (137879580)
Aug 10 11:32:28 cichlid kernel:  [<c010120d>] kernel_thread_helper+0x5/0xb (137879580)
Aug 10 11:32:29 cichlid kernel: ---------------------------
Aug 10 11:32:29 cichlid kernel: | preempt count: 20000001 ]
Aug 10 11:32:29 cichlid kernel: | 1-level deep critical section nesting:
Aug 10 11:32:29 cichlid kernel: ----------------------------------------
Aug 10 11:32:29 cichlid kernel: .. [add_preempt_count+28/30] .... add_preempt_count+0x1c/0x1e
Aug 10 11:32:29 cichlid kernel: .. [<c013cbb0>] .... add_preempt_count+0x1c/0x1e
Aug 10 11:32:29 cichlid kernel: .....[__WARN_ON+18/118] ..   ( <= __WARN_ON+0x12/0x76)
Aug 10 11:32:29 cichlid kernel: .....[<c012053c>] ..   ( <= __WARN_ON+0x12/0x76)
Aug 10 11:32:29 cichlid kernel: 
Aug 10 11:32:29 cichlid kernel: ------------------------------
Aug 10 11:32:29 cichlid kernel: | showing all locks held by: |  (IRQ 14/206 [f7ea60a0,  51]):
Aug 10 11:32:29 cichlid kernel: ------------------------------
Aug 10 11:32:29 cichlid kernel: 
Aug 10 11:32:29 cichlid kernel: #001:             [c03e3b80] {ide_lock}
Aug 10 11:32:29 cichlid kernel: ... acquired at:               ide_end_request+0x19/0x95
Aug 10 11:32:29 cichlid kernel: 
Aug 10 11:32:29 cichlid kernel: #002:             [c03471a4] {console_sem.lock}
Aug 10 11:32:29 cichlid kernel: ... acquired at:               vprintk+0x140/0x253
Aug 10 11:32:30 cichlid kernel: 
Aug 10 11:32:30 cichlid kernel: #003:             [f7f6a4c8] {&cachep->spinlock}
Aug 10 11:32:30 cichlid kernel: ... acquired at:               __kmalloc+0x87/0x19a
Aug 10 11:32:30 cichlid kernel: 
Aug 10 11:32:30 cichlid kernel: IRQ 14/206[CPU#0]: BUG in FREE_WAITER at kernel/rt.c:1140
Aug 10 11:32:30 cichlid kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20 (20)
Aug 10 11:32:30 cichlid kernel:  [<c0103ef1>] dump_stack+0x1e/0x20 (20)
Aug 10 11:32:30 cichlid kernel:  [__WARN_ON+94/118] __WARN_ON+0x5e/0x76 (44)
Aug 10 11:32:30 cichlid kernel:  [<c0120588>] __WARN_ON+0x5e/0x76 (44)
Aug 10 11:32:30 cichlid kernel:  [__down_mutex+626/1578] __down_mutex+0x272/0x62a (124)
Aug 10 11:32:30 cichlid kernel:  [<c02f4c12>] __down_mutex+0x272/0x62a (124)
Aug 10 11:32:30 cichlid kernel:  [_spin_lock+31/68] __lock_text_start+0x1f/0x44 (28)
Aug 10 11:32:30 cichlid kernel:  [<c02f66cf>] __lock_text_start+0x1f/0x44 (28)
Aug 10 11:32:30 cichlid kernel:  [kfree+142/341] kfree+0x8e/0x155 (52)
Aug 10 11:32:30 cichlid kernel:  [<c0151b87>] kfree+0x8e/0x155 (52)
Aug 10 11:32:30 cichlid kernel:  [soft_cursor+360/412] soft_cursor+0x168/0x19c (64)
Aug 10 11:32:30 cichlid kernel:  [<c01dd94c>] soft_cursor+0x168/0x19c (64)
Aug 10 11:32:30 cichlid kernel:  [bit_cursor+733/1400] bit_cursor+0x2dd/0x578 (164)
Aug 10 11:32:30 cichlid kernel:  [<c01d668a>] bit_cursor+0x2dd/0x578 (164)
Aug 10 11:32:30 cichlid kernel:  [fbcon_cursor+404/593] fbcon_cursor+0x194/0x251 (76)
Aug 10 11:32:30 cichlid kernel:  [<c01d215f>] fbcon_cursor+0x194/0x251 (76)
Aug 10 11:32:30 cichlid kernel:  [hide_cursor+35/58] hide_cursor+0x23/0x3a (20)
Aug 10 11:32:30 cichlid kernel:  [<c020f51b>] hide_cursor+0x23/0x3a (20)
Aug 10 11:32:30 cichlid kernel:  [vt_console_print+602/664] vt_console_print+0x25a/0x298 (48)
Aug 10 11:32:30 cichlid kernel:  [<c0212300>] vt_console_print+0x25a/0x298 (48)
Aug 10 11:32:30 cichlid kernel:  [__call_console_drivers+87/92] __call_console_drivers+0x57/0x5c (32)
Aug 10 11:32:30 cichlid kernel:  [<c011f9b0>] __call_console_drivers+0x57/0x5c (32)
Aug 10 11:32:30 cichlid kernel:  [_call_console_drivers+121/123] _call_console_drivers+0x79/0x7b (24)
Aug 10 11:32:30 cichlid kernel:  [<c011fa2e>] _call_console_drivers+0x79/0x7b (24)
Aug 10 11:32:30 cichlid kernel:  [call_console_drivers+165/348] call_console_drivers+0xa5/0x15c (36)
Aug 10 11:32:30 cichlid kernel:  [<c011fad5>] call_console_drivers+0xa5/0x15c (36)
Aug 10 11:32:30 cichlid kernel:  [release_console_sem+46/235] release_console_sem+0x2e/0xeb (32)
Aug 10 11:32:30 cichlid kernel:  [<c011ffaf>] release_console_sem+0x2e/0xeb (32)
Aug 10 11:32:30 cichlid kernel:  [vprintk+366/595] vprintk+0x16e/0x253 (120)
Aug 10 11:32:30 cichlid kernel:  [<c011fde8>] vprintk+0x16e/0x253 (120)
Aug 10 11:32:30 cichlid kernel:  [printk+24/26] printk+0x18/0x1a (16)
Aug 10 11:32:30 cichlid kernel:  [<c011fc78>] printk+0x18/0x1a (16)
Aug 10 11:32:30 cichlid kernel:  [schedule+137/274] schedule+0x89/0x112 (28)
Aug 10 11:32:30 cichlid kernel:  [<c02f3db5>] schedule+0x89/0x112 (28)
Aug 10 11:32:30 cichlid kernel:  [__down_mutex+1156/1578] __down_mutex+0x484/0x62a (124)
Aug 10 11:32:30 cichlid kernel:  [<c02f4e24>] __down_mutex+0x484/0x62a (124)
Aug 10 11:32:30 cichlid kernel:  [_spin_lock_irqsave+31/73] _spin_lock_irqsave+0x1f/0x49 (28)
Aug 10 11:32:30 cichlid kernel:  [<c02f682b>] _spin_lock_irqsave+0x1f/0x49 (28)
Aug 10 11:32:31 cichlid kernel:  [__wake_up+21/95] __wake_up+0x15/0x5f (44)
Aug 10 11:32:31 cichlid kernel:  [<c011a5fb>] __wake_up+0x15/0x5f (44)
Aug 10 11:32:31 cichlid kernel:  [__wake_up_bit+52/58] __wake_up_bit+0x34/0x3a (24)
Aug 10 11:32:31 cichlid kernel:  [<c0135471>] __wake_up_bit+0x34/0x3a (24)
Aug 10 11:32:31 cichlid kernel:  [wake_up_bit+23/27] wake_up_bit+0x17/0x1b (16)
Aug 10 11:32:31 cichlid kernel:  [<c013548e>] wake_up_bit+0x17/0x1b (16)
Aug 10 11:32:31 cichlid kernel:  [unlock_buffer+17/19] unlock_buffer+0x11/0x13 (8)
Aug 10 11:32:31 cichlid kernel:  [<c0169431>] unlock_buffer+0x11/0x13 (8)
Aug 10 11:32:31 cichlid kernel:  [end_buffer_async_write+96/486] end_buffer_async_write+0x60/0x1e6 (68)
Aug 10 11:32:31 cichlid kernel:  [<c0169e66>] end_buffer_async_write+0x60/0x1e6 (68)
Aug 10 11:32:31 cichlid kernel:  [end_bio_bh_io_sync+47/102] end_bio_bh_io_sync+0x2f/0x66 (20)
Aug 10 11:32:31 cichlid kernel:  [<c016ce27>] end_bio_bh_io_sync+0x2f/0x66 (20)
Aug 10 11:32:31 cichlid kernel:  [bio_endio+78/120] bio_endio+0x4e/0x78 (32)
Aug 10 11:32:31 cichlid kernel:  [<c016e579>] bio_endio+0x4e/0x78 (32)
Aug 10 11:32:31 cichlid kernel:  [__end_that_request_first+212/586] __end_that_request_first+0xd4/0x24a (52)
Aug 10 11:32:31 cichlid kernel:  [<c022ad53>] __end_that_request_first+0xd4/0x24a (52)
Aug 10 11:32:31 cichlid kernel:  [end_that_request_first+34/36] end_that_request_first+0x22/0x24 (20)
Aug 10 11:32:31 cichlid kernel:  [<c022aeeb>] end_that_request_first+0x22/0x24 (20)
Aug 10 11:32:31 cichlid kernel:  [__ide_end_request+88/393] __ide_end_request+0x58/0x189 (36)
Aug 10 11:32:31 cichlid kernel:  [<c0239098>] __ide_end_request+0x58/0x189 (36)
Aug 10 11:32:31 cichlid kernel:  [ide_end_request+124/149] ide_end_request+0x7c/0x95 (40)
Aug 10 11:32:31 cichlid kernel:  [<c0239245>] ide_end_request+0x7c/0x95 (40)
Aug 10 11:32:31 cichlid kernel:  [ide_dma_intr+139/206] ide_dma_intr+0x8b/0xce (32)
Aug 10 11:32:31 cichlid kernel:  [<c0242214>] ide_dma_intr+0x8b/0xce (32)
Aug 10 11:32:31 cichlid kernel:  [ide_intr+164/317] ide_intr+0xa4/0x13d (36)
Aug 10 11:32:31 cichlid kernel:  [<c023afee>] ide_intr+0xa4/0x13d (36)
Aug 10 11:32:31 cichlid kernel:  [handle_IRQ_event+101/218] handle_IRQ_event+0x65/0xda (52)
Aug 10 11:32:31 cichlid kernel:  [<c0145cdb>] handle_IRQ_event+0x65/0xda (52)
Aug 10 11:32:31 cichlid kernel:  [do_hardirq+78/232] do_hardirq+0x4e/0xe8 (44)
Aug 10 11:32:31 cichlid kernel:  [<c0146440>] do_hardirq+0x4e/0xe8 (44)
Aug 10 11:32:31 cichlid kernel:  [do_irqd+204/467] do_irqd+0xcc/0x1d3 (40)
Aug 10 11:32:31 cichlid kernel:  [<c01465a6>] do_irqd+0xcc/0x1d3 (40)
Aug 10 11:32:31 cichlid kernel:  [kthread+165/205] kthread+0xa5/0xcd (48)
Aug 10 11:32:31 cichlid kernel:  [<c0134f1b>] kthread+0xa5/0xcd (48)
Aug 10 11:32:31 cichlid kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb (137879580)
Aug 10 11:32:31 cichlid kernel:  [<c010120d>] kernel_thread_helper+0x5/0xb (137879580)
Aug 10 11:32:32 cichlid kernel: ---------------------------
Aug 10 11:32:32 cichlid kernel: | preempt count: 20000001 ]
Aug 10 11:32:32 cichlid kernel: | 1-level deep critical section nesting:
Aug 10 11:32:32 cichlid kernel: ----------------------------------------
Aug 10 11:32:32 cichlid kernel: .. [add_preempt_count+28/30] .... add_preempt_count+0x1c/0x1e
Aug 10 11:32:32 cichlid kernel: .. [<c013cbb0>] .... add_preempt_count+0x1c/0x1e
Aug 10 11:32:32 cichlid kernel: .....[__WARN_ON+18/118] ..   ( <= __WARN_ON+0x12/0x76)
Aug 10 11:32:32 cichlid kernel: .....[<c012053c>] ..   ( <= __WARN_ON+0x12/0x76)
Aug 10 11:32:33 cichlid kernel: 
Aug 10 11:32:37 cichlid kernel: ------------------------------
Aug 10 11:32:37 cichlid kernel: | showing all locks held by: |  (IRQ 14/206 [f7ea60a0,  51]):
Aug 10 11:32:37 cichlid kernel: ------------------------------
Aug 10 11:32:37 cichlid kernel: 
Aug 10 11:32:37 cichlid kernel: #001:             [c03e3b80] {ide_lock}
Aug 10 11:32:37 cichlid kernel: ... acquired at:               ide_end_request+0x19/0x95
Aug 10 11:32:37 cichlid kernel: 
Aug 10 11:32:37 cichlid kernel: #002:             [c03471a4] {console_sem.lock}
Aug 10 11:32:37 cichlid kernel: ... acquired at:               vprintk+0x140/0x253
Aug 10 11:32:37 cichlid kernel: 
Aug 10 11:32:37 cichlid kernel: #003:             [f7f6a4c8] {&cachep->spinlock}
Aug 10 11:32:37 cichlid kernel: ... acquired at:               kfree+0x8e/0x155
Aug 10 11:32:37 cichlid kernel: 
Aug 10 11:32:37 cichlid kernel: #004:             [c1808d40] {&q->lock}
Aug 10 11:32:37 cichlid kernel: ... acquired at:               __wake_up+0x15/0x5f
Aug 10 11:32:37 cichlid kernel: 
Aug 10 11:32:37 cichlid kernel: caller is __down_mutex+0x484/0x62a
Aug 10 11:32:37 cichlid kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20 (20)
Aug 10 11:32:37 cichlid kernel:  [<c0103ef1>] dump_stack+0x1e/0x20 (20)
Aug 10 11:32:37 cichlid kernel:  [schedule+161/274] schedule+0xa1/0x112 (28)
Aug 10 11:32:37 cichlid kernel:  [<c02f3dcd>] schedule+0xa1/0x112 (28)
Aug 10 11:32:37 cichlid kernel:  [__down_mutex+1156/1578] __down_mutex+0x484/0x62a (124)
Aug 10 11:32:37 cichlid kernel:  [<c02f4e24>] __down_mutex+0x484/0x62a (124)
Aug 10 11:32:37 cichlid kernel:  [_spin_lock_irqsave+31/73] _spin_lock_irqsave+0x1f/0x49 (28)
Aug 10 11:32:37 cichlid kernel:  [<c02f682b>] _spin_lock_irqsave+0x1f/0x49 (28)
Aug 10 11:32:37 cichlid kernel:  [__wake_up+21/95] __wake_up+0x15/0x5f (44)
Aug 10 11:32:37 cichlid kernel:  [<c011a5fb>] __wake_up+0x15/0x5f (44)
Aug 10 11:32:37 cichlid kernel:  [__wake_up_bit+52/58] __wake_up_bit+0x34/0x3a (24)
Aug 10 11:32:37 cichlid kernel:  [<c0135471>] __wake_up_bit+0x34/0x3a (24)
Aug 10 11:32:37 cichlid kernel:  [wake_up_bit+23/27] wake_up_bit+0x17/0x1b (16)
Aug 10 11:32:37 cichlid kernel:  [<c013548e>] wake_up_bit+0x17/0x1b (16)
Aug 10 11:32:37 cichlid kernel:  [unlock_buffer+17/19] unlock_buffer+0x11/0x13 (8)
Aug 10 11:32:37 cichlid kernel:  [<c0169431>] unlock_buffer+0x11/0x13 (8)
Aug 10 11:32:37 cichlid kernel:  [end_buffer_async_write+96/486] end_buffer_async_write+0x60/0x1e6 (68)
Aug 10 11:32:37 cichlid kernel:  [<c0169e66>] end_buffer_async_write+0x60/0x1e6 (68)
Aug 10 11:32:37 cichlid kernel:  [end_bio_bh_io_sync+47/102] end_bio_bh_io_sync+0x2f/0x66 (20)
Aug 10 11:32:37 cichlid kernel:  [<c016ce27>] end_bio_bh_io_sync+0x2f/0x66 (20)
Aug 10 11:32:37 cichlid kernel:  [bio_endio+78/120] bio_endio+0x4e/0x78 (32)
Aug 10 11:32:38 cichlid kernel:  [<c016e579>] bio_endio+0x4e/0x78 (32)
Aug 10 11:32:38 cichlid kernel:  [__end_that_request_first+212/586] __end_that_request_first+0xd4/0x24a (52)
Aug 10 11:32:39 cichlid kernel:  [<c022ad53>] __end_that_request_first+0xd4/0x24a (52)
Aug 10 11:32:39 cichlid kernel:  [end_that_request_first+34/36] end_that_request_first+0x22/0x24 (20)
Aug 10 11:32:39 cichlid kernel:  [<c022aeeb>] end_that_request_first+0x22/0x24 (20)
Aug 10 11:32:39 cichlid kernel:  [__ide_end_request+88/393] __ide_end_request+0x58/0x189 (36)
Aug 10 11:32:39 cichlid kernel:  [<c0239098>] __ide_end_request+0x58/0x189 (36)
Aug 10 11:32:39 cichlid kernel:  [ide_end_request+124/149] ide_end_request+0x7c/0x95 (40)
Aug 10 11:32:39 cichlid kernel:  [<c0239245>] ide_end_request+0x7c/0x95 (40)
Aug 10 11:32:39 cichlid kernel:  [ide_dma_intr+139/206] ide_dma_intr+0x8b/0xce (32)
Aug 10 11:32:39 cichlid kernel:  [<c0242214>] ide_dma_intr+0x8b/0xce (32)
Aug 10 11:32:39 cichlid kernel:  [ide_intr+164/317] ide_intr+0xa4/0x13d (36)
Aug 10 11:32:39 cichlid kernel:  [<c023afee>] ide_intr+0xa4/0x13d (36)
Aug 10 11:32:39 cichlid kernel:  [handle_IRQ_event+101/218] handle_IRQ_event+0x65/0xda (52)
Aug 10 11:32:39 cichlid kernel:  [<c0145cdb>] handle_IRQ_event+0x65/0xda (52)
Aug 10 11:32:39 cichlid kernel:  [do_hardirq+78/232] do_hardirq+0x4e/0xe8 (44)
Aug 10 11:32:39 cichlid kernel:  [<c0146440>] do_hardirq+0x4e/0xe8 (44)
Aug 10 11:32:39 cichlid kernel:  [do_irqd+204/467] do_irqd+0xcc/0x1d3 (40)
Aug 10 11:32:39 cichlid kernel:  [<c01465a6>] do_irqd+0xcc/0x1d3 (40)
Aug 10 11:32:39 cichlid kernel:  [kthread+165/205] kthread+0xa5/0xcd (48)
Aug 10 11:32:39 cichlid kernel:  [<c0134f1b>] kthread+0xa5/0xcd (48)
Aug 10 11:32:39 cichlid kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb (137879580)
Aug 10 11:32:39 cichlid kernel:  [<c010120d>] kernel_thread_helper+0x5/0xb (137879580)
Aug 10 11:32:39 cichlid kernel: ---------------------------
Aug 10 11:32:39 cichlid kernel: | preempt count: 20000000 ]
Aug 10 11:32:39 cichlid kernel: | 0-level deep critical section nesting:
Aug 10 11:32:39 cichlid kernel: ----------------------------------------
Aug 10 11:32:39 cichlid kernel: 
Aug 10 11:32:39 cichlid kernel: ------------------------------
Aug 10 11:32:39 cichlid kernel: | showing all locks held by: |  (IRQ 14/206 [f7ea60a0,  51]):
Aug 10 11:32:39 cichlid kernel: ------------------------------
Aug 10 11:32:39 cichlid kernel: 
Aug 10 11:32:39 cichlid kernel: #001:             [c03e3b80] {ide_lock}
Aug 10 11:32:39 cichlid kernel: ... acquired at:               ide_end_request+0x19/0x95
Aug 10 11:32:39 cichlid kernel: 
Aug 10 11:32:39 cichlid kernel: #002:             [c1808d40] {&q->lock}
Aug 10 11:32:39 cichlid kernel: ... acquired at:               __wake_up+0x15/0x5f
Aug 10 11:32:39 cichlid kernel: 
