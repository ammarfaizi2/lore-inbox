Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbUJWPbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUJWPbp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 11:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbUJWPbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 11:31:44 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:40661 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261160AbUJWPbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 11:31:35 -0400
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.9-mm1 oops
Date: Sat, 23 Oct 2004 17:31:21 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410231731.21778.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


100% reproducible with elevator=cfq

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c013f2c7
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: ipv6 dm_mod emu10k1 sound soundcore ac97_codec unix
CPU:    0
EIP:    0060:[put_page+7/144]    Not tainted VLI
EFLAGS: 00010282   (2.6.9-mm1) 
EIP is at put_page+0x7/0x90
eax: 00000000   ebx: df047400   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: df047400   esp: cadd0c80
ds: 007b   es: 007b   ss: 0068
Process diotest4 (pid: 4498, threadinfo=cadd0000 task=de712a40)
Stack: df047400 c0178d50 00000000 00000000 c0179c91 df047400 00000001 c01b391b 
       c86b6b00 cb0c9b80 cadd0d1c cb0c9c38 c019d31e cee0b0b0 00000000 00000000 
       00003000 00000000 df047400 00000000 08051000 0000000c c017a182 00000001 
Call Trace:
 [dio_cleanup+48/64] dio_cleanup+0x30/0x40
 [direct_io_worker+817/1568] direct_io_worker+0x331/0x620
 [journal_put_journal_head+59/192] journal_put_journal_head+0x3b/0xc0
 [ext3_do_update_inode+366/944] ext3_do_update_inode+0x16e/0x3b0
 [__blockdev_direct_IO+514/752] __blockdev_direct_IO+0x202/0x2f0
 [ext3_direct_io_get_blocks+0/240] ext3_direct_io_get_blocks+0x0/0xf0
 [ext3_direct_IO+201/576] ext3_direct_IO+0xc9/0x240
 [ext3_direct_io_get_blocks+0/240] ext3_direct_io_get_blocks+0x0/0xf0
 [generic_file_direct_IO+121/160] generic_file_direct_IO+0x79/0xa0
 [generic_file_direct_write+134/416] generic_file_direct_write+0x86/0x1a0
 [generic_file_aio_write_nolock+689/1200] generic_file_aio_write_nolock+0x2b1/0x4b0
 [generic_file_aio_write+131/256] generic_file_aio_write+0x83/0x100
 [ext3_file_write+68/224] ext3_file_write+0x44/0xe0
 [do_sync_write+190/240] do_sync_write+0xbe/0xf0
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [dnotify_parent+162/224] dnotify_parent+0xa2/0xe0
 [do_sync_write+0/240] do_sync_write+0x0/0xf0
 [vfs_write+184/304] vfs_write+0xb8/0x130
 [sys_write+81/128] sys_write+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 83 ec 04 8b 54 24 08 <8b> 02 a9 00 80 00 00 75 44 8b 02 f6 c4 08 75 1f 8b 02 89 d1 a9 
 <1>Unable to handle kernel paging request at virtual address 4e6c9214
 printing eip:
c0178939
*pde = 00000000
Oops: 0000 [#2]
PREEMPT 
Modules linked in: ipv6 dm_mod emu10k1 sound soundcore ac97_codec unix
CPU:    0
EIP:    0060:[dio_get_page+25/96]    Not tainted VLI
EFLAGS: 00010216   (2.6.9-mm1) 
EIP is at dio_get_page+0x19/0x60
eax: 62615a59   ebx: c4e72800   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: c4e72800   esp: de868c7c
ds: 007b   es: 007b   ss: 0068
Process diotest1 (pid: 4493, threadinfo=de868000 task=d1c435d0)
Stack: dffe0520 c4e72800 c0178d48 c4e72800 00000000 c0179c91 c4e72800 00000001 
       c01b391b c86b6380 c08349fc de868d1c c0834ab4 c019d31e cee0b0b0 00000000 
       00000000 00040000 00000000 c4e72800 00000000 08050000 0000000c c017a182 
Call Trace:
 [dio_cleanup+40/64] dio_cleanup+0x28/0x40
 [direct_io_worker+817/1568] direct_io_worker+0x331/0x620
 [journal_put_journal_head+59/192] journal_put_journal_head+0x3b/0xc0
 [ext3_do_update_inode+366/944] ext3_do_update_inode+0x16e/0x3b0
 [__blockdev_direct_IO+514/752] __blockdev_direct_IO+0x202/0x2f0
 [ext3_direct_io_get_blocks+0/240] ext3_direct_io_get_blocks+0x0/0xf0
 [ext3_direct_IO+201/576] ext3_direct_IO+0xc9/0x240
 [ext3_direct_io_get_blocks+0/240] ext3_direct_io_get_blocks+0x0/0xf0
 [generic_file_direct_IO+121/160] generic_file_direct_IO+0x79/0xa0
 [generic_file_direct_write+134/416] generic_file_direct_write+0x86/0x1a0
 [generic_file_aio_write_nolock+689/1200] generic_file_aio_write_nolock+0x2b1/0x4b0
 [generic_file_aio_write+131/256] generic_file_aio_write+0x83/0x100
 [ext3_file_write+68/224] ext3_file_write+0x44/0xe0
 [do_sync_write+190/240] do_sync_write+0xbe/0xf0
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [dnotify_parent+162/224] dnotify_parent+0xa2/0xe0
 [do_sync_write+0/240] do_sync_write+0x0/0xf0
 [vfs_write+184/304] vfs_write+0xb8/0x130
 [schedule+770/1376] schedule+0x302/0x560
 [sys_write+81/128] sys_write+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 00 89 87 b0 00 00 00 eb a5 89 f6 8d bc 27 00 00 00 00 83 ec 08 89 5c 24 04 8b 5c 24 0c 8b 83 b0 01 00 00 39 83 b4 01 00 00 74 18 <8b> 94 83 b0 00 00 00 40 89 83 b0 01 00 00 89 d0 8b 5c 24 04 83  
-- 
I route therefore you are
