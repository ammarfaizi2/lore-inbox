Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbTJNRjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTJNRjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:39:18 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:54725 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S262594AbTJNRjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:39:08 -0400
Message-ID: <3F8C344A.6060601@blue-labs.org>
Date: Tue, 14 Oct 2003 13:37:14 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031014
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS 2.6.0-test7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened after I installed two new ram chips into my Dell Inspiron 
8200 laptop.  The old memory was 128M/PC2100 (DDR266).  The new chips 
are 512M/PC2700 (DDR333).

Unable to handle kernel paging request at virtual address 34e9c8c2
 printing eip:
c0169d78
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0169d78>]    Not tainted
EFLAGS: 00010206
EIP is at find_vma+0x2d/0x51
eax: 34e9c8ba   ebx: bfffc5b0   ecx: 00000000   edx: 34e9c8d2
esi: eb246d4c   edi: c0122d80   ebp: db5ff980   esp: ec961f04
ds: 007b   es: 007b   ss: 0068
Process configure (pid: 5138, threadinfo=ec960000 task=db5ff980)
Stack: eb246d4c eb246d6c c0122f3a eb246d4c bfffc5b0 00000282 00000011 
00001414
       bfffc5b0 ec960000 c012b434 00030001 bfffc590 ec961fc4 00000000 
00000000
       00000000 80010000 c013c3be 00000000 1f0ee140 e937ad4c db5ff980 
c0537408
Call Trace:
 [<c0122f3a>] do_page_fault+0x1ba/0x481
 [<c012b434>] do_fork+0x199/0x1dd
 [<c013c3be>] sigprocmask+0xeb/0x296
 [<c012555d>] schedule+0x387/0x8c9
 [<c013c68d>] sys_rt_sigprocmask+0x124/0x33f
 [<c017a945>] sys_close+0x101/0x223
 [<c0122d80>] do_page_fault+0x0/0x481
 [<c010aaa5>] error_code+0x2d/0x38

Code: 39 58 08 76 1a 39 58 04 89 c1 76 07 8b 52 0c 85 d2 75 ea 85
 <3>Slab corruption: start=e8f0f78c, expend=e8f0f7cb, problemat=e8f0f7b5
Last user: [<c016ac8a>](exit_mmap+0x200/0x2b6)
Data: *****************************************EC E5 8E E5 
******************A5
Next: 71 F0 2C .8A AC 16 C0 A5 C2 0F 17 4C 5D 8A E8 00 E0 58 40 00 70 
.40 E8 F1 F0 E8 25 00 00 00
slab error in check_poison_obj(): cache `vm_area_struct': object was 
modified after freeing
Call Trace:
 [<c015a65d>] check_poison_obj+0x100/0x186
 [<c01294dc>] copy_mm+0x3e4/0x75a
 [<c015c8f1>] kmem_cache_alloc+0x85/0x203
 [<c01294dc>] copy_mm+0x3e4/0x75a
 [<c012a761>] copy_process+0x594/0x10ce
 [<c03e474a>] sock_writev+0x4a/0x50
 [<c012b2f7>] do_fork+0x5c/0x1dd
 [<c01961fd>] sys_select+0x23c/0x50b
 [<c017b68b>] vfs_write+0xc9/0x119
 [<c0107ae2>] sys_fork+0x37/0x3b
 [<c010a07b>] syscall_call+0x7/0xb


