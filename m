Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbTD2QHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 12:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTD2QHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 12:07:50 -0400
Received: from ip-86-8.evc.net ([212.95.86.8]:34176 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S261220AbTD2QHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 12:07:45 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: oops mm/slab.c:1563  on 2.5.68
Date: Tue, 29 Apr 2003 18:19:58 +0200
User-Agent: KMail/1.5
References: <200304272244.18348.linux@1g6.biz>
In-Reply-To: <200304272244.18348.linux@1g6.biz>
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304291819.58865.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Is Manfred Spraul the maintainer of this file ?
who should I contact for this ?

Regards.

Nicolas


Apr 29 17:37:00 hal9003 kernel: drivers/usb/media/ov511.c: Invalid channel 
(-1)
Apr 29 17:37:31 hal9003 last message repeated 123 times
Apr 29 17:37:52 hal9003 last message repeated 89 times
Apr 29 17:37:53 hal9003 kernel: ------------[ cut here ]------------
Apr 29 17:37:53 hal9003 kernel: kernel BUG at mm/slab.c:1563!
Apr 29 17:37:53 hal9003 kernel: invalid operand: 0000 [#1]
Apr 29 17:37:53 hal9003 kernel: CPU:    0
Apr 29 17:37:53 hal9003 kernel: EIP:    0060:[cache_alloc_refill+533/616]    
Not tainted
Apr 29 17:37:53 hal9003 kernel: EIP:    0060:[<c0137478>]    Not tainted
Apr 29 17:37:53 hal9003 kernel: EFLAGS: 00010002
Apr 29 17:37:53 hal9003 kernel: EIP is at cache_alloc_refill+0x215/0x268
Apr 29 17:37:53 hal9003 kernel: eax: 00000000   ebx: c1754228   ecx: 00000033   
edx: 00000032
Apr 29 17:37:53 hal9003 kernel: esi: c1754240   edi: 00000032   ebp: f621be98   
esp: f621be70
Apr 29 17:37:53 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Apr 29 17:37:53 hal9003 kernel: Process kdeinit (pid: 2063, 
threadinfo=f621a000 task=f62f6c80)
Apr 29 17:37:53 hal9003 kernel: Stack: e0a7bd2c 39e06045 f7ffd56c c1bf0094 
f7ffd574 c1bf0084 00000008 00000001
Apr 29 17:37:53 hal9003 kernel:        f7ffd560 00000246 f621bec0 c0137898 
f7ffd560 000000d0 e3c05580 00016395
Apr 29 17:37:53 hal9003 kernel:        f621bec0 00000001 f624db68 00000000 
f621befc c011a813 f7ffd560 000000d0
Apr 29 17:37:53 hal9003 kernel: Call Trace:
Apr 29 17:37:53 hal9003 kernel:  [kmem_cache_alloc+317/324] 
kmem_cache_alloc+0x13d/0x144
Apr 29 17:37:53 hal9003 kernel:  [<c0137898>] kmem_cache_alloc+0x13d/0x144
Apr 29 17:37:53 hal9003 kernel:  [copy_mm+456/864] copy_mm+0x1c8/0x360
Apr 29 17:37:53 hal9003 kernel:  [<c011a813>] copy_mm+0x1c8/0x360
Apr 29 17:37:53 hal9003 kernel:  [copy_process+1173/2639] 
copy_process+0x495/0xa4f
Apr 29 17:37:53 hal9003 kernel:  [<c011b1c6>] copy_process+0x495/0xa4f
Apr 29 17:37:53 hal9003 kernel:  [do_pipe+380/492] do_pipe+0x17c/0x1ec
Apr 29 17:37:53 hal9003 kernel:  [<c0153583>] do_pipe+0x17c/0x1ec
Apr 29 17:37:53 hal9003 kernel:  [do_fork+77/340] do_fork+0x4d/0x154
Apr 29 17:37:53 hal9003 kernel:  [<c011b7cd>] do_fork+0x4d/0x154
Apr 29 17:37:53 hal9003 kernel:  [sys_fork+56/74] sys_fork+0x38/0x4a
Apr 29 17:37:53 hal9003 kernel:  [<c01079f1>] sys_fork+0x38/0x4a
Apr 29 17:37:53 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 29 17:37:53 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
Apr 29 17:37:53 hal9003 kernel:
Apr 29 17:37:53 hal9003 kernel: Code: 0f 0b 1b 06 9b be 2b c0 e9 73 fe ff ff 
8b 7d 08 8b 57 38 e9
Apr 29 17:37:53 hal9003 kernel:  <3>drivers/usb/media/ov511.c: Invalid channel 
(-1)
Apr 29 17:37:53 hal9003 kernel: drivers/usb/media/ov511.c: Invalid channel 
(-1)
Apr 29 17:38:00 hal9003 last message repeated 31 times
Apr 29 17:38:01 hal9003 CROND[12878]: (root) CMD (   
/usr/share/msec/promisc_check.sh)
Apr 29 17:38:01 hal9003 kernel: ------------[ cut here ]------------
Apr 29 17:38:01 hal9003 kernel: kernel BUG at mm/slab.c:1563!
Apr 29 17:38:01 hal9003 kernel: invalid operand: 0000 [#2]
Apr 29 17:38:01 hal9003 kernel: CPU:    0
Apr 29 17:38:01 hal9003 kernel: EIP:    0060:[cache_alloc_refill+533/616]    
Not tainted
Apr 29 17:38:01 hal9003 kernel: EIP:    0060:[<c0137478>]    Not tainted
Apr 29 17:38:01 hal9003 kernel: EFLAGS: 00010002
Apr 29 17:38:01 hal9003 kernel: EIP is at cache_alloc_refill+0x215/0x268
Apr 29 17:38:01 hal9003 kernel: eax: 00000000   ebx: c1754228   ecx: 00000033   
edx: 00000032
Apr 29 17:38:01 hal9003 kernel: esi: c1754240   edi: c1bf0084   ebp: e09c5c18   
esp: e09c5bf0
Apr 29 17:38:01 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Apr 29 17:38:01 hal9003 kernel: Process sh (pid: 12878, threadinfo=e09c4000 
task=f1d52100)
Apr 29 17:38:01 hal9003 kernel: Stack: 00000000 00000000 f7ffd56c 00000001 
f7ffd574 c1bf0084 00000010 f19526b0
Apr 29 17:38:01 hal9003 kernel:        f7ffd560 00000246 e09c5c40 c0137898 
f7ffd560 000000d0 e09c5c50 c011783d
Apr 29 17:38:01 hal9003 kernel:        e0628000 f19526b0 00093000 f3dd4334 
e09c5c98 c013e7b7 f7ffd560 000000d0
Apr 29 17:38:01 hal9003 kernel: Call Trace:
Apr 29 17:38:01 hal9003 kernel:  [kmem_cache_alloc+317/324] 
kmem_cache_alloc+0x13d/0x144
Apr 29 17:38:01 hal9003 kernel:  [<c0137898>] kmem_cache_alloc+0x13d/0x144
Apr 29 17:38:01 hal9003 kernel:  [pte_alloc_one+96/145] 
pte_alloc_one+0x60/0x91
Apr 29 17:38:01 hal9003 kernel:  [<c011783d>] pte_alloc_one+0x60/0x91
Apr 29 17:38:01 hal9003 kernel:  [do_mmap_pgoff+602/1658] 
do_mmap_pgoff+0x25a/0x67a
Apr 29 17:38:01 hal9003 kernel:  [<c013e7b7>] do_mmap_pgoff+0x25a/0x67a
Apr 29 17:38:01 hal9003 kernel:  [elf_map+180/184] elf_map+0xb4/0xb8
Apr 29 17:38:01 hal9003 kernel:  [<c0168c2f>] elf_map+0xb4/0xb8
Apr 29 17:38:01 hal9003 kernel:  [load_elf_binary+1980/3112] 
load_elf_binary+0x7bc/0xc28
Apr 29 17:38:01 hal9003 kernel:  [<c0169762>] load_elf_binary+0x7bc/0xc28
Apr 29 17:38:01 hal9003 kernel:  [__alloc_pages+131/681] 
__alloc_pages+0x83/0x2a9
Apr 29 17:38:01 hal9003 kernel:  [<c0134518>] __alloc_pages+0x83/0x2a9
Apr 29 17:38:01 hal9003 kernel:  [copy_strings+443/559] 
copy_strings+0x1bb/0x22f
Apr 29 17:38:01 hal9003 kernel:  [<c0151048>] copy_strings+0x1bb/0x22f
Apr 29 17:38:01 hal9003 kernel:  [search_binary_handler+250/413] 
search_binary_handler+0xfa/0x19d
Apr 29 17:38:01 hal9003 kernel:  [<c0152037>] search_binary_handler+0xfa/0x19d
Apr 29 17:38:01 hal9003 kernel:  [do_execve+388/455] do_execve+0x184/0x1c7
Apr 29 17:38:01 hal9003 kernel:  [<c015225e>] do_execve+0x184/0x1c7
Apr 29 17:38:01 hal9003 kernel:  [sys_execve+75/122] sys_execve+0x4b/0x7a
Apr 29 17:38:01 hal9003 kernel:  [<c0107af2>] sys_execve+0x4b/0x7a
Apr 29 17:38:01 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 29 17:38:01 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
Apr 29 17:38:01 hal9003 kernel:
Apr 29 17:38:01 hal9003 kernel: Code: 0f 0b 1b 06 9b be 2b c0 e9 73 fe ff ff 
8b 7d 08 8b 57 38 e9
Apr 29 17:38:01 hal9003 kernel:  <3>drivers/usb/media/ov511.c: Invalid channel 
(-1)
Apr 29 17:38:01 hal9003 kernel: drivers/usb/media/ov511.c: Invalid channel 
(-1)
Apr 29 17:38:10 hal9003 last message repeated 36 times
Apr 29 17:38:10 hal9003 kernel: ------------[ cut here ]------------

Apr 29 17:38:10 hal9003 kernel: kernel BUG at mm/slab.c:1563!
Apr 29 17:38:10 hal9003 kernel: invalid operand: 0000 [#3]
Apr 29 17:38:10 hal9003 kernel: CPU:    0
Apr 29 17:38:10 hal9003 kernel: EIP:    0060:[cache_alloc_refill+533/616]    
Not tainted
Apr 29 17:38:10 hal9003 kernel: EIP:    0060:[<c0137478>]    Not tainted
Apr 29 17:38:10 hal9003 kernel: EFLAGS: 00010002
Apr 29 17:38:10 hal9003 kernel: EIP is at cache_alloc_refill+0x215/0x268
Apr 29 17:38:10 hal9003 kernel: eax: 00000000   ebx: c1754228   ecx: 00000033   
edx: 00000032
Apr 29 17:38:10 hal9003 kernel: esi: c1754240   edi: c1bf0084   ebp: f6497e98   
esp: f6497e70
Apr 29 17:38:10 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Apr 29 17:38:10 hal9003 kernel: Process httpd2 (pid: 1801, threadinfo=f6496000 
task=f6864c80)
Apr 29 17:38:10 hal9003 kernel: Stack: e1b903ac 3b388045 f7ffd56c 3b388045 
f7ffd574 c1bf0084 00000010 00000002
Apr 29 17:38:10 hal9003 kernel:        f7ffd560 00000246 f6497ec0 c0137898 
f7ffd560 000000d0 ec53d880 00016411
Apr 29 17:38:10 hal9003 kernel:        f6497ec0 00000002 f650e234 00000000 
f6497efc c011a813 f7ffd560 000000d0
Apr 29 17:38:10 hal9003 kernel: Call Trace:
Apr 29 17:38:10 hal9003 kernel:  [kmem_cache_alloc+317/324] 
kmem_cache_alloc+0x13d/0x144
Apr 29 17:38:10 hal9003 kernel:  [<c0137898>] kmem_cache_alloc+0x13d/0x144
Apr 29 17:38:10 hal9003 kernel:  [copy_mm+456/864] copy_mm+0x1c8/0x360
Apr 29 17:38:10 hal9003 kernel:  [<c011a813>] copy_mm+0x1c8/0x360
Apr 29 17:38:10 hal9003 kernel:  [copy_process+1173/2639] 
copy_process+0x495/0xa4f
Apr 29 17:38:10 hal9003 kernel:  [<c011b1c6>] copy_process+0x495/0xa4f
Apr 29 17:38:10 hal9003 kernel:  [do_pipe+380/492] do_pipe+0x17c/0x1ec
Apr 29 17:38:10 hal9003 kernel:  [<c0153583>] do_pipe+0x17c/0x1ec
Apr 29 17:38:10 hal9003 kernel:  [do_fork+77/340] do_fork+0x4d/0x154
Apr 29 17:38:10 hal9003 kernel:  [<c011b7cd>] do_fork+0x4d/0x154
Apr 29 17:38:10 hal9003 kernel:  [do_fcntl+180/399] do_fcntl+0xb4/0x18f
Apr 29 17:38:10 hal9003 kernel:  [<c0157410>] do_fcntl+0xb4/0x18f
Apr 29 17:38:10 hal9003 kernel:  [sys_fork+56/74] sys_fork+0x38/0x4a
Apr 29 17:38:10 hal9003 kernel:  [<c01079f1>] sys_fork+0x38/0x4a
Apr 29 17:38:10 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 29 17:38:10 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
Apr 29 17:38:10 hal9003 kernel:
Apr 29 17:38:10 hal9003 kernel: Code: 0f 0b 1b 06 9b be 2b c0 e9 73 fe ff ff 
8b 7d 08 8b 57 38 e9
Apr 29 17:38:10 hal9003 kernel:  <3>drivers/usb/media/ov511.c: Invalid channel 
(-1)
Apr 29 17:38:10 hal9003 kernel: drivers/usb/media/ov511.c: Invalid channel 
(-1)
Apr 29 17:38:23 hal9003 last message repeated 54 times
Apr 29 17:38:23 hal9003 kernel: ------------[ cut here ]------------
Apr 29 17:38:23 hal9003 kernel: kernel BUG at mm/slab.c:1563!
Apr 29 17:38:23 hal9003 kernel: invalid operand: 0000 [#4]
Apr 29 17:38:23 hal9003 kernel: CPU:    0
Apr 29 17:38:23 hal9003 kernel: EIP:    0060:[cache_alloc_refill+533/616]    
Not tainted
Apr 29 17:38:23 hal9003 kernel: EIP:    0060:[<c0137478>]    Not tainted
Apr 29 17:38:23 hal9003 kernel: EFLAGS: 00010002
Apr 29 17:38:23 hal9003 kernel: EIP is at cache_alloc_refill+0x215/0x268
Apr 29 17:38:23 hal9003 kernel: eax: 00000000   ebx: c1754228   ecx: 00000033   
edx: 00000032
Apr 29 17:38:23 hal9003 kernel: esi: c1754240   edi: c1bf0084   ebp: e38a9e98   
esp: e38a9e70
Apr 29 17:38:23 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Apr 29 17:38:23 hal9003 kernel: Process httpd2 (pid: 8615, threadinfo=e38a8000 
task=f5109300)
Apr 29 17:38:23 hal9003 kernel: Stack: f64b0e10 3b41f045 f7ffd56c 3b41f045 
f7ffd574 c1bf0084 00000010 00000001
Apr 29 17:38:23 hal9003 kernel:        f7ffd560 00000246 e38a9ec0 c0137898 
f7ffd560 000000d0 e2632780 00016458
Apr 29 17:38:23 hal9003 kernel:        e38a9ec0 00000001 e3f6ba84 00000000 
e38a9efc c011a813 f7ffd560 000000d0
Apr 29 17:38:23 hal9003 kernel: Call Trace:
Apr 29 17:38:23 hal9003 kernel:  [kmem_cache_alloc+317/324] 
kmem_cache_alloc+0x13d/0x144
Apr 29 17:38:23 hal9003 kernel:  [<c0137898>] kmem_cache_alloc+0x13d/0x144
Apr 29 17:38:23 hal9003 kernel:  [copy_mm+456/864] copy_mm+0x1c8/0x360
Apr 29 17:38:23 hal9003 kernel:  [<c011a813>] copy_mm+0x1c8/0x360
Apr 29 17:38:23 hal9003 kernel:  [copy_process+1173/2639] 
copy_process+0x495/0xa4f
Apr 29 17:38:23 hal9003 kernel:  [<c011b1c6>] copy_process+0x495/0xa4f
Apr 29 17:38:23 hal9003 kernel:  [do_pipe+380/492] do_pipe+0x17c/0x1ec
Apr 29 17:38:23 hal9003 kernel:  [<c0153583>] do_pipe+0x17c/0x1ec
Apr 29 17:38:23 hal9003 kernel:  [do_fork+77/340] do_fork+0x4d/0x154
Apr 29 17:38:23 hal9003 kernel:  [<c011b7cd>] do_fork+0x4d/0x154
Apr 29 17:38:23 hal9003 kernel:  [do_fcntl+180/399] do_fcntl+0xb4/0x18f
Apr 29 17:38:23 hal9003 kernel:  [<c0157410>] do_fcntl+0xb4/0x18f
Apr 29 17:38:23 hal9003 kernel:  [sys_fork+56/74] sys_fork+0x38/0x4a
Apr 29 17:38:23 hal9003 kernel:  [<c01079f1>] sys_fork+0x38/0x4a
Apr 29 17:38:23 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 29 17:38:23 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
Apr 29 17:38:23 hal9003 kernel:
Apr 29 17:38:23 hal9003 kernel: Code: 0f 0b 1b 06 9b be 2b c0 e9 73 fe ff ff 
8b 7d 08 8b 57 38 e9
Apr 29 17:38:24 hal9003 kernel:  <3>drivers/usb/media/ov511.c: Invalid channel 
(-1)
Apr 29 17:38:24 hal9003 kernel: drivers/usb/media/ov511.c: Invalid channel 
(-1)
Apr 29 17:38:32 hal9003 last message repeated 34 times
Apr 29 17:38:32 hal9003 kernel: ------------[ cut here ]------------
Apr 29 17:38:32 hal9003 kernel: kernel BUG at mm/slab.c:1563!
Apr 29 17:38:32 hal9003 kernel: invalid operand: 0000 [#5]
Apr 29 17:38:32 hal9003 kernel: CPU:    0
Apr 29 17:38:32 hal9003 kernel: EIP:    0060:[cache_alloc_refill+533/616]    
Not tainted
Apr 29 17:38:32 hal9003 kernel: EIP:    0060:[<c0137478>]    Not tainted
Apr 29 17:38:32 hal9003 kernel: EFLAGS: 00010002
Apr 29 17:38:32 hal9003 kernel: EIP is at cache_alloc_refill+0x215/0x268
Apr 29 17:38:32 hal9003 kernel: eax: 00000000   ebx: c1754228   ecx: 00000033   
edx: 00000032
Apr 29 17:38:32 hal9003 kernel: esi: c1754240   edi: c1bf0084   ebp: e9c8de98   
esp: e9c8de70
Apr 29 17:38:32 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Apr 29 17:38:32 hal9003 kernel: Process bash (pid: 12312, threadinfo=e9c8c000 
task=ef41f380)
Apr 29 17:38:32 hal9003 kernel: Stack: f1e9f60c 3fe15005 f7ffd56c 3fe15005 
f7ffd574 c1bf0084 00000010 00000001
Apr 29 17:38:32 hal9003 kernel:        f7ffd560 00000246 e9c8dec0 c0137898 
f7ffd560 000000d0 e3a54700 0001648c
Apr 29 17:38:32 hal9003 kernel:        e9c8dec0 00000001 e9f2a2cc 00000000 
e9c8defc c011a813 f7ffd560 000000d0
Apr 29 17:38:32 hal9003 kernel: Call Trace:
Apr 29 17:38:32 hal9003 kernel:  [kmem_cache_alloc+317/324] 
kmem_cache_alloc+0x13d/0x144
Apr 29 17:38:32 hal9003 kernel:  [<c0137898>] kmem_cache_alloc+0x13d/0x144
Apr 29 17:38:32 hal9003 kernel:  [copy_mm+456/864] copy_mm+0x1c8/0x360
Apr 29 17:38:32 hal9003 kernel:  [<c011a813>] copy_mm+0x1c8/0x360
Apr 29 17:38:32 hal9003 kernel:  [copy_process+1173/2639] 
copy_process+0x495/0xa4f
Apr 29 17:38:32 hal9003 kernel:  [<c011b1c6>] copy_process+0x495/0xa4f
Apr 29 17:38:32 hal9003 kernel:  [do_fork+77/340] do_fork+0x4d/0x154
Apr 29 17:38:32 hal9003 kernel:  [<c011b7cd>] do_fork+0x4d/0x154
Apr 29 17:38:32 hal9003 kernel:  [sigprocmask+77/174] sigprocmask+0x4d/0xae
Apr 29 17:38:32 hal9003 kernel:  [<c0125025>] sigprocmask+0x4d/0xae
Apr 29 17:38:32 hal9003 kernel:  [sys_rt_sigprocmask+206/285] 
sys_rt_sigprocmask+0xce/0x11d
Apr 29 17:38:32 hal9003 kernel:  [<c0125154>] sys_rt_sigprocmask+0xce/0x11d
Apr 29 17:38:32 hal9003 kernel:  [sys_fork+56/74] sys_fork+0x38/0x4a
Apr 29 17:38:32 hal9003 kernel:  [<c01079f1>] sys_fork+0x38/0x4a
Apr 29 17:38:32 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 29 17:38:32 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
Apr 29 17:38:32 hal9003 kernel:
Apr 29 17:38:32 hal9003 kernel: Code: 0f 0b 1b 06 9b be 2b c0 e9 73 fe ff ff 
8b 7d 08 8b 57 38 e9


and many many more  ...

