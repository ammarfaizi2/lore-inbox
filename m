Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbUK0Djt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbUK0Djt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUK0Dj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:39:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17604 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262601AbUKZTgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:36:15 -0500
Subject: An oops on a HP DL380 with kernel 2.6.5
To: linux-kernel@vger.kernel.org, paul.vogt@versatel.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DMW.Boundary.605592468"
From: root <root@hercules.unix.versatel.com>
Message-Id: <E1CXcrT-0007UF-00@hercules.versatel.com>
Date: Fri, 26 Nov 2004 10:57:55 +0100
X-OriginalArrivalTime: 26 Nov 2004 09:57:01.0792 (UTC) FILETIME=[46B72E00:01C4D39E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Mime message, which your mail program may not understand. Parts
of the message will appear as text. If the remainder appears as random
characters in the message body, instead of as attachments, then you'll
have to extract these parts and decode them manually.

--DMW.Boundary.605592468
Content-Type: text/plain; name="message.txt"; charset=US-ASCII
Content-Disposition: inline; filename="message.txt"
Content-Transfer-Encoding: 7bit

Hello

Yesterday one of our servers crashed with an oops (syslog attached). It is running kernel 2.6.5 so I don't know if the error is interesting but I thought I send it anyway and let you decide. The server has 2 CPU's and 6 Gb of memory. Still 
the application manages to use 800Mb of swap in addition.
I have included the .config file used to build the kernel.

best regards, Paul Vogt
--DMW.Boundary.605592468
Content-Type: application/octet-stream; name="oops.txt"
Content-Disposition: attachment; filename="oops.txt"
Content-Transfer-Encoding: 7bit

Nov 25 01:16:01 hercules kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Nov 25 01:16:01 hercules kernel:  printing eip:
Nov 25 01:16:01 hercules kernel: c01270c2
Nov 25 01:16:01 hercules kernel: *pde = 2285d001
Nov 25 01:16:01 hercules kernel: *pte = 00000000
Nov 25 01:16:01 hercules kernel: Oops: 0000 [#2]
Nov 25 01:16:01 hercules kernel: SMP 
Nov 25 01:16:01 hercules kernel: CPU:    2
Nov 25 01:16:01 hercules kernel: EIP:    0060:[groups_search+86/120]    Not tainted
Nov 25 01:16:01 hercules kernel: EFLAGS: 00010246   (2.6.5) 
Nov 25 01:16:01 hercules kernel: EIP is at groups_search+0x56/0x78
Nov 25 01:16:01 hercules kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
Nov 25 01:16:01 hercules kernel: esi: 00000001   edi: 00000000   ebp: e069480c   esp: d1addecc
Nov 25 01:16:01 hercules kernel: ds: 007b   es: 007b   ss: 0068
Nov 25 01:16:01 hercules kernel: Process sh (pid: 22945, threadinfo=d1adc000 task=e31a79c0)
Nov 25 01:16:01 hercules kernel: Stack: d1adc000 00000001 d1d88000 d1addf24 c0127271 e0694780 00000000 000041ed 
Nov 25 01:16:01 hercules kernel:        c4f8fb14 c0156c59 00000000 00000101 d1addf80 d1d88000 d1addf80 00000101 
Nov 25 01:16:01 hercules kernel:        d1d88001 40197110 00000004 c0114238 bfffcad0 400cfad0 00000001 c0157021 
Nov 25 01:16:01 hercules kernel: Call Trace:
Nov 25 01:16:01 hercules kernel:  [in_group_p+53/108] in_group_p+0x35/0x6c
Nov 25 01:16:01 hercules kernel:  [link_path_walk+1997/2148] link_path_walk+0x7cd/0x864
Nov 25 01:16:01 hercules kernel:  [do_page_fault+0/1344] do_page_fault+0x0/0x540
Nov 25 01:16:01 hercules kernel:  [path_lookup+341/348] <1>Unable to handle kernel paging requestpath_lookup+0x155/0x15c
Nov 25 01:16:01 hercules kernel:  [open_namei+150/976]  at virtual address 080d65ac
Nov 25 01:16:01 hercules kernel:  printing eip:
Nov 25 01:16:01 hercules kernel: c01270c2
Nov 25 01:16:01 hercules kernel: *pde = 09494001
Nov 25 01:16:01 hercules kernel: *pte = 00000000
Nov 25 01:16:01 hercules kernel: open_namei+0x96/0x3d0
Nov 25 01:16:01 hercules kernel:  [filp_open+59/92] filp_open+0x3b/0x5c
Nov 25 01:16:01 hercules kernel:  [sys_open+55/116] sys_open+0x37/0x74
Nov 25 01:16:01 hercules kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 25 01:16:01 hercules kernel: 
Nov 25 01:16:01 hercules kernel: Code: 2b 14 88 85 d2 7e 07 8d 7b 01 eb 08 89 f6 85 d2 7d ac 89 de 
Nov 25 01:16:01 hercules kernel:  Oops: 0000 [#3]
Nov 25 01:16:01 hercules kernel: SMP 
Nov 25 01:16:01 hercules kernel: CPU:    1
Nov 25 01:16:01 hercules kernel: EIP:    0060:[groups_search+86/120]    Not tainted
Nov 25 01:16:01 hercules kernel: EFLAGS: 00010206   (2.6.5) 
Nov 25 01:16:01 hercules kernel: EIP is at groups_search+0x56/0x78
Nov 25 01:16:01 hercules kernel: eax: 080d65a0   ebx: 00000003   ecx: 00000003   edx: 00000000
Nov 25 01:16:01 hercules kernel: esi: 00000006   edi: 00000000   ebp: e069480c   esp: f1db5c84
Nov 25 01:16:01 hercules kernel: ds: 007b   es: 007b   ss: 0068
Nov 25 01:16:01 hercules kernel: Process cron (pid: 22950, threadinfo=f1db4000 task=d663b410)
Nov 25 01:16:01 hercules kernel: Stack: f1db4000 00000001 d577f340 f1db5cdc c0127271 e0694780 00000000 000041ed 
Nov 25 01:16:01 hercules kernel:        c4f8fb14 c0156c59 00000000 f1db5d04 f1db5d04 d577f340 f1db5d04 00000101 
Nov 25 01:16:01 hercules kernel:        d577f341 f1db5e18 00000080 c014a79c 00000013 c014a7c1 00000013 c0157021 
Nov 25 01:16:01 hercules kernel: Call Trace:
Nov 25 01:16:01 hercules kernel:  [in_group_p+53/108] in_group_p+0x35/0x6c
Nov 25 01:16:01 hercules kernel:  [link_path_walk+1997/2148] link_path_walk+0x7cd/0x864
Nov 25 01:16:01 hercules kernel:  [vfs_read+156/204] vfs_read+0x9c/0xcc
Nov 25 01:16:01 hercules kernel:  [vfs_read+193/204] vfs_read+0xc1/0xcc
Nov 25 01:16:01 hercules kernel:  [path_lookup+341/348] path_lookup+0x155/0x15c
Nov 25 01:16:01 hercules kernel:  [open_exec+35/192] open_exec+0x23/0xc0
Nov 25 01:16:01 hercules kernel:  [load_elf_binary+735/2776] load_elf_binary+0x2df/0xad8
Nov 25 01:16:01 hercules kernel:  [kmap_high+329/396] kmap_high+0x149/0x18c
Nov 25 01:16:01 hercules kernel:  [page_address+51/128] page_address+0x33/0x80
Nov 25 01:16:01 hercules kernel:  [kmap_high+28/396] kmap_high+0x1c/0x18c
Nov 25 01:16:01 hercules kernel:  [kunmap_high+21/140] kunmap_high+0x15/0x8c
Nov 25 01:16:01 hercules kernel:  [page_address+51/128] page_address+0x33/0x80
Nov 25 01:16:01 hercules kernel:  [search_binary_handler+129/404] search_binary_handler+0x81/0x194
Nov 25 01:16:01 hercules kernel:  [do_execve+417/528] do_execve+0x1a1/0x210
Nov 25 01:16:01 hercules kernel:  [sys_execve+47/108] sys_execve+0x2f/0x6c
Nov 25 01:16:01 hercules kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 25 01:16:01 hercules kernel: 
Nov 25 01:16:01 hercules kernel: Code: 2b 14 88 85 d2 7e 07 8d 7b 01 eb 08 89 f6 85 d2 7d ac 89 de 
Nov 25 01:16:01 hercules kernel:  <1>Unable to handle kernel paging request at virtual address 080d65ac
Nov 25 01:16:01 hercules kernel:  printing eip:
Nov 25 01:16:01 hercules kernel: c01270c2
Nov 25 01:16:01 hercules kernel: *pde = 0efed001
Nov 25 01:16:01 hercules kernel: *pte = 00000000
Nov 25 01:16:01 hercules kernel: Oops: 0000 [#4]
Nov 25 01:16:01 hercules kernel: SMP 
Nov 25 01:16:01 hercules kernel: CPU:    1
Nov 25 01:16:01 hercules kernel: EIP:    0060:[groups_search+86/120]    Not tainted
Nov 25 01:16:01 hercules kernel: EFLAGS: 00010206   (2.6.5) 
Nov 25 01:16:01 hercules kernel: EIP is at groups_search+0x56/0x78
Nov 25 01:16:01 hercules kernel: eax: 080d65a0   ebx: 00000003   ecx: 00000003   edx: 00000000
Nov 25 01:16:01 hercules kernel: esi: 00000006   edi: 00000000   ebp: e069480c   esp: de187c84
Nov 25 01:16:01 hercules kernel: ds: 007b   es: 007b   ss: 0068
Nov 25 01:16:01 hercules kernel: Process cron (pid: 22952, threadinfo=de186000 task=eb9f0e60)
Nov 25 01:16:01 hercules kernel: Stack: de186000 00000001 d577fa80 de187cdc c0127271 e0694780 00000000 000041ed 
Nov 25 01:16:01 hercules kernel:        c4f8fb14 c0156c59 00000000 de187d04 de187d04 d577fa80 de187d04 00000101 
Nov 25 01:16:01 hercules kernel:        d577fa81 de187e18 00000080 c014a79c 00000013 c014a7c1 00000013 c0157021 
Nov 25 01:16:01 hercules kernel: Call Trace:
Nov 25 01:16:01 hercules kernel:  [in_group_p+53/108] in_group_p+0x35/0x6c
Nov 25 01:16:01 hercules kernel:  [link_path_walk+1997/2148] link_path_walk+0x7cd/0x864
Nov 25 01:16:01 hercules kernel:  [vfs_read+156/204] vfs_read+0x9c/0xcc
Nov 25 01:16:01 hercules kernel:  [vfs_read+193/204] vfs_read+0xc1/0xcc
Nov 25 01:16:01 hercules kernel:  [path_lookup+341/348] path_lookup+0x155/0x15c
Nov 25 01:16:01 hercules kernel:  [open_exec+35/192] open_exec+0x23/0xc0
Nov 25 01:16:01 hercules kernel:  [load_elf_binary+735/2776] load_elf_binary+0x2df/0xad8
Nov 25 01:16:01 hercules kernel:  [kmap_high+329/396] kmap_high+0x149/0x18c
Nov 25 01:16:01 hercules kernel:  [page_address+51/128] page_address+0x33/0x80
Nov 25 01:16:01 hercules kernel:  [kmap_high+28/396] kmap_high+0x1c/0x18c
Nov 25 01:16:01 hercules kernel:  [kunmap_high+21/140] kunmap_high+0x15/0x8c
Nov 25 01:16:01 hercules kernel:  [page_address+51/128] page_address+0x33/0x80
Nov 25 01:16:01 hercules kernel:  [search_binary_handler+129/404] search_binary_handler+0x81/0x194
Nov 25 01:16:01 hercules kernel:  [do_execve+417/528] do_execve+0x1a1/0x210
Nov 25 01:16:01 hercules kernel:  [sys_execve+47/108] sys_execve+0x2f/0x6c
Nov 25 01:16:01 hercules kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 25 01:16:01 hercules kernel: 
Nov 25 01:16:01 hercules kernel: Code: 2b 14 88 85 d2 7e 07 8d 7b 01 eb 08 89 f6 85 d2 7d ac 89 de 
Nov 25 07:55:02 hercules kernel: klogd 1.4.1#13, log source = /proc/kmsg started.
Nov 25 07:55:02 hercules kernel: Inspecting /boot/System.map-2.6.5
Nov 25 07:55:02 hercules kernel: Loaded 24197 symbols from /boot/System.map-2.6.5.
Nov 25 07:55:02 hercules kernel: Symbols match kernel version 2.6.5.
Nov 25 07:55:02 hercules kernel: No module symbols loaded - kernel modules not enabled. 
Nov 25 07:55:02 hercules kernel: Linux version 2.6.5 (root@hercules) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Mon Apr 5 15:42:31 METDST 2004
Nov 25 07:55:02 hercules kernel: BIOS-provided physical RAM map:
Nov 25 07:55:02 hercules kernel:  BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
Nov 25 07:55:02 hercules kernel:  BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
Nov 25 07:55:02 hercules kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Nov 25 07:55:02 hercules kernel:  BIOS-e820: 0000000000100000 - 00000000efffa000 (usable)
Nov 25 07:55:02 hercules kernel:  BIOS-e820: 00000000efffa000 - 00000000f0000000 (ACPI data)
Nov 25 07:55:02 hercules kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Nov 25 07:55:02 hercules kernel:  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
Nov 25 07:55:02 hercules kernel:  BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
Nov 25 07:55:02 hercules kernel:  BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
Nov 25 07:55:02 hercules kernel: 5248MB HIGHMEM available.
Nov 25 07:55:02 hercules kernel: 896MB LOWMEM available.
Nov 25 07:55:02 hercules kernel: found SMP MP-table at 000f4fd0
Nov 25 07:55:02 hercules kernel: On node 0 totalpages: 1572864
Nov 25 07:55:02 hercules kernel:   DMA zone: 4096 pages, LIFO batch:1
Nov 25 07:55:02 hercules kernel:   Normal zone: 225280 pages, LIFO batch:16
Nov 25 07:55:02 hercules kernel:   HighMem zone: 1343488 pages, LIFO batch:16
Nov 25 07:55:02 hercules kernel: DMI 2.3 present.
Nov 25 07:55:02 hercules kernel: ACPI: RSDP (v000 COMPAQ                                    ) @ 0x000f4f70
Nov 25 07:55:02 hercules kernel: ACPI: RSDT (v001 COMPAQ P29      0x00000002 Ò^D 0x0000162e) @ 0xefffa000
Nov 25 07:55:02 hercules kernel: ACPI: FADT (v001 COMPAQ P29      0x00000002 Ò^D 0x0000162e) @ 0xefffa040
Nov 25 07:55:02 hercules kernel: ACPI: MADT (v001 COMPAQ 00000083 0x00000002  0x00000000) @ 0xefffa100
Nov 25 07:55:02 hercules kernel: ACPI: SPCR (v001 COMPAQ SPCRRBSU 0x00000001 Ò^D 0x0000162e) @ 0xefffa1c0
Nov 25 07:55:02 hercules kernel: ACPI: DSDT (v001 COMPAQ     DSDT 0x00000001 MSFT 0x0100000b) @ 0x00000000
Nov 25 07:55:02 hercules kernel: ACPI: Local APIC address 0xfee00000
Nov 25 07:55:02 hercules kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Nov 25 07:55:02 hercules kernel: Processor #0 15:2 APIC version 20
Nov 25 07:55:02 hercules kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
Nov 25 07:55:02 hercules kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
Nov 25 07:55:02 hercules kernel: ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
Nov 25 07:55:02 hercules kernel: Processor #6 15:2 APIC version 20
Nov 25 07:55:02 hercules kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Nov 25 07:55:02 hercules kernel: Processor #1 15:2 APIC version 20
Nov 25 07:55:02 hercules kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
Nov 25 07:55:02 hercules kernel: ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
Nov 25 07:55:02 hercules kernel: ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
Nov 25 07:55:02 hercules kernel: Processor #7 15:2 APIC version 20
Nov 25 07:55:02 hercules kernel: ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
Nov 25 07:55:02 hercules kernel: Using ACPI for processor (LAPIC) configuration information
Nov 25 07:55:02 hercules kernel: Intel MultiProcessor Specification v1.4
Nov 25 07:55:02 hercules kernel:     Virtual Wire compatibility mode.
Nov 25 07:55:02 hercules kernel: OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
Nov 25 07:55:02 hercules kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Nov 25 07:55:02 hercules kernel: I/O APIC #3 Version 17 at 0xFEC01000.
Nov 25 07:55:02 hercules kernel: I/O APIC #4 Version 17 at 0xFEC02000.
Nov 25 07:55:02 hercules kernel: I/O APIC #5 Version 17 at 0xFEC03000.
Nov 25 07:55:02 hercules kernel: Enabling APIC mode:  Flat.  Using 4 I/O APICs
Nov 25 07:55:02 hercules kernel: Processors: 4
Nov 25 07:55:02 hercules kernel: Built 1 zonelists
Nov 25 07:55:02 hercules kernel: Kernel command line: auto BOOT_IMAGE=linux ro root=6801
Nov 25 07:55:02 hercules kernel: Initializing CPU#0
Nov 25 07:55:02 hercules kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Nov 25 07:55:02 hercules kernel: Detected 2788.215 MHz processor.
Nov 25 07:55:02 hercules kernel: Using tsc for high-res timesource
Nov 25 07:55:02 hercules kernel: Console: colour VGA+ 80x25
Nov 25 07:55:02 hercules kernel: Memory: 5963380k/6291456k available (1547k kernel code, 64756k reserved, 789k data, 136k init, 5111784k highmem)
Nov 25 07:55:02 hercules kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Nov 25 07:55:02 hercules kernel: Calibrating delay loop... 5488.64 BogoMIPS
Nov 25 07:55:02 hercules kernel: Dentry cache hash table entries: 1048576 (order: 10, 4194304 bytes)
Nov 25 07:55:02 hercules kernel: Inode-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Nov 25 07:55:02 hercules kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Nov 25 07:55:02 hercules kernel: CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
Nov 25 07:55:02 hercules kernel: CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
Nov 25 07:55:02 hercules kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Nov 25 07:55:02 hercules kernel: CPU: L2 cache: 512K
Nov 25 07:55:02 hercules kernel: CPU: Physical Processor ID: 0
Nov 25 07:55:02 hercules kernel: CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Nov 25 07:55:02 hercules kernel: Enabling fast FPU save and restore... done.
Nov 25 07:55:02 hercules kernel: Enabling unmasked SIMD FPU exception support... done.
Nov 25 07:55:02 hercules kernel: Checking 'hlt' instruction... OK.
Nov 25 07:55:02 hercules kernel: POSIX conformance testing by UNIFIX
Nov 25 07:55:02 hercules kernel: CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
Nov 25 07:55:02 hercules kernel: per-CPU timeslice cutoff: 1462.50 usecs.
Nov 25 07:55:02 hercules kernel: task migration cache decay timeout: 2 msecs.
Nov 25 07:55:02 hercules kernel: enabled ExtINT on CPU#0
Nov 25 07:55:02 hercules kernel: ESR value before enabling vector: 00000000
Nov 25 07:55:02 hercules kernel: ESR value after enabling vector: 00000000
Nov 25 07:55:02 hercules kernel: Booting processor 1/1 eip 2000
Nov 25 07:55:02 hercules kernel: Initializing CPU#1
Nov 25 07:55:02 hercules kernel: masked ExtINT on CPU#1
Nov 25 07:55:02 hercules kernel: ESR value before enabling vector: 00000000
Nov 25 07:55:02 hercules kernel: ESR value after enabling vector: 00000000
Nov 25 07:55:02 hercules kernel: Calibrating delay loop... 5554.17 BogoMIPS
Nov 25 07:55:02 hercules kernel: CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
Nov 25 07:55:02 hercules kernel: CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
Nov 25 07:55:02 hercules kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Nov 25 07:55:02 hercules kernel: CPU: L2 cache: 512K
Nov 25 07:55:02 hercules kernel: CPU: Physical Processor ID: 0
Nov 25 07:55:02 hercules kernel: CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Nov 25 07:55:02 hercules kernel: CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
Nov 25 07:55:02 hercules kernel: Booting processor 2/6 eip 2000
Nov 25 07:55:02 hercules kernel: Initializing CPU#2
Nov 25 07:55:02 hercules kernel: masked ExtINT on CPU#2
Nov 25 07:55:02 hercules kernel: ESR value before enabling vector: 00000000
Nov 25 07:55:02 hercules kernel: ESR value after enabling vector: 00000000
Nov 25 07:55:02 hercules kernel: Calibrating delay loop... 5554.17 BogoMIPS
Nov 25 07:55:02 hercules kernel: CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
Nov 25 07:55:02 hercules kernel: CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
Nov 25 07:55:02 hercules kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Nov 25 07:55:02 hercules kernel: CPU: L2 cache: 512K
Nov 25 07:55:02 hercules kernel: CPU: Physical Processor ID: 3
Nov 25 07:55:02 hercules kernel: CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Nov 25 07:55:02 hercules kernel: CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
Nov 25 07:55:02 hercules kernel: Booting processor 3/7 eip 2000
Nov 25 07:55:02 hercules kernel: Initializing CPU#3
Nov 25 07:55:02 hercules kernel: masked ExtINT on CPU#3
Nov 25 07:55:02 hercules kernel: ESR value before enabling vector: 00000000
Nov 25 07:55:02 hercules kernel: ESR value after enabling vector: 00000000
Nov 25 07:55:02 hercules kernel: Calibrating delay loop... 5554.17 BogoMIPS
Nov 25 07:55:02 hercules kernel: CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
Nov 25 07:55:02 hercules kernel: CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
Nov 25 07:55:02 hercules kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Nov 25 07:55:02 hercules kernel: CPU: L2 cache: 512K
Nov 25 07:55:02 hercules kernel: CPU: Physical Processor ID: 3
Nov 25 07:55:02 hercules kernel: CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Nov 25 07:55:02 hercules kernel: CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
Nov 25 07:55:02 hercules kernel: Total of 4 processors activated (22151.16 BogoMIPS).
Nov 25 07:55:02 hercules kernel: cpu_sibling_map[0] = 1
Nov 25 07:55:02 hercules kernel: cpu_sibling_map[1] = 0
Nov 25 07:55:02 hercules kernel: cpu_sibling_map[2] = 3
Nov 25 07:55:02 hercules kernel: cpu_sibling_map[3] = 2
Nov 25 07:55:02 hercules kernel: ENABLING IO-APIC IRQs
Nov 25 07:55:02 hercules kernel: Setting 2 in the phys_id_present_map
Nov 25 07:55:02 hercules kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Nov 25 07:55:02 hercules kernel: Setting 3 in the phys_id_present_map
Nov 25 07:55:02 hercules kernel: ...changing IO-APIC physical APIC ID to 3 ... ok.
Nov 25 07:55:02 hercules kernel: Setting 4 in the phys_id_present_map
Nov 25 07:55:02 hercules kernel: ...changing IO-APIC physical APIC ID to 4 ... ok.
Nov 25 07:55:02 hercules kernel: Setting 5 in the phys_id_present_map
Nov 25 07:55:02 hercules kernel: ...changing IO-APIC physical APIC ID to 5 ... ok.
Nov 25 07:55:02 hercules kernel: init IO_APIC IRQs
Nov 25 07:55:02 hercules kernel:  IO-APIC (apicid-pin) 2-0, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 4-0, 4-1, 4-2, 4-3, 4-4, 4-5, 4-6, 4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15, 5-0, 5-1, 5-2, 5-3, 5-4, 5-5, 5-6, 5-7, 5-8, 5-9, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15 not connected.
Nov 25 07:55:02 hercules kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Nov 25 07:55:02 hercules kernel: number of MP IRQ sources: 16.
Nov 25 07:55:02 hercules kernel: number of IO-APIC #2 registers: 16.
Nov 25 07:55:02 hercules kernel: number of IO-APIC #3 registers: 16.
Nov 25 07:55:02 hercules kernel: number of IO-APIC #4 registers: 16.
Nov 25 07:55:02 hercules kernel: number of IO-APIC #5 registers: 16.
Nov 25 07:55:02 hercules kernel: testing the IO APIC.......................
Nov 25 07:55:02 hercules kernel: IO APIC #2......
Nov 25 07:55:02 hercules kernel: .... register #00: 02000000
Nov 25 07:55:02 hercules kernel: .......    : physical APIC id: 02
Nov 25 07:55:02 hercules kernel: .......    : Delivery Type: 0
Nov 25 07:55:02 hercules kernel: .......    : LTS          : 0
Nov 25 07:55:02 hercules kernel: .... register #01: 000F0011
Nov 25 07:55:02 hercules kernel: .......     : max redirection entries: 000F
Nov 25 07:55:02 hercules kernel: .......     : PRQ implemented: 0
Nov 25 07:55:02 hercules kernel: .......     : IO APIC version: 0011
Nov 25 07:55:02 hercules kernel: .... register #02: 02000000
Nov 25 07:55:02 hercules kernel: .......     : arbitration: 02
Nov 25 07:55:02 hercules kernel: .... IRQ redirection table:
Nov 25 07:55:02 hercules kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Nov 25 07:55:02 hercules kernel:  00 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  01 001 01  0    0    0   0   0    1    1    39
Nov 25 07:55:02 hercules kernel:  02 001 01  0    0    0   0   0    1    1    31
Nov 25 07:55:02 hercules kernel:  03 001 01  1    1    0   1   0    1    1    41
Nov 25 07:55:02 hercules kernel:  04 001 01  0    0    0   0   0    1    1    49
Nov 25 07:55:02 hercules kernel:  05 001 01  1    1    0   1   0    1    1    51
Nov 25 07:55:02 hercules kernel:  06 001 01  0    0    0   0   0    1    1    59
Nov 25 07:55:02 hercules kernel:  07 001 01  1    1    0   1   0    1    1    61
Nov 25 07:55:02 hercules kernel:  08 001 01  0    0    0   0   0    1    1    69
Nov 25 07:55:02 hercules kernel:  09 001 01  1    1    0   1   0    1    1    71
Nov 25 07:55:02 hercules kernel:  0a 001 01  1    1    0   1   0    1    1    79
Nov 25 07:55:02 hercules kernel:  0b 001 01  1    1    0   1   0    1    1    81
Nov 25 07:55:02 hercules kernel:  0c 001 01  0    0    0   0   0    1    1    89
Nov 25 07:55:02 hercules kernel:  0d 001 01  0    0    0   0   0    1    1    91
Nov 25 07:55:02 hercules kernel:  0e 001 01  0    0    0   0   0    1    1    99
Nov 25 07:55:02 hercules kernel:  0f 001 01  1    1    0   1   0    1    1    A1
Nov 25 07:55:02 hercules kernel: IO APIC #3......
Nov 25 07:55:02 hercules kernel: .... register #00: 03000000
Nov 25 07:55:02 hercules kernel: .......    : physical APIC id: 03
Nov 25 07:55:02 hercules kernel: .......    : Delivery Type: 0
Nov 25 07:55:02 hercules kernel: .......    : LTS          : 0
Nov 25 07:55:02 hercules kernel: .... register #01: 000F0011
Nov 25 07:55:02 hercules kernel: .......     : max redirection entries: 000F
Nov 25 07:55:02 hercules kernel: .......     : PRQ implemented: 0
Nov 25 07:55:02 hercules kernel: .......     : IO APIC version: 0011
Nov 25 07:55:02 hercules kernel: .... register #02: 03000000
Nov 25 07:55:02 hercules kernel: .......     : arbitration: 03
Nov 25 07:55:02 hercules kernel: .... IRQ redirection table:
Nov 25 07:55:02 hercules kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Nov 25 07:55:02 hercules kernel:  00 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  01 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  02 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  03 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  04 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  05 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  06 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  07 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  08 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  09 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0a 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0b 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0c 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0d 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0e 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0f 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel: IO APIC #4......
Nov 25 07:55:02 hercules kernel: .... register #00: 04000000
Nov 25 07:55:02 hercules kernel: .......    : physical APIC id: 04
Nov 25 07:55:02 hercules kernel: .......    : Delivery Type: 0
Nov 25 07:55:02 hercules kernel: .......    : LTS          : 0
Nov 25 07:55:02 hercules kernel: .... register #01: 000F0011
Nov 25 07:55:02 hercules kernel: .......     : max redirection entries: 000F
Nov 25 07:55:02 hercules kernel: .......     : PRQ implemented: 0
Nov 25 07:55:02 hercules kernel: .......     : IO APIC version: 0011
Nov 25 07:55:02 hercules kernel: .... register #02: 04000000
Nov 25 07:55:02 hercules kernel: .......     : arbitration: 04
Nov 25 07:55:02 hercules kernel: .... IRQ redirection table:
Nov 25 07:55:02 hercules kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Nov 25 07:55:02 hercules kernel:  00 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  01 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  02 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  03 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  04 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  05 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  06 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  07 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  08 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  09 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0a 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0b 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0c 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0d 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0e 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0f 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel: IO APIC #5......
Nov 25 07:55:02 hercules kernel: .... register #00: 05000000
Nov 25 07:55:02 hercules kernel: .......    : physical APIC id: 05
Nov 25 07:55:02 hercules kernel: .......    : Delivery Type: 0
Nov 25 07:55:02 hercules kernel: .......    : LTS          : 0
Nov 25 07:55:02 hercules kernel: .... register #01: 000F0011
Nov 25 07:55:02 hercules kernel: .......     : max redirection entries: 000F
Nov 25 07:55:02 hercules kernel: .......     : PRQ implemented: 0
Nov 25 07:55:02 hercules kernel: .......     : IO APIC version: 0011
Nov 25 07:55:02 hercules kernel: .... register #02: 05000000
Nov 25 07:55:02 hercules kernel: .......     : arbitration: 05
Nov 25 07:55:02 hercules kernel: .... IRQ redirection table:
Nov 25 07:55:02 hercules kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Nov 25 07:55:02 hercules kernel:  00 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  01 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  02 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  03 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  04 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  05 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  06 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  07 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  08 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  09 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0a 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0b 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0c 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0d 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0e 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel:  0f 000 00  1    0    0   0   0    0    0    00
Nov 25 07:55:02 hercules kernel: IRQ to pin mappings:
Nov 25 07:55:02 hercules kernel: IRQ0 -> 0:2
Nov 25 07:55:02 hercules kernel: IRQ1 -> 0:1
Nov 25 07:55:02 hercules kernel: IRQ3 -> 0:3
Nov 25 07:55:02 hercules kernel: IRQ4 -> 0:4
Nov 25 07:55:02 hercules kernel: IRQ5 -> 0:5
Nov 25 07:55:02 hercules kernel: IRQ6 -> 0:6
Nov 25 07:55:02 hercules kernel: IRQ7 -> 0:7
Nov 25 07:55:02 hercules kernel: IRQ8 -> 0:8
Nov 25 07:55:02 hercules kernel: IRQ9 -> 0:9
Nov 25 07:55:02 hercules kernel: IRQ10 -> 0:10
Nov 25 07:55:02 hercules kernel: IRQ11 -> 0:11
Nov 25 07:55:02 hercules kernel: IRQ12 -> 0:12
Nov 25 07:55:02 hercules kernel: IRQ13 -> 0:13
Nov 25 07:55:02 hercules kernel: IRQ14 -> 0:14
Nov 25 07:55:02 hercules kernel: IRQ15 -> 0:15
Nov 25 07:55:02 hercules kernel: .................................... done.
Nov 25 07:55:02 hercules kernel: Using local APIC timer interrupts.
Nov 25 07:55:02 hercules kernel: calibrating APIC timer ...
Nov 25 07:55:02 hercules kernel: ..... CPU clock speed is 2786.0455 MHz.
Nov 25 07:55:02 hercules kernel: ..... host bus clock speed is 99.0516 MHz.
Nov 25 07:55:02 hercules kernel: checking TSC synchronization across 4 CPUs: passed.
Nov 25 07:55:02 hercules kernel: Brought up 4 CPUs
Nov 25 07:55:02 hercules kernel: NET: Registered protocol family 16
Nov 25 07:55:02 hercules kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0094, last bus=9
Nov 25 07:55:02 hercules kernel: PCI: Using configuration type 1
Nov 25 07:55:02 hercules kernel: mtrr: v2.0 (20020519)
Nov 25 07:55:02 hercules kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
Nov 25 07:55:02 hercules kernel: mtrr: probably your BIOS does not setup all CPUs.
Nov 25 07:55:02 hercules kernel: mtrr: corrected configuration.
Nov 25 07:55:02 hercules kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Nov 25 07:55:02 hercules kernel: PCI: Probing PCI hardware
Nov 25 07:55:02 hercules kernel: PCI: Probing PCI hardware (bus 00)
Nov 25 07:55:02 hercules kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
Nov 25 07:55:02 hercules kernel: PCI: Discovered peer bus 01
Nov 25 07:55:02 hercules kernel: PCI: Discovered peer bus 02
Nov 25 07:55:02 hercules kernel: PCI: Discovered peer bus 06
Nov 25 07:55:02 hercules kernel: PCI: Device 00:00 not found by BIOS
Nov 25 07:55:02 hercules kernel: PCI: Device 00:01 not found by BIOS
Nov 25 07:55:02 hercules kernel: PCI: Device 00:02 not found by BIOS
Nov 25 07:55:02 hercules kernel: PCI: Device 00:78 not found by BIOS
Nov 25 07:55:02 hercules kernel: PCI: Device 00:7b not found by BIOS
Nov 25 07:55:02 hercules kernel: PCI: Device 00:80 not found by BIOS
Nov 25 07:55:02 hercules kernel: PCI: Device 00:82 not found by BIOS
Nov 25 07:55:02 hercules kernel: PCI: Device 00:88 not found by BIOS
Nov 25 07:55:02 hercules kernel: PCI: Device 00:8a not found by BIOS
Nov 25 07:55:02 hercules kernel: vga16fb: initializing
Nov 25 07:55:02 hercules kernel: vga16fb: mapped to 0xc00a0000
Nov 25 07:55:02 hercules kernel: fb0: VGA16 VGA frame buffer device
Nov 25 07:55:02 hercules kernel: Starting balanced_irq
Nov 25 07:55:02 hercules kernel: highmem bounce pool size: 64 pages
Nov 25 07:55:02 hercules kernel: isapnp: Scanning for PnP cards...
Nov 25 07:55:02 hercules kernel: isapnp: No Plug & Play device found
Nov 25 07:55:02 hercules kernel: Linux agpgart interface v0.100 (c) Dave Jones
Nov 25 07:55:02 hercules kernel: [drm] Initialized r128 2.5.0 20030725 on minor 0
Nov 25 07:55:02 hercules kernel: [drm] Initialized radeon 1.9.0 20020828 on minor 1
Nov 25 07:55:02 hercules kernel: Compaq SMART2 Driver (v 2.6.0)
Nov 25 07:55:02 hercules kernel: Compaq CISS Driver (v 2.6.0)
Nov 25 07:55:02 hercules kernel: cciss: Device 0xb178 has been found at bus 1 dev 3 func 0
Nov 25 07:55:02 hercules kernel: cciss: using DAC cycles
Nov 25 07:55:02 hercules kernel: Using anticipatory io scheduler
Nov 25 07:55:02 hercules kernel:       blocks= 35553120 block_size= 512
Nov 25 07:55:02 hercules kernel:       heads= 255, sectors= 32, cylinders= 4357
Nov 25 07:55:02 hercules kernel: 
Nov 25 07:55:02 hercules kernel:  cciss/c0d0: p1 p2 p3 < p5 p6 > p4
Nov 25 07:55:02 hercules kernel: cciss: Device 0xb060 has been found at bus 6 dev 2 func 0
Nov 25 07:55:02 hercules kernel: cciss: using DAC cycles
Nov 25 07:55:02 hercules kernel:       blocks= 426784320 block_size= 512
Nov 25 07:55:02 hercules kernel:       heads= 255, sectors= 32, cylinders= 52302
Nov 25 07:55:02 hercules kernel: 
Nov 25 07:55:02 hercules kernel:       blocks= 142253280 block_size= 512
Nov 25 07:55:02 hercules kernel:       heads= 255, sectors= 32, cylinders= 17433
Nov 25 07:55:02 hercules kernel: 
Nov 25 07:55:02 hercules kernel:       blocks= 213392160 block_size= 512
Nov 25 07:55:02 hercules kernel:       heads= 255, sectors= 32, cylinders= 26151
Nov 25 07:55:02 hercules kernel: 
Nov 25 07:55:02 hercules kernel:  cciss/c1d0: p1
Nov 25 07:55:02 hercules kernel:  cciss/c1d1: p1
Nov 25 07:55:02 hercules kernel:  cciss/c1d2: p1
Nov 25 07:55:02 hercules kernel: tg3.c:v2.9 (March 8, 2004)
Nov 25 07:55:02 hercules kernel: eth0: Tigon3 [partno(TBD) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:0b:cd:3e:d8:fd
Nov 25 07:55:02 hercules kernel: eth1: Tigon3 [partno(TBD) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:0b:cd:3e:d8:fc
Nov 25 07:55:02 hercules kernel: mice: PS/2 mouse device common for all mice
Nov 25 07:55:02 hercules kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Nov 25 07:55:02 hercules kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov 25 07:55:02 hercules kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 25 07:55:02 hercules kernel: NET: Registered protocol family 2
Nov 25 07:55:02 hercules kernel: IP: routing cache hash table of 65536 buckets, 512Kbytes
Nov 25 07:55:02 hercules kernel: TCP: Hash tables configured (established 524288 bind 65536)
Nov 25 07:55:02 hercules kernel: NET: Registered protocol family 1
Nov 25 07:55:02 hercules kernel: NET: Registered protocol family 17
Nov 25 07:55:02 hercules kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Nov 25 07:55:02 hercules kernel: EXT3-fs: write access will be enabled during recovery.
Nov 25 07:55:02 hercules kernel: kjournald starting.  Commit interval 5 seconds
Nov 25 07:55:02 hercules kernel: EXT3-fs: cciss/c0d0p1: orphan cleanup on readonly fs
Nov 25 07:55:02 hercules kernel: ext3_orphan_cleanup: deleting unreferenced inode 162728
Nov 25 07:55:02 hercules kernel: ext3_orphan_cleanup: deleting unreferenced inode 162752
Nov 25 07:55:02 hercules kernel: ext3_orphan_cleanup: deleting unreferenced inode 192073
Nov 25 07:55:02 hercules kernel: ext3_orphan_cleanup: deleting unreferenced inode 162571
Nov 25 07:55:02 hercules kernel: EXT3-fs: cciss/c0d0p1: 4 orphan inodes deleted
Nov 25 07:55:02 hercules kernel: EXT3-fs: recovery complete.
Nov 25 07:55:02 hercules kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 25 07:55:02 hercules kernel: VFS: Mounted root (ext3 filesystem) readonly.
Nov 25 07:55:02 hercules kernel: Freeing unused kernel memory: 136k freed
Nov 25 07:55:02 hercules kernel: Adding 1905352k swap on /dev/cciss/c0d0p2.  Priority:-1 extents:1
Nov 25 07:55:02 hercules kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 25 07:55:02 hercules kernel: input: PS/2 Logitech Mouse on isa0060/serio1
Nov 25 07:55:02 hercules kernel: EXT3 FS on cciss/c0d0p1, internal journal
Nov 25 07:55:02 hercules kernel: input: PS/2 Logitech Mouse on isa0060/serio1
Nov 25 07:55:02 hercules kernel: kjournald starting.  Commit interval 5 seconds
Nov 25 07:55:02 hercules kernel: EXT3 FS on cciss/c0d0p5, internal journal
Nov 25 07:55:02 hercules kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 25 07:55:02 hercules kernel: kjournald starting.  Commit interval 5 seconds
Nov 25 07:55:02 hercules kernel: EXT3 FS on cciss/c0d0p4, internal journal
Nov 25 07:55:02 hercules kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 25 07:55:02 hercules kernel: kjournald starting.  Commit interval 5 seconds
Nov 25 07:55:02 hercules kernel: EXT3 FS on cciss/c0d0p6, internal journal
Nov 25 07:55:02 hercules kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 25 07:55:02 hercules kernel: kjournald starting.  Commit interval 5 seconds
Nov 25 07:55:02 hercules kernel: EXT3 FS on cciss/c1d0p1, internal journal
Nov 25 07:55:02 hercules kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 25 07:55:02 hercules kernel: kjournald starting.  Commit interval 5 seconds
Nov 25 07:55:02 hercules kernel: EXT3 FS on cciss/c1d1p1, internal journal
Nov 25 07:55:02 hercules kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 25 07:55:02 hercules kernel: kjournald starting.  Commit interval 5 seconds
Nov 25 07:55:02 hercules kernel: EXT3 FS on cciss/c1d2p1, internal journal
Nov 25 07:55:02 hercules kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 25 07:55:02 hercules kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
Nov 25 07:55:02 hercules kernel: tg3: eth0: Flow control is off for TX and off for RX.
Nov 25 07:55:02 hercules kernel: process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
Nov 25 07:55:05 hercules ntpd[419]: kernel time discipline status 0040
Nov 25 07:58:22 hercules ntpd[419]: kernel time discipline status change 41
Nov 25 09:00:06 hercules kernel: process `snmpget' is using obsolete setsockopt SO_BSDCOMPAT
--DMW.Boundary.605592468
Content-Type: application/octet-stream; name=".config"
Content-Disposition: attachment; filename=".config"
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODULE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=8
# CONFIG_PREEMPT is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_USE_VECTOR is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
CONFIG_BLK_CPQ_DA=y
CONFIG_BLK_CPQ_CISS_DA=y
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_CARMEL is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=m
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BLK_DEV_DM is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
CONFIG_TIGON3=y

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
CONFIG_DRM_R128=y
CONFIG_DRM_RADEON=y
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE is not set

#
# Logo configuration
#
# CONFIG_LOGO is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_STORAGE is not set

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y
--DMW.Boundary.605592468--
