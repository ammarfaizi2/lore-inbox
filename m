Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317083AbSFWTin>; Sun, 23 Jun 2002 15:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSFWTin>; Sun, 23 Jun 2002 15:38:43 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:23241 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317083AbSFWTii>; Sun, 23 Jun 2002 15:38:38 -0400
From: Dirk Schmidt <dreisam-rd@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops
Date: Sun, 23 Jun 2002 21:39:49 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DYB67B5WEQ71PYLPOLMZ"
Message-Id: <200206232139.50505.dreisam-rd@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_DYB67B5WEQ71PYLPOLMZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Today I got some kernel oops again.
The output of ksymoops is attached. I am absolutely not familiar with tracing 
kernel bugs, so I hope the information below is useful for you. If not, 
please email me what to do.

My system is Debian Woody with the woodie's 2.4.18-k6 kernel as appearing in 
the log running on an AMD K6-II and 192MB RAM and 2 IDE harddisks.

Best wishes


Dirk
--------------Boundary-00=_DYB67B5WEQ71PYLPOLMZ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ksymoops.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ksymoops.out"

ksymoops 2.4.5 on i586 2.4.18-k6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-k6/ (default)
     -m /boot/System.map-2.4.18-k6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /lib/modules/2.4.18-k6/kernel/drivers/ide/ide-disk.o for module ide-disk has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-k6/kernel/drivers/ide/ide-probe-mod.o for module ide-probe-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-k6/kernel/drivers/ide/ide-mod.o for module ide-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-k6/kernel/fs/ext2/ext2.o for module ext2 has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-k6/kernel/fs/ext3/ext3.o for module ext3 has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-k6/kernel/fs/jbd/jbd.o for module jbd has changed since load
Jun 23 17:32:22 utopia2 kernel: Unable to handle kernel paging request at virtual address 0000ca48
Jun 23 17:32:22 utopia2 kernel: c013f005
Jun 23 17:32:22 utopia2 kernel: *pde = 00000000
Jun 23 17:32:22 utopia2 kernel: Oops: 0002
Jun 23 17:32:22 utopia2 kernel: CPU:    0
Jun 23 17:32:22 utopia2 kernel: EIP:    0010:[get_new_inode+93/360]    Not tainted
Jun 23 17:32:22 utopia2 kernel: EFLAGS: 00010202
Jun 23 17:32:22 utopia2 kernel: eax: 0000ca48   ebx: 00000000   ecx: c000c0a0   edx: c283b0e8
Jun 23 17:32:22 utopia2 kernel: esi: 0000ca40   edi: cbd46918   ebp: cbe6ac00   esp: c6239ed0
Jun 23 17:32:22 utopia2 kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 17:32:22 utopia2 kernel: Process xmms (pid: 4003, stackpage=c6239000)
Jun 23 17:32:22 utopia2 kernel: Stack: 00000000 cbd46918 00007e45 cbe6ac00 c013f286 cbe6ac00 00007e45 cbd46918 
Jun 23 17:32:22 utopia2 kernel:        00000000 00000000 00007e45 c2362340 c2362340 c1d39660 cc81d0fa cbe6ac00 
Jun 23 17:32:22 utopia2 kernel:        00007e45 00000000 00000000 fffffff4 c9d14080 c0ac60c0 c0135cb7 c9d14080 
Jun 23 17:32:22 utopia2 kernel: Call Trace: [iget4+186/204] [nfs:__insmod_nfs_O/lib/modules/2.4.18-k6/kernel/fs/nfs/nfs.o_M3+-790278/96] [real_lookup+83/196] [link_path_walk+1188/1736] [getname+94/156] 
Jun 23 17:32:22 utopia2 kernel: Code: 89 56 08 c7 40 04 3c dc 1e c0 a3 3c dc 1e c0 8b 07 89 70 04 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; 0000ca48 Before first symbol
>>ecx; c000c0a0 Before first symbol
>>edx; c283b0e8 <_end+25d175c/c5a3674>
>>esi; 0000ca40 Before first symbol
>>edi; cbd46918 <_end+badcf8c/c5a3674>
>>ebp; cbe6ac00 <_end+bc01274/c5a3674>
>>esp; c6239ed0 <_end+5fd0544/c5a3674>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 56 08                  mov    %edx,0x8(%esi)
Code;  00000003 Before first symbol
   3:   c7 40 04 3c dc 1e c0      movl   $0xc01edc3c,0x4(%eax)
Code;  0000000a Before first symbol
   a:   a3 3c dc 1e c0            mov    %eax,0xc01edc3c
Code;  0000000f Before first symbol
   f:   8b 07                     mov    (%edi),%eax
