Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbUKINMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbUKINMM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 08:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbUKINMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 08:12:12 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:3772 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261227AbUKINMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 08:12:07 -0500
Date: Tue, 9 Nov 2004 14:12:04 +0100
Message-Id: <200411091312.OAA16797@boskoop.iwr.uni-heidelberg.de>
To: linux-kernel@vger.kernel.org
Cc: ml <michael.lampe@iwr.uni-heidelberg.de>
From: ml <michael.lampe@iwr.uni-heidelberg.de>
Subject: [OOPS] 2.4.27: EXT2/SMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Unable to handle kernel paging request at virtual address 75522244
c015c570
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c015c570>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 75522240   ebx: 00000000   ecx: 00000000   edx: db643964
esi: 00000000   edi: 00000000   ebp: 00000000   esp: e9edff0c
ds: 0018   es: 0018   ss: 0018
Process tclsh (pid: 31649, stackpage=e9edf000)
Stack: 00000000 00000000 c015c72f d36438a0 00000000 d36438a0 e9ede000 c817de20 
       d3643930 e9ede000 00000004 e00874a0 00000001 c0280800 fffff000 00000001 
       00000000 f79d1400 d36438a0 c0146a14 c817de20 e9edffb0 c0147040 c817de20 
Call Trace:    [<c015c72f>] [<c0146a14>] [<c0147040>] [<c01471a3>] [<c0147040>]
  [<c01461cb>] [<c0106e83>]
Code: 8b 40 04 50 51 52 e8 91 e1 fc ff 89 c3 83 c4 10 81 fb 18 fc 

>>EIP; c015c570 <ext2_get_page+14/dc>   <=====
Trace; c015c72e <ext2_readdir+f6/280>
Trace; c0146a14 <vfs_readdir+94/e0>
Trace; c0147040 <filldir64+0/114>
Trace; c01471a2 <sys_getdents64+4e/b2>
Trace; c0147040 <filldir64+0/114>
Trace; c01461ca <sys_fcntl64+7e/88>
Trace; c0106e82 <system_call+32/38>
Code;  c015c570 <ext2_get_page+14/dc>
00000000 <_EIP>:
Code;  c015c570 <ext2_get_page+14/dc>   <=====
   0:   8b 40 04                  mov    0x4(%eax),%eax   <=====
Code;  c015c572 <ext2_get_page+16/dc>
   3:   50                        push   %eax
Code;  c015c574 <ext2_get_page+18/dc>
   4:   51                        push   %ecx
Code;  c015c574 <ext2_get_page+18/dc>
   5:   52                        push   %edx
Code;  c015c576 <ext2_get_page+1a/dc>
   6:   e8 91 e1 fc ff            call   fffce19c <_EIP+0xfffce19c> c012a70c <read_cache_page+0/11c>
Code;  c015c57a <ext2_get_page+1e/dc>
   b:   89 c3                     mov    %eax,%ebx
Code;  c015c57c <ext2_get_page+20/dc>
   d:   83 c4 10                  add    $0x10,%esp
Code;  c015c580 <ext2_get_page+24/dc>
  10:   81 fb 18 fc 00 00         cmp    $0xfc18,%ebx
