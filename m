Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129493AbRCAInP>; Thu, 1 Mar 2001 03:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129550AbRCAInG>; Thu, 1 Mar 2001 03:43:06 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:14092 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S129493AbRCAImx>;
	Thu, 1 Mar 2001 03:42:53 -0500
Message-ID: <3A9E0C03.6010001@megapathdsl.net>
Date: Thu, 01 Mar 2001 00:44:51 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac7 i686; en-US; 0.9) Gecko/20010227
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.2-a6 + ac7 -- OOPS on Athlon during boot -- invalid operand: 0000 in process lsmod
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012af6f>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010092
eax: 0000001b   ebx: cfa12000   ecx: 00000001   edx: 00000001
esi: cfa1290c   edi: 00000100   ebp: c14470c0   esp: cf8a9e38
ds: 0018   es: 0018   ss: 0018
Process lsmod (pid: 395, stackpage=cf8a9000)
Stack: c020f785 c020f805 0000057b 00000000 cfa12944 cfa12954 cfa12944 
00426cc8
        c0247ca0 0000e734 00000082 d286d081 cfa12910 cf861724 cfa12944 
cf858800
        d286d0ef cfced26c cfa12944 00000297 cfa12944 d286d11e cf861724 
cf861724
Call Trace: [<d286d081>] [<d286d0ef>] [<d286d11e>] [<d286da46>] 
[<d286f714>] [<d287400c>] [<d2874000>]
        [<d287092a>] [<d2874014>] [<d2871728>] [<d2874010>] [<d287400c>] 
[<c010a2ff>] [<c010a482>] [<d286d000>]
        [<c0109038>] [<d286d000>] [<c012d803>] [<d286d000>] [<c012e01a>] 
[<c012e044>] [<c0117dde>] [<c0108f8f>]
Code: 0f 0b 83 c4 0c 89 f1 03 4d 0c ba 71 f0 2c 5a 87 51 fc 81 fa

 >>EIP; c012af6f <kfree+17f/2a0>   <=====
Trace; d286d081 <[3c59x]vortex_error+1f1/2e0>
Trace; d286d0ef <[3c59x]vortex_error+25f/2e0>
Trace; d286d11e <[3c59x]vortex_error+28e/2e0>
Trace; d286da46 <[3c59x]boomerang_interrupt+1c6/3c0>
Trace; d286f714 <[3c59x]__module_pci_device_size+200/1596>
Trace; d287400c <__module_parm_watchdog+2b34/????>
Trace; d2874000 <__module_parm_watchdog+2b28/????>
Trace; d287092a <[3c59x]__module_pci_device_size+1416/1596>
Trace; d2874014 <__module_parm_watchdog+2b3c/????>
Trace; d2871728 <__module_parm_watchdog+250/????>
Trace; d2874010 <__module_parm_watchdog+2b38/????>
Trace; d287400c <__module_parm_watchdog+2b34/????>
Trace; c010a2ff <handle_IRQ_event+2f/60>
Trace; c010a482 <do_IRQ+72/c0>
Trace; d286d000 <[3c59x]vortex_error+170/2e0>
Trace; c0109038 <ret_from_intr+0/20>
Trace; d286d000 <[3c59x]vortex_error+170/2e0>
Trace; c012d803 <__free_pages_ok+113/310>
Trace; d286d000 <[3c59x]vortex_error+170/2e0>
Trace; c012e01a <__free_pages+1a/20>
Trace; c012e044 <free_pages+24/30>
Trace; c0117dde <sys_query_module+be/160>
Trace; c0108f8f <system_call+33/38>
Code;  c012af6f <kfree+17f/2a0>
00000000 <_EIP>:
Code;  c012af6f <kfree+17f/2a0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c012af71 <kfree+181/2a0>
    2:   83 c4 0c                  add    $0xc,%esp
Code;  c012af74 <kfree+184/2a0>
    5:   89 f1                     mov    %esi,%ecx
Code;  c012af76 <kfree+186/2a0>
    7:   03 4d 0c                  add    0xc(%ebp),%ecx
Code;  c012af79 <kfree+189/2a0>
    a:   ba 71 f0 2c 5a            mov    $0x5a2cf071,%edx
Code;  c012af7e <kfree+18e/2a0>
    f:   87 51 fc                  xchg   %edx,0xfffffffc(%ecx)
Code;  c012af81 <kfree+191/2a0>
   12:   81 fa 00 00 00 00         cmp    $0x0,%edx

Kernel panic: Aiee, killing interrupt handler!

