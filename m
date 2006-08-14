Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751962AbWHNJHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbWHNJHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 05:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWHNJHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 05:07:45 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:9114 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751962AbWHNJHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 05:07:44 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: 2.6.18-rc4-mm1
Date: Mon, 14 Aug 2006 11:06:10 +0200
User-Agent: KMail/1.9.3
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060813012454.f1d52189.akpm@osdl.org> <6bffcb0e0608130524j81944bag14c65957c2781e7f@mail.gmail.com> <44E019F6.40506@reub.net>
In-Reply-To: <44E019F6.40506@reub.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608141106.10753.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 08:36, Reuben Farrelly wrote:
> On 14/08/2006 12:24 a.m., Michal Piotrowski wrote:
> > On 13/08/06, Andrew Morton <akpm@osdl.org> wrote:
> >>
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/ 
> >>
> >>
> >> - Warning: all the Serial ATA Kconfig options have been renamed.  If you
> >>   blindly run `make oldconfig' you won't have any disks.
> >>
> > 
> > MAX_STACK_TRACE_ENTRIES too low!
> > 
> > What does it mean?
> > 
> > BUG: MAX_STACK_TRACE_ENTRIES too low!
> > turning off the locking correctness validator.
> > [<c0103e41>] dump_trace+0x70/0x176
> > [<c0103fc1>] show_trace_log_lvl+0x12/0x22
> > [<c0103fde>] show_trace+0xd/0xf
> > [<c01040b0>] dump_stack+0x17/0x19
> > [<c0138f30>] save_trace+0xce/0xd7
> > [<c0139370>] add_lock_to_list+0x22/0x39
> > [<c0139b3c>] check_prev_add+0x139/0x1b4
> > [<c0139c04>] check_prevs_add+0x4d/0xaf
> > [<c013b646>] __lock_acquire+0x8a1/0x93c
> > [<c013bd4c>] lock_acquire+0x6f/0x8f
> > [<c03033e8>] _spin_lock_irq+0x29/0x35
> > [<c01ed022>] __make_request+0x68/0x413
> > [<c01ed6a7>] generic_make_request+0x273/0x2a4
> > [<c01ed802>] submit_bio+0x12a/0x132
> > [<c017b6f6>] submit_bh+0x10e/0x12e
> > [<c0179fd3>] __block_write_full_page+0x231/0x326
> > [<c017b567>] block_write_full_page+0xd7/0xdf
> > [<c017e17a>] blkdev_writepage+0xf/0x11
> > [<c0199d92>] mpage_writepages+0x1b6/0x324
> > [<c017f3ee>] generic_writepages+0xa/0xc
> > [<c015b6b5>] do_writepages+0x23/0x36
> > [<c019871c>] __sync_single_inode+0x7b/0x199
> > [<c01989ac>] __writeback_single_inode+0x172/0x17a
> > [<c0198b50>] generic_sync_sb_inodes+0x19c/0x242
> > [<c0198c13>] sync_sb_inodes+0x1d/0x20
> > [<c0198c8e>] writeback_inodes+0x78/0xae
> > [<c015b52b>] wb_kupdate+0x7c/0xdd
> > [<c015bf14>] __pdflush+0xcc/0x163
> > [<c015bfdd>] pdflush+0x32/0x34
> > [<c01347a9>] kthread+0x82/0xaa
> > [<c0303dfd>] kernel_thread_helper+0x5/0xb
> > [<c0103fc1>] show_trace_log_lvl+0x12/0x22
> > [<c0103fde>] show_trace+0xd/0xf
> > [<c01040b0>] dump_stack+0x17/0x19
> > [<c0138f30>] save_trace+0xce/0xd7
> > [<c0139370>] add_lock_to_list+0x22/0x39
> > [<c0139b3c>] check_prev_add+0x139/0x1b4
> > [<c0139c04>] check_prevs_add+0x4d/0xaf
> > [<c013b646>] __lock_acquire+0x8a1/0x93c
> > [<c013bd4c>] lock_acquire+0x6f/0x8f
> > [<c03033e8>] _spin_lock_irq+0x29/0x35
> > [<c01ed022>] __make_request+0x68/0x413
> > [<c01ed6a7>] generic_make_request+0x273/0x2a4
> > [<c01ed802>] submit_bio+0x12a/0x132
> > [<c017b6f6>] submit_bh+0x10e/0x12e
> > [<c0179fd3>] __block_write_full_page+0x231/0x326
> > [<c017b567>] block_write_full_page+0xd7/0xdf
> > [<c017e17a>] blkdev_writepage+0xf/0x11
> > [<c0199d92>] mpage_writepages+0x1b6/0x324
> > [<c017f3ee>] generic_writepages+0xa/0xc
> > [<c015b6b5>] do_writepages+0x23/0x36
> > [<c019871c>] __sync_single_inode+0x7b/0x199
> > [<c01989ac>] __writeback_single_inode+0x172/0x17a
> > [<c0198b50>] generic_sync_sb_inodes+0x19c/0x242
> > [<c0198c13>] sync_sb_inodes+0x1d/0x20
> > [<c0198c8e>] writeback_inodes+0x78/0xae
> > [<c015b52b>] wb_kupdate+0x7c/0xdd
> > [<c015bf14>] __pdflush+0xcc/0x163
> > [<c015bfdd>] pdflush+0x32/0x34
> > [<c01347a9>] kthread+0x82/0xaa
> > [<c0303dfd>] kernel_thread_helper+0x5/0xb
> > =======================
> > 
> > config & dmesg 
> > http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm1/frontline/
> > 
> > Regards,
> > Michal
> 
> Seeing this message here as well, which I guess is the same thing even though 
> the trace is a bit different.

I'm seeing these too, on x86_64:

PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.

Call Trace:
 [<ffffffff8020b0d9>] dump_trace+0x99/0x3b0
 [<ffffffff8020b433>] show_trace+0x43/0x60
 [<ffffffff8020b735>] dump_stack+0x15/0x20
 [<ffffffff802484d6>] save_trace+0xd6/0xf0
 [<ffffffff80248601>] add_lock_to_list+0x91/0xc0
 [<ffffffff8024a861>] __lock_acquire+0xb01/0xd30
 [<ffffffff8024ae2b>] lock_acquire+0x8b/0xc0
 [<ffffffff8047259f>] _spin_lock+0x2f/0x40
 [<ffffffff802889a2>] cache_alloc_refill+0xa2/0x7f0
 [<ffffffff802888a7>] kmem_cache_alloc+0x77/0xd0
 [<ffffffff804349ce>] inet_twsk_alloc+0x2e/0x140
 [<ffffffff8044a404>] tcp_time_wait+0x64/0x350
 [<ffffffff8043ba5e>] tcp_fin+0xde/0x1f0
 [<ffffffff8043efa5>] tcp_data_queue+0x2c5/0xbf0
 [<ffffffff804405b8>] tcp_rcv_state_process+0xce8/0xd80
 [<ffffffff804486f4>] tcp_v4_do_rcv+0x334/0x390
 [<ffffffff804496e7>] tcp_v4_rcv+0x8f7/0x960
 [<ffffffff8042c44a>] ip_local_deliver+0x19a/0x250
 [<ffffffff8042c9a4>] ip_rcv+0x4a4/0x4f0
 [<ffffffff8040ded4>] netif_receive_skb+0x314/0x370
 [<ffffffff8813b1cf>] :skge:skge_poll+0x43f/0x570
 [<ffffffff8040c25a>] net_rx_action+0xba/0x1f0
 [<ffffffff80232e40>] __do_softirq+0x70/0xf0
 [<ffffffff8020aa7c>] call_softirq+0x1c/0x30
 [<ffffffff8020cbcd>] do_softirq+0x3d/0xb0
 [<ffffffff80232c9e>] irq_exit+0x4e/0x60
 [<ffffffff8020cd75>] do_IRQ+0x135/0x140
 [<ffffffff8020a266>] ret_from_intr+0x0/0xf
 [<ffffffff802083b2>] default_idle+0x42/0x80
 [<ffffffff80208445>] cpu_idle+0x55/0xa0
 [<ffffffff8020703a>] rest_init+0x3a/0x40
 [<ffffffff8090d81f>] start_kernel+0x24f/0x260
 [<ffffffff8090d15f>] _sinittext+0x15f/0x170
 <IRQ>  [<ffffffff802484d6>] save_trace+0xd6/0xf0
 [<ffffffff80248601>] add_lock_to_list+0x91/0xc0
 [<ffffffff8024a861>] __lock_acquire+0xb01/0xd30
 [<ffffffff8024aed9>] mark_held_locks+0x79/0xa0
 [<ffffffff802889a2>] cache_alloc_refill+0xa2/0x7f0
 [<ffffffff8024ae2b>] lock_acquire+0x8b/0xc0
 [<ffffffff802889a2>] cache_alloc_refill+0xa2/0x7f0
 [<ffffffff804349ce>] inet_twsk_alloc+0x2e/0x140
 [<ffffffff8047259f>] _spin_lock+0x2f/0x40
 [<ffffffff802889a2>] cache_alloc_refill+0xa2/0x7f0
 [<ffffffff80287fbf>] check_poison_obj+0x2f/0x1e0
 [<ffffffff8028715d>] dbg_redzone1+0x1d/0x30
 [<ffffffff804349ce>] inet_twsk_alloc+0x2e/0x140
 [<ffffffff802888a7>] kmem_cache_alloc+0x77/0xd0
 [<ffffffff804349ce>] inet_twsk_alloc+0x2e/0x140
 [<ffffffff8044a404>] tcp_time_wait+0x64/0x350
 [<ffffffff8043ba5e>] tcp_fin+0xde/0x1f0
 [<ffffffff8043efa5>] tcp_data_queue+0x2c5/0xbf0
 [<ffffffff8023723b>] mod_timer+0x2b/0x30
 [<ffffffff804405b8>] tcp_rcv_state_process+0xce8/0xd80
 [<ffffffff804486f4>] tcp_v4_do_rcv+0x334/0x390
 [<ffffffff80449280>] tcp_v4_rcv+0x490/0x960
 [<ffffffff804496e7>] tcp_v4_rcv+0x8f7/0x960
 [<ffffffff8042c44a>] ip_local_deliver+0x19a/0x250
 [<ffffffff8042c9a4>] ip_rcv+0x4a4/0x4f0
 [<ffffffff80407797>] kfree_skb+0x27/0x30
 [<ffffffff88297634>] :af_packet:packet_rcv_spkt+0x184/0x1a0
 [<ffffffff8040ded4>] netif_receive_skb+0x314/0x370
 [<ffffffff8813b1cf>] :skge:skge_poll+0x43f/0x570
 [<ffffffff8040c25a>] net_rx_action+0xba/0x1f0
 [<ffffffff80232e40>] __do_softirq+0x70/0xf0
 [<ffffffff8020aa7c>] call_softirq+0x1c/0x30
 [<ffffffff8020cbcd>] do_softirq+0x3d/0xb0
 [<ffffffff80232c9e>] irq_exit+0x4e/0x60
 [<ffffffff8020cd75>] do_IRQ+0x135/0x140
 [<ffffffff80208370>] default_idle+0x0/0x80
 [<ffffffff8020a266>] ret_from_intr+0x0/0xf
 <EOI>  [<ffffffff802083b0>] default_idle+0x40/0x80
 [<ffffffff802083b2>] default_idle+0x42/0x80
 [<ffffffff80208445>] cpu_idle+0x55/0xa0
 [<ffffffff8020703a>] rest_init+0x3a/0x40
 [<ffffffff8090d81f>] start_kernel+0x24f/0x260
 [<ffffffff8090d15f>] _sinittext+0x15f/0x170

