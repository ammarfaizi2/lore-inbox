Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290392AbSAPIKS>; Wed, 16 Jan 2002 03:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289888AbSAPIKJ>; Wed, 16 Jan 2002 03:10:09 -0500
Received: from p50801AC5.dip.t-dialin.net ([80.128.26.197]:36101 "EHLO
	asok.cccrewhome.de") by vger.kernel.org with ESMTP
	id <S287751AbSAPIJ5>; Wed, 16 Jan 2002 03:09:57 -0500
Mime-Version: 1.0
Message-Id: <p05100300b86ae2bfd25a@[192.168.100.2]>
Date: Wed, 16 Jan 2002 09:09:55 +0100
To: linux-kernel@vger.kernel.org
From: Sebastian Wenleder <Sebastian@wenleder.de>
Subject: 2.4.18-pre3 Oopses
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are a few more oopses from 2.4.18-pre3
I ran memtest86 with no errors.
This machine was stable in early 2.4 stages, but it changed somewhere 
around 2.4.14 or so! I'm afraid I cannot remeber the exact version 
number!

Thanks a lot!

Sebastian

ksymoops 2.4.1 on i686 2.4.18-pre3.

Jan 15 09:20:03 asok kernel: Unable to handle kernel paging request 
at virtual address 7258086c
Jan 15 09:20:03 asok kernel: c013caf6
Jan 15 09:20:03 asok kernel: *pde = 00000000
Jan 15 09:20:03 asok kernel: Oops: 0002
Jan 15 09:20:03 asok kernel: CPU:    0
Jan 15 09:20:03 asok kernel: EIP:    0010:[iput+278/440]    Not tainted
Jan 15 09:20:03 asok kernel: EFLAGS: 00010246
Jan 15 09:20:03 asok kernel: eax: 72580868   ebx: c6ea1440   ecx: 
c6ea16c6   edx: c6ea1448
Jan 15 09:20:03 asok kernel: esi: c7fa0e00   edi: c02b1980   ebp: 
0000038d   esp: c7fb9f4c
Jan 15 09:20:03 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 09:20:03 asok kernel: Process kswapd (pid: 4, stackpage=c7fb9000)
Jan 15 09:20:03 asok kernel: Stack: c222fef8 c222fee0 c6ea1440 
c013ab66 c6ea1440 0000000a 000001d0 00000020
Jan 15 09:20:03 asok kernel:        00000006 c013ae2b 00001273 
c0125050 00000006 000001d0 00000006 000001d0
Jan 15 09:20:03 asok kernel:        c02afb48 00000000 c02afb48 
c012509f 00000020 c02afb48 00000001 c7fb8000
Jan 15 09:20:03 asok kernel: Call Trace: [prune_dcache+214/328] 
[shrink_dcache_memory+27/52] [shrink_caches+104/128] 
[try_to_free_pages+55/88] [kswapd_balance_pgdat+67/140]
Jan 15 09:20:03 asok kernel: Code: 89 48 04 89 01 a1 24 08 2b c0 89 
50 04 89 43 08 c7 42 04 24
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
    3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
    5:   a1 24 08 2b c0            mov    0xc02b0824,%eax
Code;  0000000a Before first symbol
    a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  0000000d Before first symbol
    d:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  00000010 Before first symbol
   10:   c7 42 04 24 00 00 00      movl   $0x24,0x4(%edx)

Jan 15 11:45:01 asok kernel: Unable to handle kernel paging request 
at virtual address 30c6e81c
Jan 15 11:45:01 asok kernel: c013c433
Jan 15 11:45:01 asok kernel: *pde = 00000000
Jan 15 11:45:01 asok kernel: Oops: 0000
Jan 15 11:45:01 asok kernel: CPU:    0
Jan 15 11:45:01 asok kernel: EIP:    0010:[prune_icache+43/204]    Not tainted
Jan 15 11:45:01 asok kernel: EFLAGS: 00010203
Jan 15 11:45:01 asok kernel: eax: 00000001   ebx: 30c6e818   ecx: 
00000001   edx: c6e81621
Jan 15 11:45:01 asok kernel: esi: c6e81621   edi: 30c6e818   ebp: 
c5867e38   esp: c5867e20
Jan 15 11:45:01 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 11:45:01 asok kernel: Process grep (pid: 29267, stackpage=c5867000)
Jan 15 11:45:01 asok kernel: Stack: 00000013 000001d2 00000020 
00000000 c5867e30 c5867e30 00000006 c013c4ef
Jan 15 11:45:01 asok kernel:        00000d42 c0125057 00000006 
000001d2 00000006 000001d2 00000006 000001d2
Jan 15 11:45:01 asok kernel:        c02afb48 c02afb48 c02afb48 
c012509f 00000020 c5866000 00000000 000001d2
Jan 15 11:45:01 asok kernel: Call Trace: [shrink_icache_memory+27/48] 
[shrink_caches+111/128] [try_to_free_pages+55/88] 
[balance_classzone+103/564] [__alloc_pages+262/356]
Jan 15 11:45:01 asok kernel: Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 
00 a8 38 75 e6 0b 86 c8 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 7f 04                  mov    0x4(%edi),%edi
Code;  00000003 Before first symbol
    3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  00000006 Before first symbol
    6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  0000000c Before first symbol
    c:   a8 38                     test   $0x38,%al
Code;  0000000e Before first symbol
    e:   75 e6                     jne    fffffff6 <_EIP+0xfffffff6> 
fffffff6 <END_OF_CODE+3fcd1ada/????>
Code;  00000010 Before first symbol
   10:   0b 86 c8 00 00 00         or     0xc8(%esi),%eax

Jan 15 13:50:00 asok kernel: Unable to handle kernel paging request 
at virtual address 30c6e81c
Jan 15 13:50:00 asok kernel: c013c433
Jan 15 13:50:00 asok kernel: *pde = 00000000
Jan 15 13:50:00 asok kernel: Oops: 0000
Jan 15 13:50:00 asok kernel: CPU:    0
Jan 15 13:50:00 asok kernel: EIP:    0010:[prune_icache+43/204]    Not tainted
Jan 15 13:50:00 asok kernel: EFLAGS: 00010203
Jan 15 13:50:00 asok kernel: eax: 00000001   ebx: 30c6e818   ecx: 
00000001   edx: c6e81621
Jan 15 13:50:00 asok kernel: esi: c6e81621   edi: 30c6e818   ebp: 
c53ebea0   esp: c53ebe88
Jan 15 13:50:00 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 13:50:00 asok kernel: Process denyip (pid: 30712, stackpage=c53eb000)
Jan 15 13:50:00 asok kernel: Stack: 00000019 000001d0 00000020 
000005f8 c4477628 c353cc08 00000006 c013c4ef
Jan 15 13:50:00 asok kernel:        00000801 c0125057 00000006 
000001d0 00000006 000001d0 00000006 000001d0
Jan 15 13:50:00 asok kernel:        c02afb48 c02afb48 c02afb48 
c012509f 00000020 c53ea000 00000000 000001d0
Jan 15 13:50:00 asok kernel: Call Trace: [shrink_icache_memory+27/48] 
[shrink_caches+111/128] [try_to_free_pages+55/88] 
[balance_classzone+103/564] [__alloc_pages+262/356]
Jan 15 13:50:00 asok kernel: Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 
00 a8 38 75 e6 0b 86 c8 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 7f 04                  mov    0x4(%edi),%edi
Code;  00000003 Before first symbol
    3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  00000006 Before first symbol
    6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  0000000c Before first symbol
    c:   a8 38                     test   $0x38,%al
Code;  0000000e Before first symbol
    e:   75 e6                     jne    fffffff6 <_EIP+0xfffffff6> 
fffffff6 <END_OF_CODE+3fcd1ada/????>
Code;  00000010 Before first symbol
   10:   0b 86 c8 00 00 00         or     0xc8(%esi),%eax

Jan 15 13:50:00 asok kernel:  <1>Unable to handle kernel paging 
request at virtual address 30c6e81c
Jan 15 13:50:00 asok kernel: c013c433
Jan 15 13:50:00 asok kernel: *pde = 00000000
Jan 15 13:50:00 asok kernel: Oops: 0000
Jan 15 13:50:00 asok kernel: CPU:    0
Jan 15 13:50:00 asok kernel: EIP:    0010:[prune_icache+43/204]    Not tainted
Jan 15 13:50:00 asok kernel: EFLAGS: 00010203
Jan 15 13:50:00 asok kernel: eax: 00000001   ebx: 30c6e818   ecx: 
00000001   edx: c6e81621
Jan 15 13:50:00 asok kernel: esi: c6e81621   edi: 30c6e818   ebp: 
c04fde38   esp: c04fde20
Jan 15 13:50:00 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 13:50:00 asok kernel: Process denyip (pid: 30720, stackpage=c04fd000)
Jan 15 13:50:00 asok kernel: Stack: 00000020 000001d2 00000020 
00000000 c04fde30 c04fde30 00000006 c013c4ef
Jan 15 13:50:00 asok kernel:        00000e95 c0125057 00000006 
000001d2 00000006 000001d2 00000006 000001d2
Jan 15 13:50:00 asok kernel:        c02afb48 c02afb48 c02afb48 
c012509f 00000020 c04fc000 00000000 000001d2
Jan 15 13:50:00 asok kernel: Call Trace: [shrink_icache_memory+27/48] 
[shrink_caches+111/128] [try_to_free_pages+55/88] 
[balance_classzone+103/564] [__alloc_pages+262/356]
Jan 15 13:50:00 asok kernel: Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 
00 a8 38 75 e6 0b 86 c8 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 7f 04                  mov    0x4(%edi),%edi
Code;  00000003 Before first symbol
    3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  00000006 Before first symbol
    6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  0000000c Before first symbol
    c:   a8 38                     test   $0x38,%al
Code;  0000000e Before first symbol
    e:   75 e6                     jne    fffffff6 <_EIP+0xfffffff6> 
fffffff6 <END_OF_CODE+3fcd1ada/????>
Code;  00000010 Before first symbol
   10:   0b 86 c8 00 00 00         or     0xc8(%esi),%eax

Jan 15 13:50:00 asok kernel:  <1>Unable to handle kernel paging 
request at virtual address 30c6e81c
Jan 15 13:50:00 asok kernel: c013c433
Jan 15 13:50:00 asok kernel: *pde = 00000000
Jan 15 13:50:00 asok kernel: Oops: 0000
Jan 15 13:50:00 asok kernel: CPU:    0
Jan 15 13:50:00 asok kernel: EIP:    0010:[prune_icache+43/204]    Not tainted
Jan 15 13:50:00 asok kernel: EFLAGS: 00010203
Jan 15 13:50:00 asok kernel: eax: 00000001   ebx: 30c6e818   ecx: 
00000001   edx: c6e81621
Jan 15 13:50:00 asok kernel: esi: c6e81621   edi: 30c6e818   ebp: 
c55f7e38   esp: c55f7e20
Jan 15 13:50:00 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 13:50:00 asok kernel: Process denyip (pid: 30719, stackpage=c55f7000)
Jan 15 13:50:00 asok kernel: Stack: 00000020 000001d2 00000020 
00000000 c55f7e30 c55f7e30 00000006 c013c4ef
Jan 15 13:50:00 asok kernel:        00000f18 c0125057 00000006 
000001d2 00000006 000001d2 00000006 000001d2
Jan 15 13:50:00 asok kernel:        c02afb48 c02afb48 c02afb48 
c012509f 00000020 c55f6000 00000000 000001d2
Jan 15 13:50:00 asok kernel: Call Trace: [shrink_icache_memory+27/48] 
[shrink_caches+111/128] [try_to_free_pages+55/88] 
[balance_classzone+103/564] [__alloc_pages+262/356]
Jan 15 13:50:00 asok kernel: Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 
00 a8 38 75 e6 0b 86 c8 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 7f 04                  mov    0x4(%edi),%edi
Code;  00000003 Before first symbol
    3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  00000006 Before first symbol
    6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  0000000c Before first symbol
    c:   a8 38                     test   $0x38,%al
Code;  0000000e Before first symbol
    e:   75 e6                     jne    fffffff6 <_EIP+0xfffffff6> 
fffffff6 <END_OF_CODE+3fcd1ada/????>
Code;  00000010 Before first symbol
   10:   0b 86 c8 00 00 00         or     0xc8(%esi),%eax

Jan 15 09:45:00 asok kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000017
Jan 15 09:45:00 asok kernel: c013ab49
Jan 15 09:45:00 asok kernel: *pde = 00000000
Jan 15 09:45:00 asok kernel: Oops: 0000
Jan 15 09:45:00 asok kernel: CPU:    0
Jan 15 09:45:00 asok kernel: EIP:    0010:[prune_dcache+185/328]    Not tainted
Jan 15 09:45:00 asok kernel: EFLAGS: 00010206
Jan 15 09:45:00 asok kernel: eax: 00000003   ebx: c6ee9238   ecx: 
c2a60b90   edx: c2a60b90
Jan 15 09:45:00 asok kernel: esi: c6ee9220   edi: c2a60b80   ebp: 
00000cce   esp: c145fe0c
Jan 15 09:45:00 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 09:45:00 asok kernel: Process sh (pid: 27812, stackpage=c145f000)
Jan 15 09:45:00 asok kernel: Stack: 00000005 000001d2 00000009 
00000005 c013ae2b 00000df7 c0125050 00000005
Jan 15 09:45:00 asok kernel:        000001d2 00000005 000001d2 
c02afb48 c02afb48 c02afb48 c012509f 00000009
Jan 15 09:45:00 asok kernel:        c145e000 00000000 000001d2 
c0125a6f c02afcc4 00000100 00000010 00000000
Jan 15 09:45:00 asok kernel: Call Trace: [shrink_dcache_memory+27/52] 
[shrink_caches+104/128] [try_to_free_pages+55/88] 
[balance_classzone+103/564] [__alloc_pages+262/356]
Jan 15 09:45:00 asok kernel: Code: 8b 40 14 85 c0 74 10 57 56 ff d0 
83 c4 08 eb 17 8d b4 26 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 40 14                  mov    0x14(%eax),%eax
Code;  00000003 Before first symbol
    3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
    5:   74 10                     je     17 <_EIP+0x17> 00000017 
Before first symbol
Code;  00000007 Before first symbol
    7:   57                        push   %edi
Code;  00000008 Before first symbol
    8:   56                        push   %esi
Code;  00000009 Before first symbol
    9:   ff d0                     call   *%eax
Code;  0000000b Before first symbol
    b:   83 c4 08                  add    $0x8,%esp
Code;  0000000e Before first symbol
    e:   eb 17                     jmp    27 <_EIP+0x27> 00000027 
Before first symbol
Code;  00000010 Before first symbol
   10:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi

Jan 15 09:45:00 asok kernel:  <1>Unable to handle kernel paging 
request at virtual address 2df6486c
Jan 15 09:45:00 asok kernel: c013caf6
Jan 15 09:45:00 asok kernel: *pde = 00000000
Jan 15 09:45:00 asok kernel: Oops: 0002
Jan 15 09:45:00 asok kernel: CPU:    0
Jan 15 09:45:00 asok kernel: EIP:    0010:[iput+278/440]    Not tainted
Jan 15 09:45:00 asok kernel: EFLAGS: 00010246
Jan 15 09:45:00 asok kernel: eax: 2df64868   ebx: c6e81440   ecx: 
c6e816c0   edx: c6e81448
Jan 15 09:45:00 asok kernel: esi: c7fa0e00   edi: c02b1980   ebp: 
00000aba   esp: c145fe20
Jan 15 09:45:00 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 09:45:00 asok kernel: Process run-crons (pid: 27816, stackpage=c145f000)
Jan 15 09:45:00 asok kernel: Stack: c55c54b8 c55c54a0 c6e81440 
c013ab66 c6e81440 00000020 000001d2 00000020
Jan 15 09:45:00 asok kernel:        00000006 c013ae2b 00000b75 
c0125050 00000006 000001d2 00000006 000001d2
Jan 15 09:45:00 asok kernel:        c02afb48 c02afb48 c02afb48 
c012509f 00000020 c145e000 00000000 000001d2
Jan 15 09:45:00 asok kernel: Call Trace: [prune_dcache+214/328] 
[shrink_dcache_memory+27/52] [shrink_caches+104/128] 
[try_to_free_pages+55/88] [balance_classzone+103/564]
Jan 15 09:45:00 asok kernel: Code: 89 48 04 89 01 a1 24 08 2b c0 89 
50 04 89 43 08 c7 42 04 24

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
    3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
    5:   a1 24 08 2b c0            mov    0xc02b0824,%eax
Code;  0000000a Before first symbol
    a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  0000000d Before first symbol
    d:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  00000010 Before first symbol
   10:   c7 42 04 24 00 00 00      movl   $0x24,0x4(%edx)

Jan 15 09:45:00 asok kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000017
Jan 15 09:45:00 asok kernel: c013ab49
Jan 15 09:45:00 asok kernel: *pde = 00000000
Jan 15 09:45:00 asok kernel: Oops: 0000
Jan 15 09:45:00 asok kernel: CPU:    0
Jan 15 09:45:00 asok kernel: EIP:    0010:[prune_dcache+185/328]    Not tainted
Jan 15 09:45:00 asok kernel: EFLAGS: 00010206
Jan 15 09:45:00 asok kernel: eax: 00000003   ebx: c6dc1238   ecx: 
c2a91490   edx: c2a91490
Jan 15 09:45:00 asok kernel: esi: c6dc1220   edi: c2a91480   ebp: 
000000b8   esp: c052de0c
Jan 15 09:45:00 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 09:45:00 asok kernel: Process xargs (pid: 27817, stackpage=c052d000)
Jan 15 09:45:00 asok kernel: Stack: 0000001c 000001d2 00000020 
00000006 c013ae2b 00000b58 c0125050 00000006
Jan 15 09:45:00 asok kernel:        000001d2 00000006 000001d2 
c02afb48 c02afb48 c02afb48 c012509f 00000020
Jan 15 09:45:00 asok kernel:        c052c000 00000000 000001d2 
c0125a6f c02afcc4 00000100 00000010 00000000
Jan 15 09:45:00 asok kernel: Call Trace: [shrink_dcache_memory+27/52] 
[shrink_caches+104/128] [try_to_free_pages+55/88] 
[balance_classzone+103/564] [__alloc_pages+262/356]
Jan 15 09:45:00 asok kernel: Code: 8b 40 14 85 c0 74 10 57 56 ff d0 
83 c4 08 eb 17 8d b4 26 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 40 14                  mov    0x14(%eax),%eax
Code;  00000003 Before first symbol
    3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
    5:   74 10                     je     17 <_EIP+0x17> 00000017 
Before first symbol
Code;  00000007 Before first symbol
    7:   57                        push   %edi
Code;  00000008 Before first symbol
    8:   56                        push   %esi
Code;  00000009 Before first symbol
    9:   ff d0                     call   *%eax
Code;  0000000b Before first symbol
    b:   83 c4 08                  add    $0x8,%esp
Code;  0000000e Before first symbol
    e:   eb 17                     jmp    27 <_EIP+0x27> 00000027 
Before first symbol
Code;  00000010 Before first symbol
   10:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi

Jan 15 11:00:01 asok kernel: Unable to handle kernel paging request 
at virtual address fdc7c86c
Jan 15 11:00:01 asok kernel: c013caf6
Jan 15 11:00:01 asok kernel: *pde = 00000000
Jan 15 11:00:01 asok kernel: Oops: 0002
Jan 15 11:00:01 asok kernel: CPU:    0
Jan 15 11:00:01 asok kernel: EIP:    0010:[iput+278/440]    Not tainted
Jan 15 11:00:01 asok kernel: EFLAGS: 00010246
Jan 15 11:00:01 asok kernel: eax: fdc7c868   ebx: c6f29440   ecx: 
c6f296c4   edx: c6f29448
Jan 15 11:00:01 asok kernel: esi: c7fa0e00   edi: c02b1980   ebp: 
00000087   esp: c6befdf8
Jan 15 11:00:01 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 11:00:01 asok kernel: Process ps (pid: 28843, stackpage=c6bef000)
Jan 15 11:00:01 asok kernel: Stack: c63ae338 c63ae320 c6f29440 
c013ab66 c6f29440 00000003 000001d2 00000003
Jan 15 11:00:01 asok kernel:        00000005 c013ae2b 0000077c 
c0125050 00000005 000001d2 00000005 000001d2
Jan 15 11:00:01 asok kernel:        c02afb48 c02afb48 c02afb48 
c012509f 00000003 c6bee000 00000000 000001d2
Jan 15 11:00:01 asok kernel: Call Trace: [prune_dcache+214/328] 
[shrink_dcache_memory+27/52] [shrink_caches+104/128] 
[try_to_free_pages+55/88] [balance_classzone+103/564]
Jan 15 11:00:01 asok kernel: Code: 89 48 04 89 01 a1 24 08 2b c0 89 
50 04 89 43 08 c7 42 04 24

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
    3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
    5:   a1 24 08 2b c0            mov    0xc02b0824,%eax
Code;  0000000a Before first symbol
    a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  0000000d Before first symbol
    d:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  00000010 Before first symbol
   10:   c7 42 04 24 00 00 00      movl   $0x24,0x4(%edx)

Jan 15 11:05:00 asok kernel:  <1>Unable to handle kernel paging 
request at virtual address f294486c
Jan 15 11:05:00 asok kernel: c013caf6
Jan 15 11:05:00 asok kernel: *pde = 00000000
Jan 15 11:05:00 asok kernel: Oops: 0002
Jan 15 11:05:00 asok kernel: CPU:    0
Jan 15 11:05:00 asok kernel: EIP:    0010:[iput+278/440]    Not tainted
Jan 15 11:05:00 asok kernel: EFLAGS: 00010246
Jan 15 11:05:00 asok kernel: eax: f2944868   ebx: c6d09440   ecx: 
c6d096c6   edx: c6d09448
Jan 15 11:05:00 asok kernel: esi: c7fa0e00   edi: c02b1980   ebp: 
000004a9   esp: c0553e20
Jan 15 11:05:00 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 11:05:00 asok kernel: Process denyip (pid: 28884, stackpage=c0553000)
Jan 15 11:05:00 asok kernel: Stack: c7d4b5f8 c7d4b5e0 c6d09440 
c013ab66 c6d09440 0000001f 000001d2 00000020
Jan 15 11:05:00 asok kernel:        00000005 c013ae2b 0000052c 
c0125050 00000005 000001d2 00000005 000001d2
Jan 15 11:05:00 asok kernel:        c02afb48 c02afb48 c02afb48 
c012509f 00000020 c0552000 00000000 000001d2
Jan 15 11:05:00 asok kernel: Call Trace: [prune_dcache+214/328] 
[shrink_dcache_memory+27/52] [shrink_caches+104/128] 
[try_to_free_pages+55/88] [balance_classzone+103/564]
Jan 15 11:05:00 asok kernel: Code: 89 48 04 89 01 a1 24 08 2b c0 89 
50 04 89 43 08 c7 42 04 24

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
    3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
    5:   a1 24 08 2b c0            mov    0xc02b0824,%eax
Code;  0000000a Before first symbol
    a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  0000000d Before first symbol
    d:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  00000010 Before first symbol
   10:   c7 42 04 24 00 00 00      movl   $0x24,0x4(%edx)

Jan 15 11:15:00 asok kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000015
Jan 15 11:15:00 asok kernel: c013ab49
Jan 15 11:15:00 asok kernel: *pde = 00000000
Jan 15 11:15:00 asok kernel: Oops: 0000
Jan 15 11:15:00 asok kernel: CPU:    0
Jan 15 11:15:00 asok kernel: EIP:    0010:[prune_dcache+185/328]    Not tainted
Jan 15 11:15:00 asok kernel: EFLAGS: 00010202
Jan 15 11:15:00 asok kernel: eax: 00000001   ebx: c7809238   ecx: 
c546f650   edx: c546f650
Jan 15 11:15:00 asok kernel: esi: c7809220   edi: c546f640   ebp: 
0000024f   esp: c70a3e34
Jan 15 11:15:00 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 11:15:00 asok kernel: Process run-crons (pid: 29006, stackpage=c70a3000)
Jan 15 11:15:00 asok kernel: Stack: 00000020 000001d2 00000020 
00000006 c013ae2b 0000045c c0125050 00000006
Jan 15 11:15:00 asok kernel:        000001d2 00000006 000001d2 
c02afb48 c02afb48 c02afb48 c012509f 00000020
Jan 15 11:15:00 asok kernel:        c70a2000 00000000 000001d2 
c0125a6f c02afcc4 00000100 00000010 00000000
Jan 15 11:15:00 asok kernel: Call Trace: [shrink_dcache_memory+27/52] 
[shrink_caches+104/128] [try_to_free_pages+55/88] 
[balance_classzone+103/564] [__alloc_pages+262/356]
Jan 15 11:15:00 asok kernel: Code: 8b 40 14 85 c0 74 10 57 56 ff d0 
83 c4 08 eb 17 8d b4 26 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 40 14                  mov    0x14(%eax),%eax
Code;  00000003 Before first symbol
    3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
    5:   74 10                     je     17 <_EIP+0x17> 00000017 
Before first symbol
Code;  00000007 Before first symbol
    7:   57                        push   %edi
Code;  00000008 Before first symbol
    8:   56                        push   %esi
Code;  00000009 Before first symbol
    9:   ff d0                     call   *%eax
Code;  0000000b Before first symbol
    b:   83 c4 08                  add    $0x8,%esp
Code;  0000000e Before first symbol
    e:   eb 17                     jmp    27 <_EIP+0x27> 00000027 
Before first symbol
Code;  00000010 Before first symbol
   10:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi

Jan 15 11:15:03 asok kernel:  <1>Unable to handle kernel paging 
request at virtual address 30c6e81c
Jan 15 11:15:03 asok kernel: c013c433
Jan 15 11:15:03 asok kernel: *pde = 00000000
Jan 15 11:15:03 asok kernel: Oops: 0000
Jan 15 11:15:03 asok kernel: CPU:    0
Jan 15 11:15:03 asok kernel: EIP:    0010:[prune_icache+43/204]    Not tainted
Jan 15 11:15:03 asok kernel: EFLAGS: 00010203
Jan 15 11:15:03 asok kernel: eax: 00000001   ebx: 30c6e818   ecx: 
00000001   edx: c6e81621
Jan 15 11:15:03 asok kernel: esi: c6e81621   edi: 30c6e818   ebp: 
c0911e38   esp: c0911e20
Jan 15 11:15:03 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 11:15:03 asok kernel: Process popper (pid: 29008, stackpage=c0911000)
Jan 15 11:15:03 asok kernel: Stack: 0000001b 000001d2 00000020 
0000065d c6e81268 c0dd5dc8 00000006 c013c4ef
Jan 15 11:15:03 asok kernel:        000005cd c0125057 00000006 
000001d2 00000006 000001d2 00000006 000001d2
Jan 15 11:15:03 asok kernel:        c02afb48 c02afb48 c02afb48 
c012509f 00000020 c0910000 00000000 000001d2
Jan 15 11:15:03 asok kernel: Call Trace: [shrink_icache_memory+27/48] 
[shrink_caches+111/128] [try_to_free_pages+55/88] 
[balance_classzone+103/564] [__alloc_pages+262/356]
Jan 15 11:15:03 asok kernel: Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 
00 a8 38 75 e6 0b 86 c8 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 7f 04                  mov    0x4(%edi),%edi
Code;  00000003 Before first symbol
    3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  00000006 Before first symbol
    6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  0000000c Before first symbol
    c:   a8 38                     test   $0x38,%al
Code;  0000000e Before first symbol
    e:   75 e6                     jne    fffffff6 <_EIP+0xfffffff6> 
fffffff6 <END_OF_CODE+3fcd1ada/????>
Code;  00000010 Before first symbol
   10:   0b 86 c8 00 00 00         or     0xc8(%esi),%eax

Jan 15 11:20:00 asok kernel:  <1>Unable to handle kernel paging 
request at virtual address 30c6e81c
Jan 15 11:20:00 asok kernel: c013c433
Jan 15 11:20:00 asok kernel: *pde = 00000000
Jan 15 11:20:00 asok kernel: Oops: 0000
Jan 15 11:20:00 asok kernel: CPU:    0
Jan 15 11:20:00 asok kernel: EIP:    0010:[prune_icache+43/204]    Not tainted
Jan 15 11:20:00 asok kernel: EFLAGS: 00010203
Jan 15 11:20:00 asok kernel: eax: 00000001   ebx: 30c6e818   ecx: 
00000001   edx: c6e81621
Jan 15 11:20:00 asok kernel: esi: c6e81621   edi: 30c6e818   ebp: 
c0e71e38   esp: c0e71e20
Jan 15 11:20:00 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 11:20:00 asok kernel: Process sh (pid: 29013, stackpage=c0e71000)
Jan 15 11:20:00 asok kernel: Stack: 00000007 000001d2 00000020 
00000000 c0e71e30 c0e71e30 00000006 c013c4ef
Jan 15 11:20:00 asok kernel:        00000cb8 c0125057 00000006 
000001d2 00000006 000001d2 00000006 000001d2
Jan 15 11:20:00 asok kernel:        c02afb48 c02afb48 c02afb48 
c012509f 00000020 c0e70000 00000000 000001d2
Jan 15 11:20:00 asok kernel: Call Trace: [shrink_icache_memory+27/48] 
[shrink_caches+111/128] [try_to_free_pages+55/88] 
[balance_classzone+103/564] [__alloc_pages+262/356]
Jan 15 11:20:00 asok kernel: Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 
00 a8 38 75 e6 0b 86 c8 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 7f 04                  mov    0x4(%edi),%edi
Code;  00000003 Before first symbol
    3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  00000006 Before first symbol
    6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  0000000c Before first symbol
    c:   a8 38                     test   $0x38,%al
Code;  0000000e Before first symbol
    e:   75 e6                     jne    fffffff6 <_EIP+0xfffffff6> 
fffffff6 <END_OF_CODE+3fcd1ada/????>
Code;  00000010 Before first symbol
   10:   0b 86 c8 00 00 00         or     0xc8(%esi),%eax
