Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWHNGgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWHNGgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 02:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWHNGgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 02:36:41 -0400
Received: from tornado.reub.net ([202.89.145.182]:48065 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751551AbWHNGgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 02:36:41 -0400
Message-ID: <44E019F6.40506@reub.net>
Date: Mon, 14 Aug 2006 18:36:38 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 2.0a1 (Windows/20060813)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm1
References: <20060813012454.f1d52189.akpm@osdl.org> <6bffcb0e0608130524j81944bag14c65957c2781e7f@mail.gmail.com>
In-Reply-To: <6bffcb0e0608130524j81944bag14c65957c2781e7f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2006 12:24 a.m., Michal Piotrowski wrote:
> On 13/08/06, Andrew Morton <akpm@osdl.org> wrote:
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/ 
>>
>>
>> - Warning: all the Serial ATA Kconfig options have been renamed.  If you
>>   blindly run `make oldconfig' you won't have any disks.
>>
> 
> MAX_STACK_TRACE_ENTRIES too low!
> 
> What does it mean?
> 
> BUG: MAX_STACK_TRACE_ENTRIES too low!
> turning off the locking correctness validator.
> [<c0103e41>] dump_trace+0x70/0x176
> [<c0103fc1>] show_trace_log_lvl+0x12/0x22
> [<c0103fde>] show_trace+0xd/0xf
> [<c01040b0>] dump_stack+0x17/0x19
> [<c0138f30>] save_trace+0xce/0xd7
> [<c0139370>] add_lock_to_list+0x22/0x39
> [<c0139b3c>] check_prev_add+0x139/0x1b4
> [<c0139c04>] check_prevs_add+0x4d/0xaf
> [<c013b646>] __lock_acquire+0x8a1/0x93c
> [<c013bd4c>] lock_acquire+0x6f/0x8f
> [<c03033e8>] _spin_lock_irq+0x29/0x35
> [<c01ed022>] __make_request+0x68/0x413
> [<c01ed6a7>] generic_make_request+0x273/0x2a4
> [<c01ed802>] submit_bio+0x12a/0x132
> [<c017b6f6>] submit_bh+0x10e/0x12e
> [<c0179fd3>] __block_write_full_page+0x231/0x326
> [<c017b567>] block_write_full_page+0xd7/0xdf
> [<c017e17a>] blkdev_writepage+0xf/0x11
> [<c0199d92>] mpage_writepages+0x1b6/0x324
> [<c017f3ee>] generic_writepages+0xa/0xc
> [<c015b6b5>] do_writepages+0x23/0x36
> [<c019871c>] __sync_single_inode+0x7b/0x199
> [<c01989ac>] __writeback_single_inode+0x172/0x17a
> [<c0198b50>] generic_sync_sb_inodes+0x19c/0x242
> [<c0198c13>] sync_sb_inodes+0x1d/0x20
> [<c0198c8e>] writeback_inodes+0x78/0xae
> [<c015b52b>] wb_kupdate+0x7c/0xdd
> [<c015bf14>] __pdflush+0xcc/0x163
> [<c015bfdd>] pdflush+0x32/0x34
> [<c01347a9>] kthread+0x82/0xaa
> [<c0303dfd>] kernel_thread_helper+0x5/0xb
> [<c0103fc1>] show_trace_log_lvl+0x12/0x22
> [<c0103fde>] show_trace+0xd/0xf
> [<c01040b0>] dump_stack+0x17/0x19
> [<c0138f30>] save_trace+0xce/0xd7
> [<c0139370>] add_lock_to_list+0x22/0x39
> [<c0139b3c>] check_prev_add+0x139/0x1b4
> [<c0139c04>] check_prevs_add+0x4d/0xaf
> [<c013b646>] __lock_acquire+0x8a1/0x93c
> [<c013bd4c>] lock_acquire+0x6f/0x8f
> [<c03033e8>] _spin_lock_irq+0x29/0x35
> [<c01ed022>] __make_request+0x68/0x413
> [<c01ed6a7>] generic_make_request+0x273/0x2a4
> [<c01ed802>] submit_bio+0x12a/0x132
> [<c017b6f6>] submit_bh+0x10e/0x12e
> [<c0179fd3>] __block_write_full_page+0x231/0x326
> [<c017b567>] block_write_full_page+0xd7/0xdf
> [<c017e17a>] blkdev_writepage+0xf/0x11
> [<c0199d92>] mpage_writepages+0x1b6/0x324
> [<c017f3ee>] generic_writepages+0xa/0xc
> [<c015b6b5>] do_writepages+0x23/0x36
> [<c019871c>] __sync_single_inode+0x7b/0x199
> [<c01989ac>] __writeback_single_inode+0x172/0x17a
> [<c0198b50>] generic_sync_sb_inodes+0x19c/0x242
> [<c0198c13>] sync_sb_inodes+0x1d/0x20
> [<c0198c8e>] writeback_inodes+0x78/0xae
> [<c015b52b>] wb_kupdate+0x7c/0xdd
> [<c015bf14>] __pdflush+0xcc/0x163
> [<c015bfdd>] pdflush+0x32/0x34
> [<c01347a9>] kthread+0x82/0xaa
> [<c0303dfd>] kernel_thread_helper+0x5/0xb
> =======================
> 
> config & dmesg 
> http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm1/frontline/
> 
> Regards,
> Michal

Seeing this message here as well, which I guess is the same thing even though 
the trace is a bit different.

IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.

Call Trace:
  [<ffffffff8026cdfe>] dump_trace+0xbe/0x3a0
  [<ffffffff8026d11c>] show_trace+0x3c/0x55
  [<ffffffff8026d14a>] dump_stack+0x15/0x1b
  [<ffffffff8029bec6>] save_trace+0xd6/0xe3
  [<ffffffff8029bf55>] add_lock_to_list+0x82/0xab
  [<ffffffff8029e720>] __lock_acquire+0xad0/0xc78
  [<ffffffff8029e917>] lock_acquire+0x4f/0x78
  [<ffffffff80268698>] _spin_lock+0x25/0x34
  [<ffffffff803ff699>] ata_scsi_queuecmd+0x39/0x16a
  [<ffffffff803e7fb7>] scsi_dispatch_cmd+0x1f7/0x250
  [<ffffffff803ecbd6>] scsi_request_fn+0x296/0x380
  [<ffffffff8035f7b2>] __generic_unplug_device+0x28/0x2f
  [<ffffffff8025ea4b>] generic_unplug_device+0x25/0x38
  [<ffffffff80261a4b>] blk_backing_dev_unplug+0x16/0x1b
  [<ffffffff80215aa9>] sync_buffer+0x39/0x42
  [<ffffffff80266951>] __wait_on_bit+0x45/0x79
  [<ffffffff802669f4>] out_of_line_wait_on_bit+0x6f/0x8b
  [<ffffffff8024c49a>] __wait_on_buffer+0x20/0x22
  [<ffffffff8023c790>] sync_dirty_buffer+0x90/0xd0
  [<ffffffff803329e9>] journal_update_superblock+0x89/0xd6
  [<ffffffff80330e01>] cleanup_journal_tail+0x121/0x132
  [<ffffffff80330eec>] log_do_checkpoint+0x1c/0x47b
  [<ffffffff803314ae>] __log_wait_for_space+0x9a/0xc0
  [<ffffffff8032d84b>] start_this_handle+0x1fb/0x46a
  [<ffffffff8032db95>] journal_start+0xdb/0x116
  [<ffffffff80325a4a>] ext3_journal_start_sb+0x4a/0x4c
  [<ffffffff8032067e>] ext3_dirty_inode+0x31/0x93
  [<ffffffff802140fe>] __mark_inode_dirty+0x2e/0x19f
  [<ffffffff8020bd2c>] touch_atime+0x9c/0xa3
  [<ffffffff80222464>] generic_file_mmap+0x39/0x4f
  [<ffffffff8020e5e5>] do_mmap_pgoff+0x4b5/0x7b5
  [<ffffffff802241a1>] sys_mmap+0x94/0xcf
  [<ffffffff802625fe>] system_call+0x7e/0x83
  [<00002b03387e4e0a>]
  [<ffffffff8029bec6>] save_trace+0xd6/0xe3
  [<ffffffff8029bf55>] add_lock_to_list+0x82/0xab
  [<ffffffff8029e720>] __lock_acquire+0xad0/0xc78
  [<ffffffff803e7841>] scsi_done+0x0/0x24
  [<ffffffff8029e917>] lock_acquire+0x4f/0x78
  [<ffffffff803ff699>] ata_scsi_queuecmd+0x39/0x16a
  [<ffffffff80268698>] _spin_lock+0x25/0x34
  [<ffffffff803ff699>] ata_scsi_queuecmd+0x39/0x16a
  [<ffffffff803e7fb7>] scsi_dispatch_cmd+0x1f7/0x250
  [<ffffffff803ecbd6>] scsi_request_fn+0x296/0x380
  [<ffffffff8035f7b2>] __generic_unplug_device+0x28/0x2f
  [<ffffffff8025ea4b>] generic_unplug_device+0x25/0x38
  [<ffffffff80261a4b>] blk_backing_dev_unplug+0x16/0x1b
  [<ffffffff80215aa9>] sync_buffer+0x39/0x42
  [<ffffffff80266951>] __wait_on_bit+0x45/0x79
  [<ffffffff80215a70>] sync_buffer+0x0/0x42
  [<ffffffff80215a70>] sync_buffer+0x0/0x42
  [<ffffffff802669f4>] out_of_line_wait_on_bit+0x6f/0x8b
  [<ffffffff80298270>] wake_bit_function+0x0/0x31
  [<ffffffff8024c49a>] __wait_on_buffer+0x20/0x22
  [<ffffffff8023c790>] sync_dirty_buffer+0x90/0xd0
  [<ffffffff803329e9>] journal_update_superblock+0x89/0xd6
  [<ffffffff80330e01>] cleanup_journal_tail+0x121/0x132
  [<ffffffff80330eec>] log_do_checkpoint+0x1c/0x47b
  [<ffffffff8029dc25>] check_noncircular+0x95/0xc0
  [<ffffffff8029dc25>] check_noncircular+0x95/0xc0
  [<ffffffff8029dc25>] check_noncircular+0x95/0xc0
  [<ffffffff8029cf5d>] find_usage_backwards+0x7a/0xa1
  [<ffffffff8029d91c>] check_usage+0x35/0x2a9
  [<ffffffff8029e67d>] __lock_acquire+0xa2d/0xc78
  [<ffffffff803314ae>] __log_wait_for_space+0x9a/0xc0
  [<ffffffff8032d84b>] start_this_handle+0x1fb/0x46a
  [<ffffffff8020a649>] kmem_cache_alloc+0xb9/0xd0
  [<ffffffff8032db95>] journal_start+0xdb/0x116
  [<ffffffff80325a4a>] ext3_journal_start_sb+0x4a/0x4c
  [<ffffffff8032067e>] ext3_dirty_inode+0x31/0x93
  [<ffffffff802140fe>] __mark_inode_dirty+0x2e/0x19f
  [<ffffffff80222421>] dbg_redzone1+0x1d/0x27
  [<ffffffff8020bd2c>] touch_atime+0x9c/0xa3
  [<ffffffff80222464>] generic_file_mmap+0x39/0x4f
  [<ffffffff8020e5e5>] do_mmap_pgoff+0x4b5/0x7b5
  [<ffffffff8026899f>] _spin_unlock_irq+0x2b/0x33
  [<ffffffff802241a1>] sys_mmap+0x94/0xcf
  [<ffffffff802625fe>] system_call+0x7e/0x83

Can someone take a look at this too, please?

Reuben



