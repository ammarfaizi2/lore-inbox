Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTLXHcN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 02:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTLXHcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 02:32:13 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:20892 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261567AbTLXHcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 02:32:10 -0500
Date: Tue, 23 Dec 2003 23:30:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: error27@email.com
Subject: [Bug 1740] New: Kernel Oops under stress test 
Message-ID: <127920000.1072251056@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1740

           Summary: Kernel Oops under stress test
    Kernel Version: 2.6.0-test11
            Status: NEW
          Severity: normal
             Owner: reiserfs-dev@namesys.com
         Submitter: error27@email.com


Distribution:  Debian
Hardware Environment:  i386 UP
Software Environment:  Preempt enabled
Problem Description:  

I was running a stress test on the file system and I triggerred this oops.

Dec 21 10:23:12 localhost kernel: reiserfs: checking transaction log (hdb1) for
(hdb1)
Dec 21 10:23:16 localhost kernel: Using r5 hash to sort names
Dec 21 10:46:04 localhost kernel:  printing eip:
Dec 21 10:46:04 localhost kernel: cf3386ac
Dec 21 10:46:04 localhost kernel: Oops: 0000 [#1]
Dec 21 10:46:04 localhost kernel: CPU:    0
Dec 21 10:46:04 localhost kernel: EIP:    0060:[_end+249926920/1068625500]   
Not tainted
Dec 21 10:46:04 localhost kernel: EFLAGS: 00010246
Dec 21 10:46:04 localhost kernel: EIP is at scan_bitmap_block+0x4fc/0x5d0 [reiserfs]
Dec 21 10:46:04 localhost kernel: eax: ffffffff   ebx: c2b2c000   ecx: 07fffe72
  edx: 00000000
Dec 21 10:46:04 localhost kernel: esi: 00000000   edi: c2b2c000   ebp: c52c38cc
  esp: c52c387c
Dec 21 10:46:04 localhost kernel: ds: 007b   es: 007b   ss: 0068
Dec 21 10:46:04 localhost kernel: Process dir_create.sh (pid: 6053,
threadinfo=c52c2000 task=c78319b0)
Dec 21 10:46:04 localhost kernel: Stack: c4b38df8 00000006 00000270 00000001
c52c38bc c9888000 00000070 00008000 
Dec 21 10:46:04 localhost kernel:        00000000 c52c38b8 cf35047d 00000000
ffffffef cc879030 c4b38df8 c52c38d8 
Dec 21 10:46:04 localhost kernel:        00008000 00000006 c4b38df8 c52c390c
c52c391c cf338975 c52c3b24 00000006 
Dec 21 10:46:04 localhost kernel: Call Trace:
Dec 21 10:46:04 localhost kernel:  [_end+250024665/1068625500]
reiserfs_kfree+0x1d/0x60 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [_end+249927633/1068625500]
scan_bitmap+0x1f5/0x220 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [_end+249930610/1068625500]
reiserfs_allocate_blocknrs+0x1e6/0x820 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [_end+250096956/1068625500]
copy_item_head+0x20/0x30 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [_end+249972993/1068625500]
reiserfs_get_block+0x435/0x16b0 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [_end+250059470/1068625500]
leaf_paste_in_buffer+0x1d2/0x380 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [free_initmem+126/131]
smp_apic_timer_interrupt+0xd7/0x150
Dec 21 10:46:04 localhost kernel:  [show_registers+349/417]
apic_timer_interrupt+0x1a/0x20
Dec 21 10:46:04 localhost kernel:  [setscheduler+173/1002] set_pmd_pte+0x5b/0x110
Dec 21 10:46:04 localhost kernel:  [shmem_delete_inode+147/298] kfree+0x1ea/0x440
Dec 21 10:46:04 localhost kernel:  [_end+250024665/1068625500]
reiserfs_kfree+0x1d/0x60 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [fcntl_setlease+631/764]
alloc_buffer_head+0x48/0x70
Dec 21 10:46:04 localhost kernel:  [locks_copy_lock+82/105]
__block_prepare_write+0x1eb/0x420
Dec 21 10:46:04 localhost kernel:  [posix_locks_deadlock+27/117]
block_prepare_write+0x32/0x50
Dec 21 10:46:04 localhost kernel:  [_end+249971916/1068625500]
reiserfs_get_block+0x0/0x16b0 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [sys_remap_file_pages+210/381]
generic_file_aio_write_nolock+0x410/0xc00
Dec 21 10:46:04 localhost kernel:  [_end+249971916/1068625500]
reiserfs_get_block+0x0/0x16b0 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [_end+249978652/1068625500]
inode2sd+0x80/0xb0 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [sys_madvise+33/300]
generic_file_write_nolock+0x78/0x90
Dec 21 10:46:04 localhost kernel:  [_end+249957415/1068625500]
reiserfs_add_entry+0x41b/0x550 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [_end+250125062/1068625500]
check_journal_end+0x19a/0x2c0 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [clear_page_tables+17/325]
generic_file_write+0x6d/0x90
Dec 21 10:46:04 localhost kernel:  [_end+250004550/1068625500]
reiserfs_file_write+0x9ca/0x9d1 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [_end+250123363/1068625500]
journal_end+0x27/0x30 [reiserfs]
Dec 21 10:46:04 localhost kernel:  [invalidate_inode_pages2+154/252]
unlock_page+0x16/0x60
Dec 21 10:46:04 localhost kernel:  [get_unused_fd+342/437] do_wp_page+0x377/0x440
Dec 21 10:46:04 localhost kernel:  [vfs_readv+32/99] handle_mm_fault+0x1a7/0x210
Dec 21 10:46:04 localhost kernel:  [__wake_up_common+73/87]
do_page_fault+0x356/0x57a
Dec 21 10:46:04 localhost kernel:  [aio_free_ring+29/257] locate_fd+0xa9/0x130
Dec 21 10:46:04 localhost kernel:  [aio_setup_ring+38/607] dupfd+0x83/0x100
Dec 21 10:46:04 localhost kernel:  [sys_unlink+239/321] vfs_write+0xaf/0x120
Dec 21 10:46:04 localhost kernel:  [vfs_mknod+44/327] filp_close+0x57/0x90
Dec 21 10:46:04 localhost kernel:  [vfs_symlink+190/238] sys_write+0x3f/0x60
Dec 21 10:46:04 localhost kernel:  [irq_entries_start+1123/2176]
syscall_call+0x7/0xb
Dec 21 10:46:04 localhost kernel: 
Dec 21 10:46:04 localhost kernel: Code: f3 af 74 09 33 47 fc 83 ef 04 0f bc d0
29 df c1 e7 03 01 fa 
Dec 21 11:08:26 localhost -- MARK --

Steps to reproduce:


