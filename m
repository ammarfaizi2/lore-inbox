Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265047AbSJRH4u>; Fri, 18 Oct 2002 03:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265043AbSJRH4u>; Fri, 18 Oct 2002 03:56:50 -0400
Received: from mail.spylog.com ([194.67.35.220]:62601 "EHLO mail.spylog.com")
	by vger.kernel.org with ESMTP id <S265047AbSJRH4q>;
	Fri, 18 Oct 2002 03:56:46 -0400
Date: Fri, 18 Oct 2002 12:02:40 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: bug in 2.4.19-pre3aa2
Message-ID: <20021018080240.GA31218@an.local>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Kernel 2.4.19-pre3aa3, no SMP, 1 CPU, compiled for HIGHMEM 4Gb.


ksymoops 2.4.7 on i686 2.4.19-pre3aa2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre3aa2/ (default)
     -m /boot/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 01000074
e0132e12
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[discard_bh_page+50/124]    Not tainted
EFLAGS: 00010202
eax: e1121000   ebx: e1121000   ecx: 00000000   edx: 0100004c
esi: 00000000   edi: 0100004c   ebp: 00000000   esp: e2217e68
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 474, stackpage=e2217000)
Stack: e1121000 00000000 00000000 f1cfe6bc e0121a7a e1121000 00000000 00000001 
       e0121a93 e1121000 00000000 e1121000 e0121c16 e1121000 00000000 e2217ed4 
       00000000 f1cfe6bc 00000000 00000001 e2217ed4 00000000 e0121cbb f1cfe60c 
Call Trace: [do_flushpage+38/44] [truncate_complete_page+19/72] [truncate_list_pages+334/432] [truncate_inode_pages+67/108] [iput+178/448] 
Code: 8b 5a 28 0f b7 42 08 8d 34 28 39 6c 24 18 77 09 52 e8 e0 fe 
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 5a 28                  mov    0x28(%edx),%ebx
Code;  00000003 Before first symbol
   3:   0f b7 42 08               movzwl 0x8(%edx),%eax
Code;  00000007 Before first symbol
   7:   8d 34 28                  lea    (%eax,%ebp,1),%esi
Code;  0000000a Before first symbol
   a:   39 6c 24 18               cmp    %ebp,0x18(%esp,1)
Code;  0000000e Before first symbol
   e:   77 09                     ja     19 <_EIP+0x19> 00000019 Before first symbol
Code;  00000010 Before first symbol
  10:   52                        push   %edx
Code;  00000011 Before first symbol
  11:   e8 e0 fe 00 00            call   fef6 <_EIP+0xfef6> 0000fef6 Before first symbol

Unable to handle kernel paging request at virtual address 0ce02b1c
e0132dba
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[try_to_release_page+54/92]    Not tainted
EFLAGS: 00010286
eax: 0ce02b00   ebx: e1121010   ecx: 000001d0   edx: 00000001
esi: 000001d0   edi: 00000007   ebp: 00000000   esp: e1ef7f40
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=e1ef7000)
Stack: e112102c e1121010 e01298b2 e1121010 000001d0 00000020 000001d0 e02ae440 
       e02ae440 e1ef6000 00000c80 00009b79 000001d0 e02ae440 e0129cb7 e1ef7fa8 
       0000003c 00000020 000001d0 e0129d20 e1ef7fa8 e02ae440 00000002 e1ef6000 
Call Trace: [shrink_cache+618/1012] [shrink_caches+47/60] [try_to_free_pages+92/232] [kswapd_balance_pgdat+76/152] [kswapd_balance+18/40] 
Code: 83 78 1c 00 74 12 56 53 8b 40 1c ff d0 83 c4 08 85 c0 75 04 


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   83 78 1c 00               cmpl   $0x0,0x1c(%eax)
Code;  00000004 Before first symbol
   4:   74 12                     je     18 <_EIP+0x18> 00000018 Before first symbol
Code;  00000006 Before first symbol
   6:   56                        push   %esi
Code;  00000007 Before first symbol
   7:   53                        push   %ebx
Code;  00000008 Before first symbol
   8:   8b 40 1c                  mov    0x1c(%eax),%eax
