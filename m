Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263022AbREaHvo>; Thu, 31 May 2001 03:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbREaHvf>; Thu, 31 May 2001 03:51:35 -0400
Received: from zeus.kernel.org ([209.10.41.242]:24000 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263022AbREaHvZ>;
	Thu, 31 May 2001 03:51:25 -0400
Date: Thu, 31 May 2001 09:45:56 +0200
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.4.5-ac3
Message-ID: <20010531094556.A599@hal9000>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.18i
From: Jose Carlos Garcia Sogo <jose@servidor.jaimedelamo.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


   Hello!

   I've just got an oops with the 2.4.5-ac3 kernel. I have attached the log 
  to this mail. I have also having more random dead locks, but I haven't 
  catch any log of them. If I manage to get some logs, I'll send here also.

   Anyway, 2.4.5-ac3 is much more stable in my computer than vanilla 2.4.5, 
  which was almost unusable. With 2.4.4, I had some problems also.

   I'm using NVIDIA's module for a TNT2 M64 card.

   My computer is:
     AMD K6-II 450
     128 MB of RAM
     NVIDIA TNT2 M64 video card
     Realtek 8139 ethernet card
     Sound Blaster 128 PCI

   Thanks 

Please, CC all the responses to my email address. I'm not subscribed 
to this list

-- 
José Carlos García Sogo         Seahorse(-bonobo) developer
jose jaimedelamo eu org         http://seahorse.sourceforge.net

Key-Id: 0x90788E11 
Fingerprint = B06B 023F EAA6 37DC 1E62  B079 4BE0 5825 9078 8E11  

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops_kernel-2.4.5-ac3"

May 31 00:17:33 hal9000 kernel: c011cdb0
May 31 00:17:33 hal9000 kernel: *pde = 00000000
May 31 00:17:33 hal9000 kernel: Oops: 0000
May 31 00:17:33 hal9000 kernel: CPU:    0
May 31 00:17:33 hal9000 kernel: EIP:    0010:[zap_page_range+40/596]
May 31 00:17:33 hal9000 kernel: EFLAGS: 00210217
May 31 00:17:33 hal9000 kernel: eax: 000003ff   ebx: ffffffff   ecx: ffffffff   edx: c47567ac
May 31 00:17:33 hal9000 kernel: esi: ffffffff   edi: ffffffff   ebp: 00000000   esp: c5f3be4c
May 31 00:17:33 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:17:33 hal9000 kernel: Process localedef (pid: 13031, stackpage=c5f3b000)
May 31 00:17:33 hal9000 kernel: Stack: ffffffff c2d87adc ffffffff 00000000 00416000 40416000 c0096404 c081a05c 
May 31 00:17:33 hal9000 kernel:        00000000 00000000 00017000 00000000 ffffffff c011dbc6 ffffffff ffffffff 
May 31 00:17:34 hal9000 kernel:        00000000 00000000 00000000 00000000 00000000 c011dc54 c7e543d4 00000000 
May 31 00:17:34 hal9000 kernel: Call Trace: [vmtruncate_list+70/88] [vmtruncate+124/376] [inode_setattr+36/176] [notify_change+156/220] [do_truncate+73/96] 
May 31 00:17:34 hal9000 kernel: Code: 8b 51 0c 8d 3c 82 3b 74 24 30 72 14 68 64 01 00 00 68 c7 93 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 51 0c                  mov    0xc(%ecx),%edx
Code;  00000003 Before first symbol
   3:   8d 3c 82                  lea    (%edx,%eax,4),%edi
Code;  00000006 Before first symbol
   6:   3b 74 24 30               cmp    0x30(%esp,1),%esi
Code;  0000000a Before first symbol
   a:   72 14                     jb     20 <_EIP+0x20> 00000020 Before first symbol
Code;  0000000c Before first symbol
   c:   68 64 01 00 00            push   $0x164
Code;  00000011 Before first symbol
  11:   68 c7 93 00 00            push   $0x93c7

May 31 00:17:40 hal9000 kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 0000001f
May 31 00:17:40 hal9000 kernel: c013e89c
May 31 00:17:40 hal9000 kernel: *pde = 00000000
May 31 00:17:40 hal9000 kernel: Oops: 0000
May 31 00:17:40 hal9000 kernel: CPU:    0
May 31 00:17:40 hal9000 kernel: EIP:    0010:[find_inode+28/72]
May 31 00:17:40 hal9000 kernel: EFLAGS: 00210206
May 31 00:17:40 hal9000 kernel: eax: 00000000   ebx: ffffffff   ecx: 0000000d   edx: c7fe0000
May 31 00:17:40 hal9000 kernel: esi: ffffffff   edi: 00000000   ebp: 00004f61   esp: c3e45e88
May 31 00:17:40 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:17:40 hal9000 kernel: Process mkfontdir (pid: 13102, stackpage=c3e45000)
May 31 00:17:40 hal9000 kernel: Stack: 00004f61 c7fe3f00 00004f61 c7f4d000 c013ec74 c7f4d000 00004f61 c7fe3f00 
May 31 00:17:40 hal9000 kernel:        00000000 00000000 00004f61 c3391be4 c5ce62a4 c3fd58bc c014a861 c7f4d000 
May 31 00:17:40 hal9000 kernel:        00004f61 00000000 00000000 fffffff4 c5ce62a4 c3391be4 c53fd0a8 c0135857 
May 31 00:17:40 hal9000 kernel: Call Trace: [iget4+64/212] [ext2_lookup+89/128] [real_lookup+83/196] [path_walk+1307/1868] [do_page_fault+0/1116] 
May 31 00:17:40 hal9000 kernel:    [<d1a5e2d3>] [open_namei+119/1404] [filp_open+46/76] [sys_open+53/184] [system_call+51/64] 
May 31 00:17:40 hal9000 kernel: Code: 39 6e 20 75 ef 8b 44 24 14 39 86 90 00 00 00 75 e3 85 ff 74 

Trace; d1a5e2d3 <END_OF_CODE+40540a0/????>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 6e 20                  cmp    %ebp,0x20(%esi)
Code;  00000003 Before first symbol
   3:   75 ef                     jne    fffffff4 <_EIP+0xfffffff4> fffffff4 <END_OF_CODE+325f5dc1/????>
Code;  00000005 Before first symbol
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  00000009 Before first symbol
   9:   39 86 90 00 00 00         cmp    %eax,0x90(%esi)
Code;  0000000f Before first symbol
   f:   75 e3                     jne    fffffff4 <_EIP+0xfffffff4> fffffff4 <END_OF_CODE+325f5dc1/????>
Code;  00000011 Before first symbol
  11:   85 ff                     test   %edi,%edi
Code;  00000013 Before first symbol
  13:   74 00                     je     15 <_EIP+0x15> 00000015 Before first symbol

May 31 00:19:03 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:19:03 hal9000 kernel: invalid operand: 0000
May 31 00:19:03 hal9000 kernel: CPU:    0
May 31 00:19:03 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:19:03 hal9000 kernel: EFLAGS: 00010286
May 31 00:19:03 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 000022b4
May 31 00:19:03 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c7f9dfa4   esp: c7f9df80
May 31 00:19:03 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:19:03 hal9000 kernel: Process kswapd (pid: 3, stackpage=c7f9d000)
May 31 00:19:03 hal9000 kernel: Stack: c021cfa7 0000028c 00000004 00000342 00000000 00000000 00000000 c7f9df9c 
May 31 00:19:03 hal9000 kernel:        c7f9df9c 0008e000 c013e871 00000321 c01271cf 00000006 00000004 00000006 
May 31 00:19:03 hal9000 kernel:        00000004 00000004 00000000 c7f9c000 c021a391 c7f9c239 c012724b 00000004 
May 31 00:19:03 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [kswapd+83/224] [kernel_thread+40/56] 
May 31 00:19:03 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:19:27 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:19:27 hal9000 kernel: invalid operand: 0000
May 31 00:19:27 hal9000 kernel: CPU:    0
May 31 00:19:27 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:19:27 hal9000 kernel: EFLAGS: 00010282
May 31 00:19:27 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 00002584
May 31 00:19:27 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c0669e0c   esp: c0669de8
May 31 00:19:27 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:19:27 hal9000 kernel: Process nautilus (pid: 12127, stackpage=c0669000)
May 31 00:19:27 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 0000000f 00000001 00000000 00000003 c49f04ac 
May 31 00:19:27 hal9000 kernel:        c5f0122c 00000001 c013e871 00000341 c01271cf 00000006 00000005 00000006 
May 31 00:19:27 hal9000 kernel:        00000005 00000005 00000001 c0668000 c025c40c 00000000 c012731e 00000005 
May 31 00:19:27 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [read_cluster_nonblocking+162/272] 
May 31 00:19:27 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:19:27 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:19:27 hal9000 kernel: invalid operand: 0000
May 31 00:19:27 hal9000 kernel: CPU:    0
May 31 00:19:27 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:19:27 hal9000 kernel: EFLAGS: 00010286
May 31 00:19:27 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 000028f7
May 31 00:19:27 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c5033e2c   esp: c5033e08
May 31 00:19:27 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:19:27 hal9000 kernel: Process galeon-bin (pid: 12229, stackpage=c5033000)
May 31 00:19:27 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 00000012 00000001 00000000 00000000 c5033e24 
May 31 00:19:27 hal9000 kernel:        c5033e24 00000001 c013e871 00000377 c01271cf 00000006 00000005 00000006 
May 31 00:19:27 hal9000 kernel:        00000005 00000005 00000000 c5032000 c025c40c 00000000 c012731e 00000005 
May 31 00:19:27 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [read_swap_cache_async+49/148] 
May 31 00:19:27 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:19:28 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:19:28 hal9000 kernel: invalid operand: 0000
May 31 00:19:28 hal9000 kernel: CPU:    0
May 31 00:19:28 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:19:28 hal9000 kernel: EFLAGS: 00010286
May 31 00:19:28 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 00002c5f
May 31 00:19:28 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c188be2c   esp: c188be08
May 31 00:19:28 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:19:28 hal9000 kernel: Process nautilus (pid: 12169, stackpage=c188b000)
May 31 00:19:28 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 0000009d 00000001 00000000 00000000 c188be24 
May 31 00:19:28 hal9000 kernel:        c188be24 00000001 c013e871 00000389 c01271cf 00000006 00000005 00000006 
May 31 00:19:28 hal9000 kernel:        00000005 00000005 00000000 c188a000 c025c40c 00000000 c012731e 00000005 
May 31 00:19:28 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [read_swap_cache_async+49/148] 
May 31 00:19:28 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:20:12 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:20:12 hal9000 kernel: invalid operand: 0000
May 31 00:20:12 hal9000 kernel: CPU:    0
May 31 00:20:12 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:20:12 hal9000 kernel: EFLAGS: 00010286
May 31 00:20:12 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 00003000
May 31 00:20:12 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c262fe3c   esp: c262fe18
May 31 00:20:12 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:20:12 hal9000 kernel: Process galeon (pid: 13108, stackpage=c262f000)
May 31 00:20:12 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 00000000 00000001 00000000 00000000 c262fe34 
May 31 00:20:12 hal9000 kernel:        c262fe34 00000001 c013e871 0000039d c01271cf 00000006 00000005 00000006 
May 31 00:20:12 hal9000 kernel:        00000005 00000005 00000001 c262e000 c025c40c 00000000 c012731e 00000005 
May 31 00:20:12 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [do_anonymous_page+50/148] 
May 31 00:20:12 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:20:12 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:20:12 hal9000 kernel: invalid operand: 0000
May 31 00:20:12 hal9000 kernel: CPU:    0
May 31 00:20:12 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:20:12 hal9000 kernel: EFLAGS: 00010286
May 31 00:20:12 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 0000337e
May 31 00:20:12 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c0c2be3c   esp: c0c2be18
May 31 00:20:12 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:20:12 hal9000 kernel: Process galeon (pid: 13107, stackpage=c0c2b000)
May 31 00:20:12 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 00000000 00000001 00000000 00000000 c0c2be34 
May 31 00:20:12 hal9000 kernel:        c0c2be34 00000001 c013e871 000003ac c01271cf 00000006 00000005 00000006 
May 31 00:20:12 hal9000 kernel:        00000005 00000005 00000001 c0c2a000 c025c40c 00000000 c012731e 00000005 
May 31 00:20:12 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [do_anonymous_page+50/148] 
May 31 00:20:12 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:20:41 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:20:41 hal9000 kernel: invalid operand: 0000
May 31 00:20:41 hal9000 kernel: CPU:    0
May 31 00:20:41 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:20:41 hal9000 kernel: EFLAGS: 00010282
May 31 00:20:41 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 000036e2
May 31 00:20:41 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c5439e0c   esp: c5439de8
May 31 00:20:41 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:20:41 hal9000 kernel: Process xchat (pid: 12173, stackpage=c5439000)
May 31 00:20:41 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 00000000 00000001 00000000 00000000 c5439e04 
May 31 00:20:41 hal9000 kernel:        c5439e04 00000001 c013e871 000003c7 c01271cf 00000006 00000005 00000006 
May 31 00:20:41 hal9000 kernel:        00000005 00000005 00000001 c5438000 c025c40c 00000000 c012731e 00000005 
May 31 00:20:41 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [read_cluster_nonblocking+162/272] 
May 31 00:20:41 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:20:44 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:20:44 hal9000 kernel: invalid operand: 0000
May 31 00:20:44 hal9000 kernel: CPU:    0
May 31 00:20:44 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:20:44 hal9000 kernel: EFLAGS: 00010286
May 31 00:20:44 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 00003a45
May 31 00:20:44 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c7607e9c   esp: c7607e78
May 31 00:20:44 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:20:44 hal9000 kernel: Process mkfontdir (pid: 13120, stackpage=c7607000)
May 31 00:20:44 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 00000016 00000001 00000000 00000000 c7607e94 
May 31 00:20:44 hal9000 kernel:        c7607e94 00000001 c013e871 000003d9 c01271cf 00000006 00000005 00000006 
May 31 00:20:44 hal9000 kernel:        00000005 00000005 00000000 c7606000 c025c40c 00000000 c012731e 00000005 
May 31 00:20:44 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [generic_file_readahead+478/644] 
May 31 00:20:44 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:20:45 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:20:45 hal9000 kernel: invalid operand: 0000
May 31 00:20:45 hal9000 kernel: CPU:    0
May 31 00:20:45 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:20:45 hal9000 kernel: EFLAGS: 00010286
May 31 00:20:45 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 00003d71
May 31 00:20:45 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c7607e3c   esp: c7607e18
May 31 00:20:45 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:20:45 hal9000 kernel: Process cat (pid: 13142, stackpage=c7607000)
May 31 00:20:45 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 00000001 00000001 00000000 00000000 c7607e34 
May 31 00:20:45 hal9000 kernel:        c7607e34 00000001 c013e871 000003ee c01271cf 00000006 00000005 00000006 
May 31 00:20:45 hal9000 kernel:        00000005 00000005 00000000 c7606000 c025c40c 00000000 c012731e 00000005 
May 31 00:20:45 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [do_anonymous_page+50/148] 
May 31 00:20:45 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:20:45 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:20:45 hal9000 kernel: invalid operand: 0000
May 31 00:20:45 hal9000 kernel: CPU:    0
May 31 00:20:45 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:20:45 hal9000 kernel: EFLAGS: 00010282
May 31 00:20:45 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 000040d2
May 31 00:20:45 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c6cc9e64   esp: c6cc9e40
May 31 00:20:45 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:20:45 hal9000 kernel: Process update-fonts-sc (pid: 13164, stackpage=c6cc9000)
May 31 00:20:45 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 00000005 00000001 00000000 00000000 c6cc9e5c 
May 31 00:20:45 hal9000 kernel:        c6cc9e5c 00000001 c013e871 00000400 c01271cf 00000006 00000005 00000006 
May 31 00:20:45 hal9000 kernel:        00000005 00000005 00000000 c6cc8000 c025c40c 00000000 c012731e 00000005 
May 31 00:20:45 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [do_wp_page+366/588] 
May 31 00:20:45 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:20:46 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:20:46 hal9000 kernel: invalid operand: 0000
May 31 00:20:46 hal9000 kernel: CPU:    0
May 31 00:20:46 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:20:46 hal9000 kernel: EFLAGS: 00010286
May 31 00:20:46 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 0000443f
May 31 00:20:46 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c605de3c   esp: c605de18
May 31 00:20:46 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:20:46 hal9000 kernel: Process frontend (pid: 13179, stackpage=c605d000)
May 31 00:20:46 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 00000001 00000001 00000000 00000000 c605de34 
May 31 00:20:46 hal9000 kernel:        c605de34 00000001 c013e871 0000040d c01271cf 00000006 00000005 00000006 
May 31 00:20:46 hal9000 kernel:        00000005 00000005 00000000 c605c000 c025c40c 00000000 c012731e 00000005 
May 31 00:20:46 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [do_anonymous_page+50/148] 
May 31 00:20:46 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:20:46 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:20:46 hal9000 kernel: invalid operand: 0000
May 31 00:20:46 hal9000 kernel: CPU:    0
May 31 00:20:46 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:20:46 hal9000 kernel: EFLAGS: 00010286
May 31 00:20:46 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 000047a5
May 31 00:20:46 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c605de3c   esp: c605de18
May 31 00:20:46 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:20:46 hal9000 kernel: Process frontend (pid: 13180, stackpage=c605d000)
May 31 00:20:46 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 00000002 00000001 00000000 00000000 c605de34 
May 31 00:20:46 hal9000 kernel:        c605de34 00000001 c013e871 00000416 c01271cf 00000006 00000005 00000006 
May 31 00:20:46 hal9000 kernel:        00000005 00000005 00000000 c605c000 c025c40c 00000000 c012731e 00000005 
May 31 00:20:46 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [do_anonymous_page+50/148] 
May 31 00:20:46 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:20:46 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:20:46 hal9000 kernel: invalid operand: 0000
May 31 00:20:46 hal9000 kernel: CPU:    0
May 31 00:20:46 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:20:46 hal9000 kernel: EFLAGS: 00010286
May 31 00:20:46 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 00004b0b
May 31 00:20:46 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c605de3c   esp: c605de18
May 31 00:20:46 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:20:46 hal9000 kernel: Process frontend (pid: 13185, stackpage=c605d000)
May 31 00:20:46 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 00000001 00000001 00000000 00000000 c605de34 
May 31 00:20:46 hal9000 kernel:        c605de34 00000001 c013e871 00000421 c01271cf 00000006 00000005 00000006 
May 31 00:20:46 hal9000 kernel:        00000005 00000005 00000000 c605c000 c025c40c 00000000 c012731e 00000005 
May 31 00:20:46 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [do_anonymous_page+50/148] 
May 31 00:20:46 hal9000 kernel:    [<c8993040>] [do_munmap+88/556] [do_brk+172/364] [sys_brk+170/212] [error_code+52/64] 
May 31 00:20:46 hal9000 kernel: Code: 0f 0b 83 c4 08 8b 86 f8 00 00 00 0b 86 c0 00 00 00 75 c1 56 

Trace; c8993040 <[NVdriver]TimeStart.22+238/13f7>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  0000000b Before first symbol
   b:   0b 86 c0 00 00 00         or     0xc0(%esi),%eax
Code;  00000011 Before first symbol
  11:   75 c1                     jne    ffffffd4 <_EIP+0xffffffd4> ffffffd4 <END_OF_CODE+325f5da1/????>
Code;  00000013 Before first symbol
  13:   56                        push   %esi

May 31 00:20:46 hal9000 kernel:  kernel BUG at inode.c:652!
May 31 00:20:46 hal9000 kernel: invalid operand: 0000
May 31 00:20:46 hal9000 kernel: CPU:    0
May 31 00:20:46 hal9000 kernel: EIP:    0010:[prune_icache+84/264]
May 31 00:20:46 hal9000 kernel: EFLAGS: 00010282
May 31 00:20:46 hal9000 kernel: eax: 0000001b   ebx: c63534ac   ecx: c025ae7c   edx: 00004e8b
May 31 00:20:46 hal9000 kernel: esi: c63534a4   edi: ffffffff   ebp: c51e3eec   esp: c51e3ec8
May 31 00:20:46 hal9000 kernel: ds: 0018   es: 0018   ss: 0018
May 31 00:20:46 hal9000 kernel: Process dpkg (pid: 12999, stackpage=c51e3000)
May 31 00:20:46 hal9000 kernel: Stack: c021cfa7 0000028c 00000005 00000022 00000001 00000000 00000000 c51e3ee4 
May 31 00:20:46 hal9000 kernel:        c51e3ee4 00000001 c013e871 0000042b c01271cf 00000006 00000005 00000006 
May 31 00:20:46 hal9000 kernel:        00000005 00000005 00000000 c51e2000 c025c40c 00000000 c012731e 00000005 
May 31 00:20:46 hal9000 kernel: Call Trace: [shrink_icache_memory+33/48] [do_try_to_free_pages+47/88] [try_to_free_pages+34/44] [__alloc_pages+435/580] [generic_file_write+839/1484] 

1 warning issued.  Results may not be reliable.

--9amGYk9869ThD9tj--
