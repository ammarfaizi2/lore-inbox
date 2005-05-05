Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVEEX5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVEEX5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 19:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVEEX5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 19:57:25 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:56998 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S262009AbVEEXzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 19:55:51 -0400
Date: Fri, 6 May 2005 02:55:40 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: openafs-info@openafs.org
cc: linux-kernel@vger.kernel.org
Subject: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and openafs
 1.3.82
Message-ID: <Pine.LNX.4.62.0505060209040.31479@tassadar.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-AntiVirus: checked by AntiVir Milter (version: 1.1.0-4; AVE: 6.30.0.12; VDF: 6.30.0.157; host: tassadar)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 	Hello ,

[1.] One line summary of the problem:

Oopses on an openafs client system using openafs 1.3.78 and kernel 2.4.29.
Oopses also occur afer moving to kernel 2.4.30 and openafs 1.3.82


[2.] Full description of the problem/report:

 	My openafs enabled slackware 10.1 system oopsed 4 times during a 
40+ days of uptime period. The first 3 oopses went undetected because of 
no visible side effects , but the 4th froze the system. Those were with 
2.4.29 vanilla kernel and openafs 1.3.78 . After moving to 2.4.30 and 
1.3.82 , two oopses that lead to a system freeze occured within the first 
24 hours of uptime. Mediocre read/write operations take place in the openafs 
filesystem by the client 24h/day (at around 2Mbytes/sec average),mostly 
rsync/ftp. System is a dual PIII at 600 Mhz , 768 RAM

 	Most of the oopses seem to happen then the openafs server in 
the cell that I use mostly restarts. ( 4 am)

[3.] Keywords (i.e., modules, networking, kernel):

openafs 1.3.78 1.3.82 , vanilla kernel 2.4.29 2.4.30 , SMP


[4.] Kernel version (from /proc/version):

for 2.4.30 :

Linux version 2.4.30 (root@system) (gcc version 3.3.4) #1 SMP Wed May 4 
15:10:58 EEST 2005


for 2.4.29:

Linux version 2.4.29 (root@system) (gcc version 3.3.4) #1 SMP Sun Mar 1
10:29:35 EEST 2005

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)


   From 2.4.29 and openafs 1.3.78:

a)

ksymoops 2.4.11 on i686 2.4.30.  Options used
      -V (default)
      -k /usr/src/ksyms2429 (specified)
      -l /usr/src/modules2429 (specified)
      -o /lib/modules/2.4.29/ (specified)
      -m /usr/src/linux-2.4.29/System.map (specified)

