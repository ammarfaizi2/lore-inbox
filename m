Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRJ0SqE>; Sat, 27 Oct 2001 14:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274684AbRJ0Spy>; Sat, 27 Oct 2001 14:45:54 -0400
Received: from mtiwmhc25.worldnet.att.net ([204.127.131.50]:54705 "EHLO
	mtiwmhc25.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S274681AbRJ0Spv>; Sat, 27 Oct 2001 14:45:51 -0400
Date: Sat, 27 Oct 2001 14:46:24 -0400
From: khromy <khromy@lnuxlab.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: [oops] linux-2.4.14-pre2 - __remove_from_queues+14/28
Message-ID: <20011027144624.A11364@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you need more info, let me know.

--

Linux version 2.4.14-pre2 (khromy@vingeren.girl) (gcc version 2.95.4 20011006
(Debian prerelease)) #1 Fri Oct 26 15:28:10 EDT 2001

--

ksymoops 2.4.3 on i686 2.4.14-pre2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14-pre2/ (default)
     -m /boot/System.map-2.4.14-pre2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 00100000
c012e694
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012e694>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c3135920   ecx: c3135920   edx: 00100000
esi: c3135a40   edi: c3135a40   ebp: c10c4bc0   esp: c1311f2c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1311000)
Stack: c0130889 c3135920 c3135a40 c10c4bc0 00000001 00000000 c0127fa6 c10c4bc0 
       000001d0 00000020 000001d0 00000020 00000006 00000020 c1310000 00000310 
       00000c81 000001d0 c01e3ac8 c01282b6 00000006 00000009 00000006 000001d0 
Call Trace: [<c0130889>] [<c0127fa6>] [<c01282b6>] [<c012830c>] [<c01283a3>] 
   [<c01283fe>] [<c012851d>] [<c0105478>] 
Code: 89 02 c7 41 30 00 00 00 00 51 e8 89 ff ff ff 83 c4 04 c3 90 

>>EIP; c012e694 <__remove_from_queues+14/28>   <=====
Trace; c0130888 <try_to_free_buffers+5c/10c>
Trace; c0127fa6 <shrink_cache+1aa/390>
Trace; c01282b6 <shrink_caches+56/88>
Trace; c012830c <try_to_free_pages+24/44>
Trace; c01283a2 <kswapd_balance_pgdat+42/8c>
Trace; c01283fe <kswapd_balance+12/38>
Trace; c012851c <kswapd+98/bc>
Trace; c0105478 <kernel_thread+28/38>
Code;  c012e694 <__remove_from_queues+14/28>
00000000 <_EIP>:
Code;  c012e694 <__remove_from_queues+14/28>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012e696 <__remove_from_queues+16/28>
   2:   c7 41 30 00 00 00 00      movl   $0x0,0x30(%ecx)
Code;  c012e69c <__remove_from_queues+1c/28>
   9:   51                        push   %ecx
Code;  c012e69e <__remove_from_queues+1e/28>
   a:   e8 89 ff ff ff            call   ffffff98 <_EIP+0xffffff98> c012e62c <__remove_from_lru_list+0/54>
Code;  c012e6a2 <__remove_from_queues+22/28>
   f:   83 c4 04                  add    $0x4,%esp
Code;  c012e6a6 <__remove_from_queues+26/28>
  12:   c3                        ret    
Code;  c012e6a6 <__remove_from_queues+26/28>
  13:   90                        nop    


1 warning issued.  Results may not be reliable.
