Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132163AbRCYTlZ>; Sun, 25 Mar 2001 14:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132165AbRCYTlQ>; Sun, 25 Mar 2001 14:41:16 -0500
Received: from ma-northadams1-47.nad.adelphia.net ([24.51.236.47]:58116 "EHLO
	sparrow.net") by vger.kernel.org with ESMTP id <S132163AbRCYTlH>;
	Sun, 25 Mar 2001 14:41:07 -0500
Date: Sun, 25 Mar 2001 14:40:25 -0500
From: Eric Buddington <eric@sparrow.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.2-23 in pipe_write
Message-ID: <20010325144025.E162@sparrow.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These oopsen were invoked by a normal shell script. Hope you can make
some use of it. Processor is a K6/2.

-Eric

--------------

ksymoops 2.4.1 on i586 2.4.2-ac23.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-ac23/ (default)
     -m /boot/System.map-2.4.2-ac23-k6 (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000014
c013880e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013880e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c034c440   ecx: c2efd460   edx: c034c440
esi: c2efd400   edi: 00000000   ebp: 00000015   esp: c7489f7c
ds: 0018   es: 0018   ss: 0018
Process sed (pid: 5898, stackpage=c7489000)
Stack: c034c440 ffffffea 00000000 00000015 c2efd460 fffffe00 00000000 400f7000 
       c012fd5a c034c440 400f7000 00000015 c034c460 c7488000 00000015 400f7000 
       bffffba4 c0108d33 00000001 400f7000 00000015 00000015 400f7000 bffffba4 
Call Trace: [<c012fd5a>] [<c0108d33>] 
Code: 83 7f 14 00 0f 84 08 02 00 00 c7 44 24 1c 01 00 00 00 81 fd 

>>EIP; c013880e <pipe_write+6e/2b8>   <=====
Trace; c012fd5a <sys_write+8e/c4>
Trace; c0108d33 <system_call+33/40>
Code;  c013880e <pipe_write+6e/2b8>
00000000 <_EIP>:
Code;  c013880e <pipe_write+6e/2b8>   <=====
   0:   83 7f 14 00               cmpl   $0x0,0x14(%edi)   <=====
Code;  c0138812 <pipe_write+72/2b8>
   4:   0f 84 08 02 00 00         je     212 <_EIP+0x212> c0138a20 <pipe_write+280/2b8>
Code;  c0138818 <pipe_write+78/2b8>
   a:   c7 44 24 1c 01 00 00      movl   $0x1,0x1c(%esp,1)
Code;  c013881f <pipe_write+7f/2b8>
  11:   00 
Code;  c0138820 <pipe_write+80/2b8>
  12:   81 fd 00 00 00 00         cmp    $0x0,%ebp

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000014
c013880e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013880e>]
EFLAGS: 00010246
eax: 00000000   ebx: c3621120   ecx: c36aa2c0   edx: c3621120
esi: c36aa260   edi: 00000000   ebp: 00000015   esp: c0e69f7c
ds: 0018   es: 0018   ss: 0018
Process sed (pid: 5945, stackpage=c0e69000)
Stack: c3621120 ffffffea 00000000 00000015 c36aa2c0 fffffe00 00000000 400f7000 
       c012fd5a c3621120 400f7000 00000015 c3621140 c0e68000 00000015 400f7000 
       bffffba4 c0108d33 00000001 400f7000 00000015 00000015 400f7000 bffffba4 
Call Trace: [<c012fd5a>] [<c0108d33>] 
Code: 83 7f 14 00 0f 84 08 02 00 00 c7 44 24 1c 01 00 00 00 81 fd 

>>EIP; c013880e <pipe_write+6e/2b8>   <=====
Trace; c012fd5a <sys_write+8e/c4>
Trace; c0108d33 <system_call+33/40>
Code;  c013880e <pipe_write+6e/2b8>
00000000 <_EIP>:
Code;  c013880e <pipe_write+6e/2b8>   <=====
   0:   83 7f 14 00               cmpl   $0x0,0x14(%edi)   <=====
Code;  c0138812 <pipe_write+72/2b8>
   4:   0f 84 08 02 00 00         je     212 <_EIP+0x212> c0138a20 <pipe_write+280/2b8>
Code;  c0138818 <pipe_write+78/2b8>
   a:   c7 44 24 1c 01 00 00      movl   $0x1,0x1c(%esp,1)
Code;  c013881f <pipe_write+7f/2b8>
  11:   00 
Code;  c0138820 <pipe_write+80/2b8>
  12:   81 fd 00 00 00 00         cmp    $0x0,%ebp


1 warning issued.  Results may not be reliable.

