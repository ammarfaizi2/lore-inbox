Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310637AbSE0IHr>; Mon, 27 May 2002 04:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314285AbSE0IHq>; Mon, 27 May 2002 04:07:46 -0400
Received: from ns.tasking.nl ([195.193.207.2]:35344 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S310637AbSE0IHo>;
	Mon, 27 May 2002 04:07:44 -0400
Date: Mon, 27 May 2002 10:04:51 +0200
From: Frank van Maarseveen <fvm@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 Oops
Message-ID: <20020527100451.A1090@espoo.tasking.nl>
Reply-To: frank.van.maarseveen@altium.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Subliminal-Message: Use Linux!
Organization: ALTIUM Software BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.3.5 on i686 2.4.18-x68.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-x68/ (default)
     -m /boot/System.map-2.4.18-x68 (specified)

May 27 09:57:31 espoo kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000 
May 27 09:57:31 espoo kernel: c0141f90 
May 27 09:57:31 espoo kernel: *pde = 00000000 
May 27 09:57:31 espoo kernel: Oops: 0000 
May 27 09:57:31 espoo kernel: CPU:    0 
May 27 09:57:31 espoo kernel: EIP:    0010:[<c0141f90>]    Not tainted 
Using defaults from ksymoops -t elf32-i386 -a i386
May 27 09:57:31 espoo kernel: EFLAGS: 00010213 
May 27 09:57:31 espoo kernel: eax: c145ba08   ebx: fffffff0   ecx: 0000000f   edx: c1440000 
May 27 09:57:31 espoo kernel: esi: 116fcad5   edi: ca2c9f74   ebp: 00000000   esp: ca2c9f10 
May 27 09:57:31 espoo kernel: ds: 0018   es: 0018   ss: 0018 
May 27 09:57:31 espoo kernel: Process make (pid: 26870, stackpage=ca2c9000) 
May 27 09:57:31 espoo kernel: Stack: 116fcad5 ca49be08 ca2c9f74 ca2c9fa4 c145ba08 cea8e026 116fcad5 00000005  
May 27 09:57:31 espoo kernel:        c0139c44 ca49be08 ca2c9f74 116fcad5 c013a04a ca49be08 ca2c9f74 00000004  
May 27 09:57:31 espoo kernel:        cea8e000 00000000 ca2c9fa4 00000009 ca2c8000 ca2c8000 00000009 cea8e02c  
May 27 09:57:31 espoo kernel: Call Trace: [<c0139c44>] [<c013a04a>] [<c013a5da>] [<c013a991>] [<c01376e9>]  
May 27 09:57:31 espoo kernel:    [<c0106dc3>]  
May 27 09:57:31 espoo kernel: Code: 8b 6d 00 8b 74 24 18 39 73 44 75 7c 8b 74 24 24 39 73 0c 75  

>>EIP; c0141f90 <d_lookup+60/100>   <=====
Trace; c0139c44 <cached_lookup+10/54>
Trace; c013a04a <link_path_walk+202/778>
Trace; c013a5da <path_walk+1a/1c>
Trace; c013a991 <__user_walk+35/50>
Trace; c01376e9 <sys_newstat+19/70>
Trace; c0106dc3 <system_call+33/40>
Code;  c0141f90 <d_lookup+60/100>
00000000 <_EIP>:
Code;  c0141f90 <d_lookup+60/100>   <=====
   0:   8b 6d 00                  movl   0x0(%ebp),%ebp   <=====
Code;  c0141f93 <d_lookup+63/100>
   3:   8b 74 24 18               movl   0x18(%esp,1),%esi
Code;  c0141f97 <d_lookup+67/100>
   7:   39 73 44                  cmpl   %esi,0x44(%ebx)
Code;  c0141f9a <d_lookup+6a/100>
   a:   75 7c                     jne    88 <_EIP+0x88> c0142018 <d_lookup+e8/100>
Code;  c0141f9c <d_lookup+6c/100>
   c:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0141fa0 <d_lookup+70/100>
  10:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c0141fa3 <d_lookup+73/100>
  13:   75 00                     jne    15 <_EIP+0x15> c0141fa5 <d_lookup+75/100>

-- 
Frank
