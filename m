Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTEVSw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTEVSw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:52:26 -0400
Received: from freeside.toyota.com ([63.87.74.7]:20714 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP id S263129AbTEVSwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:52:23 -0400
Message-ID: <3ECD1F75.2050609@tmsusa.com>
Date: Thu, 22 May 2003 12:05:25 -0700
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.69-mm8 improvements and one oops
References: <3ECD13A1.9060103@tmsusa.com> <20030522183526.GC30353@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>You didn't run this through ksymoops.
>
Sorry, how lame of me - no brain left after finals

Here is the decoded oops:

ksymoops 2.4.5 on i686 2.5.69-mm8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.69-mm8/ (default)
     -m /boot/System.map-2.5.69-mm8 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod


kernel BUG at kernel/sched.c:614!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c011d762>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000008   ebx: 00000000   ecx: d65d4e40   edx: d563c000
esi: d8fa0120   edi: d953a31c   ebp: d563dfb8   esp: d563df9c
ds: 007b   es: 007b   ss: 0068
Stack: 43297d43 7d43297d 297d4329 43297d43 7d43297d d8fa0120 d65d54c0 
d564ffbc
       c010a362 d8fa0120 01200011 00000000 00000000 00000000 40018da8 
bfffe148
       00000000 0000007b 0000007b 00000078 ffffe410 00000073 00000202 
bfffe0ec
 [<c010a362>] ret_from_fork+0x6/0x14
Code: 85 d2 74 16 89 d6 83 c6 04 19 c9 39 70 18 83 d9 00 85 c9 75 05 8b 
43 7c 89
 02 83 c4 14 5b 5e 5d c3 89 34 24 e8 a0 35 00 00 eb c6 <0f> 0b 66 02 ad 
7d 3e c0
 eb b2 8d 74 26 00 89 d8 e8 f9 66 00 00

 >>EIP; c011d762 <schedule_tail+e2/140>   <=====

 >>ecx; d65d4e40 <__crc_unregister_filesystem+187c64/32bd9c>
 >>edx; d563c000 <__crc_proc_dointvec_minmax+15d80d/308f7b>
 >>esi; d8fa0120 <__crc_raise_softirq+150704/241947>
 >>edi; d953a31c <__crc_acpi_os_read_pci_configuration+78bac/110b35>
 >>ebp; d563dfb8 <__crc_proc_dointvec_minmax+15f7c5/308f7b>
 >>esp; d563df9c <__crc_proc_dointvec_minmax+15f7a9/308f7b>

Code;  c011d737 <schedule_tail+b7/140>
00000000 <_EIP>:
Code;  c011d737 <schedule_tail+b7/140>
   0:   85 d2                     test   %edx,%edx
Code;  c011d739 <schedule_tail+b9/140>
   2:   74 16                     je     1a <_EIP+0x1a>
Code;  c011d73b <schedule_tail+bb/140>
   4:   89 d6                     mov    %edx,%esi
Code;  c011d73d <schedule_tail+bd/140>
   6:   83 c6 04                  add    $0x4,%esi
Code;  c011d740 <schedule_tail+c0/140>
   9:   19 c9                     sbb    %ecx,%ecx
Code;  c011d742 <schedule_tail+c2/140>
   b:   39 70 18                  cmp    %esi,0x18(%eax)
Code;  c011d745 <schedule_tail+c5/140>
   e:   83 d9 00                  sbb    $0x0,%ecx
Code;  c011d748 <schedule_tail+c8/140>
  11:   85 c9                     test   %ecx,%ecx
Code;  c011d74a <schedule_tail+ca/140>
  13:   75 05                     jne    1a <_EIP+0x1a>
Code;  c011d74c <schedule_tail+cc/140>
  15:   8b 43 7c                  mov    0x7c(%ebx),%eax
Code;  c011d74f <schedule_tail+cf/140>
  18:   89 02                     mov    %eax,(%edx)
Code;  c011d751 <schedule_tail+d1/140>
  1a:   83 c4 14                  add    $0x14,%esp
Code;  c011d754 <schedule_tail+d4/140>
  1d:   5b                        pop    %ebx
Code;  c011d755 <schedule_tail+d5/140>
  1e:   5e                        pop    %esi
Code;  c011d756 <schedule_tail+d6/140>
  1f:   5d                        pop    %ebp
Code;  c011d757 <schedule_tail+d7/140>
  20:   c3                        ret   
Code;  c011d758 <schedule_tail+d8/140>
  21:   89 34 24                  mov    %esi,(%esp,1)
Code;  c011d75b <schedule_tail+db/140>
  24:   e8 a0 35 00 00            call   35c9 <_EIP+0x35c9>
Code;  c011d760 <schedule_tail+e0/140>
  29:   eb c6                     jmp    fffffff1 <_EIP+0xfffffff1>
Code;  c011d762 <schedule_tail+e2/140>   <=====
  2b:   0f 0b                     ud2a      <=====
Code;  c011d764 <schedule_tail+e4/140>
  2d:   66                        data16
Code;  c011d765 <schedule_tail+e5/140>
  2e:   02 ad 7d 3e c0 eb         add    0xebc03e7d(%ebp),%ch
Code;  c011d76b <schedule_tail+eb/140>
  34:   b2 8d                     mov    $0x8d,%dl
Code;  c011d76d <schedule_tail+ed/140>
  36:   74 26                     je     5e <_EIP+0x5e>
Code;  c011d76f <schedule_tail+ef/140>
  38:   00 89 d8 e8 f9 66         add    %cl,0x66f9e8d8(%ecx)


1 warning and 1 error issued.  Results may not be reliable.