Warning (compare_maps): libafs-2.4.29.mp symbol kallsyms_address_to_symbol not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol kallsyms_symbol_to_address not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_chdir not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_exit not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_ioctl not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_open not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_wait4 not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_write not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Mar 27 04:01:19 system kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000039
Mar 27 04:01:19 system kernel: c014d88b
Mar 27 04:01:19 system kernel: *pde = 00000000
Mar 27 04:01:19 system kernel: Oops: 0000
Mar 27 04:01:19 system kernel: CPU:    0
Mar 27 04:01:19 system kernel: EIP:    0010:[<c014d88b>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 27 04:01:19 system kernel: EFLAGS: 00010213
Mar 27 04:01:19 system kernel: eax: 00000001   ebx: 00000001   ecx: f0d62ec4   edx: efd41760
Mar 27 04:01:19 system kernel: esi: cb519009   edi: 00000001   ebp: c5083f98   esp: c5083f24
Mar 27 04:01:19 system kernel: ds: 0018   es: 0018   ss: 0018
Mar 27 04:01:19 system kernel: Process rsync (pid: 1508, stackpage=c5083000)
Mar 27 04:01:19 system kernel: Stack: d9def0c0 c5083f40 00000008 00000246 00000008 f0d62e58 00000001 cb519000
Mar 27 04:01:19 system kernel:        00000009 0fbf25c9 bfff7950 c5083f98 cb519000 00000000 00000008 c014df19
Mar 27 04:01:19 system kernel:        cb519000 cb519000 c5083f98 c014e279 bfff7950 c0153020 c5082000 c5083f98
Mar 27 04:01:19 system kernel: Call Trace:    [<c014df19>] [<c014e279>] [<c0153020>] [<c014a1ff>] [<c0108ebb>]
Mar 27 04:01:19 system kernel: Code: 8b 43 38 85 c0 0f 84 83 00 00 00 f0 fe 0d e0 99 41 c0 0f 88


>>EIP; c014d88b <link_path_walk+55b/9e0>   <=====

>>edx; efd41760 <_end+2f8df1b4/30431ab4>
>>esi; cb519009 <_end+b0b6a5d/30431ab4>
>>ebp; c5083f98 <_end+4c219ec/30431ab4>
>>esp; c5083f24 <_end+4c21978/30431ab4>

Trace; c014df19 <path_lookup+39/40>
Trace; c014e279 <__user_walk+49/60>
Trace; c0153020 <filldir64+0/130>
Trace; c014a1ff <sys_lstat64+1f/90>
Trace; c0108ebb <system_call+33/38>

Code;  c014d88b <link_path_walk+55b/9e0>
00000000 <_EIP>:
Code;  c014d88b <link_path_walk+55b/9e0>   <=====
    0:   8b 43 38                  mov    0x38(%ebx),%eax   <=====
Code;  c014d88e <link_path_walk+55e/9e0>
    3:   85 c0                     test   %eax,%eax
Code;  c014d890 <link_path_walk+560/9e0>
    5:   0f 84 83 00 00 00         je     8e <_EIP+0x8e>
Code;  c014d896 <link_path_walk+566/9e0>
    b:   f0 fe 0d e0 99 41 c0      lock decb 0xc04199e0
Code;  c014d89d <link_path_walk+56d/9e0>
   12:   0f 88 00 00 00 00         js     18 <_EIP+0x18>


8 warnings issued.  Results may not be reliable.

b)

ksymoops 2.4.11 on i686 2.4.30.  Options used
      -V (default)
      -k /usr/src/ksyms2429 (specified)
      -l /usr/src/modules2429 (specified)
      -o /lib/modules/2.4.29/ (specified)
      -m /usr/src/linux-2.4.29/System.map (specified)

