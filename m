Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWIZPo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWIZPo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWIZPo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:44:56 -0400
Received: from zod.pns.networktel.net ([209.159.47.6]:41720 "EHLO
	zod.pns.networktel.net") by vger.kernel.org with ESMTP
	id S1751074AbWIZPoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:44:55 -0400
Message-ID: <45194883.3080700@versaccounting.com>
Date: Tue, 26 Sep 2006 10:34:27 -0500
From: Ben Duncan <ben@versaccounting.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: EIP Errors kernel 2.6.18 ...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Getting EIP erros with 2.6.18 ...
following from Syslog ..

Any Ideas what is going on?
Thanks ...

Sep 26 04:46:23 desktop kernel: ------------[ cut here ]------------
Sep 26 04:46:23 desktop kernel: kernel BUG at lib/radix-tree.c:404!
Sep 26 04:46:23 desktop kernel: invalid opcode: 0000 [#1]
Sep 26 04:46:23 desktop kernel: DEBUG_PAGEALLOC
Sep 26 04:46:23 desktop kernel: Modules linked in: sr_mod nvidia uhci_hcd nvidia_agp 
i2c_nforce2 sata_nv sd_mod ide_scsi agpgart sata_sil libata genrtc
Sep 26 04:46:23 desktop kernel: CPU:    0
Sep 26 04:46:23 desktop kernel: EIP:    0060:[<c01ba714>]    Tainted: P      VLI
Sep 26 04:46:23 desktop kernel: EFLAGS: 00010046   (2.6.18 #1)
Sep 26 04:46:23 desktop kernel: EIP is at radix_tree_tag_set+0x6a/0xa2
Sep 26 04:46:23 desktop kernel: eax: 00000001   ebx: 00000001   ecx: 00000001   edx: 00000001
Sep 26 04:46:23 desktop kernel: esi: 00000000   edi: 00000000   ebp: f7cf3d70   esp: f7cf3d54
Sep 26 04:46:23 desktop kernel: ds: 007b   es: 007b   ss: 0068
Sep 26 04:46:23 desktop kernel: Process pdflush (pid: 181, ti=f7cf2000 task=f7cd6a90 
task.ti=f7cf2000)
Sep 26 04:46:23 desktop kernel: Stack: 00000001 00000001 00050001 f71a2f4c c1061be0 f71a2f48 
00000000 f7cf3d88
Sep 26 04:46:23 desktop kernel:        c013579e 00000286 f57d5f68 c1061be0 00050002 f7cf3db8 
c014ccc8 00000000
Sep 26 04:46:23 desktop kernel:        00001000 f57d5f68 000773b0 00000000 c0150760 f71a2e70 
00000000 c1061be0
Sep 26 04:46:23 desktop kernel: Call Trace:
Sep 26 04:46:23 desktop kernel:  [<c0103485>] show_stack_log_lvl+0x8f/0x97
Sep 26 04:46:23 desktop kernel:  [<c01035e6>] show_registers+0x116/0x17f
Sep 26 04:46:23 desktop kernel:  [<c01037cb>] die+0x108/0x1ba
Sep 26 04:46:23 desktop kernel:  [<c01038f9>] do_trap+0x7c/0x96
Sep 26 04:46:23 desktop kernel:  [<c0103b64>] do_invalid_op+0x95/0x9c
Sep 26 04:46:23 desktop kernel:  [<c0103161>] error_code+0x39/0x40
Sep 26 04:46:23 desktop kernel:  [<c013579e>] test_set_page_writeback+0x79/0xd1
Sep 26 04:46:23 desktop kernel:  [<c014ccc8>] __block_write_full_page+0x18f/0x292
Sep 26 04:46:23 desktop kernel:  [<c014e087>] block_write_full_page+0x9e/0xa6
Sep 26 04:46:23 desktop kernel:  [<c0150850>] blkdev_writepage+0xf/0x11
Sep 26 04:46:23 desktop kernel:  [<c0168e74>] mpage_writepages+0x1aa/0x304
Sep 26 04:46:23 desktop kernel:  [<c01519a3>] generic_writepages+0xa/0xf
Sep 26 04:46:23 desktop kernel:  [<c013531b>] do_writepages+0x25/0x38
Sep 26 04:46:23 desktop kernel:  [<c016788e>] __sync_single_inode+0x62/0x1bc
Sep 26 04:46:23 desktop kernel:  [<c0167b31>] __writeback_single_inode+0x149/0x151
Sep 26 04:46:23 desktop kernel:  [<c0167ce3>] sync_sb_inodes+0x1aa/0x275
Sep 26 04:46:23 desktop kernel:  [<c0167e39>] writeback_inodes+0x8b/0xd9
Sep 26 04:46:23 desktop kernel:  [<c01351aa>] wb_kupdate+0x70/0xd3
Sep 26 04:46:23 desktop kernel:  [<c013590a>] __pdflush+0xda/0x171
Sep 26 04:46:23 desktop kernel:  [<c01359ca>] pdflush+0x29/0x2b
Sep 26 04:46:23 desktop kernel:  [<c01242ee>] kthread+0x79/0xa1
Sep 26 04:46:23 desktop kernel:  [<c0100d19>] kernel_thread_helper+0x5/0xb
Sep 26 04:46:23 desktop kernel: Code: 83 e0 3f 89 45 e4 8d 14 ce 0f a3 82 04 01 00 00 19 c0 
85 c0 75 0a 8b 45 e4 0f ab 82 04 01 00 00 8b 55 e4 8b 74 96 04 85 f6 75 08 <0f> 0
b 94 01 70 35 31 c0 83 ef 06 4b 75 bd 85 f6 74 1c 8b 4d e8
Sep 26 04:46:23 desktop kernel: EIP: [<c01ba714>] radix_tree_tag_set+0x6a/0xa2 SS:ESP 
0068:f7cf3d54


-- 
Ben Duncan   - Business Network Solutions, Inc. 336 Elton Road  Jackson MS, 39212
"Never attribute to malice, that which can be adequately explained by stupidity"
        - Hanlon's Razor

