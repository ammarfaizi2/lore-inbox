Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbSKBLQo>; Sat, 2 Nov 2002 06:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265940AbSKBLQo>; Sat, 2 Nov 2002 06:16:44 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:3345 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S265939AbSKBLQm>; Sat, 2 Nov 2002 06:16:42 -0500
Message-ID: <3DC3B5AE.E91AF724@aitel.hist.no>
Date: Sat, 02 Nov 2002 12:23:26 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.45-bk1: kernel BUG at drivers/block/ll_rw_blk.c:1949!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this during boot. Kernel 2.5.45-bk1,
compiled with gcc 2.95.4, SMP+preempt
The machine has 2 scsi disks and a
tekram controller.

Helge Hafting

kernel BUG at drivers/block/ll_rw_blk.c:1949!
invalid operand: 0000
CPU:    1
EIP:    0060:[<c0236c86>]    Not tainted
EFLAGS: 00010246
EIP is at submit_bio+0x16/0xa8
eax: 00000000   ebx: 00000000   ecx: cbbe0ed4   edx: 00000000
esi: cbbe0ed4   edi: 00000000   ebp: 00000001   esp: cbd81df4
ds: 0068   es: 0068   ss: 0068
Process find (pid: 758, threadinfo=cbd80000 task=ceaa9360)
Stack: 00001000 000b951f c016d026 00000000 cbbe0ed4 c016d2f7 00000000
cbbe0ed4 
       c11d56a0 00000000 00000000 cbbfc9ec 0005a90a 00000000 d124bf38
00000001 
       00000001 00000000 00000001 00000000 00000001 0000000c cbbfc964
00000010 
Call Trace:
 [<c016d026>] mpage_bio_submit+0x22/0x28
 [<c016d2f7>] do_mpage_readpage+0x25b/0x390
 [<c01637e6>] d_splice_alias+0x162/0x184
 [<c0180c0e>] ext2_lookup+0x6e/0x8c
 [<c0158791>] real_lookup+0x85/0xe4
 [<c0133a8e>] add_to_page_cache+0x4a/0xf4
 [<c016d57e>] mpage_readpage+0x2a/0x44
 [<c017f5f8>] ext2_get_block+0x0/0x3f4
 [<c017fa0f>] ext2_readpage+0xf/0x14
 [<c017f5f8>] ext2_get_block+0x0/0x3f4
 [<c01351b6>] read_cache_page+0xae/0x1e4
 [<c017d46b>] ext2_get_page+0x1f/0x90
 [<c017fa00>] ext2_readpage+0x0/0x14
 [<c017d617>] ext2_readdir+0x13b/0x380
 [<c015d945>] vfs_readdir+0x75/0x88
 [<c015dbd0>] filldir64+0x0/0x104
 [<c015dd1e>] sys_getdents64+0x4a/0x96
 [<c015dbd0>] filldir64+0x0/0x104
 [<c015cead>] sys_fcntl64+0x85/0x98
 [<c015ceb9>] sys_fcntl64+0x91/0x98
 [<c0107543>] syscall_call+0x7/0xb

Code: 0f 0b 9d 07 39 ab 36 c0 89 f6 83 7e 28 00 75 0a 0f 0b 9e 07
