Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265500AbUFONDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUFONDJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUFONDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:03:09 -0400
Received: from smtp2.libero.it ([193.70.192.52]:14054 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S265500AbUFONC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:02:57 -0400
From: "Mario ''Jorge'' Di Nitto" <jorge78@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: [BUG] & [BADNESS] 2.6.7-rc3-mm2
Date: Tue, 15 Jun 2004 12:56:35 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406151256.35621.jorge78@inwind.it>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all.
Yesterday I've updated to 2.6.7-rc3-mm2, and after a reboot, I got this:

[cut]

Jun 15 12:28:02 D998 kernel: slamr: SmartLink AMRMO modem.
Jun 15 12:28:02 D998 kernel: slamr: probe 1039:7013 SiS630 card...
Jun 15 12:28:02 D998 kernel: ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 5 
(level, low) -> IRQ 5
Jun 15 12:28:02 D998 kernel: slamr: probe of 0000:00:02.6 failed with error 
-12
Jun 15 12:28:02 D998 kernel: Badness in __vunmap at mm/vmalloc.c:294
Jun 15 12:28:02 D998 kernel:  [sys_init_module+372/595] 
sys_init_module+0x174/0x253
Jun 15 12:28:02 D998 kernel:  [filp_close+79/122] filp_close+0x4f/0x7a
Jun 15 12:28:02 D998 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 15 12:28:02 D998 kernel: 
Jun 15 12:28:06 D998 xfs: ignoring font path 
element /usr/lib/X11/fonts/cyrillic/ (unreadable) 
Jun 15 12:28:06 D998 xfs: ignoring font path element /usr/lib/X11/fonts/CID 
(unreadable) 
Jun 15 12:28:14 D998 kernel: Badness in map_area_pte at mm/vmalloc.c:100
Jun 15 12:28:14 D998 kernel:  [map_area_pte+146/148] map_area_pte+0x92/0x94
Jun 15 12:28:14 D998 kernel:  [map_area_pmd+92/132] map_area_pmd+0x5c/0x84
Jun 15 12:28:14 D998 kernel:  [map_vm_area+87/161] map_vm_area+0x57/0xa1
Jun 15 12:28:14 D998 kernel:  [__vmalloc+203/250] __vmalloc+0xcb/0xfa
Jun 15 12:28:14 D998 kernel:  [ipc_rcu_alloc+19/55] ipc_rcu_alloc+0x13/0x37
Jun 15 12:28:14 D998 kernel:  [grow_ary+74/161] grow_ary+0x4a/0xa1
Jun 15 12:28:14 D998 kernel:  [ipc_addid+19/158] ipc_addid+0x13/0x9e
Jun 15 12:28:14 D998 kernel:  [newseg+181/409] newseg+0xb5/0x199
Jun 15 12:28:14 D998 kernel:  [sys_shmget+75/277] sys_shmget+0x4b/0x115
Jun 15 12:28:14 D998 kernel:  [sys_ipc+618/656] sys_ipc+0x26a/0x290
Jun 15 12:28:14 D998 kernel:  [do_page_fault+0/1307] do_page_fault+0x0/0x51b
Jun 15 12:28:14 D998 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 15 12:28:14 D998 kernel: 
Jun 15 12:28:14 D998 kernel: Badness in map_area_pte at mm/vmalloc.c:100
Jun 15 12:28:14 D998 kernel:  [map_area_pte+146/148] map_area_pte+0x92/0x94
Jun 15 12:28:14 D998 kernel:  [map_area_pmd+92/132] map_area_pmd+0x5c/0x84
Jun 15 12:28:14 D998 kernel:  [map_vm_area+87/161] map_vm_area+0x57/0xa1
Jun 15 12:28:14 D998 kernel:  [__vmalloc+203/250] __vmalloc+0xcb/0xfa
Jun 15 12:28:14 D998 kernel:  [ipc_rcu_alloc+19/55] ipc_rcu_alloc+0x13/0x37
Jun 15 12:28:14 D998 kernel:  [grow_ary+74/161] grow_ary+0x4a/0xa1
Jun 15 12:28:14 D998 kernel:  [ipc_addid+19/158] ipc_addid+0x13/0x9e
Jun 15 12:28:14 D998 kernel:  [newseg+181/409] newseg+0xb5/0x199
Jun 15 12:28:14 D998 kernel:  [sys_shmget+75/277] sys_shmget+0x4b/0x115
Jun 15 12:28:14 D998 kernel:  [sys_ipc+618/656] sys_ipc+0x26a/0x290
Jun 15 12:28:14 D998 kernel:  [do_page_fault+0/1307] do_page_fault+0x0/0x51b
Jun 15 12:28:14 D998 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 15 12:28:14 D998 kernel: 
Jun 15 12:28:14 D998 kernel: Badness in map_area_pte at mm/vmalloc.c:100
Jun 15 12:28:14 D998 kernel:  [map_area_pte+146/148] map_area_pte+0x92/0x94
Jun 15 12:28:14 D998 kernel:  [map_area_pmd+92/132] map_area_pmd+0x5c/0x84
Jun 15 12:28:14 D998 kernel:  [map_vm_area+87/161] map_vm_area+0x57/0xa1
Jun 15 12:28:14 D998 kernel:  [__vmalloc+203/250] __vmalloc+0xcb/0xfa
Jun 15 12:28:14 D998 kernel:  [ipc_rcu_alloc+19/55] ipc_rcu_alloc+0x13/0x37
Jun 15 12:28:14 D998 kernel:  [grow_ary+74/161] grow_ary+0x4a/0xa1
Jun 15 12:28:14 D998 kernel:  [ipc_addid+19/158] ipc_addid+0x13/0x9e
Jun 15 12:28:14 D998 kernel:  [newseg+181/409] newseg+0xb5/0x199
Jun 15 12:28:14 D998 kernel:  [sys_shmget+75/277] sys_shmget+0x4b/0x115
Jun 15 12:28:14 D998 kernel:  [sys_ipc+618/656] sys_ipc+0x26a/0x290
Jun 15 12:28:14 D998 kernel:  [do_page_fault+0/1307] do_page_fault+0x0/0x51b
Jun 15 12:28:14 D998 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 15 12:28:14 D998 kernel: 
Jun 15 12:28:14 D998 kernel: Badness in map_area_pte at mm/vmalloc.c:100
Jun 15 12:28:14 D998 kernel:  [map_area_pte+146/148] map_area_pte+0x92/0x94
Jun 15 12:28:14 D998 kernel:  [map_area_pmd+92/132] map_area_pmd+0x5c/0x84
Jun 15 12:28:14 D998 kernel:  [map_vm_area+87/161] map_vm_area+0x57/0xa1
Jun 15 12:28:14 D998 kernel:  [__vmalloc+203/250] __vmalloc+0xcb/0xfa
Jun 15 12:28:14 D998 kernel:  [ipc_rcu_alloc+19/55] ipc_rcu_alloc+0x13/0x37
Jun 15 12:28:14 D998 kernel:  [grow_ary+74/161] grow_ary+0x4a/0xa1
Jun 15 12:28:14 D998 kernel:  [ipc_addid+19/158] ipc_addid+0x13/0x9e
Jun 15 12:28:14 D998 kernel:  [newseg+181/409] newseg+0xb5/0x199
Jun 15 12:28:14 D998 kernel:  [sys_shmget+75/277] sys_shmget+0x4b/0x115
Jun 15 12:28:14 D998 kernel:  [sys_ipc+618/656] sys_ipc+0x26a/0x290
Jun 15 12:28:14 D998 kernel:  [do_page_fault+0/1307] do_page_fault+0x0/0x51b
Jun 15 12:28:14 D998 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 15 12:28:14 D998 kernel: 
Jun 15 12:28:15 D998 kernel: e0bba23a
Jun 15 12:28:15 D998 kernel: PREEMPT 
Jun 15 12:28:15 D998 kernel: Modules linked in: slamr snd_intel8x0 
snd_ac97_codec gameport snd_mpu401_uart snd_rawmidi uinput i2c_sis96x 
i2c_sensor thermal processor fan button battery ac msr microcode cpuid evdev
Jun 15 12:28:15 D998 kernel: CPU:    0
Jun 15 12:28:15 D998 kernel: EIP:    0060:[pg0+543695418/1068261376]    
Tainted: P   VLI
Jun 15 12:28:15 D998 kernel: EFLAGS: 00010212   (2.6.7-rc3-mm2) 
Jun 15 12:28:15 D998 kernel: EIP is at 0xe0bba23a
Jun 15 12:28:15 D998 kernel: eax: 007659e6   ebx: 00008008   ecx: 0076535a   
edx: 00008008
Jun 15 12:28:15 D998 kernel: esi: c14e26b0   edi: c0503120   ebp: c14e2600   
esp: c04cffc8
Jun 15 12:28:15 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jun 15 12:28:15 D998 kernel: Process swapper (pid: 0, threadinfo=c04cf000 
task=c0427a40)
Jun 15 12:28:15 D998 kernel: Stack: 0009e700 00000001 c04cf000 0009e700 
c0503120 0055a007 c010409b 0001080e 
Jun 15 12:28:15 D998 kernel:        c04d06a6 00000047 c04d030b 00000000 
c0504360 c010019f 
Jun 15 12:28:15 D998 kernel: Call Trace:
Jun 15 12:28:15 D998 kernel:  [cpu_idle+44/53] cpu_idle+0x2c/0x35
Jun 15 12:28:15 D998 kernel:  [start_kernel+371/431] start_kernel+0x173/0x1af
Jun 15 12:28:15 D998 kernel:  [unknown_bootoption+0/324] 
unknown_bootoption+0x0/0x144
Jun 15 12:28:15 D998 kernel: 
Jun 15 12:28:15 D998 kernel: Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
Jun 15 12:28:15 D998 kernel:  <0>Kernel panic: Attempted to kill the idle 
task!

------------------------------------------------------------------------------------------------------------

Ksymoops output:

D998:/home/io# ksymoops -m /boot/System.map-2.6.7-rc3-mm2 <error2.txt
ksymoops 2.4.9 on i686 2.6.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.6/ (default)
     -m /boot/System.map-2.6.7-rc3-mm2 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jun 15 12:28:02 D998 kernel: cs: IO port probe 0x0100-0x04ff: excluding 
0x200-0x20f 0x378-0x37f 0x480-0x48f
Jun 15 12:28:02 D998 kernel: cs: IO port probe 0x0800-0x08ff: clean.
Jun 15 12:28:02 D998 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jun 15 12:28:02 D998 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jun 15 12:28:15 D998 kernel: e0bba23a
Jun 15 12:28:15 D998 kernel: CPU:    0
Jun 15 12:28:15 D998 kernel: EIP:    0060:[pg0+543695418/1068261376]    
Tainted: P   VLI
Jun 15 12:28:15 D998 kernel: EFLAGS: 00010212   (2.6.7-rc3-mm2)
Jun 15 12:28:15 D998 kernel: eax: 007659e6   ebx: 00008008   ecx: 0076535a   
edx: 00008008
Jun 15 12:28:15 D998 kernel: esi: c14e26b0   edi: c0503120   ebp: c14e2600   
esp: c04cffc8
Jun 15 12:28:15 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jun 15 12:28:15 D998 kernel: Stack: 0009e700 00000001 c04cf000 0009e700 
c0503120 0055a007 c010409b 0001080e
Jun 15 12:28:15 D998 kernel:        c04d06a6 00000047 c04d030b 00000000 
c0504360 c010019f
Jun 15 12:28:15 D998 kernel: Call Trace:
Jun 15 12:28:15 D998 kernel: Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Using defaults from ksymoops -t elf32-i386 -a i386


>>esi; c14e26b0 <pg0+faa6b0/3fac6000>
>>edi; c0503120 <late_time_init+0/4>
>>ebp; c14e2600 <pg0+faa600/3fac6000>
>>esp; c04cffc8 <init_thread_union+fc8/1000>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:

Jun 15 12:28:15 D998 kernel:  <0>Kernel panic: Attempted to kill the idle 
task!

1 error issued.  Results may not be reliable.

TIA,
						Jorge

-- 
Il reggiseno e' uno strumento democratico perche' separa la destra dalla
sinistra, solleva le masse e attira i popoli.
