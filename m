Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289155AbSAGJsF>; Mon, 7 Jan 2002 04:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289158AbSAGJr4>; Mon, 7 Jan 2002 04:47:56 -0500
Received: from pD9E4FB43.dip.t-dialin.net ([217.228.251.67]:10500 "EHLO
	asok.cccrewhome.de") by vger.kernel.org with ESMTP
	id <S289155AbSAGJrr>; Mon, 7 Jan 2002 04:47:47 -0500
Mime-Version: 1.0
Message-Id: <p05100300b85f1d806b3e@[192.168.100.2]>
Date: Mon, 7 Jan 2002 10:47:42 +0100
To: linux-kernel@vger.kernel.org
From: Sebastian Wenleder <Sebastian@wenleder.de>
Subject: 2.4.17 oopses
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi here are three oopses/oopss/oops (don't know the correct plural ;-)

gcc --version = 2.95.3

Best,
Sebastian

------
ksymoops 2.4.1 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.17/ (specified)
     -m /boot/System.map-2.4.17 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Jan  6 16:00:02 asok kernel: Unable to handle kernel paging request at virtual address 0ecdc86c
Jan  6 16:00:02 asok kernel: c013c066
Jan  6 16:00:02 asok kernel: *pde = 00000000
Jan  6 16:00:02 asok kernel: Oops: 0002
Jan  6 16:00:02 asok kernel: CPU:    0
Jan  6 16:00:02 asok kernel: EIP:    0010:[iput+278/440]    Not tainted
Jan  6 16:00:02 asok kernel: EFLAGS: 00010246
Jan  6 16:00:02 asok kernel: eax: 0ecdc868   ebx: c6b09440   ecx: c6b096c7   edx: c6b09448
Jan  6 16:00:02 asok kernel: esi: c7fa0e00   edi: c02b1220   ebp: 000002a7   esp: c7fb9f4c
Jan  6 16:00:02 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan  6 16:00:02 asok kernel: Process kswapd (pid: 4, stackpage=c7fb9000)
Jan  6 16:00:02 asok kernel: Stack: c2fac1f8 c2fac1e0 c6b09440 c013a0d6 c6b09440 0000001c 000001d0 0000001c 
Jan  6 16:00:02 asok kernel:        00000004 c013a39b 000007c1 c0124b50 00000004 000001d0 00000004 000001d0 
Jan  6 16:00:02 asok kernel:        c02af3e8 00000000 c02af3e8 c0124b9f 0000001c c02af3e8 00000001 c7fb8000 
Jan  6 16:00:02 asok kernel: Call Trace: [prune_dcache+214/328] [shrink_dcache_memory+27/52] [shrink_caches+108/132] [try_to_free_pages+55/92] [kswapd_balance_pgdat+67/140] 
Jan  6 16:00:02 asok kernel: Code: 89 48 04 89 01 a1 c4 00 2b c0 89 50 04 89 43 08 c7 42 04 c4 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
   5:   a1 c4 00 2b c0            mov    0xc02b00c4,%eax
Code;  0000000a Before first symbol
   a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  0000000d Before first symbol
   d:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  00000010 Before first symbol
  10:   c7 42 04 c4 00 00 00      movl   $0xc4,0x4(%edx)


1 warning issued.  Results may not be reliable.
------
ksymoops 2.4.1 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.17/ (specified)
     -m /boot/System.map-2.4.17 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Jan  6 16:00:02 asok kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000016
Jan  6 16:00:02 asok kernel: c013a0b9
Jan  6 16:00:02 asok kernel: *pde = 00000000
Jan  6 16:00:02 asok kernel: Oops: 0000
Jan  6 16:00:02 asok kernel: CPU:    0
Jan  6 16:00:02 asok kernel: EIP:    0010:[prune_dcache+185/328]    Not tainted
Jan  6 16:00:02 asok kernel: EFLAGS: 00010202
Jan  6 16:00:02 asok kernel: eax: 00000002   ebx: c6d09238   ecx: c2c31df0   edx: c2c31df0
Jan  6 16:00:02 asok kernel: esi: c6d09220   edi: c2c31de0   ebp: 0000032f   esp: c7013e0c
Jan  6 16:00:02 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan  6 16:00:02 asok kernel: Process setiathome (pid: 24507, stackpage=c7013000)
Jan  6 16:00:02 asok kernel: Stack: 00000009 000001d2 0000001c 00000003 c013a39b 0000047b c0124b50 00000003 
Jan  6 16:00:02 asok kernel:        000001d2 00000003 000001d2 c02af3e8 c02af3e8 c02af3e8 c0124b9f 0000001c 
Jan  6 16:00:02 asok kernel:        c7012000 00000000 000001d2 c012556f c02af564 00000100 00000010 00000000 
Jan  6 16:00:02 asok kernel: Call Trace: [shrink_dcache_memory+27/52] [shrink_caches+108/132] [try_to_free_pages+55/92] [balance_classzone+103/564] [__alloc_pages+262/356] 
Jan  6 16:00:02 asok kernel: Code: 8b 40 14 85 c0 74 10 57 56 ff d0 83 c4 08 eb 17 8d b4 26 00 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 14                  mov    0x14(%eax),%eax
Code;  00000003 Before first symbol
   3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
   5:   74 10                     je     17 <_EIP+0x17> 00000017 Before first symbol
Code;  00000007 Before first symbol
   7:   57                        push   %edi
Code;  00000008 Before first symbol
   8:   56                        push   %esi
Code;  00000009 Before first symbol
   9:   ff d0                     call   *%eax
Code;  0000000b Before first symbol
   b:   83 c4 08                  add    $0x8,%esp
Code;  0000000e Before first symbol
   e:   eb 17                     jmp    27 <_EIP+0x27> 00000027 Before first symbol
Code;  00000010 Before first symbol
  10:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi


1 warning issued.  Results may not be reliable.
------
ksymoops 2.4.1 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.17/ (specified)
     -m /boot/System.map-2.4.17 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Jan  7 00:15:13 asok kernel: Unable to handle kernel paging request at virtual address da0d686c
Jan  7 00:15:13 asok kernel: c013be96
Jan  7 00:15:13 asok kernel: *pde = 00000000
Jan  7 00:15:13 asok kernel: Oops: 0002
Jan  7 00:15:13 asok kernel: CPU:    0
Jan  7 00:15:13 asok kernel: EIP:    0010:[iget4+106/204]    Not tainted
Jan  7 00:15:13 asok kernel: EFLAGS: 00010246
Jan  7 00:15:13 asok kernel: eax: da0d6868   ebx: c6b09440   ecx: c2c31dc7   edx: c6b09448
Jan  7 00:15:13 asok kernel: esi: c7fe25b0   edi: 0017818c   ebp: c7fa0e00   esp: c3b79efc
Jan  7 00:15:13 asok kernel: ds: 0018   es: 0018   ss: 0018
Jan  7 00:15:13 asok kernel: Process find (pid: 30414, stackpage=c3b79000)
Jan  7 00:15:13 asok kernel: Stack: c133d640 c24ad820 c133d640 c3435740 c014b3f3 c7fa0e00 0017818c 00000000 
Jan  7 00:15:13 asok kernel:        00000000 fffffff4 c24ad820 c0132a4b c24ad820 c133d640 c3b79f74 00000000 
Jan  7 00:15:13 asok kernel:        c3b79fa4 c24ad820 c01330ce c3435740 c3b79f74 00000000 c4bc2000 00000000 
Jan  7 00:15:13 asok kernel: Call Trace: [ext2_lookup+67/104] [real_lookup+83/196] [link_path_walk+1302/1880] [getname+93/156] [path_walk+26/28] 
Jan  7 00:15:13 asok kernel: Code: 89 48 04 89 01 a1 bc 00 2b c0 89 50 04 89 43 08 c7 42 04 bc 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
   5:   a1 bc 00 2b c0            mov    0xc02b00bc,%eax
Code;  0000000a Before first symbol
   a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  0000000d Before first symbol
   d:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  00000010 Before first symbol
  10:   c7 42 04 bc 00 00 00      movl   $0xbc,0x4(%edx)


1 warning issued.  Results may not be reliable.
