Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbTH3Vst (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 17:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTH3Vst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 17:48:49 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:9932 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S262160AbTH3Vsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 17:48:40 -0400
Organization: 
Date: Sun, 31 Aug 2003 00:45:33 +0300 (EEST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: linux-kernel@vger.kernel.org
Subject: IOMEGA ZIP 100 ATAPI problems with 2.6
Message-ID: <Pine.GSO.4.53.0308310037230.27956@oneiro.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With all of the 2.5, 2.6 kernels I have tried(currently 2.6.0-test4-mm3),
I
have problems with my Zip.I can mount and umount it cleanly but when I try
to write something from it in my disk either cp will just
segfault or my system will just reboot. Also when I am in KDE it will
lockup my system and kernel reports the messages that are in the end of
the mail.
Also with hdparm -I /dev/hdd the kernel prints the following message:
hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdd: drive_cmd: error=0x04

P.S.
The Zip works with 2.4 kernels...

Regards
        Panagiotis Papadakos


Aug 30 23:34:37 Santorini kernel: EXT2-fs warning: mounting unchecked fs,
running e2fsck is recommended
Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry e0bdd5be
Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry d83246f2
Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 900f6684
Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry f8a0b9e2
Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 5034ad24
Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 10c94e23
Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 504d416e
Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry e0ad353f
Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap offset entry
00ddb4e2
Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry b8d54fef
Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 68983486
.                                                                       .
................... And much more of such messages ......................

And then:

Aug 30 23:37:56 Santorini kernel: Unable to handle kernel paging request
at virtual address 00200200
Aug 30 23:37:56 Santorini kernel:  printing eip:
Aug 30 23:37:56 Santorini kernel: c013c0ba
Aug 30 23:37:56 Santorini kernel: *pde = 00000000
Aug 30 23:37:56 Santorini kernel: Oops: 0000 [#1]
Aug 30 23:37:56 Santorini kernel: PREEMPT
Aug 30 23:37:56 Santorini kernel: CPU:    0
Aug 30 23:37:56 Santorini kernel: EIP:    0060:[<c013c0ba>]    Tainted: P
VLI
Aug 30 23:37:56 Santorini kernel: EFLAGS: 00210046
Aug 30 23:37:56 Santorini kernel: EIP is at free_pages_bulk+0x17a/0x280
Aug 30 23:37:56 Santorini kernel: eax: 00000000   ebx: c1054b28   ecx:
c1054b30   edx: 00200200
Aug 30 23:37:56 Santorini kernel: esi: 000011e0   edi: ffffffff   ebp:
000008f0   esp: dd281bc4
Aug 30 23:37:56 Santorini kernel: ds: 007b   es: 007b   ss: 0068
Aug 30 23:37:56 Santorini kernel: Process kdeinit (pid: 7874,
threadinfo=dd280000 task=dada7940)
Aug 30 23:37:56 Santorini kernel: Stack: c035eb74 c1054b00 c035ec34
00000000 00000001 c1054b00 c035ebb0 0000000d
Aug 30 23:37:56 Santorini kernel:        c1028000 c035ebb0 00200082
ffffffff c035eb74 c10bc2f0 dd280000 c035ec50
Aug 30 23:37:56 Santorini kernel:        c013c713 c035eb74 00000002
c035ec50 00000000 00200202 c035eb74 c257c4cc
Aug 30 23:37:56 Santorini kernel: Call Trace:
Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
free_hot_cold_page+0xf3/0x100
Aug 30 23:37:56 Santorini kernel:  [<c0144af7>]
clear_page_tables+0xb7/0xc0
Aug 30 23:37:56 Santorini kernel:  [<c01490c9>] exit_mmap+0xb9/0x1a0
Aug 30 23:37:56 Santorini kernel:  [<c011d269>] mmput+0x79/0xf0
Aug 30 23:37:56 Santorini kernel:  [<c015f751>] exec_mmap+0xb1/0x100
Aug 30 23:37:56 Santorini kernel:  [<c015f8cc>] flush_old_exec+0x12c/0x870
Aug 30 23:37:56 Santorini kernel:  [<c015f690>] kernel_read+0x50/0x60
Aug 30 23:37:56 Santorini kernel:  [<c017e3b0>]
load_elf_binary+0x2c0/0xb40
Aug 30 23:37:56 Santorini kernel:  [<c011cfa0>]
autoremove_wake_function+0x0/0x50
Aug 30 23:37:56 Santorini kernel:  [<c011d167>] mm_init+0x97/0xe0
Aug 30 23:37:56 Santorini kernel:  [<c015f1c2>] copy_strings+0x1e2/0x220
Aug 30 23:37:56 Santorini kernel:  [<c017e0f0>] load_elf_binary+0x0/0xb40
Aug 30 23:37:56 Santorini kernel:  [<c016040c>]
search_binary_handler+0x18c/0x2c0
Aug 30 23:37:56 Santorini kernel:  [<c0160747>] do_execve+0x207/0x280
Aug 30 23:37:56 Santorini kernel:  [<c0109a12>] sys_execve+0x42/0x80
Aug 30 23:37:56 Santorini kernel:  [<c0305f27>] syscall_call+0x7/0xb
Aug 30 23:37:56 Santorini kernel:
Aug 30 23:37:56 Santorini kernel: Code: ff 85 c0 0f 85 e9 00 00 00 8b 44
24 14 8b 54 24 44 89 44 24 04 89 14 24 e8 94 fd
ff ff 85 c0 0f 85 c0 00 00 00 8d 4b 08 8b 51 04 <39> 0a 0f 85 a5 00 00 00
8b 43 08 39 48 04 0f 85 8c 00 00 00 01
Aug 30 23:37:56 Santorini kernel:  <6>note: kdeinit[7874] exited with
preempt_count 3
Aug 30 23:37:56 Santorini kernel: ------------[ cut here ]------------
Aug 30 23:37:56 Santorini kernel: kernel BUG at include/linux/list.h:148!
Aug 30 23:37:56 Santorini kernel: invalid operand: 0000 [#2]
Aug 30 23:37:56 Santorini kernel: PREEMPT
Aug 30 23:37:56 Santorini kernel: CPU:    0
Aug 30 23:37:56 Santorini kernel: EIP:    0060:[<c013c167>]    Tainted: P
VLI
Aug 30 23:37:56 Santorini kernel: EFLAGS: 00010006
Aug 30 23:37:56 Santorini kernel: EIP is at free_pages_bulk+0x227/0x280
Aug 30 23:37:56 Santorini kernel: eax: 00000000   ebx: c128fac8   ecx:
c128fad0   edx: d0645000
Aug 30 23:37:56 Santorini kernel: esi: 0000f644   edi: ffffffff   ebp:
00007b22   esp: d0ba5e74
Aug 30 23:37:56 Santorini kernel: ds: 007b   es: 007b   ss: 0068
Aug 30 23:37:56 Santorini kernel: Process kdeinit (pid: 9173,
threadinfo=d0ba4000 task=d0bdad20)
Aug 30 23:37:56 Santorini kernel: Stack: c035eb74 c128faa0 c035ec34
00000000 00000001 c128faa0 c035ebb0 00000000
Aug 30 23:37:56 Santorini kernel:        c1028000 c035ebb0 00000086
ffffffff c035eb74 c149ead0 d0ba4000 c035ec50
Aug 30 23:37:56 Santorini kernel:        c013c713 c035eb74 0000000f
c035ec50 00000000 00000202 c035eb74 dd912008
Aug 30 23:37:56 Santorini kernel: Call Trace:
Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
free_hot_cold_page+0xf3/0x100
Aug 30 23:37:56 Santorini kernel:  [<c016751a>] poll_freewait+0x3a/0x50
Aug 30 23:37:56 Santorini kernel:  [<c0167897>] do_select+0x1b7/0x2d0
Aug 30 23:37:56 Santorini kernel:  [<c0167530>] __pollwait+0x0/0xd0
Aug 30 23:37:56 Santorini kernel:  [<c0167c9f>] sys_select+0x2bf/0x4c0
Aug 30 23:37:56 Santorini kernel:  [<c0305f27>] syscall_call+0x7/0xb
Aug 30 23:37:56 Santorini kernel:
Aug 30 23:37:56 Santorini kernel: Code: e0 ff 48 14 8b 40 08 a8 08 75 0c
8b 44 24 1c 83 c4 30 5b 5e 5f 5d c3 e8 48 f5 fd
ff eb ed 0f 0b 95 00 72 17 31 c0 e9 67 ff ff ff <0f> 0b 94 00 72 17 31 c0
e9 4e ff ff ff 0f 0b ca 00 58 e9 31 c0
Aug 30 23:37:56 Santorini kernel:  <6>note: kdeinit[9173] exited with
preempt_count 2
Aug 30 23:37:56 Santorini kernel: Unable to handle kernel paging request
at virtual address 00200200
Aug 30 23:37:56 Santorini kernel:  printing eip:
Aug 30 23:37:56 Santorini kernel: c013c0ba
Aug 30 23:37:56 Santorini kernel: *pde = 00000000
Aug 30 23:37:56 Santorini kernel: Oops: 0000 [#3]
Aug 30 23:37:56 Santorini kernel: PREEMPT
Aug 30 23:37:56 Santorini kernel: CPU:    0
Aug 30 23:37:56 Santorini kernel: EIP:    0060:[<c013c0ba>]    Tainted: P
VLI
Aug 30 23:37:56 Santorini kernel: EFLAGS: 00010046
Aug 30 23:37:56 Santorini kernel: EIP is at free_pages_bulk+0x17a/0x280
Aug 30 23:37:56 Santorini kernel: eax: 00000000   ebx: c14d8820   ecx:
c14d8828   edx: 00200200
Aug 30 23:37:56 Santorini kernel: esi: 0001e035   edi: ffffffff   ebp:
0000f01a   esp: d0ba5c0c
Aug 30 23:37:56 Santorini kernel: ds: 007b   es: 007b   ss: 0068
Aug 30 23:37:56 Santorini kernel: Process kdeinit (pid: 9173,
threadinfo=d0ba4000 task=d0bdad20)
Aug 30 23:37:56 Santorini kernel: Stack: c035eb74 c14d8848 c035ec34
00000000 00000001 c14d8848 c035ebb0 00000002
Aug 30 23:37:56 Santorini kernel:        c1028000 c035ebb0 00000086
ffffffff c035eb74 c12ad960 d0ba4000 c035ec50
Aug 30 23:37:56 Santorini kernel:        c013c713 c035eb74 0000000d
c035ec50 00000000 00000202 c035eb74 d123b148
Aug 30 23:37:56 Santorini kernel: Call Trace:
Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
free_hot_cold_page+0xf3/0x100
Aug 30 23:37:56 Santorini kernel:  [<c0145132>] zap_pte_range+0x142/0x180
Aug 30 23:37:56 Santorini kernel:  [<c01451bb>] zap_pmd_range+0x4b/0x70
Aug 30 23:37:56 Santorini kernel:  [<c0145223>] unmap_page_range+0x43/0x70
Aug 30 23:37:56 Santorini kernel:  [<c0145331>] unmap_vmas+0xe1/0x210
Aug 30 23:37:56 Santorini kernel:  [<c0149093>] exit_mmap+0x83/0x1a0
Aug 30 23:37:56 Santorini kernel:  [<c011d269>] mmput+0x79/0xf0
Aug 30 23:37:56 Santorini kernel:  [<c01214bc>] do_exit+0x12c/0x400
Aug 30 23:37:56 Santorini kernel:  [<c010b880>] do_invalid_op+0x0/0xd0
Aug 30 23:37:56 Santorini kernel:  [<c010b589>] die+0xf9/0x100
Aug 30 23:37:56 Santorini kernel:  [<c010b949>] do_invalid_op+0xc9/0xd0
Aug 30 23:37:56 Santorini kernel:  [<c013c167>]
free_pages_bulk+0x227/0x280
Aug 30 23:37:56 Santorini kernel:  [<c011ff3d>] profile_hook+0x2d/0x4b
Aug 30 23:37:56 Santorini kernel:  [<c01161ee>]
smp_apic_timer_interrupt+0x2e/0x100
Aug 30 23:37:56 Santorini kernel:  [<c03068b6>]
apic_timer_interrupt+0x1a/0x20
Aug 30 23:37:56 Santorini kernel:  [<c011ff3d>] profile_hook+0x2d/0x4b
Aug 30 23:37:56 Santorini kernel:  [<c0306933>] error_code+0x2f/0x38
Aug 30 23:37:56 Santorini kernel:  [<c013c167>]
free_pages_bulk+0x227/0x280
Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
free_hot_cold_page+0xf3/0x100
Aug 30 23:37:56 Santorini kernel:  [<c016751a>] poll_freewait+0x3a/0x50
Aug 30 23:37:56 Santorini kernel:  [<c0167897>] do_select+0x1b7/0x2d0
Aug 30 23:37:56 Santorini kernel:  [<c0167530>] __pollwait+0x0/0xd0
Aug 30 23:37:56 Santorini kernel:  [<c0167c9f>] sys_select+0x2bf/0x4c0
Aug 30 23:37:56 Santorini kernel:  [<c0305f27>] syscall_call+0x7/0xb
Aug 30 23:37:56 Santorini kernel:
Aug 30 23:37:56 Santorini kernel: Code: ff 85 c0 0f 85 e9 00 00 00 8b 44
24 14 8b 54 24 44 89 44 24 04 89 14 24 e8 94 fd
ff ff 85 c0 0f 85 c0 00 00 00 8d 4b 08 8b 51 04 <39> 0a 0f 85 a5 00 00 00
8b 43 08 39 48 04 0f 85 8c 00 00 00 01
Aug 30 23:37:56 Santorini kernel:  <6>note: kdeinit[9173] exited with
preempt_count 5
Aug 30 23:37:56 Santorini kernel: ------------[ cut here ]------------
Aug 30 23:37:56 Santorini kernel: kernel BUG at include/linux/list.h:148!
Aug 30 23:37:56 Santorini kernel: invalid operand: 0000 [#4]
Aug 30 23:37:56 Santorini kernel: PREEMPT
Aug 30 23:37:56 Santorini kernel: CPU:    0
Aug 30 23:37:56 Santorini kernel: EIP:    0060:[<c013c167>]    Tainted: P
VLI
Aug 30 23:37:56 Santorini kernel: EFLAGS: 00010002
Aug 30 23:37:56 Santorini kernel: EIP is at free_pages_bulk+0x227/0x280
Aug 30 23:37:56 Santorini kernel: eax: 00000000   ebx: c11e1608   ecx:
c11e1610   edx: c0b79d80
Aug 30 23:37:56 Santorini kernel: esi: 0000b08c   edi: ffffffff   ebp:
00005846   esp: d0ba59f4
Aug 30 23:37:56 Santorini kernel: ds: 007b   es: 007b   ss: 0068
Aug 30 23:37:56 Santorini kernel: Process kdeinit (pid: 9173,
threadinfo=d0ba4000 task=d0bdad20)
Aug 30 23:37:56 Santorini kernel: Stack: c035eb74 c11e15e0 c035ec34
00000000 00000001 c11e15e0 c035ebb0 00000004
Aug 30 23:37:56 Santorini kernel:        c1028000 c035ebb0 00000082
ffffffff c035eb74 c1278fd0 d0ba4000 c035ec50
Aug 30 23:37:56 Santorini kernel:        c013c713 c035eb74 0000000b
c035ec50 00000000 00000206 c035eb74 d3af6580
Aug 30 23:37:56 Santorini kernel: Call Trace:
Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
free_hot_cold_page+0xf3/0x100
Aug 30 23:37:56 Santorini kernel:  [<c01615f1>] pipe_release+0xc1/0xd0
Aug 30 23:37:56 Santorini kernel:  [<c01617c0>]
pipe_write_release+0x0/0x40
Aug 30 23:37:56 Santorini kernel:  [<c01617fb>]
pipe_write_release+0x3b/0x40
Aug 30 23:37:56 Santorini kernel:  [<c01551f8>] __fput+0x118/0x130
Aug 30 23:37:56 Santorini kernel:  [<c0153719>] filp_close+0x59/0x90
Aug 30 23:37:56 Santorini kernel:  [<c01208c4>] put_files_struct+0x54/0xc0
Aug 30 23:37:56 Santorini kernel:  [<c01214f7>] do_exit+0x167/0x400
Aug 30 23:37:56 Santorini kernel:  [<c01196e0>] do_page_fault+0x0/0x454
Aug 30 23:37:56 Santorini kernel:  [<c010b589>] die+0xf9/0x100
Aug 30 23:37:56 Santorini kernel:  [<c011980c>] do_page_fault+0x12c/0x454
Aug 30 23:37:56 Santorini kernel:  [<c025f316>] __ide_dma_begin+0x36/0x50
Aug 30 23:37:56 Santorini kernel:  [<c025f4c3>] __ide_dma_count+0x13/0x20
Aug 30 23:37:56 Santorini kernel:  [<c025f1f0>] __ide_dma_read+0xd0/0xe0
Aug 30 23:37:56 Santorini kernel:  [<c025e8d0>] ide_dma_intr+0x0/0xc0
Aug 30 23:37:56 Santorini kernel:  [<c025ee10>] dma_timer_expiry+0x0/0x90
Aug 30 23:37:56 Santorini kernel:  [<c024dcfd>] do_rw_taskfile+0x1bd/0x2b0
Aug 30 23:37:56 Santorini kernel:  [<c01196e0>] do_page_fault+0x0/0x454
Aug 30 23:37:56 Santorini kernel:  [<c0306933>] error_code+0x2f/0x38
Aug 30 23:37:56 Santorini kernel:  [<c013c0ba>]
free_pages_bulk+0x17a/0x280
Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
free_hot_cold_page+0xf3/0x100
Aug 30 23:37:56 Santorini kernel:  [<c0145132>] zap_pte_range+0x142/0x180
Aug 30 23:37:56 Santorini kernel:  [<c01451bb>] zap_pmd_range+0x4b/0x70
Aug 30 23:37:56 Santorini kernel:  [<c0145223>] unmap_page_range+0x43/0x70
Aug 30 23:37:56 Santorini kernel:  [<c0145331>] unmap_vmas+0xe1/0x210
Aug 30 23:37:56 Santorini kernel:  [<c0149093>] exit_mmap+0x83/0x1a0
Aug 30 23:37:56 Santorini kernel:  [<c011d269>] mmput+0x79/0xf0
Aug 30 23:37:56 Santorini kernel:  [<c01214bc>] do_exit+0x12c/0x400
Aug 30 23:37:56 Santorini kernel:  [<c010b880>] do_invalid_op+0x0/0xd0
Aug 30 23:37:56 Santorini kernel:  [<c010b589>] die+0xf9/0x100
Aug 30 23:37:56 Santorini kernel:  [<c010b949>] do_invalid_op+0xc9/0xd0
Aug 30 23:37:56 Santorini kernel:  [<c013c167>]
free_pages_bulk+0x227/0x280
Aug 30 23:37:56 Santorini kernel:  [<c011ff3d>] profile_hook+0x2d/0x4b
Aug 30 23:37:56 Santorini kernel:  [<c01161ee>]
smp_apic_timer_interrupt+0x2e/0x100
Aug 30 23:37:56 Santorini kernel:  [<c03068b6>]
apic_timer_interrupt+0x1a/0x20
Aug 30 23:37:56 Santorini kernel:  [<c011ff3d>] profile_hook+0x2d/0x4b
Aug 30 23:37:56 Santorini kernel:  [<c0306933>] error_code+0x2f/0x38
Aug 30 23:37:56 Santorini kernel:  [<c013c167>]
free_pages_bulk+0x227/0x280
Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
free_hot_cold_page+0xf3/0x100
Aug 30 23:37:56 Santorini kernel:  [<c016751a>] poll_freewait+0x3a/0x50
Aug 30 23:37:56 Santorini kernel:  [<c0167897>] do_select+0x1b7/0x2d0
Aug 30 23:37:56 Santorini kernel:  [<c0167530>] __pollwait+0x0/0xd0
Aug 30 23:37:56 Santorini kernel:  [<c0167c9f>] sys_select+0x2bf/0x4c0
Aug 30 23:37:56 Santorini kernel:  [<c0305f27>] syscall_call+0x7/0xb
Aug 30 23:37:56 Santorini kernel:
Aug 30 23:37:56 Santorini kernel: Code: e0 ff 48 14 8b 40 08 a8 08 75 0c
8b 44 24 1c 83 c4 30 5b 5e 5f 5d c3 e8 48 f5 fd
ff eb ed 0f 0b 95 00 72 17 31 c0 e9 67 ff ff ff <0f> 0b 94 00 72 17 31 c0
e9 4e ff ff ff 0f 0b ca 00 58 e9 31 c0
Aug 30 23:37:56 Santorini kernel:  <6>note: kdeinit[9173] exited with
preempt_count 7
Aug 30 23:37:56 Santorini kernel: Unable to handle kernel paging request
at virtual address 00200200
Aug 30 23:37:56 Santorini kernel:  printing eip:
Aug 30 23:37:56 Santorini kernel: c013c0ba
Aug 30 23:37:56 Santorini kernel: *pde = 00000000
Aug 30 23:37:56 Santorini kernel: Oops: 0000 [#5]
Aug 30 23:37:56 Santorini kernel: PREEMPT
Aug 30 23:37:56 Santorini kernel: CPU:    0
Aug 30 23:37:56 Santorini kernel: EIP:    0060:[<c013c0ba>]    Tainted: P
VLI
Aug 30 23:37:56 Santorini kernel: EFLAGS: 00010046
Aug 30 23:37:56 Santorini kernel: EIP is at free_pages_bulk+0x17a/0x280
Aug 30 23:37:56 Santorini kernel: eax: 00000000   ebx: c1470810   ecx:
c1470818   edx: 00200200
Aug 30 23:37:56 Santorini kernel: esi: 0001b69b   edi: ffffffff   ebp:
0000db4d   esp: d0b45e74
Aug 30 23:37:56 Santorini kernel: ds: 007b   es: 007b   ss: 0068
Aug 30 23:37:56 Santorini kernel: Process artsd (pid: 9178,
threadinfo=d0b44000 task=d0bdb350)
Aug 30 23:37:56 Santorini kernel: Stack: c035eb74 c1470838 c035ec34
00000000 00000001 c1470838 c035ebb0 00000001
Aug 30 23:37:56 Santorini kernel:        c1028000 c035ebb0 00000086
ffffffff c035eb74 c1343d70 d0b44000 c035ec50
Aug 30 23:37:56 Santorini kernel:        c013c713 c035eb74 0000000e
c035ec50 00000000 00000202 c035eb74 d4e56008
Aug 30 23:37:56 Santorini kernel: Call Trace:
Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
free_hot_cold_page+0xf3/0x100
Aug 30 23:37:57 Santorini kernel:  [<c016751a>] poll_freewait+0x3a/0x50
Aug 30 23:37:57 Santorini kernel:  [<c0167897>] do_select+0x1b7/0x2d0
Aug 30 23:37:57 Santorini kernel:  [<c0167530>] __pollwait+0x0/0xd0
Aug 30 23:37:57 Santorini kernel:  [<c0167c9f>] sys_select+0x2bf/0x4c0
Aug 30 23:37:57 Santorini kernel:  [<c0305f27>] syscall_call+0x7/0xb
Aug 30 23:37:57 Santorini kernel:
Aug 30 23:37:57 Santorini kernel: Code: ff 85 c0 0f 85 e9 00 00 00 8b 44
24 14 8b 54 24 44 89 44 24 04 89 14 24 e8 94 fd
ff ff 85 c0 0f 85 c0 00 00 00 8d 4b 08 8b 51 04 <39> 0a 0f 85 a5 00 00 00
8b 43 08 39 48 04 0f 85 8c 00 00 00 01
Aug 30 23:37:57 Santorini kernel:  <6>note: artsd[9178] exited with
preempt_count 2

Aug 30 23:37:57 Santorini kernel: ------------[ cut here ]------------
Aug 30 23:37:57 Santorini kernel: kernel BUG at include/linux/list.h:148!
Aug 30 23:37:57 Santorini kernel: invalid operand: 0000 [#6]
Aug 30 23:37:57 Santorini kernel: PREEMPT
Aug 30 23:37:57 Santorini kernel: CPU:    0
Aug 30 23:37:57 Santorini kernel: EIP:    0060:[<c013c167>]    Tainted: P
VLI
Aug 30 23:37:57 Santorini kernel: EFLAGS: 00210016
Aug 30 23:37:57 Santorini kernel: EIP is at free_pages_bulk+0x227/0x280
Aug 30 23:37:57 Santorini kernel: eax: 00000000   ebx: c13955d0   ecx:
c13955d8   edx: c10da398
Aug 30 23:37:57 Santorini kernel: esi: 00015ef0   edi: fffffffe   ebp:
000057bc   esp: d68f3e3c
Aug 30 23:37:57 Santorini kernel: ds: 007b   es: 007b   ss: 0068
Aug 30 23:37:57 Santorini kernel: Process kdeinit (pid: 3095,
threadinfo=d68f2000 task=c2850670)
Aug 30 23:37:57 Santorini kernel: Stack: c035eb74 c1395580 c035ec34
00000000 00000001 c1395580 c035ebbc 00000009
Aug 30 23:37:57 Santorini kernel:        c1028000 c035ebb0 00200086
ffffffff c035eb74 c1140460 d68f2000 c035ec50
Aug 30 23:37:57 Santorini kernel:        c013c713 c035eb74 00000006
c035ec50 00000000 00200202 c035eb74 c4346f58
Aug 30 23:37:57 Santorini kernel: Call Trace:
Aug 30 23:37:57 Santorini kernel:  [<c013c713>]
free_hot_cold_page+0xf3/0x100
Aug 30 23:37:57 Santorini kernel:  [<c0145132>] zap_pte_range+0x142/0x180
Aug 30 23:37:57 Santorini kernel:  [<c0145eff>] do_wp_page+0x2af/0x300
Aug 30 23:37:57 Santorini kernel:  [<c01451bb>] zap_pmd_range+0x4b/0x70
Aug 30 23:37:57 Santorini kernel:  [<c0145223>] unmap_page_range+0x43/0x70
Aug 30 23:37:57 Santorini kernel:  [<c0145331>] unmap_vmas+0xe1/0x210
Aug 30 23:37:57 Santorini kernel:  [<c0149093>] exit_mmap+0x83/0x1a0
Aug 30 23:37:57 Santorini kernel:  [<c011d269>] mmput+0x79/0xf0
Aug 30 23:37:57 Santorini kernel:  [<c01214bc>] do_exit+0x12c/0x400
Aug 30 23:37:57 Santorini kernel:  [<c011b6f0>]
default_wake_function+0x0/0x30
Aug 30 23:37:57 Santorini kernel:  [<c012182a>] do_group_exit+0x3a/0xb0
Aug 30 23:37:57 Santorini kernel:  [<c0305f27>] syscall_call+0x7/0xb
Aug 30 23:37:57 Santorini kernel:
Aug 30 23:37:57 Santorini kernel: Code: e0 ff 48 14 8b 40 08 a8 08 75 0c
8b 44 24 1c 83 c4 30 5b 5e 5f 5d c3 e8 48 f5 fd
ff eb ed 0f 0b 95 00 72 17 31 c0 e9 67 ff ff ff <0f> 0b 94 00 72 17 31 c0
e9 4e ff ff ff 0f 0b ca 00 58 e9 31 c0
Aug 30 23:37:57 Santorini kernel:  <6>note: kdeinit[3095] exited with
preempt_count 3