Warning (compare_maps): libafs-2.4.29.mp symbol kallsyms_address_to_symbol not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol kallsyms_symbol_to_address not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_chdir not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_exit not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_ioctl not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_open not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_wait4 not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_write not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Apr  3 04:01:25 system kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000039
Apr  3 04:01:25 system kernel: c014d88b
Apr  3 04:01:25 system kernel: *pde = 00000000
Apr  3 04:01:25 system kernel: Oops: 0000
Apr  3 04:01:25 system kernel: CPU:    1
Apr  3 04:01:25 system kernel: EIP:    0010:[<c014d88b>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Apr  3 04:01:25 system kernel: EFLAGS: 00010213
Apr  3 04:01:25 system kernel: eax: 00000001   ebx: 00000001   ecx: f0d62ec4   edx: efd41760
Apr  3 04:01:25 system kernel: esi: df929009   edi: 00000001   ebp: d8c9df98   esp: d8c9df24
Apr  3 04:01:25 system kernel: ds: 0018   es: 0018   ss: 0018
Apr  3 04:01:25 system kernel: Process rsync (pid: 28573, stackpage=d8c9d000)
Apr  3 04:01:25 system kernel: Stack: c2f56d40 d8c9df40 00000008 00000246 00000008 f0d62e58 00000001 df929000
Apr  3 04:01:25 system kernel:        00000009 0fbf25c9 bfff7950 d8c9df98 df929000 00000000 00000008 c014df19
Apr  3 04:01:25 system kernel:        df929000 df929000 d8c9df98 c014e279 bfff7950 c0153020 d8c9c000 d8c9df98
Apr  3 04:01:25 system kernel: Call Trace:    [<c014df19>] [<c014e279>] [<c0153020>] [<c014a1ff>] [<c0108ebb>]
Apr  3 04:01:25 system kernel: Code: 8b 43 38 85 c0 0f 84 83 00 00 00 f0 fe 0d e0 99 41 c0 0f 88


>>EIP; c014d88b <link_path_walk+55b/9e0>   <=====

>>edx; efd41760 <_end+2f8df1b4/30431ab4>
>>esi; df929009 <_end+1f4c6a5d/30431ab4>
>>ebp; d8c9df98 <_end+1883b9ec/30431ab4>
>>esp; d8c9df24 <_end+1883b978/30431ab4>

Trace; c014df19 <path_lookup+39/40>
Trace; c014e279 <__user_walk+49/60>
Trace; c0153020 <filldir64+0/130>
Trace; c014a1ff <sys_lstat64+1f/90>
Trace; c0108ebb <system_call+33/38>

Code;  c014d88b <link_path_walk+55b/9e0>
00000000 <_EIP>:
Code;  c014d88b <link_path_walk+55b/9e0>   <=====
    0:   8b 43 38                  mov    0x38(%ebx),%eax   <=====
Code;  c014d88e <link_path_walk+55e/9e0>
    3:   85 c0                     test   %eax,%eax
Code;  c014d890 <link_path_walk+560/9e0>
    5:   0f 84 83 00 00 00         je     8e <_EIP+0x8e>
Code;  c014d896 <link_path_walk+566/9e0>
    b:   f0 fe 0d e0 99 41 c0      lock decb 0xc04199e0
Code;  c014d89d <link_path_walk+56d/9e0>
   12:   0f 88 00 00 00 00         js     18 <_EIP+0x18>


8 warnings issued.  Results may not be reliable.


c)

ksymoops 2.4.11 on i686 2.4.30.  Options used
      -V (default)
      -k /usr/src/ksyms2429 (specified)
      -l /usr/src/modules2429 (specified)
      -o /lib/modules/2.4.29/ (specified)
      -m /usr/src/linux-2.4.29/System.map (specified)

Warning (compare_maps): libafs-2.4.29.mp symbol kallsyms_address_to_symbol not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol kallsyms_symbol_to_address not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_chdir not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_exit not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_ioctl not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_open not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_wait4 not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_write not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Apr 24 04:01:42 system kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000039
Apr 24 04:01:42 system kernel: c014d88b
Apr 24 04:01:42 system kernel: *pde = 00000000
Apr 24 04:01:42 system kernel: Oops: 0000
Apr 24 04:01:42 system kernel: CPU:    0
Apr 24 04:01:42 system kernel: EIP:    0010:[<c014d88b>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 24 04:01:42 system kernel: EFLAGS: 00010213
Apr 24 04:01:42 system kernel: eax: 00000001   ebx: 00000001   ecx: f0c1d8d4   edx: efd41760
Apr 24 04:01:42 system kernel: esi: ed081036   edi: 00000001   ebp: e632ff98   esp: e632ff24
Apr 24 04:01:42 system kernel: ds: 0018   es: 0018   ss: 0018
Apr 24 04:01:42 system kernel: Process rsync (pid: 29746, stackpage=e632f000)
Apr 24 04:01:42 system kernel: Stack: eeed9a60 e632ff40 00000008 00000246 00000008 f0c1d868 00000001 ed08100a
Apr 24 04:01:42 system kernel:        0000002c 72df8b8a bfff58c0 e632ff98 ed081000 00000000 00000008 c014df19
Apr 24 04:01:42 system kernel:        ed081000 ed081000 e632ff98 c014e279 bfff58c0 c0153020 e632e000 e632ff98
Apr 24 04:01:42 system kernel: Call Trace:    [<c014df19>] [<c014e279>] [<c0153020>] [<c014a1ff>] [<c0108ebb>]
Apr 24 04:01:42 system kernel: Code: 8b 43 38 85 c0 0f 84 83 00 00 00 f0 fe 0d e0 99 41 c0 0f 88


>>EIP; c014d88b <link_path_walk+55b/9e0>   <=====

>>edx; efd41760 <_end+2f8df1b4/30431ab4>
>>esi; ed081036 <_end+2cc1ea8a/30431ab4>
>>ebp; e632ff98 <_end+25ecd9ec/30431ab4>
>>esp; e632ff24 <_end+25ecd978/30431ab4>

Trace; c014df19 <path_lookup+39/40>
Trace; c014e279 <__user_walk+49/60>
Trace; c0153020 <filldir64+0/130>
Trace; c014a1ff <sys_lstat64+1f/90>
Trace; c0108ebb <system_call+33/38>

Code;  c014d88b <link_path_walk+55b/9e0>
00000000 <_EIP>:
Code;  c014d88b <link_path_walk+55b/9e0>   <=====
    0:   8b 43 38                  mov    0x38(%ebx),%eax   <=====
Code;  c014d88e <link_path_walk+55e/9e0>
    3:   85 c0                     test   %eax,%eax
Code;  c014d890 <link_path_walk+560/9e0>
    5:   0f 84 83 00 00 00         je     8e <_EIP+0x8e>
Code;  c014d896 <link_path_walk+566/9e0>
    b:   f0 fe 0d e0 99 41 c0      lock decb 0xc04199e0
Code;  c014d89d <link_path_walk+56d/9e0>
   12:   0f 88 00 00 00 00         js     18 <_EIP+0x18>


8 warnings issued.  Results may not be reliable.


d)

