Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288624AbSANBwL>; Sun, 13 Jan 2002 20:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288623AbSANBwF>; Sun, 13 Jan 2002 20:52:05 -0500
Received: from [202.7.93.26] ([202.7.93.26]:16012 "EHLO pegasus.vrlaw.com.au")
	by vger.kernel.org with ESMTP id <S288604AbSANBvo>;
	Sun, 13 Jan 2002 20:51:44 -0500
Message-ID: <3C423A90.2E34D426@vrlaw.com.au>
Date: Mon, 14 Jan 2002 12:55:28 +1100
From: Patrick Burns <patrickb@vrlaw.com.au>
Organization: Vardanega Roberts
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in kswapd (Kernel 2.4.17)
Content-Type: multipart/mixed;
 boundary="------------B50B2D0290FD745AEF4A860F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B50B2D0290FD745AEF4A860F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Is there some kind of memory problem with kernel 2.4.17? I noticed in an
article at:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101096234600708&w=2

and another at:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0201.1/0809.html

that people were getting oopses in kswapd. I also had the same problem
this morning. The kernel froze up totally. Not even SysRq keys would
work. I am running 2x400mhz PII in an SMP machine with 512mb RAM. I have
attatched the syslog of the oops and what I got when I ran it past
ksymoops. I'm using 2.4.17 on a stock Red Hat 7.2 machine. I built it
with gcc 2.96 (the 2.96-98 version that comes with red Hat 7.2.)

Can anyone help me out? I'm not subscribed to this list, so please cc me
any advice. Thank you very much.

-Patrick

--------------B50B2D0290FD745AEF4A860F
Content-Type: text/plain; charset=us-ascii;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

Jan 14 08:42:40 pegasus kernel: Unable to handle kernel paging request at virtual address 00300014
Jan 14 08:42:40 pegasus kernel:  printing eip:
Jan 14 08:42:40 pegasus kernel: c0147d2f
Jan 14 08:42:40 pegasus kernel: *pde = 00000000
Jan 14 08:42:40 pegasus kernel: Oops: 0000
Jan 14 08:42:40 pegasus kernel: CPU:    0
Jan 14 08:42:40 pegasus kernel: EIP:    0010:[<c0147d2f>]    Not tainted
Jan 14 08:42:40 pegasus kernel: EFLAGS: 00010206
Jan 14 08:42:40 pegasus kernel: eax: 00300000   ebx: d82f0e78   ecx: df84de50   edx: d82f0e90
Jan 14 08:42:40 pegasus kernel: esi: d82f0e60   edi: d82f2440   ebp: 0000ba58   esp: c1955f30
Jan 14 08:42:40 pegasus kernel: ds: 0018   es: 0018   ss: 0018
Jan 14 08:42:40 pegasus kernel: Process kswapd (pid: 5, stackpage=c1955000)
Jan 14 08:42:40 pegasus kernel: Stack: c012f67c dffe007c c1954000 ffffffff 000001d0 c0297b28 c1954000 00000000 
Jan 14 08:42:40 pegasus kernel:        00000020 000001d0 00000006 00000006 c01480c0 0000bcfd c012f887 00000006 
Jan 14 08:42:40 pegasus kernel:        000001d0 c0297b28 00000006 000001d0 c0297b28 00000000 c012f8ec 00000020 
Jan 14 08:42:40 pegasus kernel: Call Trace: [<c012f67c>] [<c01480c0>] [<c012f887>] [<c012f8ec>] [<c012f991>] 
Jan 14 08:42:40 pegasus kernel:    [<c012fa06>] [<c012fb41>] [<c012faa0>] [<c0105000>] [<c0105836>] [<c012faa0>] 
Jan 14 08:42:40 pegasus kernel: 
Jan 14 08:42:40 pegasus kernel: Code: 8b 40 14 85 c0 74 0a 57 56 ff d0 5a 59 eb 1a 89 f6 57 e8 4a 
Jan 14 08:42:47 pegasus kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 000001f8

