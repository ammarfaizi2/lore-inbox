Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271608AbTGQWiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271609AbTGQWg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:36:56 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:28392 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S271608AbTGQWer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:34:47 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: 2.5.0-test1 kernel oops
Date: Fri, 18 Jul 2003 00:49:39 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307180049.39980.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just found this in my dmesg, possibly right after I mounted and accesed a 
iso9660 cd-rom.

Hope it's useful,

Unable to handle kernel paging request at virtual address e9000018
 printing eip:
c0168790
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0168790>]    Not tainted
EFLAGS: 00010286
EIP is at find_inode_fast+0x20/0x70
eax: df456a90   ebx: 002f2b15   ecx: e9000018   edx: e9000018
esi: dfe03800   edi: dff8ecc4   ebp: dfe03800   esp: dd42de34
ds: 007b   es: 007b   ss: 0068
Process famd (pid: 19519, threadinfo=dd42c000 task=d428e0a0)
Stack: 00000000 dd42c000 db202800 002f2b15 c0168e42 dfe03800 dff8ecc4 002f2b15
       dff8ecc4 002f2b15 db202800 dfe03800 db202800 c018a54b dfe03800 002f2b15
       d9a8e07c fffffff4 d9af3738 d9af36d0 c015cd92 d9af36d0 db202800 dd42df38
Call Trace:
 [<c0168e42>] iget_locked+0x52/0xc0
 [<c018a54b>] ext3_lookup+0x6b/0xd0
 [<c015cd92>] real_lookup+0xd2/0x100
 [<c015d036>] do_lookup+0x96/0xb0
 [<c015d4e0>] link_path_walk+0x490/0x8a0
 [<c015ddf9>] __user_walk+0x49/0x60
 [<c0158fac>] vfs_lstat+0x1c/0x60
 [<c015965b>] sys_lstat64+0x1b/0x40
 [<c01092bb>] syscall_call+0x7/0xb

Code: 8b 11 0f 18 02 90 39 59 18 89 c8 74 13 85 d2 89 d1 75 ed 31
 <6>note: famd[19519] exited with preempt_count 1


-- 
  ricardo galli       GPG id C8114D34

