Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSLHTFX>; Sun, 8 Dec 2002 14:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbSLHTFX>; Sun, 8 Dec 2002 14:05:23 -0500
Received: from f04s01.cac.psu.edu ([128.118.141.31]:51170 "EHLO
	f04n01.cac.psu.edu") by vger.kernel.org with ESMTP
	id <S261529AbSLHTFV>; Sun, 8 Dec 2002 14:05:21 -0500
Date: Sun, 8 Dec 2002 14:13:01 -0500
From: Matt Rickard <mjr318@psu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops with 3c59x module (3com 3c595 NIC)
Message-Id: <20021208141301.34534a2a.mjr318@psu.edu>
In-Reply-To: <20021207164300.2a35f18d.mjr318@psu.edu>
References: <20021207164300.2a35f18d.mjr318@psu.edu>
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize for not completely reading the FAQ before my previous oops
posting.  Here is the results of the oops after feeding it through
ksymoops.  If there's any more information that would be helpful for me
to provide, please let me know!

Here it is:

ksymoops 2.4.8 on i586 2.4.19.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /usr/src/linux/System.map (default)

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0108704>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 00000004   ecx: bffff698   edx: 401286a0
esi: 4012c1d0   edi: 00000004   ebp: bffff668   esp: c30fbfd0
ds: 0018   es: 0018   ss: 0018
Process find (pid: 894, stackpage=c30fb000)
Stack: 4012c1d0 00000004 bffff668 00000000 c010002b 0000002b 000000c5
400d914c        00000023 00000216 bffff5fc 0000002b 
Call Trace:   
Code: fe ff ff fd 1f 07 83 c4 0c cf cf fe fb f7 44 24 33 68 08 c3 


>>EIP; c0108704 <restore_all+3/f>   <=====

>>esp; c30fbfd0 <_end+2e32c34/46a3c64>

Code;  c0108704 <restore_all+3/f>
0000000000000000 <_EIP>:
Code;  c0108704 <restore_all+3/f>   <=====
   0:   fe                        (bad)     <=====
Code;  c0108705 <restore_all+4/f>
   1:   ff                        (bad)  
Code;  c0108706 <restore_all+5/f>
   2:   ff                        (bad)  
Code;  c0108707 <restore_all+6/f>
   3:   fd                        std    
Code;  c0108708 <restore_all+7/f>
   4:   1f                        pop    %ds
Code;  c0108709 <restore_all+8/f>
   5:   07                        pop    %es
Code;  c010870a <restore_all+9/f>
   6:   83 c4 0c                  add    $0xc,%esp
Code;  c010870d <restore_all+c/f>
   9:   cf                        iret   
Code;  c010870e <restore_all+d/f>
   a:   cf                        iret   
Code;  c010870f <restore_all+e/f>
   b:   fe                        (bad)  
Code;  c0108710 <signal_return+0/20>
   c:   fb                        sti    
Code;  c0108711 <signal_return+1/20>
   d:   f7 44 24 33 68 08 c3      testl  $0xc30868,0x33(%esp,1)
Code;  c0108718 <signal_return+8/20>
  14:   00 

 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000000 c013d515
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013d515>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c220c6c0   ecx: c1b3ca20   edx: c29c44c0
esi: c220c6d8   edi: c10b6320   ebp: c220c6c0   esp: c30fbe8c
ds: 0018   es: 0018   ss: 0018
Process find (pid: 894, stackpage=c30fb000)
Stack: c29c4340 c1b3ca20 c012e427 c220c6c0 c088fea0 c24e7b40 08055000
00001000        c012088d c24e7b40 c30fbf9c c30fa000 0000000b c088f5a0
c01115dd c24e7b40        c24e7b40 c01153cd c24e7b40 00000000 c30fbf9c
c0108f0c bffff668 c0108cf9 Call Trace:    [<c012e427>] [<c012088d>]
[<c01115dd>] [<c01153cd>] [<c0108f0c>]  [<c0108cf9>] [<c0108f8e>]
[<c0108704>] [<c011c60a>] [<c0135b80>] [<c01087f4>]  [<c0108704>]
Code: 08 00 00 39 43 10 74 23 20 9c 02 25 c0 89 70 04 89 43 18 c7 


>>EIP; c013d515 <dput+45/124>   <=====

>>ebx; c220c6c0 <_end+1f43324/46a3c64>
>>ecx; c1b3ca20 <_end+1873684/46a3c64>
>>edx; c29c44c0 <_end+26fb124/46a3c64>
>>esi; c220c6d8 <_end+1f4333c/46a3c64>
>>edi; c10b6320 <_end+decf84/46a3c64>
>>ebp; c220c6c0 <_end+1f43324/46a3c64>
>>esp; c30fbe8c <_end+2e32af0/46a3c64>

Trace; c012e427 <fput+af/d0>
Trace; c012088d <exit_mmap+c5/11c>
Trace; c01115dd <mmput+39/50>
Trace; c01153cd <do_exit+85/230>
Trace; c0108f0c <do_invalid_op+0/8c>
Trace; c0108cf9 <die+59/5c>
Trace; c0108f8e <do_invalid_op+82/8c>
Trace; c0108704 <restore_all+3/f>
Trace; c011c60a <in_group_p+1e/28>
Trace; c0135b80 <vfs_permission+74/f0>
Trace; c01087f4 <error_code+34/40>
Trace; c0108704 <restore_all+3/f>

Code;  c013d515 <dput+45/124>
0000000000000000 <_EIP>:
Code;  c013d515 <dput+45/124>   <=====
   0:   08 00                     or     %al,(%eax)   <=====
Code;  c013d517 <dput+47/124>
   2:   00 39                     add    %bh,(%ecx)
Code;  c013d519 <dput+49/124>
   4:   43                        inc    %ebx
Code;  c013d51a <dput+4a/124>
   5:   10 74 23 20               adc    %dh,0x20(%ebx,1)
Code;  c013d51e <dput+4e/124>
   9:   9c                        pushf  
Code;  c013d51f <dput+4f/124>
   a:   02 25 c0 89 70 04         add    0x47089c0,%ah
Code;  c013d525 <dput+55/124>
  10:   89 43 18                  mov    %eax,0x18(%ebx)
Code;  c013d528 <dput+58/124>
  13:   c7 00 00 00 00 00         movl   $0x0,(%eax)