--------------B50B2D0290FD745AEF4A860F
Content-Type: text/plain; charset=us-ascii;
 name="trace.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trace.txt"

ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jan 14 08:42:40 pegasus kernel: Unable to handle kernel paging request at virtual address 00300014
Jan 14 08:42:40 pegasus kernel: c0147d2f
Jan 14 08:42:40 pegasus kernel: *pde = 00000000
Jan 14 08:42:40 pegasus kernel: Oops: 0000
Jan 14 08:42:40 pegasus kernel: CPU:    0
Jan 14 08:42:40 pegasus kernel: EIP:    0010:[<c0147d2f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 14 08:42:40 pegasus kernel: EFLAGS: 00010206
Jan 14 08:42:40 pegasus kernel: eax: 00300000   ebx: d82f0e78   ecx: df84de50   edx: d82f0e90
Jan 14 08:42:40 pegasus kernel: esi: d82f0e60   edi: d82f2440   ebp: 0000ba58   esp: c1955f30
Jan 14 08:42:40 pegasus kernel: ds: 0018   es: 0018   ss: 0018
Jan 14 08:42:40 pegasus kernel: Process kswapd (pid: 5, stackpage=c1955000)
Jan 14 08:42:40 pegasus kernel: Stack: c012f67c dffe007c c1954000 ffffffff 000001d0 c0297b28 c1954000 00000000 
Jan 14 08:42:40 pegasus kernel:        00000020 000001d0 00000006 00000006 c01480c0 0000bcfd c012f887 00000006 
Jan 14 08:42:40 pegasus kernel:        000001d0 c0297b28 00000006 000001d0 c0297b28 00000000 c012f8ec 00000020 
Jan 14 08:42:40 pegasus kernel: Call Trace: [<c012f67c>] [<c01480c0>] [<c012f887>] [<c012f8ec>] [<c012f991>] 
Jan 14 08:42:40 pegasus kernel:    [<c012fa06>] [<c012fb41>] [<c012faa0>] [<c0105000>] [<c0105836>] [<c012faa0>] 
Jan 14 08:42:40 pegasus kernel: Code: 8b 40 14 85 c0 74 0a 57 56 ff d0 5a 59 eb 1a 89 f6 57 e8 4a 

>>EIP; c0147d2e <prune_dcache+be/160>   <=====
Trace; c012f67c <shrink_cache+30c/3b0>
Trace; c01480c0 <shrink_dcache_memory+20/30>
Trace; c012f886 <shrink_caches+66/90>
Trace; c012f8ec <try_to_free_pages+3c/60>
Trace; c012f990 <kswapd_balance_pgdat+50/a0>
Trace; c012fa06 <kswapd_balance+26/40>
Trace; c012fb40 <kswapd+a0/c0>
Trace; c012faa0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105836 <kernel_thread+26/30>
Trace; c012faa0 <kswapd+0/c0>
Code;  c0147d2e <prune_dcache+be/160>
00000000 <_EIP>:
Code;  c0147d2e <prune_dcache+be/160>   <=====
   0:   8b 40 14                  mov    0x14(%eax),%eax   <=====
Code;  c0147d30 <prune_dcache+c0/160>
   3:   85 c0                     test   %eax,%eax
Code;  c0147d32 <prune_dcache+c2/160>
   5:   74 0a                     je     11 <_EIP+0x11> c0147d3e <prune_dcache+ce/160>
Code;  c0147d34 <prune_dcache+c4/160>
   7:   57                        push   %edi
Code;  c0147d36 <prune_dcache+c6/160>
   8:   56                        push   %esi
Code;  c0147d36 <prune_dcache+c6/160>
   9:   ff d0                     call   *%eax
Code;  c0147d38 <prune_dcache+c8/160>
   b:   5a                        pop    %edx
Code;  c0147d3a <prune_dcache+ca/160>
   c:   59                        pop    %ecx
Code;  c0147d3a <prune_dcache+ca/160>
   d:   eb 1a                     jmp    29 <_EIP+0x29> c0147d56 <prune_dcache+e6/160>
Code;  c0147d3c <prune_dcache+cc/160>
   f:   89 f6                     mov    %esi,%esi
Code;  c0147d3e <prune_dcache+ce/160>
  11:   57                        push   %edi
Code;  c0147d40 <prune_dcache+d0/160>
  12:   e8 4a 00 00 00            call   61 <_EIP+0x61> c0147d8e <prune_dcache+11e/160>

Jan 14 08:42:47 pegasus kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 000001f8

1 warning issued.  Results may not be reliable.

--------------B50B2D0290FD745AEF4A860F--