Code;  00000011 Before first symbol
  11:   89 70 04                  mov    %esi,0x4(%eax)

Jun 23 18:04:01 utopia2 kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Jun 23 18:04:01 utopia2 kernel: c013d97a
Jun 23 18:04:01 utopia2 kernel: *pde = 00000000
Jun 23 18:04:01 utopia2 kernel: Oops: 0002
Jun 23 18:04:01 utopia2 kernel: CPU:    0
Jun 23 18:04:01 utopia2 kernel: EIP:    0010:[d_instantiate+26/48]    Not tainted
Jun 23 18:04:01 utopia2 kernel: EFLAGS: 00010286
Jun 23 18:04:01 utopia2 kernel: eax: 00000000   ebx: c7b22920   ecx: c000c5c0   edx: c7b22950
Jun 23 18:04:01 utopia2 kernel: esi: c000c5c0   edi: c7b22920   ebp: ffffffe4   esp: cac9ff04
Jun 23 18:04:01 utopia2 kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 18:04:01 utopia2 kernel: Process motv (pid: 3834, stackpage=cac9f000)
Jun 23 18:04:01 utopia2 kernel: Stack: c6ef13e0 c012c189 c7b22920 c000c5c0 cac9ff5c c63dc720 000003ff 0000000c 
Jun 23 18:04:01 utopia2 kernel:        cac9ff5c 0000000c 00000000 c01584f2 cac9ff5c 0000c000 00000000 cac9ff5c 
Jun 23 18:04:01 utopia2 kernel:        c01d2d4c 00000000 000003ff 00000000 000003ff 0000c000 56535953 30303030 
Jun 23 18:04:01 utopia2 kernel: Call Trace: [shmem_file_setup+189/288] [newseg+146/348] [sys_shmget+99/252] [sys_ipc+568/616] [system_call+51/64] 
Jun 23 18:04:01 utopia2 kernel: Code: 89 50 04 89 43 30 8d 41 10 89 42 04 89 51 10 89 4b 08 5b c3 


>>ebx; c7b22920 <_end+78b8f94/c5a3674>
>>ecx; c000c5c0 Before first symbol
>>edx; c7b22950 <_end+78b8fc4/c5a3674>
>>esi; c000c5c0 Before first symbol
>>edi; c7b22920 <_end+78b8f94/c5a3674>
>>ebp; ffffffe4 <END_OF_CODE+336a9081/????>
>>esp; cac9ff04 <_end+aa36578/c5a3674>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 43 30                  mov    %eax,0x30(%ebx)
Code;  00000006 Before first symbol
   6:   8d 41 10                  lea    0x10(%ecx),%eax
Code;  00000009 Before first symbol
   9:   89 42 04                  mov    %eax,0x4(%edx)
Code;  0000000c Before first symbol
   c:   89 51 10                  mov    %edx,0x10(%ecx)
Code;  0000000f Before first symbol
   f:   89 4b 08                  mov    %ecx,0x8(%ebx)
Code;  00000012 Before first symbol
  12:   5b                        pop    %ebx
Code;  00000013 Before first symbol
  13:   c3                        ret    

Jun 23 18:04:01 utopia2 kernel:  <1>Unable to handle kernel paging request at virtual address fffffffc
Jun 23 18:04:01 utopia2 kernel: c01118d0
Jun 23 18:04:01 utopia2 kernel: *pde = 00001063
Jun 23 18:04:01 utopia2 kernel: Oops: 0000
Jun 23 18:04:01 utopia2 kernel: CPU:    0
Jun 23 18:04:01 utopia2 kernel: EIP:    0010:[__wake_up+40/144]    Not tainted
Jun 23 18:04:01 utopia2 kernel: EFLAGS: 00010007
Jun 23 18:04:01 utopia2 kernel: eax: c000c840   ebx: 00000000   ecx: 00000001   edx: 00000003
Jun 23 18:04:01 utopia2 kernel: esi: c000c7a0   edi: 00000001   ebp: c93cfed4   esp: c93cfebc
Jun 23 18:04:01 utopia2 kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 18:04:01 utopia2 kernel: Process modprobe (pid: 4126, stackpage=c93cf000)
Jun 23 18:04:01 utopia2 kernel: Stack: 00000000 c000c7a0 cbd5cfe0 c000c840 00000286 00000003 cbe6ac00 c013f0a4 
Jun 23 18:04:01 utopia2 kernel:        00000000 cbd5cfe0 0004ab0d cbe6ac00 c013f286 cbe6ac00 0004ab0d cbd5cfe0 
Jun 23 18:04:01 utopia2 kernel:        00000000 00000000 0004ab0d c7b22d20 c7b22d20 cba11cc0 cc81d0fa cbe6ac00 
Jun 23 18:04:01 utopia2 kernel: Call Trace: [get_new_inode+252/360] [iget4+186/204] [nfs:__insmod_nfs_O/lib/modules/2.4.18-k6/kernel/fs/nfs/nfs.o_M3+-790278/96] [real_lookup+83/196] [link_path_walk+1188/1736] 
Jun 23 18:04:01 utopia2 kernel: Code: 8b 4b fc 8b 01 85 45 fc 74 4d 31 c0 9c 5e fa c7 01 00 00 00 


