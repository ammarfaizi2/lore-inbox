Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268133AbUHXRVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268133AbUHXRVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 13:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbUHXRVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 13:21:54 -0400
Received: from nef.ens.fr ([129.199.96.32]:1549 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S268133AbUHXRVO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 13:21:14 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Possible bug in ext3 journalling (kernel 2.6.8.1)
References: <qlk7jro1p5s.fsf@thym.ens.fr>
From: Gaetan Leurent <gaetan.leurent@ens.fr>
X-Start-Date: Tue, 24 Aug 2004 19:20:34 +0200
Date: Tue, 24 Aug 2004 19:21:13 +0200
In-Reply-To: <qlk7jro1p5s.fsf@thym.ens.fr> (Gaetan Leurent's message of
 "Tue, 24 Aug 2004 16:24:48 +0000 (UTC)")
Message-ID: <qlkk6vozc3a.fsf@thym.ens.fr>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (usg-unix-v)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Tue, 24 Aug 2004 19:21:13 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the log was uuencoded by error:


Assertion failure in journal_forget() at fs/jbd/transaction.c:1228: "!jh->b_committed_data"
------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:1228!
invalid operand: 0000 [#1]
Modules linked in: sg lp nvidia ipv6 forcedeth ide_floppy ide_tape raw ide_cd sr_mod cdrom ppa imm loop ehci_hcd ohci_hcd usbcore rtc
CPU:    0
EIP:    0060:[journal_forget+370/448]    Tainted: P  
EIP:    0060:[<c01a30f2>]    Tainted: P  
EFLAGS: 00210286   (2.6.8.1) 
EIP is at journal_forget+0x172/0x1c0
eax: 0000005f   ebx: c2e9c800   ecx: c0403bb8   edx: c0403bb8
esi: d18a0ecc   edi: d2d327e0   ebp: db6ce2b0   esp: c77a3dac
ds: 007b   es: 007b   ss: 0068
Process rm (pid: 14188, threadinfo=c77a2000 task=d77a0960)
Stack: c03bc1c8 c03a3da7 c03b863a 000004cc c03b8750 00537ac8 c2e9c800 d0c177d4 
       c01922b8 db6ce2b0 c2e9c800 c018f546 d0c177d4 c2e9c800 00537ac8 c4838d48 
       db6ce2b0 d0c177d4 c0194afc db6ce2b0 00000000 d0c177d4 c2e9c800 00537ac8 
Call Trace:
 [ext3_forget+152/256] ext3_forget+0x98/0x100
 [<c01922b8>] ext3_forget+0x98/0x100
 [ext3_free_blocks+1158/1232] ext3_free_blocks+0x486/0x4d0
 [<c018f546>] ext3_free_blocks+0x486/0x4d0
 [ext3_clear_blocks+284/368] ext3_clear_blocks+0x11c/0x170
 [<c0194afc>] ext3_clear_blocks+0x11c/0x170
 [ext3_free_data+277/368] ext3_free_data+0x115/0x170
 [<c0194c65>] ext3_free_data+0x115/0x170
 [ext3_free_branches+262/672] ext3_free_branches+0x106/0x2a0
 [<c0194dc6>] ext3_free_branches+0x106/0x2a0
 [ext3_truncate+1317/1488] ext3_truncate+0x525/0x5d0
 [<c0195485>] ext3_truncate+0x525/0x5d0
 [journal_start+169/208] journal_start+0xa9/0xd0
 [<c01a2019>] journal_start+0xa9/0xd0
 [start_transaction+35/96] start_transaction+0x23/0x60
 [<c0192383>] start_transaction+0x23/0x60
 [ext3_delete_inode+234/240] ext3_delete_inode+0xea/0xf0
 [<c019253a>] ext3_delete_inode+0xea/0xf0
 [ext3_delete_inode+0/240] ext3_delete_inode+0x0/0xf0
 [<c0192450>] ext3_delete_inode+0x0/0xf0
 [generic_delete_inode+139/320] generic_delete_inode+0x8b/0x140
 [<c016a38b>] generic_delete_inode+0x8b/0x140
 [iput+118/128] iput+0x76/0x80
 [<c016a5f6>] iput+0x76/0x80
 [sys_unlink+136/336] sys_unlink+0x88/0x150
 [<c0160b78>] sys_unlink+0x88/0x150
 [sys_ioctl+174/592] sys_ioctl+0xae/0x250
 [<c016343e>] sys_ioctl+0xae/0x250
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
 [<c0105f7d>] sysenter_past_esp+0x52/0x71
Code: 0f 0b cc 04 3a 86 3b c0 e9 73 ff ff ff c7 44 24 10 66 87 3b 
 <0>Assertion failure in journal_start() at fs/jbd/transaction.c:274: "handle->h_transaction->t_journal == journal"
------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:274!
invalid operand: 0000 [#2]
Modules linked in: sg lp nvidia ipv6 forcedeth ide_floppy ide_tape raw ide_cd sr_mod cdrom ppa imm loop ehci_hcd ohci_hcd usbcore rtc
CPU:    0
EIP:    0060:[journal_start+97/208]    Tainted: P  
EIP:    0060:[<c01a1fd1>]    Tainted: P  
EFLAGS: 00210282   (2.6.8.1) 
EIP is at journal_start+0x61/0xd0
eax: 00000073   ebx: db6ce2b0   ecx: c0403bd0   edx: 00005ce0
esi: c77a2000   edi: dff8db80   ebp: df8740d4   esp: c77a39d4
ds: 007b   es: 007b   ss: 0068
Process rm (pid: 14188, threadinfo=c77a2000 task=d77a0960)
Stack: c03bc1c8 c03a3d02 c03b863a 00000112 c03bdbd8 00000001 db6ce2b0 df8740d4 
       c01964f2 dff8db80 00000002 00000001 c01964c0 392017c0 c017057b df8740d4 
       00000006 00000000 c77a3a8e ffffffff c03a5b60 0000ffff 00ffff20 c04431a0 
Call Trace:
 [ext3_dirty_inode+50/144] ext3_dirty_inode+0x32/0x90
 [<c01964f2>] ext3_dirty_inode+0x32/0x90
 [ext3_dirty_inode+0/144] ext3_dirty_inode+0x0/0x90
 [<c01964c0>] ext3_dirty_inode+0x0/0x90
 [__mark_inode_dirty+219/432] __mark_inode_dirty+0xdb/0x1b0
 [<c017057b>] __mark_inode_dirty+0xdb/0x1b0
 [inode_update_time+199/208] inode_update_time+0xc7/0xd0
 [<c016a857>] inode_update_time+0xc7/0xd0
 [generic_file_aio_write_nolock+577/2896] generic_file_aio_write_nolock+0x241/0xb50
 [<c0136dd1>] generic_file_aio_write_nolock+0x241/0xb50
 [__print_symbol+134/256] __print_symbol+0x86/0x100
 [<c01306d6>] __print_symbol+0x86/0x100
 [__print_symbol+134/256] __print_symbol+0x86/0x100
 [<c01306d6>] __print_symbol+0x86/0x100
 [ext3_count_free_inodes+52/96] ext3_count_free_inodes+0x34/0x60
 [<c0192194>] ext3_count_free_inodes+0x34/0x60
 [ext3_statfs+259/288] ext3_statfs+0x103/0x120
 [<c019db33>] ext3_statfs+0x103/0x120
 [generic_file_aio_write+119/160] generic_file_aio_write+0x77/0xa0
 [<c01377e7>] generic_file_aio_write+0x77/0xa0
 [ext3_file_write+68/208] ext3_file_write+0x44/0xd0
 [<c0190d64>] ext3_file_write+0x44/0xd0
 [do_sync_write+132/192] do_sync_write+0x84/0xc0
 [<c0150f34>] do_sync_write+0x84/0xc0
 [do_acct_process+872/928] do_acct_process+0x368/0x3a0
 [<c0134478>] do_acct_process+0x368/0x3a0
 [acct_process+38/49] acct_process+0x26/0x31
 [<c01344d6>] acct_process+0x26/0x31
 [do_exit+117/816] do_exit+0x75/0x330
 [<c011c2e5>] do_exit+0x75/0x330
 [do_invalid_op+0/192] do_invalid_op+0x0/0xc0
 [<c0106b90>] do_invalid_op+0x0/0xc0
 [die+206/208] die+0xce/0xd0
 [<c010686e>] die+0xce/0xd0
 [do_invalid_op+159/192] do_invalid_op+0x9f/0xc0
 [<c0106c2f>] do_invalid_op+0x9f/0xc0
 [journal_forget+370/448] journal_forget+0x172/0x1c0
 [<c01a30f2>] journal_forget+0x172/0x1c0
 [autoremove_wake_function+47/96] autoremove_wake_function+0x2f/0x60
 [<c011842f>] autoremove_wake_function+0x2f/0x60
 [__wake_up_common+56/96] __wake_up_common+0x38/0x60
 [<c01174a8>] __wake_up_common+0x38/0x60
 [error_code+45/56] error_code+0x2d/0x38
 [<c0106179>] error_code+0x2d/0x38
 [journal_forget+370/448] journal_forget+0x172/0x1c0
 [<c01a30f2>] journal_forget+0x172/0x1c0
 [ext3_forget+152/256] ext3_forget+0x98/0x100
 [<c01922b8>] ext3_forget+0x98/0x100
 [ext3_free_blocks+1158/1232] ext3_free_blocks+0x486/0x4d0
 [<c018f546>] ext3_free_blocks+0x486/0x4d0
 [ext3_clear_blocks+284/368] ext3_clear_blocks+0x11c/0x170
 [<c0194afc>] ext3_clear_blocks+0x11c/0x170
 [ext3_free_data+277/368] ext3_free_data+0x115/0x170
 [<c0194c65>] ext3_free_data+0x115/0x170
 [ext3_free_branches+262/672] ext3_free_branches+0x106/0x2a0
 [<c0194dc6>] ext3_free_branches+0x106/0x2a0
 [ext3_truncate+1317/1488] ext3_truncate+0x525/0x5d0
 [<c0195485>] ext3_truncate+0x525/0x5d0
 [journal_start+169/208] journal_start+0xa9/0xd0
 [<c01a2019>] journal_start+0xa9/0xd0
 [start_transaction+35/96] start_transaction+0x23/0x60
 [<c0192383>] start_transaction+0x23/0x60
 [ext3_delete_inode+234/240] ext3_delete_inode+0xea/0xf0
 [<c019253a>] ext3_delete_inode+0xea/0xf0
 [ext3_delete_inode+0/240] ext3_delete_inode+0x0/0xf0
 [generic_delete_inode+139/320] generic_delete_inode+0x8b/0x140
 [<c016a38b>] generic_delete_inode+0x8b/0x140
 [iput+118/128] iput+0x76/0x80
 [<c016a5f6>] iput+0x76/0x80
 [sys_unlink+136/336] sys_unlink+0x88/0x150
 [<c0160b78>] sys_unlink+0x88/0x150
 [sys_ioctl+174/592] sys_ioctl+0xae/0x250
 [<c016343e>] sys_ioctl+0xae/0x250
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
 [<c0105f7d>] sysenter_past_esp+0x52/0x71
Code: 0f 0b 12 01 3a 86 3b c0 ff 43 08 89 d8 8b 5c 24 14 8b 74 24 

-- 
Gaëtan LEURENT