ksymoops 2.4.11 on i686 2.4.30.  Options used
      -V (default)
      -k /usr/src/ksyms2429 (specified)
      -l /usr/src/modules2429 (specified)
      -o /lib/modules/2.4.29/ (specified)
      -m /usr/src/linux-2.4.29/System.map (specified)

Warning (compare_maps): libafs-2.4.29.mp symbol kallsyms_address_to_symbol not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol kallsyms_symbol_to_address not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_chdir not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_exit not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_ioctl not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_open not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_wait4 not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
Warning (compare_maps): libafs-2.4.29.mp symbol sys_write not found in /usr/local/lib/openafs/libafs-2.4.29.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.29.mp.o entry
May  4 11:50:28 system kernel: dcache hc<1>Unable to handle kernel paging request at virtual address ffffffff
May  4 11:50:28 system kernel: f0a0e170
May  4 11:50:28 system kernel: *pde = 00004063
May  4 11:50:28 system kernel: Oops: 0002
May  4 11:50:28 system kernel: CPU:    0
May  4 11:50:28 system kernel: EIP:    0010:[<f0a0e170>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
May  4 11:50:28 system kernel: EFLAGS: 00010282
May  4 11:50:28 system kernel: eax: 00000009   ebx: 000ad489   ecx: 00000002   edx: eecd9f7c
May  4 11:50:28 system kernel: esi: f20ca55c   edi: f0d72000   ebp: 00000000   esp: e035fdd4
May  4 11:50:28 system kernel: ds: 0018   es: 0018   ss: 0018
May  4 11:50:28 system kernel: Process afs_cachetrim (pid: 1125, stackpage=e035f000)
May  4 11:50:28 system kernel: Stack: f0a33fe1 00000000 00000000 f0a3caa0 f20ca55c 00000000 00000000 f09cfc0f
May  4 11:50:28 system kernel:        f0a33fe1 00000000 00000000 f0a3caa0 0079123e f20ca55c 00000000 f09cf897
May  4 11:50:28 system kernel:        f20ca55c f20fbf70 f0a3caa0 f09d5a6a c277c580 00000000 00000000 e035e000
May  4 11:50:28 system kernel: Call Trace:    [<f0a33fe1>] [<f0a3caa0>] [<f09cfc0f>] [<f0a33fe1>] [<f0a3caa0>]
May  4 11:50:28 system kernel:   [<f09cf897>] [<f0a3caa0>] [<f09d5a6a>] [<f09cef5e>] [<f0a3caa0>] [<f0a3caa0>]
May  4 11:50:28 system kernel:   [<f0a1fe39>] [<f0a3509c>] [<c010740e>] [<f0a1fad0>]
May  4 11:50:28 system kernel: Code: c6 05 ff ff ff ff 2a 83 c4 1c c3 90 8d 74 26 00 b8 f9 4a a3


>>EIP; f0a0e170 <[libafs-2.4.29.mp]osi_Panic+20/40>   <=====

>>edx; eecd9f7c <_end+2e8779d0/30431ab4>
>>esp; e035fdd4 <_end+1fefd828/30431ab4>

Trace; f0a33fe1 <[libafs-2.4.29.mp].rodata.end+60e6/e545>
Trace; f0a3caa0 <[libafs-2.4.29.mp]afs_global_lock+0/20>
Trace; f09cfc0f <[libafs-2.4.29.mp]afs_HashOutDCache+7f/120>
Trace; f0a33fe1 <[libafs-2.4.29.mp].rodata.end+60e6/e545>
Trace; f0a3caa0 <[libafs-2.4.29.mp]afs_global_lock+0/20>
Trace; f09cf897 <[libafs-2.4.29.mp]afs_GetDownD+567/860>
Trace; f0a3caa0 <[libafs-2.4.29.mp]afs_global_lock+0/20>
Trace; f09d5a6a <[libafs-2.4.29.mp].text.lock.KBUILD_BASENAME+f/f5>
Trace; f09cef5e <[libafs-2.4.29.mp]afs_CacheTruncateDaemon+10e/460>
Trace; f0a3caa0 <[libafs-2.4.29.mp]afs_global_lock+0/20>
Trace; f0a3caa0 <[libafs-2.4.29.mp]afs_global_lock+0/20>
Trace; f0a1fe39 <[libafs-2.4.29.mp]afsd_thread+369/5d0>
Trace; f0a3509c <[libafs-2.4.29.mp].rodata.end+71a1/e545>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; f0a1fad0 <[libafs-2.4.29.mp]afsd_thread+0/5d0>

Code;  f0a0e170 <[libafs-2.4.29.mp]osi_Panic+20/40>
00000000 <_EIP>:
Code;  f0a0e170 <[libafs-2.4.29.mp]osi_Panic+20/40>   <=====
    0:   c6 05 ff ff ff ff 2a      movb   $0x2a,0xffffffff   <=====
Code;  f0a0e177 <[libafs-2.4.29.mp]osi_Panic+27/40>
    7:   83 c4 1c                  add    $0x1c,%esp
Code;  f0a0e17a <[libafs-2.4.29.mp]osi_Panic+2a/40>
    a:   c3                        ret 
Code;  f0a0e17b <[libafs-2.4.29.mp]osi_Panic+2b/40>
    b:   90                        nop 
Code;  f0a0e17c <[libafs-2.4.29.mp]osi_Panic+2c/40>
    c:   8d 74 26 00               lea    0x0(%esi),%esi
Code;  f0a0e180 <[libafs-2.4.29.mp]osi_Panic+30/40>
   10:   b8 f9 4a a3 00            mov    $0xa34af9,%eax


8 warnings issued.  Results may not be reliable.








>From kernel 2.4.30 and openafs 1.3.82

a)

