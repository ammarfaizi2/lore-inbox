Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbSJATri>; Tue, 1 Oct 2002 15:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262242AbSJATri>; Tue, 1 Oct 2002 15:47:38 -0400
Received: from the-penguin.otak.com ([216.122.56.136]:2454 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S262239AbSJATre>; Tue, 1 Oct 2002 15:47:34 -0400
Date: Tue, 1 Oct 2002 12:53:13 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Oops iee1394 video1394 rmap
Message-ID: <20021001195313.GA28769@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.5.39 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a oops playing with a firewire camera.
I don't think a full report is nessesary, but please spank 
me if not. :) And I will get it out ASAP.

All the iee1394 stuff was built as modules.


ksymoops 2.4.6 on i686 2.5.39.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.39/ (default)
     -m /boot/System.map-2.5.39 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
kernel BUG at rmap.c:280!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c01365a4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210246
eax: 01000000   ebx: c12327d8   ecx: 0e0ff027   edx: c12327d8
esi: 00000000   edi: 00000000   ebp: 0003c000   esp: cd823ec4
ds: 0068   es: 0068   ss: 0068
Stack: c12327d8 c646b57c 00000000 0003c000 f2ca5d40 00000000 c646b57c c12327d8 
       c01259fa 4015f000 4019b000 cc17b400 c031f024 c0125a83 c031f024 cc17b400 
       4015f000 0003c000 4015f000 cc17b400 4019b000 c031f024 c0125ade c031f024 
Call Trace: [<f2ca5d40>] [<c01259fa>] [<c0125a83>] [<c0125ade>] [<c0127db5>] [<c012802d>] [<c0128087>] [<c01088db>]
Code: 0f 0b 18 01 0e c5 26 c0 8d 74 26 00 8b 6c 24 1c 8b 45 00 a9 


>>EIP; c01365a4 <page_remove_rmap+54/150>   <=====

>>ebx; c12327d8 <_end+ec50a4/3053492c>
>>edx; c12327d8 <_end+ec50a4/3053492c>
>>esp; cd823ec4 <_end+d4b6790/3053492c>

Trace; f2ca5d40 <[video1394]__module_license+79c/ba5>
Trace; c01259fa <zap_pte_range+13a/190>
Trace; c0125a83 <zap_pmd_range+33/50>
Trace; c0125ade <unmap_page_range+3e/60>
Trace; c0127db5 <unmap_region+55/d0>
Trace; c012802d <do_munmap+cd/f0>
Trace; c0128087 <sys_munmap+37/60>
Trace; c01088db <syscall_call+7/b>

Code;  c01365a4 <page_remove_rmap+54/150>
00000000 <_EIP>:
Code;  c01365a4 <page_remove_rmap+54/150>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01365a6 <page_remove_rmap+56/150>
   2:   18 01                     sbb    %al,(%ecx)
Code;  c01365a8 <page_remove_rmap+58/150>
   4:   0e                        push   %cs
Code;  c01365a9 <page_remove_rmap+59/150>
   5:   c5 26                     lds    (%esi),%esp
Code;  c01365ab <page_remove_rmap+5b/150>
   7:   c0 8d 74 26 00 8b 6c      rorb   $0x6c,0x8b002674(%ebp)
Code;  c01365b2 <page_remove_rmap+62/150>
   e:   24 1c                     and    $0x1c,%al
Code;  c01365b4 <page_remove_rmap+64/150>
  10:   8b 45 00                  mov    0x0(%ebp),%eax
Code;  c01365b7 <page_remove_rmap+67/150>
  13:   a9 00 00 00 00            test   $0x0,%eax

kernel BUG at rmap.c:280!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c01365a4>]    Not tainted
EFLAGS: 00210246
eax: 01000000   ebx: c10e5e98   ecx: 05bf7027   edx: c10e5e98
esi: 00000000   edi: 00000000   ebp: 0003c000   esp: d0fd5ec4
ds: 0068   es: 0068   ss: 0068
Stack: c10e5e98 c248e57c 00000000 0003c000 f2ca5d40 00000000 c248e57c c10e5e98 
       c01259fa 4015f000 4019b000 d09ec400 c031f024 c0125a83 c031f024 d09ec400 
       4015f000 0003c000 4015f000 d09ec400 4019b000 c031f024 c0125ade c031f024 
Call Trace: [<f2ca5d40>] [<c01259fa>] [<c0125a83>] [<c0125ade>] [<c0127db5>] [<c012802d>] [<c0128087>] [<c01088db>]
Code: 0f 0b 18 01 0e c5 26 c0 8d 74 26 00 8b 6c 24 1c 8b 45 00 a9 


