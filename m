Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSLOPnQ>; Sun, 15 Dec 2002 10:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbSLOPnQ>; Sun, 15 Dec 2002 10:43:16 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:3344 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S261907AbSLOPnN>; Sun, 15 Dec 2002 10:43:13 -0500
Date: Sun, 15 Dec 2002 16:51:05 +0100 (CET)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: EXT3-fs panic on 2.4.20
Message-ID: <Pine.LNX.4.50.0212151647520.4261-100000@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After 14 days, on running 2.4.20 machine, ext3 partitions mounted without 
any special options.

ksymoops 2.4.4 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /lib/modules/2.4.20/System.map (specified)

Dec 15 15:27:01 oceanic kernel: Kernel panic: EXT3-fs panic (device sd(8,23)): load_block_bitmap: block_group >= groups_count - block_group = 524287, groups_count = 2126
Dec 15 15:27:01 oceanic kernel: kernel BUG at transaction.c:248!
Dec 15 15:27:01 oceanic kernel: invalid operand: 0000
Dec 15 15:27:01 oceanic kernel: CPU:    0
Dec 15 15:27:01 oceanic kernel: EIP:    0010:[<f88ab368>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 15 15:27:01 oceanic kernel: EFLAGS: 00010202
Dec 15 15:27:01 oceanic kernel: eax: 0000007a   ebx: f5c4fd40   ecx: c029e0c0   edx: 00018765
Dec 15 15:27:01 oceanic kernel: esi: f7b57000   edi: f7530000   ebp: f6295920   esp: f753178c
Dec 15 15:27:01 oceanic kernel: ds: 0018   es: 0018   ss: 0018
Dec 15 15:27:01 oceanic kernel: Process smbd (pid: 21636, stackpage=f7531000)
Dec 15 15:27:01 oceanic kernel: Stack: f88b2300 f88b3ffb f88b3fd0 000000f8 f88b23a0 f5c4fd40 ffffffe2 f77020c0 
Dec 15 15:27:01 oceanic kernel:        f88bf7de f7b57000 00000001 c013afe6 d585ae60 c013bc31 00000400 00000000 
Dec 15 15:27:01 oceanic kernel:        00014140 00000000 c2382900 f77020c0 f7b56800 00000001 c014db12 f77020c0 
Dec 15 15:27:01 oceanic kernel: Call Trace:    [<f88b2300>] [<f88b3ffb>] [<f88b3fd0>] [<f88b23a0>] [<f88bf7de>]
Dec 15 15:27:01 oceanic kernel:   [<c013afe6>] [<c013bc31>] [<c014db12>] [<c012c2f7>] [<c012c4e0>] [<c013b188>]
Dec 15 15:27:01 oceanic kernel:   [<c0199cfb>] [<f88babc2>] [<c0153aeb>] [<c0153dac>] [<c013a1d3>] [<c013a40e>]
Dec 15 15:27:01 oceanic kernel:   [<f88c7320>] [<c013a467>] [<c0117599>] [<f88c247f>] [<f88c5e40>] [<f88c7320>]
Dec 15 15:27:01 oceanic kernel:   [<f88c9540>] [<f88c9540>] [<f88c4960>] [<f88b919d>] [<f88c7320>] [<f88c4960>]
Dec 15 15:27:01 oceanic kernel:   [<c014db12>] [<f88b9452>] [<f88bf229>] [<f88bf287>] [<f88abd6f>] [<f88bf6b1>]
Dec 15 15:27:01 oceanic kernel:   [<f88bf645>] [<f88bf656>] [<f88bf757>] [<f88bf819>] [<f88ac466>] [<f88bc0f3>]
Dec 15 15:27:01 oceanic kernel:   [<c01fefb2>] [<f88be345>] [<f88aff50>] [<f88abd0e>] [<f88b1d40>] [<f88be42c>]
Dec 15 15:27:01 oceanic kernel:   [<c01c35d2>] [<f88abd0e>] [<c01b72bc>] [<f88be72f>] [<c011c6ed>] [<c013a04e>]
Dec 15 15:27:01 oceanic kernel:   [<c013af18>] [<c013b1b6>] [<f88be5d6>] [<c013af18>] [<f88abd0e>] [<f88bf645>]
Dec 15 15:27:01 oceanic kernel:   [<f88bf656>] [<f88be9c5>] [<f88b3ff0>] [<f88b1c27>] [<f88ab285>] [<f88ab39d>]
Dec 15 15:27:01 oceanic kernel:   [<f88bc1c8>] [<f88ac705>] [<f88bc35c>] [<f88bc280>] [<f88bc280>] [<c014f178>]
Dec 15 15:27:01 oceanic kernel:   [<c014d216>] [<c014551e>] [<c0143090>] [<c01440ba>] [<c01455d9>] [<c01070c3>]
Dec 15 15:27:01 oceanic kernel: Code: 0f 0b f8 00 d0 3f 8b f8 83 c4 14 ff 43 08 eb 40 8b 4c 24 14 

>>EIP; f88ab368 <[jbd]__kstrtab_journal_update_format+28/40>   <=====
Trace; f88b2300 <[jbd].rodata.end+61/5391>
Trace; f88b3ffb <[jbd].rodata.end+1d5c/5391>
Trace; f88b3fd0 <[jbd].rodata.end+1d31/5391>
Trace; f88b23a0 <[jbd].rodata.end+101/5391>
Trace; f88bf7de <[ext3]ext3_dirty_inode+6e/100>
Trace; c013afe6 <balance_dirty+6/30>
Trace; c013bc31 <__block_commit_write+b1/e0>
Trace; c014db12 <__mark_inode_dirty+32/b0>
Trace; c012c2f7 <generic_file_write+387/810>
Trace; c012c4e0 <generic_file_write+570/810>
Trace; c013b188 <bread+18/70>
Trace; c0199cfb <generic_unplug_device+2b/40>
Trace; f88babc2 <[ext3]ext3_file_write+22/b0>
Trace; c0153aeb <write_dquot+ab/100>
Trace; c0153dac <sync_dquots+8c/e0>
Trace; c013a1d3 <write_unlocked_buffers+23/30>
Trace; c013a40e <fsync_dev+3e/80>
Trace; f88c7320 <[ext3].text.end+2af1/49f1>
Trace; c013a467 <sys_sync+7/10>
Trace; c0117599 <panic+79/110>
Trace; f88c247f <[ext3]ext3_panic+3f/40>
Trace; f88c5e40 <[ext3].text.end+1611/49f1>
Trace; f88c7320 <[ext3].text.end+2af1/49f1>
Trace; f88c9540 <[ext3]error_buf+0/0>
Trace; f88c9540 <[ext3]error_buf+0/0>
Trace; f88c4960 <[ext3].text.end+131/49f1>
Trace; f88b919d <[ext3]__load_block_bitmap+2d/1b0>
Trace; f88c7320 <[ext3].text.end+2af1/49f1>
Trace; f88c4960 <[ext3].text.end+131/49f1>
Trace; c014db12 <__mark_inode_dirty+32/b0>
Trace; f88b9452 <[ext3]ext3_free_blocks+132/5f0>
Trace; f88bf229 <[ext3]ext3_do_update_inode+2f9/380>
Trace; f88bf287 <[ext3]ext3_do_update_inode+357/380>
Trace; f88abd6f <[jbd]journal_get_write_access+3f/60>
Trace; f88bf6b1 <[ext3]ext3_reserve_inode_write+31/b0>
Trace; f88bf645 <[ext3]ext3_mark_iloc_dirty+25/60>
Trace; f88bf656 <[ext3]ext3_mark_iloc_dirty+36/60>
Trace; f88bf757 <[ext3]ext3_mark_inode_dirty+27/40>
Trace; f88bf819 <[ext3]ext3_dirty_inode+a9/100>
Trace; f88ac466 <[jbd]journal_forget+e6/1d0>
Trace; f88bc0f3 <[ext3]ext3_forget+63/e0>
Trace; c01fefb2 <ip_output+f2/160>
Trace; f88be345 <[ext3]ext3_clear_blocks+135/140>
Trace; f88aff50 <[jbd]journal_cancel_revoke+50/d0>
Trace; f88abd0e <[jbd]do_get_write_access+4fe/520>
Trace; f88b1d40 <[jbd]journal_alloc_journal_head+10/70>
Trace; f88be42c <[ext3]ext3_free_data+dc/190>
Trace; c01c35d2 <ahc_linux_queue+172/1c0>
Trace; f88abd0e <[jbd]do_get_write_access+4fe/520>
Trace; c01b72bc <scsi_dispatch_cmd+12c/270>
Trace; f88be72f <[ext3]ext3_free_branches+24f/260>
Trace; c011c6ed <__run_task_queue+5d/70>
Trace; c013a04e <__wait_on_buffer+8e/a0>
Trace; c013af18 <getblk+28/60>
Trace; c013b1b6 <bread+46/70>
Trace; f88be5d6 <[ext3]ext3_free_branches+f6/260>
Trace; c013af18 <getblk+28/60>
Trace; f88abd0e <[jbd]do_get_write_access+4fe/520>
Trace; f88bf645 <[ext3]ext3_mark_iloc_dirty+25/60>
Trace; f88bf656 <[ext3]ext3_mark_iloc_dirty+36/60>
Trace; f88be9c5 <[ext3]ext3_truncate+285/3a0>
Trace; f88b3ff0 <[jbd].rodata.end+1d51/5391>
Trace; f88b1c27 <[jbd]__jbd_kmalloc+27/70>
Trace; f88ab285 <[jbd]__kstrtab_journal_revoke+7/22>
Trace; f88ab39d <[jbd]__kstrtab_journal_check_used_features+1d/40>
Trace; f88bc1c8 <[ext3]start_transaction+58/90>
Trace; f88ac705 <[jbd]journal_stop+185/190>
Trace; f88bc35c <[ext3]ext3_delete_inode+dc/180>
Trace; f88bc280 <[ext3]ext3_delete_inode+0/180>
Trace; f88bc280 <[ext3]ext3_delete_inode+0/180>
Trace; c014f178 <iput+168/280>
Trace; c014d216 <d_delete+66/c0>
Trace; c014551e <vfs_unlink+1de/210>
Trace; c0143090 <cached_lookup+10/50>
Trace; c01440ba <lookup_hash+4a/d0>
Trace; c01455d9 <sys_unlink+89/f0>
Trace; c01070c3 <system_call+33/38>
Code;  f88ab368 <[jbd]__kstrtab_journal_update_format+28/40>
00000000 <_EIP>:
Code;  f88ab368 <[jbd]__kstrtab_journal_update_format+28/40>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  f88ab36a <[jbd]__kstrtab_journal_update_format+2a/40>
   2:   f8                        clc    
Code;  f88ab36b <[jbd]__kstrtab_journal_update_format+2b/40>
   3:   00 d0                     add    %dl,%al
Code;  f88ab36d <[jbd]__kstrtab_journal_update_format+2d/40>
   5:   3f                        aas    
Code;  f88ab36e <[jbd]__kstrtab_journal_update_format+2e/40>
   6:   8b f8                     mov    %eax,%edi
Code;  f88ab370 <[jbd]__kstrtab_journal_update_format+30/40>
   8:   83 c4 14                  add    $0x14,%esp
Code;  f88ab373 <[jbd]__kstrtab_journal_update_format+33/40>
   b:   ff 43 08                  incl   0x8(%ebx)
Code;  f88ab376 <[jbd]__kstrtab_journal_update_format+36/40>
   e:   eb 40                     jmp    50 <_EIP+0x50> f88ab3b8 <[jbd]__kstrtab_journal_check_used_features+38/40>
Code;  f88ab378 <[jbd]__kstrtab_journal_update_format+38/40>
  10:   8b 4c 24 14               mov    0x14(%esp,1),%ecx