ksymoops 2.4.11 on i686 2.4.30.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.30/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): libafs-2.4.30.mp symbol sys_chdir not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_exit not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_ioctl not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_open not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_wait4 not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_write not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
May  5 04:49:11 system kernel: kernel BUG at inode.c:1204!
May  5 04:49:11 system kernel: invalid operand: 0000
May  5 04:49:11 system kernel: CPU:    1
May  5 04:49:11 system kernel: EIP:    0010:[<c015a980>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
May  5 04:49:11 system kernel: EFLAGS: 00010246
May  5 04:49:11 system kernel: eax: 00000000   ebx: c671db40   ecx: c671db50   edx: c671db50
May  5 04:49:11 system kernel: esi: eed14800   edi: 00000000   ebp: 0000ab3f   esp: effddf40
May  5 04:49:11 system kernel: ds: 0018   es: 0018   ss: 0018
May  5 04:49:11 system kernel: Process kswapd (pid: 5, stackpage=effdd000)
May  5 04:49:11 system kernel: Stack: d13d4040 c0157571 d563fba0 c6c7c458 c6c7c440 c671db40 c01579ce c671db40
May  5 04:49:11 system kernel:        ecf12ac0 000001d0 0000003c 0000000b c03a3a7c c0157da4 0000deba c013937e
May  5 04:49:11 system kernel:        00000006 000001d0 00000000 00000000 c03a3a7c effdc000 c03a39a0 00000000
May  5 04:49:11 system kernel: Call Trace:    [<c0157571>] [<c01579ce>] [<c0157da4>] [<c013937e>] [<c0139526>]
May  5 04:49:11 system kernel:   [<c0139598>] [<c01396d8>] [<c0105000>] [<c010740e>] [<c0139640>]
May  5 04:49:11 system kernel: Code: 0f 0b b4 04 72 bd 34 c0 e9 0a fd ff ff 8d 76 00 8b 54 24 04


>>EIP; c015a980 <iput+310/320>   <=====

>>ebx; c671db40 <_end+62b5700/3042bc20>
>>ecx; c671db50 <_end+62b5710/3042bc20>
>>edx; c671db50 <_end+62b5710/3042bc20>
>>esi; eed14800 <_end+2e8ac3c0/3042bc20>
>>esp; effddf40 <_end+2fb75b00/3042bc20>

Trace; c0157571 <dput+31/190>
Trace; c01579ce <prune_dcache+fe/190>
Trace; c0157da4 <shrink_dcache_memory+24/40>
Trace; c013937e <try_to_free_pages_zone+7e/100>
Trace; c0139526 <kswapd_balance_pgdat+66/b0>
Trace; c0139598 <kswapd_balance+28/40>
Trace; c01396d8 <kswapd+98/b9>
Trace; c0105000 <_stext+0/0>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c0139640 <kswapd+0/b9>

Code;  c015a980 <iput+310/320>
00000000 <_EIP>:
Code;  c015a980 <iput+310/320>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c015a982 <iput+312/320>
    2:   b4 04                     mov    $0x4,%ah
Code;  c015a984 <iput+314/320>
    4:   72 bd                     jb     ffffffc3 <_EIP+0xffffffc3>
Code;  c015a986 <iput+316/320>
    6:   34 c0                     xor    $0xc0,%al
Code;  c015a988 <iput+318/320>
    8:   e9 0a fd ff ff            jmp    fffffd17 <_EIP+0xfffffd17>
Code;  c015a98d <iput+31d/320>
    d:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c015a990 <force_delete+0/20>
   10:   8b 54 24 04               mov    0x4(%esp),%edx


7 warnings issued.  Results may not be reliable.

b)

