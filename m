Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbTBCVCU>; Mon, 3 Feb 2003 16:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTBCVCU>; Mon, 3 Feb 2003 16:02:20 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:23455 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S265532AbTBCVCS>;
	Mon, 3 Feb 2003 16:02:18 -0500
From: b_adlakha@softhome.net
To: linux-kernel@vger.kernel.org
Subject: [OOPS] kernel 2.5.59
Date: Mon, 03 Feb 2003 14:11:50 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [210.214.80.157]
Message-ID: <courier.3E3EDB16.00007614@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this each time I boot : 


Feb  3 02:34:38 localhost kernel:  printing eip:
Feb  3 02:34:38 localhost kernel: c012764a
Feb  3 02:34:38 localhost kernel: *pde = 00000000
Feb  3 02:34:38 localhost kernel: Oops: 0000
Feb  3 02:34:38 localhost kernel: CPU:    0
Feb  3 02:34:38 localhost kernel: EIP:    0060:[<c012764a>]    Not tainted
Feb  3 02:34:38 localhost kernel: EFLAGS: 00010093
Feb  3 02:34:38 localhost kernel: EIP is at __find_symbol+0x3e/0x84
Feb  3 02:34:38 localhost kernel: eax: c0354281   ebx: 000007c2   ecx: 
00000000   edx: c0412020
Feb  3 02:34:38 localhost kernel: esi: 40c0362e   edi: d0867190   ebp: 
cf7c5ec4   esp: cf7c5eb8
Feb  3 02:34:38 localhost kernel: ds: 007b   es: 007b   ss: 0068
Feb  3 02:34:38 localhost kernel: Process modprobe (pid: 42, 
threadinfo=cf7c4000 task=cf94b280)
Feb  3 02:34:38 localhost kernel: Stack: cf7c4000 d0866f14 d0867580 cf7c5ee8 
c012809f d0867190 cf7c5ee4 00000001
Feb  3 02:34:38 localhost kernel:        d0866cd4 d0866f14 0000004b 0000035c 
cf7c5f18 c01282de d0861f50 00000019
Feb  3 02:34:38 localhost kernel:        d0866f14 d0867190 d0867580 d0861f50 
0000000f d0867580 00000000 0000006f
Feb  3 02:34:38 localhost kernel: Call Trace:
Feb  3 02:34:38 localhost kernel:  [<c012809f>] resolve_symbol+0x2b/0x6c
Feb  3 02:34:38 localhost kernel:  [<c01282de>] simplify_symbols+0x7e/0xe4
Feb  3 02:34:38 localhost kernel:  [<c0128b44>] load_module+0x594/0x7ac
Feb  3 02:34:38 localhost kernel:  [<c0128dd1>] sys_init_module+0x75/0x1c8
Feb  3 02:34:38 localhost kernel:  [<c0108ca3>] syscall_call+0x7/0xb
Feb  3 02:34:38 localhost kernel:
Feb  3 02:34:38 localhost kernel: Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 
19 c0 0c 01 85 c0 75 12
Feb  3 02:34:38 localhost kernel:  <6>note: modprobe[42] exited with 
preempt_count 1
Feb  3 02:34:38 localhost kernel: Debug: sleeping function called from 
illegal context at include/asm/semaphore.h:119
Feb  3 02:34:38 localhost kernel: Call Trace:
Feb  3 02:34:38 localhost kernel:  [<c0117038>] __might_sleep+0x54/0x5c
Feb  3 02:34:38 localhost kernel:  [<c0136c5b>] 
remove_shared_vm_struct+0x2b/0x7c
Feb  3 02:34:38 localhost kernel:  [<c013808c>] exit_mmap+0x118/0x15c
Feb  3 02:34:38 localhost kernel:  [<c011750d>] mmput+0x55/0x70
Feb  3 02:34:38 localhost kernel:  [<c011aafb>] do_exit+0x157/0x3e0
Feb  3 02:34:38 localhost kernel:  [<c0109ba7>] die+0x73/0x74
Feb  3 02:34:38 localhost kernel:  [<c0114adc>] do_page_fault+0x2dc/0x40e
Feb  3 02:34:38 localhost kernel:  [<c0114800>] do_page_fault+0x0/0x40e
Feb  3 02:34:38 localhost kernel:  [<c01571b8>] update_atime+0x14/0x98
Feb  3 02:34:38 localhost kernel:  [<c012b68f>] 
do_generic_mapping_read+0x34b/0x358
Feb  3 02:34:38 localhost kernel:  [<c012b98b>] 
__generic_file_aio_read+0x1af/0x1cc
Feb  3 02:34:38 localhost kernel:  [<c012b6dc>] file_read_actor+0x0/0x100
Feb  3 02:34:38 localhost kernel:  [<c01096cd>] error_code+0x2d/0x38
Feb  3 02:34:38 localhost kernel:  [<c013007b>] kmem_cache_create+0xd3/0x454
Feb  3 02:34:38 localhost kernel:  [<c012764a>] __find_symbol+0x3e/0x84
Feb  3 02:34:38 localhost kernel:  [<c012809f>] resolve_symbol+0x2b/0x6c
Feb  3 02:34:38 localhost kernel:  [<c01282de>] simplify_symbols+0x7e/0xe4
Feb  3 02:34:38 localhost kernel:  [<c0128b44>] load_module+0x594/0x7ac
Feb  3 02:34:38 localhost kernel:  [<c0128dd1>] sys_init_module+0x75/0x1c8
Feb  3 02:34:38 localhost kernel:  [<c0108ca3>] syscall_call+0x7/0xb 

 

Also,
my modules.devfsd contains lines with "probeall" and I have no idea what 
probeall is, and modprobe gives an error at boot time like this: 

 

Feb  3 02:34:38 localhost modprobe: FATAL: Module /dev/midi* not found.
Feb  3 02:34:38 localhost modprobe: WARNING: /etc/modules.devfs line 26: 
ignoring bad line starting with 'probeall'
Feb  3 02:34:38 localhost modprobe: WARNING: /etc/modules.devfs line 30: 
ignoring bad line starting with 'probeall'
Feb  3 02:34:38 localhost modprobe: WARNING: /etc/modules.devfs line 35: 
ignoring bad line starting with 'probeall'
Feb  3 02:34:38 localhost modprobe: WARNING: /etc/modules.devfs line 39: 
ignoring bad line starting with 'probeall'
Feb  3 02:34:38 localhost modprobe: WARNING: /etc/modules.devfs line 42: 
ignoring bad line starting with 'probeall'
Feb  3 02:34:38 localhost modprobe: WARNING: /etc/modules.devfs line 48: 
ignoring bad line starting with 'probeall'
Feb  3 02:34:38 localhost modprobe: WARNING: /etc/modules.devfs line 52: 
ignoring bad line starting with 'probeall'
Feb  3 02:34:38 localhost modprobe: WARNING: /etc/modules.devfs line 57: 
ignoring bad line starting with 'probeall'
Feb  3 02:34:38 localhost modprobe: WARNING: /etc/modules.devfs line 62: 
ignoring bad line starting with 'probeall'
Feb  3 02:34:38 localhost modprobe: FATAL: Module /dev/sound not found. 

why does this happen only with the 2.5.59 kernel? 

Also, I cannot get pppd to run properly in 2.5.59, I have evrything compiled 
in the kernel (ppp_generic, ppp_async and compression stuff)
but ppp does with the following error :
"couldn't get tty to ppp discipline"
This happens only with the 2.5.59 kernel, not 2.4.20 (these are the only two 
I have)
what am I doing wrong? 

thnks for reading/replying... 