>>eax; c000c840 Before first symbol
>>esi; c000c7a0 Before first symbol
>>ebp; c93cfed4 <_end+9166548/c5a3674>
>>esp; c93cfebc <_end+9166530/c5a3674>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  00000003 Before first symbol
   3:   8b 01                     mov    (%ecx),%eax
Code;  00000005 Before first symbol
   5:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  00000008 Before first symbol
   8:   74 4d                     je     57 <_EIP+0x57> 00000057 Before first symbol
Code;  0000000a Before first symbol
   a:   31 c0                     xor    %eax,%eax
Code;  0000000c Before first symbol
   c:   9c                        pushf  
Code;  0000000d Before first symbol
   d:   5e                        pop    %esi
Code;  0000000e Before first symbol
   e:   fa                        cli    
Code;  0000000f Before first symbol
   f:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Jun 23 18:04:01 utopia2 kernel:  <1>Unable to handle kernel paging request at virtual address 00636d70
Jun 23 18:04:01 utopia2 kernel: c013d97a
Jun 23 18:04:01 utopia2 kernel: *pde = 00000000
Jun 23 18:04:01 utopia2 kernel: Oops: 0002
Jun 23 18:04:01 utopia2 kernel: CPU:    0
Jun 23 18:04:01 utopia2 kernel: EIP:    0010:[d_instantiate+26/48]    Not tainted
Jun 23 18:04:01 utopia2 kernel: EFLAGS: 00010282
Jun 23 18:04:01 utopia2 kernel: eax: 00636d6c   ebx: c7b225a0   ecx: c000c020   edx: c7b225d0
Jun 23 18:04:01 utopia2 kernel: esi: c5dc75a0   edi: c6c61f60   ebp: 00000005   esp: c6c61f38
Jun 23 18:04:01 utopia2 kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 18:04:01 utopia2 kernel: Process kdeinit (pid: 4125, stackpage=c6c61000)
Jun 23 18:04:01 utopia2 kernel: Stack: c7b225a0 c01806d7 c7b225a0 c000c020 00000000 00000019 40fe1aa0 bfffe330 
Jun 23 18:04:01 utopia2 kernel:        3739395b 005d3438 00001000 4070e000 00000000 c0121328 c16152a0 c2138ae0 
Jun 23 18:04:01 utopia2 kernel:        c6c61f58 00000007 000185c8 c01810e4 c000c140 00000000 c000c140 c0181d31 
Jun 23 18:04:01 utopia2 kernel: Call Trace: [sock_map_fd+239/356] [do_munmap+556/572] [sys_socket+44/76] [sys_socketcall+97/468] [error_code+52/64] 
Jun 23 18:04:01 utopia2 kernel: Code: 89 50 04 89 43 30 8d 41 10 89 42 04 89 51 10 89 4b 08 5b c3 


>>eax; 00636d6c Before first symbol
>>ebx; c7b225a0 <_end+78b8c14/c5a3674>
>>ecx; c000c020 Before first symbol
>>edx; c7b225d0 <_end+78b8c44/c5a3674>
>>esi; c5dc75a0 <_end+5b5dc14/c5a3674>
>>edi; c6c61f60 <_end+69f85d4/c5a3674>
>>esp; c6c61f38 <_end+69f85ac/c5a3674>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 43 30                  mov    %eax,0x30(%ebx)
Code;  00000006 Before first symbol
   6:   8d 41 10                  lea    0x10(%ecx),%eax
Code;  00000009 Before first symbol
   9:   89 42 04                  mov    %eax,0x4(%edx)
Code;  0000000c Before first symbol
   c:   89 51 10                  mov    %edx,0x10(%ecx)
Code;  0000000f Before first symbol
   f:   89 4b 08                  mov    %ecx,0x8(%ebx)
Code;  00000012 Before first symbol
  12:   5b                        pop    %ebx
Code;  00000013 Before first symbol
  13:   c3                        ret    


7 warnings issued.  Results may not be reliable.

--------------Boundary-00=_DYB67B5WEQ71PYLPOLMZ--