ksymoops 2.4.11 on i686 2.4.30.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.30/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): libafs-2.4.30.mp symbol sys_chdir not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_exit not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_ioctl not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_open not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_wait4 not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_write not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
May  5 04:49:12 system kernel:  kernel BUG at inode.c:1204!
May  5 04:49:12 system kernel: invalid operand: 0000
May  5 04:49:12 system kernel: CPU:    0
May  5 04:49:12 system kernel: EIP:    0010:[<c015a980>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
May  5 04:49:12 system kernel: EFLAGS: 00010246
May  5 04:49:12 system kernel: eax: 00000000   ebx: c671d940   ecx: c671d950   edx: c671d950
May  5 04:49:12 system kernel: esi: eed14800   edi: 00000000   ebp: 0000000a   esp: e4489c1c
May  5 04:49:12 system kernel: ds: 0018   es: 0018   ss: 0018
May  5 04:49:12 system kernel: Process rsync (pid: 16673, stackpage=e4489000)
May  5 04:49:12 system kernel: Stack: 00000000 c0157571 daaf01c0 c6c7c4d8 c6c7c4c0 c671d940 c01579ce c671d940
May  5 04:49:12 system kernel:        c70acda0 ceb3d4c0 ceb3d4d0 ceb3d4c0 f0ac39a4 c0157d74 0000000e ceb3d4c0
May  5 04:49:12 system kernel:        c0157763 ceb3d4c0 f0ac3870 f0ac3880 f09be0ab ceb3d4c0 f0a6f3e0 00000000
May  5 04:49:12 system kernel: Call Trace:    [<c0157571>] [<c01579ce>] [<c0157d74>] [<c0157763>] [<f09be0ab>]
May  5 04:49:12 system kernel:   [<f09c1b47>] [<f09c423b>] [<f09a67d0>] [<f0a16380>] [<f09f555e>] [<f0a16900>]
May  5 04:49:12 system kernel:   [<f09f7f19>] [<c014e2ed>] [<c014ea20>] [<c0140d5e>] [<c0141163>] [<c0108ebb>]
May  5 04:49:12 system kernel: Code: 0f 0b b4 04 72 bd 34 c0 e9 0a fd ff ff 8d 76 00 8b 54 24 04


>>EIP; c015a980 <iput+310/320>   <=====

>>ebx; c671d940 <_end+62b5500/3042bc20>
>>ecx; c671d950 <_end+62b5510/3042bc20>
>>edx; c671d950 <_end+62b5510/3042bc20>
>>esi; eed14800 <_end+2e8ac3c0/3042bc20>
>>esp; e4489c1c <_end+240217dc/3042bc20>

Trace; c0157571 <dput+31/190>
Trace; c01579ce <prune_dcache+fe/190>
Trace; c0157d74 <shrink_dcache_parent+24/30>
Trace; c0157763 <d_invalidate+93/b0>
Trace; f09be0ab <[libafs-2.4.30.mp]afs_linux_lookup+3b/1b0>
Trace; f09c1b47 <[libafs-2.4.30.mp]afs_syscall+c7/450>
Trace; f09c423b <[libafs-2.4.30.mp]afs_icl_AppendRecord+72b/a70>
Trace; f09a67d0 <[libafs-2.4.30.mp]rxi_ReceiveAckPacket+440/c50>
Trace; f0a16380 <END_OF_CODE+224d1/????>
Trace; f09f555e <.data.end+16af/????>
Trace; f0a16900 <END_OF_CODE+22a51/????>
Trace; f09f7f19 <.data.end+406a/????>
Trace; c014e2ed <vfs_create+10d/1e0>
Trace; c014ea20 <open_namei+660/6c0>
Trace; c0140d5e <filp_open+3e/70>
Trace; c0141163 <sys_open+53/c0>
Trace; c0108ebb <system_call+33/38>

Code;  c015a980 <iput+310/320>
00000000 <_EIP>:
Code;  c015a980 <iput+310/320>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c015a982 <iput+312/320>
    2:   b4 04                     mov    $0x4,%ah
Code;  c015a984 <iput+314/320>
    4:   72 bd                     jb     ffffffc3 <_EIP+0xffffffc3>
Code;  c015a986 <iput+316/320>
    6:   34 c0                     xor    $0xc0,%al
Code;  c015a988 <iput+318/320>
    8:   e9 0a fd ff ff            jmp    fffffd17 <_EIP+0xfffffd17>
Code;  c015a98d <iput+31d/320>
    d:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c015a990 <force_delete+0/20>
   10:   8b 54 24 04               mov    0x4(%esp),%edx


7 warnings issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
      problem (if possible)

None

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Linux system 2.4.30 #1 SMP Wed May 4 15:10:58 EEST 2005 i686 unknown unknown GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
util-linux             2.12p
mount                  2.12p
modutils               2.4.27
e2fsprogs              1.35
jfsutils               1.1.6
xfsprogs               2.6.13
quota-tools            3.12.
PPP                    2.4.2
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Linux C++ Library      5.0.6
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         smbfs libafs-2.4.30.mp loop

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 601.369
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1199.30

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 601.369
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1202.58

[7.3.] Module information (from /proc/modules):

smbfs                  44720  13 (autoclean)
libafs-2.4.30.mp      536000   2
loop                   48176  39

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000cc000-000d13ff : Extension ROM
000f0000-000fffff : System ROM
00100000-2fffcfff : System RAM
   00100000-00339bd1 : Kernel code
   00339bd2-003c4c3f : Kernel data
2fffd000-2fffefff : ACPI Tables
2ffff000-2fffffff : ACPI Non-volatile Storage
df000000-dfffffff : NVidia / SGS Thomson (Joint Venture) Riva128
e0000000-e001ffff : PCI device 8086:1076 (Intel Corp.)
   e0000000-e001ffff : e1000
e0800000-e081ffff : PCI device 8086:1076 (Intel Corp.)
   e0800000-e081ffff : e1000
e1000000-e1000fff : Adaptec AHA-2940U2/U2W / 7890/7891
   e1000000-e1000fff : aic7xxx
e2000000-e2ffffff : NVidia / SGS Thomson (Joint Venture) Riva128
e4000000-e7ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
 	Latency: 64
 	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
 	Capabilities: [a0] AGP version 1.0
 		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
 		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64
 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
 	I/O behind bridge: 0000e000-0000dfff
 	Memory behind bridge: e1c00000-e1bfffff
 	Prefetchable memory behind bridge: e4000000-e3ffffff
 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0

00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 	Region 4: I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 	Interrupt: pin D routed to IRQ 19
 	Region 4: I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin ? routed to IRQ 9

00:06.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891
 	Subsystem: Adaptec 2940U2W SCSI Controller
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (9750ns min, 6250ns max)
 	Interrupt: pin A routed to IRQ 19
 	BIST result: 00
 	Region 0: I/O ports at d000 [disabled] [size=256]
 	Region 1: Memory at e1000000 (64-bit, non-prefetchable) [size=4K]
 	Expansion ROM at <unassigned> [disabled] [size=128K]
 	Capabilities: [dc] Power Management version 1
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller
 	Subsystem: Intel Corp. PRO/1000 MT Desktop Adapter
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (63750ns min), cache line size 08
 	Interrupt: pin A routed to IRQ 18
 	Region 0: Memory at e0800000 (32-bit, non-prefetchable) [size=128K]
 	Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=128K]
 	Region 2: I/O ports at b800 [size=64]
 	Expansion ROM at <unassigned> [disabled] [size=128K]
 	Capabilities: [dc] Power Management version 2
 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
 	Capabilities: [e4] PCI-X non-bridge device.
 		Command: DPERE- ERO+ RBC=0 OST=0
 		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
 		Address: 0000000000000000  Data: 0000

00:0c.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture) Riva128 (rev 10) (prog-if 00 [VGA])
 	Subsystem: Diamond Multimedia Systems Viper V330
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (750ns min, 250ns max)
 	Interrupt: pin A routed to IRQ 16
 	Region 0: Memory at df000000 (32-bit, non-prefetchable) [size=16M]
 	Region 1: Memory at e2000000 (32-bit, prefetchable) [size=16M]
 	Expansion ROM at e1c00000 [disabled] [size=4M]

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 01 Lun: 00
   Vendor: QUANTUM  Model: VIKING II 9.1WLS Rev: 5520
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
   Vendor: IBM      Model: DNES-309170W     Rev: SA30
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
   Vendor: QUANTUM  Model: VIKING II 9.1WLS Rev: 5520
   Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

None


 	In about 10 hours I will know if the system freeze will occur 
again in the first 24 hours after the last reboot.
 	I would say that it just doesnt want the openafs server to go away 
while writing in one of its volumes. I have been seeing similar behaviour 
since 2.4.20 with openafs 1.3.x , but on a system too old an unstable on 
its own to rely on it for a report.

 	If you reply pls CC me.

 	Best regards, 
--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
=============================================================================
