Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131502AbRDCIvA>; Tue, 3 Apr 2001 04:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131600AbRDCIuu>; Tue, 3 Apr 2001 04:50:50 -0400
Received: from ns.tasking.nl ([195.193.207.2]:19976 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S131502AbRDCIui>;
	Tue, 3 Apr 2001 04:50:38 -0400
Date: Tue, 3 Apr 2001 10:48:14 +0200
From: Frank van Maarseveen <fvm@tasking.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 Oops
Message-ID: <20010403104814.A30594@espoo.tasking.nl>
Reply-To: frank_van_maarseveen@tasking.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
Organization: TASKING, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe it's already fixed. But just in case it's not:

ksymoops 2.3.5 on i686 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /boot/System.map-2.4.0 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Apr  3 07:37:51 naantali kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000 
Apr  3 07:37:51 naantali kernel: c01402c0 
Apr  3 07:37:51 naantali kernel: *pde = 00000000 
Apr  3 07:37:51 naantali kernel: Oops: 0000 
Apr  3 07:37:51 naantali kernel: CPU:    0 
Apr  3 07:37:51 naantali kernel: EIP:    0010:[<c01402c0>] 
Using defaults from ksymoops -t elf32-i386 -a i386
Apr  3 07:37:51 naantali kernel: EFLAGS: 00013203 
Apr  3 07:37:51 naantali kernel: eax: c127c980   ebx: ffffffe8   ecx: 0000001c   edx: c1260000 
Apr  3 07:37:51 naantali kernel: esi: 000064fe   edi: c67e9e10   ebp: 00000000   esp: c67e9dac 
Apr  3 07:37:51 naantali kernel: ds: 0018   es: 0018   ss: 0018 
Apr  3 07:37:51 naantali kernel: Process X (pid: 14960, stackpage=c67e9000) 
Apr  3 07:37:51 naantali kernel: Stack: 00000000 c4a5b000 c67e9e10 c4a5b005 c127c980 c4a5b001 000064fe 00000003  
Apr  3 07:37:51 naantali kernel:        c0138334 c12f8320 c67e9e10 00000000 c0138798 c12f8320 c67e9e10 00000004  
Apr  3 07:37:51 naantali kernel:        00000000 c4a5b000 c67e9e34 bffffa80 c67e8000 000041ed c67e8000 00000009  
Apr  3 07:37:51 naantali kernel: Call Trace: [<c0138334>] [<c0138798>] [<c01368f7>] [<c013710a>] [<c0128cc0>] [<c0129d43>] [<c011fbdf>]  
Apr  3 07:37:51 naantali kernel:        [<c012023b>] [<c0110d9f>] [<c0110c44>] [<c0111918>] [<c013814c>] [<c0107943>] [<c0108e93>] [<c010002b>]  
Apr  3 07:37:51 naantali kernel: Code: 8b 6d 00 8b 74 24 18 39 73 48 75 7c 8b 74 24 24 39 73 0c 75  

>>EIP; c01402c0 <d_lookup+68/108>   <=====
Trace; c0138334 <cached_lookup+10/54>
Trace; c0138798 <path_walk+224/81c>
Trace; c01368f7 <open_exec+27/b8>
Trace; c013710a <do_execve+1e/1ec>
Trace; c0128cc0 <free_shortage+1c/104>
Trace; c0129d43 <__alloc_pages+db/2e4>
Trace; c011fbdf <do_wp_page+27f/2a8>
Trace; c012023b <handle_mm_fault+123/164>
Trace; c0110d9f <do_page_fault+15b/41c>
Trace; c0110c44 <do_page_fault+0/41c>
Trace; c0111918 <schedule+2d8/430>
Trace; c013814c <getname+5c/a0>
Trace; c0107943 <sys_execve+2f/60>
Trace; c0108e93 <system_call+33/40>
Trace; c010002b <startup_32+2b/13a>
Code;  c01402c0 <d_lookup+68/108>
00000000 <_EIP>:
Code;  c01402c0 <d_lookup+68/108>   <=====
   0:   8b 6d 00                  movl   0x0(%ebp),%ebp   <=====
Code;  c01402c3 <d_lookup+6b/108>
   3:   8b 74 24 18               movl   0x18(%esp,1),%esi
Code;  c01402c7 <d_lookup+6f/108>
   7:   39 73 48                  cmpl   %esi,0x48(%ebx)
Code;  c01402ca <d_lookup+72/108>
   a:   75 7c                     jne    88 <_EIP+0x88> c0140348 <d_lookup+f0/108>
Code;  c01402cc <d_lookup+74/108>
   c:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c01402d0 <d_lookup+78/108>
  10:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c01402d3 <d_lookup+7b/108>
  13:   75 00                     jne    15 <_EIP+0x15> c01402d5 <d_lookup+7d/108>


1 warning issued.  Results may not be reliable.

-- 
Frank
