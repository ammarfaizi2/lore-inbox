Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTJ1WSm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTJ1WSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:18:42 -0500
Received: from mailhost1.intology.com.au ([203.221.183.69]:59875 "EHLO
	mailhost1.intology.com.au") by vger.kernel.org with ESMTP
	id S261774AbTJ1WSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:18:36 -0500
Date: Wed, 29 Oct 2003 09:18:23 +1100
From: Jason Thomas <jason@intology.com.au>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.23-pre7 oops
Message-ID: <20031028221823.GB29646@intology.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this oops seems to occur after about 5 days of uptime, the current
one occured after 7days.

Also, I'm not subscribed so please CC me on any queries.

Thanks.

ksymoops 2.4.9 on i586 2.4.23-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-pre7/ (default)
     -m /boot/System.map-2.4.23-pre7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000004
c012531a
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012531a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c11e5490   ecx: c11e5490   edx: 2f000000
esi: c50f0c34   edi: c0218a18   ebp: dfef7f34   esp: dfef7f2c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=dfef7000)
Stack: 00000000 c11e5490 dfef7f60 c012c71c c11e5490 dfef6000 000008fc 000042b3 
       000001d0 0000000f 00000017 000001d0 c0218a18 dfef7f78 c012c9b0 dfef7f8c 
       0000003c 00000020 000001d0 dfef7f9c c012ca10 dfef7f8c 00000000 c0218a18 
Call Trace:    [<c012c71c>] [<c012c9b0>] [<c012ca10>] [<c012cbe3>] [<c012cc5a>]
  [<c012cd90>] [<c0105000>] [<c0105743>] [<c012cd00>]
Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03 00 00 00 00 c7 43 


>>EIP; c012531a <__remove_inode_page+1a/80>   <=====

>>edi; c0218a18 <contig_page_data+d8/3c0>

Trace; c012c71c <shrink_cache+25c/360>
Trace; c012c9b0 <shrink_caches+30/40>
Trace; c012ca10 <try_to_free_pages_zone+50/e0>
Trace; c012cbe3 <kswapd_balance_pgdat+63/c0>
Trace; c012cc5a <kswapd_balance+1a/40>
Trace; c012cd90 <kswapd+90/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105743 <arch_kernel_thread+23/40>
Trace; c012cd00 <kswapd+0/c0>

Code;  c012531a <__remove_inode_page+1a/80>
00000000 <_EIP>:
Code;  c012531a <__remove_inode_page+1a/80>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c012531d <__remove_inode_page+1d/80>
   3:   89 02                     mov    %eax,(%edx)
Code;  c012531f <__remove_inode_page+1f/80>
   5:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c0125326 <__remove_inode_page+26/80>
   c:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012532c <__remove_inode_page+2c/80>
  12:   c7 43 00 00 00 00 00      movl   $0x0,0x0(%ebx)


1 warning and 1 error issued.  Results may not be reliable.
