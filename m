Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbSLMSEJ>; Fri, 13 Dec 2002 13:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSLMSEJ>; Fri, 13 Dec 2002 13:04:09 -0500
Received: from stingr.net ([212.193.32.15]:61957 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S265201AbSLMSEI>;
	Fri, 13 Dec 2002 13:04:08 -0500
Date: Fri, 13 Dec 2002 21:11:55 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.5.51-mm2
Message-ID: <20021213181155.GB2496@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is very funny.

mke2fs -j -O dir_index -J size=192 -T news -N 1000100
atest3 1000000
 (creat & write 1 byte to 1000000 files)
 
free space on device became 0 and voila

Unable to handle kernel paging request at virtual address 5a5a5b9e
 printing eip:
c01a5ed2
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0060:[<c01a5ed2>]    Not tainted
EFLAGS: 00010202
EIP is at ext3_get_inode_loc+0x32/0x1a0
eax: c5e9a2d0   ebx: 00000000   ecx: 00000000   edx: 5a5a5a5a
esi: 5a5a5a5a   edi: c8999ec8   ebp: c5e9a2d0   esp: c8999e5c
ds: 0068   es: 0068   ss: 0068
Process atest3 (pid: 1482, threadinfo=c8998000 task=c7f17960)
Stack: c5e9a060 c0146111 cbd389b0 c5e9a240 ca50f1f4 cbd32c00 00000000 ca50f1f4
       c8999ec8 c5e9a2d0 c01a6c91 c5e9a2d0 c8999ec8 ffffffe4 c57fe3ec cb5b30d0
       c01aca2d cbd389b0 c5e9a244 c8999ec8 c5e9a2d0 ca50f1f4 cb5b30d0 c01a6d7b
Call Trace:
 [<c0146111>] cache_free_debugcheck+0x131/0x1c0
 [<c01a6c91>] ext3_reserve_inode_write+0x31/0xf0
 [<c01aca2d>] ext3_destroy_inode+0x1d/0x30
 [<c01a6d7b>] ext3_mark_inode_dirty+0x2b/0x60
 [<c01aa03b>] ext3_add_nondir+0x5b/0x60
 [<c01aa1ae>] ext3_create+0x16e/0x230
 [<c016eae7>] permission+0x57/0x70
 [<c016ffd6>] vfs_create+0xb6/0x130
 [<c0170659>] open_namei+0x3b9/0x420
 [<c015da53>] filp_open+0x43/0x70
 [<c015df5b>] sys_open+0x5b/0x90
 [<c015dfaf>] sys_creat+0x1f/0x30
 [<c010998f>] syscall_call+0x7/0xb

Code: 8b 86 44 01 00 00 3b 50 50 72 0d 8b 9e 44 01 00 00 8b 43 2c



-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