Code;  0000000b Before first symbol
   b:   ff d0                     call   *%eax
Code;  0000000d Before first symbol
   d:   83 c4 08                  add    $0x8,%esp
Code;  00000010 Before first symbol
  10:   85 c0                     test   %eax,%eax
Code;  00000012 Before first symbol
  12:   75 04                     jne    18 <_EIP+0x18> 00000018 Before first symbol

kernel BUG at vmscan.c:408!
invalid operand: 0000
CPU:    0
EIP:    0010:[shrink_cache+161/1012]    Not tainted
EFLAGS: 00010282
eax: 0000001c   ebx: e1121010   ecx: e02ad188   edx: 000ed3df
esi: e1120ff4   edi: 0000001b   ebp: 00000000   esp: e44ade8c
ds: 0018   es: 0018   ss: 0018
Process forwarderng (pid: 940, stackpage=e44ad000)
Stack: e025bed8 00000198 00000020 000001d2 e02ae440 e02ae440 e44ac000 00000c80 
       00009a68 000001d2 e02ae440 e0129cb7 e44adee8 0000003c 00000020 000001d2 
       e0129d20 e44adee8 000001d2 e44ac000 00000000 00000018 e44adee8 00000000 
Call Trace: [shrink_caches+47/60] [try_to_free_pages+92/232] [balance_classzone+99/612] [__alloc_pages+390/652] [generic_file_write+1045/1880] 
Code: 0f 0b 83 c4 08 89 f6 8b 43 fc a8 80 74 19 68 9a 01 00 00 68 


>>ecx; e02ad188 <console_sem+0/14>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   89 f6                     mov    %esi,%esi
Code;  00000007 Before first symbol
   7:   8b 43 fc                  mov    0xfffffffc(%ebx),%eax
Code;  0000000a Before first symbol
   a:   a8 80                     test   $0x80,%al
Code;  0000000c Before first symbol
   c:   74 19                     je     27 <_EIP+0x27> 00000027 Before first symbol
Code;  0000000e Before first symbol
   e:   68 9a 01 00 00            push   $0x19a
Code;  00000013 Before first symbol
  13:   68 00 00 00 00            push   $0x0

kernel BUG at vmscan.c:408!
invalid operand: 0000
CPU:    0
EIP:    0010:[shrink_cache+161/1012]    Not tainted
EFLAGS: 00010282
eax: 0000001c   ebx: e1121010   ecx: e02ad188   edx: 000ed728
esi: e1120ff4   edi: 0000001f   ebp: e02ae440   esp: e3e0fddc
ds: 0018   es: 0018   ss: 0018
Process forwarderng (pid: 847, stackpage=e3e0f000)
Stack: e025bed8 00000198 0000001f 000001d2 e02ae440 e02ae440 e3e0e000 00000c1c 
       00009a6d 000001d2 e02ae440 e0129cb7 e3e0fe38 0000003c 00000020 000001d2 
       e0129d20 e3e0fe38 000001d2 e3e0e000 00000000 00000018 e3e0fe38 00000000 
Call Trace: [shrink_caches+47/60] [try_to_free_pages+92/232] [balance_classzone+99/612] [__alloc_pages+390/652] [read_swap_cache_async+97/168] 
Code: 0f 0b 83 c4 08 89 f6 8b 43 fc a8 80 74 19 68 9a 01 00 00 68 


>>ecx; e02ad188 <console_sem+0/14>
>>ebp; e02ae440 <contig_page_data+1a0/3a0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   89 f6                     mov    %esi,%esi
Code;  00000007 Before first symbol
   7:   8b 43 fc                  mov    0xfffffffc(%ebx),%eax
Code;  0000000a Before first symbol
   a:   a8 80                     test   $0x80,%al
Code;  0000000c Before first symbol
   c:   74 19                     je     27 <_EIP+0x27> 00000027 Before first symbol
Code;  0000000e Before first symbol
   e:   68 9a 01 00 00            push   $0x19a
Code;  00000013 Before first symbol
  13:   68 00 00 00 00            push   $0x0


1 warning and 1 error issued.  Results may not be reliable.



-- 
bye.
Andrey Nekrasov, SpyLOG.