>>EIP; c01365a4 <page_remove_rmap+54/150>   <=====

>>ebx; c10e5e98 <_end+d78764/3053492c>
>>edx; c10e5e98 <_end+d78764/3053492c>
>>esp; d0fd5ec4 <_end+10c68790/3053492c>

Trace; f2ca5d40 <[video1394]__module_license+79c/ba5>
Trace; c01259fa <zap_pte_range+13a/190>
Trace; c0125a83 <zap_pmd_range+33/50>
Trace; c0125ade <unmap_page_range+3e/60>
Trace; c0127db5 <unmap_region+55/d0>
Trace; c012802d <do_munmap+cd/f0>
Trace; c0128087 <sys_munmap+37/60>
Trace; c01088db <syscall_call+7/b>

Code;  c01365a4 <page_remove_rmap+54/150>
00000000 <_EIP>:
Code;  c01365a4 <page_remove_rmap+54/150>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01365a6 <page_remove_rmap+56/150>
   2:   18 01                     sbb    %al,(%ecx)
Code;  c01365a8 <page_remove_rmap+58/150>
   4:   0e                        push   %cs
Code;  c01365a9 <page_remove_rmap+59/150>
   5:   c5 26                     lds    (%esi),%esp
Code;  c01365ab <page_remove_rmap+5b/150>
   7:   c0 8d 74 26 00 8b 6c      rorb   $0x6c,0x8b002674(%ebp)
Code;  c01365b2 <page_remove_rmap+62/150>
   e:   24 1c                     and    $0x1c,%al
Code;  c01365b4 <page_remove_rmap+64/150>
  10:   8b 45 00                  mov    0x0(%ebp),%eax
Code;  c01365b7 <page_remove_rmap+67/150>
  13:   a9 00 00 00 00            test   $0x0,%eax

kernel BUG at rmap.c:280!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c01365a4>]    Not tainted
EFLAGS: 00210246
eax: 01000000   ebx: c10e65f0   ecx: 05c26027   edx: c10e65f0
esi: 00000000   edi: 00000000   ebp: 0003c000   esp: e87bfec4
ds: 0068   es: 0068   ss: 0068
Stack: c10e65f0 dabba57c 00000000 0003c000 f2ca5d40 00000000 dabba57c c10e65f0 
       c01259fa 4015f000 4019b000 d77a8400 c031f024 c0125a83 c031f024 d77a8400 
       4015f000 0003c000 4015f000 d77a8400 4019b000 c031f024 c0125ade c031f024 
Call Trace: [<f2ca5d40>] [<c01259fa>] [<c0125a83>] [<c0125ade>] [<c0127db5>] [<c012802d>] [<c0128087>] [<c01088db>]
Code: 0f 0b 18 01 0e c5 26 c0 8d 74 26 00 8b 6c 24 1c 8b 45 00 a9 


>>EIP; c01365a4 <page_remove_rmap+54/150>   <=====

>>ebx; c10e65f0 <_end+d78ebc/3053492c>
>>edx; c10e65f0 <_end+d78ebc/3053492c>
>>esp; e87bfec4 <_end+28452790/3053492c>

Trace; f2ca5d40 <[video1394]__module_license+79c/ba5>
Trace; c01259fa <zap_pte_range+13a/190>
Trace; c0125a83 <zap_pmd_range+33/50>
Trace; c0125ade <unmap_page_range+3e/60>
Trace; c0127db5 <unmap_region+55/d0>
Trace; c012802d <do_munmap+cd/f0>
Trace; c0128087 <sys_munmap+37/60>
Trace; c01088db <syscall_call+7/b>

Code;  c01365a4 <page_remove_rmap+54/150>
00000000 <_EIP>:
Code;  c01365a4 <page_remove_rmap+54/150>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01365a6 <page_remove_rmap+56/150>
   2:   18 01                     sbb    %al,(%ecx)
Code;  c01365a8 <page_remove_rmap+58/150>
   4:   0e                        push   %cs
Code;  c01365a9 <page_remove_rmap+59/150>
   5:   c5 26                     lds    (%esi),%esp
Code;  c01365ab <page_remove_rmap+5b/150>
   7:   c0 8d 74 26 00 8b 6c      rorb   $0x6c,0x8b002674(%ebp)
Code;  c01365b2 <page_remove_rmap+62/150>
   e:   24 1c                     and    $0x1c,%al
Code;  c01365b4 <page_remove_rmap+64/150>
  10:   8b 45 00                  mov    0x0(%ebp),%eax
Code;  c01365b7 <page_remove_rmap+67/150>
  13:   a9 00 00 00 00            test   $0x0,%eax


1 warning issued.  Results may not be reliable.

-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


