Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTKMG4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 01:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTKMG4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 01:56:34 -0500
Received: from h218.201.190.194.elnet.msk.ru ([194.190.201.218]:61861 "EHLO
	deka.deka") by vger.kernel.org with ESMTP id S261776AbTKMG4A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 01:56:00 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Deka adm <tech@deka.ru>
Reply-To: tech@deka.ru
Organization: Deka
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: memory dump
Date: Thu, 13 Nov 2003 10:00:59 +0300
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200311131000.59105.tech@deka.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Time to time kernel in panic with memoru dump.

Description:
Fileserver with cryptoloop devices attached in samba as share folders. Time to 
time server crashed with memoru dump. After loading from
rescue disk and force fsck for ext3, and change memory chips in server
problim was fixed, i hope....

Keywords:

kernel memory cryptoloop

Kernel version:

Linux version 2.4.18-14 (bhcompile@stripples.devel.redhat.com) (gcc version 
3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Wed Sep 4 13:35:50 EDT 2002

Kernel oops message:

Nov 12 16:00:00 screep kernel: Oops: 0000
Nov 12 16:00:00 screep kernel: cipher-aes cryptoloop loop cryptoapi 8139too 
mii ipt_REJECT iptable_filter ip_
Nov 12 16:00:00 screep kernel: CPU:    0
Nov 12 16:00:00 screep kernel: EIP:    0010:[<c013d030>]    Not tainted
Nov 12 16:00:00 screep kernel: EFLAGS: 00010206
Nov 12 16:00:00 screep kernel: 
Nov 12 16:00:01 screep kernel: EIP is at page_remove_rmap [kernel] 0x50 
(2.4.18-14)
Nov 12 16:00:01 screep kernel: eax: 04400000   ebx: d67d6ff8   ecx: c14eb738   
edx: d691537c
Nov 12 16:00:01 screep kernel: esi: c0305480   edi: 00006000   ebp: 167d7067   
esp: d672bbc0
Nov 12 16:00:01 screep kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 16:00:01 screep kernel: Process bash (pid: 1832, stackpage=d672b000)
Nov 12 16:00:01 screep kernel: Stack: ffffffff 0000abd5 d6915370 00001000 
d691537c 00004000 c012c6c3 c14ead60 
Nov 12 16:00:01 screep kernel:        00000001 00000000 c1f750e0 00000003 
08400000 d6871084 080e1000 00000000 
Nov 12 16:00:01 screep kernel:        c012aa9b f72b8a40 d6871080 080db000 
00006000 084db000 00000000 080e1000 
Nov 12 16:00:01 screep kernel: Call Trace: [<c012c6c3>] zap_pte_range [kernel] 
0x113 (0xd672bbd8))
Nov 12 16:00:01 screep kernel: [<c012aa9b>] do_zap_page_range [kernel] 0x8b 
(0xd672bc00))
Nov 12 16:00:01 screep kernel: [<c012afb8>] zap_page_range [kernel] 0x58 
(0xd672bc34))
Nov 12 16:00:01 screep kernel: [<c012de51>] exit_mmap [kernel] 0xd1 
(0xd672bc58))
Nov 12 16:00:01 screep kernel: [<c014861d>] exec_mmap [kernel] 0x10d 
(0xd672bc80))
Nov 12 16:00:01 screep kernel: [<c01486d5>] flush_old_exec [kernel] 0xb5 
(0xd672bc9c))
Nov 12 16:00:01 screep kernel: [<c015e6da>] load_elf_binary [kernel] 0x2ba 
(0xd672bcbc))
Nov 12 16:00:01 screep kernel: [<c012fbe0>] file_read_actor [kernel] 0x0 
(0xd672bda4))
Nov 12 16:00:01 screep kernel: [<c015e420>] load_elf_binary [kernel] 0x0 
(0xd672bdf0))
Nov 12 16:00:01 screep kernel: [<c0148d4d>] search_binary_handler [kernel] 
0x10d (0xd672bdfc))
Nov 12 16:00:01 screep kernel: [<c0148f4b>] do_execve [kernel] 0x17b 
(0xd672be44))
Nov 12 16:00:01 screep kernel: [<c0107990>] sys_execve [kernel] 0x50 
(0xd672bfa4))
Nov 12 16:00:01 screep kernel: [<c010910f>] system_call [kernel] 0x33 
(0xd672bfc0))
Nov 12 16:00:01 screep kernel: 
Nov 12 16:00:01 screep kernel: 
Nov 12 16:00:01 screep kernel: Code: 39 50 04 74 17 89 c3 8b 00 85 c0 75 f3 8d 
76 00 8b 5c 24 10 
Nov 12 16:00:01 screep kernel:  ------------[ cut here ]------------
Nov 12 16:00:01 screep kernel: kernel BUG at mmap.c:1335!
Nov 12 16:00:01 screep kernel: invalid operand: 0000
Nov 12 16:00:01 screep kernel: cipher-aes cryptoloop loop cryptoapi 8139too 
mii ipt_REJECT iptable_filter ip_
Nov 12 16:00:01 screep kernel: CPU:    0
Nov 12 16:00:01 screep kernel: EIP:    0010:[<c012de88>]    Not tainted
Nov 12 16:00:01 screep kernel: EFLAGS: 00010206
Nov 12 16:00:01 screep kernel: 
Nov 12 16:00:01 screep kernel: EIP is at exit_mmap [kernel] 0x108 (2.4.18-14)
Nov 12 16:00:01 screep kernel: eax: 0000000c   ebx: 00000000   ecx: 00000000   
edx: f7febc48
Nov 12 16:00:01 screep kernel: esi: f72b8a40   edi: d672a000   ebp: 0000000b   
esp: d672ba70
Nov 12 16:00:01 screep kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 16:00:01 screep kernel: Process bash (pid: 1832, stackpage=d672b000)
Nov 12 16:00:01 screep kernel: Stack: f72b8a40 d672ba90 c0303630 d672bb8c 
f72b8a5c f72b8a40 f72b8a5c d672a000 
Nov 12 16:00:01 screep kernel:        0000000b c01193f9 f72b8a40 00000202 
f72b8a40 c011e006 f72b8a40 f72b0018 
Nov 12 16:00:01 screep kernel:        d672bb8c f72b8a5c 04400004 00000000 
c01097d1 0000000b c0257e5d 00000000 
Nov 12 16:00:01 screep kernel: Call Trace: [<c01193f9>] mmput [kernel] 0x39 
(0xd672ba94))
Nov 12 16:00:01 screep kernel: [<c011e006>] do_exit [kernel] 0xa6 
(0xd672baa4))
Nov 12 16:00:01 screep kernel: [<c01097d1>] die [kernel] 0x81 (0xd672bac0))
Nov 12 16:00:01 screep kernel: [<c0116b64>] do_page_fault [kernel] 0x2a4 
(0xd672bad4))
Nov 12 16:00:01 screep kernel: [<c0137c3d>] __alloc_pages [kernel] 0x8d 
(0xd672bb2c))
Nov 12 16:00:01 screep kernel: [<c01306a5>] filemap_nopage [kernel] 0x1a5 
(0xd672bb30))
Nov 12 16:00:01 screep kernel: [<c013cfd3>] page_add_rmap [kernel] 0x53 
(0xd672bb50))
Nov 12 16:00:01 screep kernel: [<c012bd4b>] do_no_page [kernel] 0xeb 
(0xd672bb60))
Nov 12 16:00:01 screep kernel: [<c01168c0>] do_page_fault [kernel] 0x0 
(0xd672bb78))
Nov 12 16:00:01 screep kernel: [<c0109200>] error_code [kernel] 0x34 
(0xd672bb80))
Nov 12 16:00:01 screep kernel: [<c013d030>] page_remove_rmap [kernel] 0x50 
(0xd672bbb4))
Nov 12 16:00:01 screep kernel: [<c012c6c3>] zap_pte_range [kernel] 0x113 
(0xd672bbd8))
Nov 12 16:00:01 screep kernel: [<c012aa9b>] do_zap_page_range [kernel] 0x8b 
(0xd672bc00))
Nov 12 16:00:01 screep kernel: [<c012afb8>] zap_page_range [kernel] 0x58 
(0xd672bc34))
Nov 12 16:00:01 screep kernel: [<c012de51>] exit_mmap [kernel] 0xd1 
(0xd672bc58))
Nov 12 16:00:01 screep kernel: [<c014861d>] exec_mmap [kernel] 0x10d 
(0xd672bc80))
Nov 12 16:00:01 screep kernel: [<c01486d5>] flush_old_exec [kernel] 0xb5 
(0xd672bc9c))
Nov 12 16:00:01 screep kernel: [<c015e6da>] load_elf_binary [kernel] 0x2ba 
(0xd672bcbc))
Nov 12 16:00:01 screep kernel: [<c012fbe0>] file_read_actor [kernel] 0x0 
(0xd672bda4))
Nov 12 16:00:01 screep kernel: [<c015e420>] load_elf_binary [kernel] 0x0 
(0xd672bdf0))
Nov 12 16:00:01 screep kernel: [<c0148d4d>] search_binary_handler [kernel] 
0x10d (0xd672bdfc))
Nov 12 16:00:01 screep kernel: [<c0148f4b>] do_execve [kernel] 0x17b 
(0xd672be44))
Nov 12 16:00:01 screep kernel: [<c0107990>] sys_execve [kernel] 0x50 
(0xd672bfa4))
Nov 12 16:00:01 screep kernel: [<c010910f>] system_call [kernel] 0x33 
(0xd672bfc0))
Nov 12 16:00:01 screep kernel: 
Nov 12 16:00:01 screep kernel: 
Nov 12 16:00:01 screep kernel: Code: 0f 0b 37 05 e6 95 25 c0 89 34 24 c7 44 24 
04 00 00 00 00 c7 
Nov 12 16:03:00 screep kernel:  no vm86_info: BAD
Nov 12 16:03:00 screep kernel: no vm86_info: BAD
Nov 12 16:06:00 screep kernel: no vm86_info: BAD
Nov 12 16:06:00 screep kernel: no vm86_info: BAD
Nov 12 16:11:17 screep kernel: attempt to access beyond end of device
Nov 12 16:11:17 screep kernel: 03:02: rw=0, want=717868236, limit=35841015
Nov 12 16:11:17 screep kernel: attempt to access beyond end of device
Nov 12 16:11:17 screep kernel: 03:02: rw=0, want=971099344, limit=35841015
Nov 12 16:11:17 screep kernel: attempt to access beyond end of device
Nov 12 16:11:17 screep kernel: 03:02: rw=0, want=1858194644, limit=35841015
Nov 12 16:11:17 screep kernel: attempt to access beyond end of device
Nov 12 16:11:17 screep kernel: 03:02: rw=0, want=63294680, limit=35841015
Nov 12 16:11:17 screep kernel: attempt to access beyond end of device
Nov 12 16:11:17 screep kernel: 03:02: rw=0, want=717868236, limit=35841015
Nov 12 16:11:17 screep kernel: attempt to access beyond end of device
Nov 12 16:11:17 screep kernel: 03:02: rw=0, want=971099344, limit=35841015
Nov 12 16:11:17 screep kernel: attempt to access beyond end of device
Nov 12 16:11:17 screep kernel: 03:02: rw=0, want=1858194644, limit=35841015
Nov 12 16:11:17 screep kernel: attempt to access beyond end of device
Nov 12 16:11:17 screep kernel: 03:02: rw=0, want=63294680, limit=35841015
Nov 12 16:11:18 screep kernel: attempt to access beyond end of device
Nov 12 16:11:18 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:11:18 screep kernel: attempt to access beyond end of device
Nov 12 16:11:18 screep kernel: 07:01: rw=0, want=547117304, limit=3145728
Nov 12 16:11:18 screep kernel: attempt to access beyond end of device
Nov 12 16:11:18 screep kernel: 07:01: rw=0, want=374102268, limit=3145728
Nov 12 16:11:18 screep kernel: attempt to access beyond end of device
Nov 12 16:11:18 screep kernel: 07:01: rw=0, want=252205312, limit=3145728
Nov 12 16:11:42 screep kernel: attempt to access beyond end of device
Nov 12 16:11:42 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:11:42 screep kernel: attempt to access beyond end of device
Nov 12 16:11:42 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:11:42 screep kernel: attempt to access beyond end of device
Nov 12 16:11:42 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:11:42 screep kernel: attempt to access beyond end of device
Nov 12 16:11:42 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:11:42 screep kernel: attempt to access beyond end of device
Nov 12 16:11:42 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:11:42 screep kernel: attempt to access beyond end of device
Nov 12 16:11:42 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:11:42 screep kernel: attempt to access beyond end of device
Nov 12 16:11:42 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:11:42 screep kernel: attempt to access beyond end of device
Nov 12 16:11:42 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:12:00 screep kernel: no vm86_info: BAD
Nov 12 16:12:46 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 100597760, count = 
1
Nov 12 16:12:46 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 12451840, count = 
1
Nov 12 16:12:46 screep kernel: attempt to access beyond end of device
Nov 12 16:12:46 screep kernel: 07:02: rw=0, want=49807364, limit=3145728
Nov 12 16:12:46 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=12451840
Nov 12 16:12:46 screep kernel: attempt to access beyond end of device
Nov 12 16:12:46 screep kernel: 07:02: rw=0, want=402391044, limit=3145728
Nov 12 16:12:46 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=100597760
Nov 12 16:12:46 screep kernel: attempt to access beyond end of device
Nov 12 16:12:46 screep kernel: 07:02: rw=0, want=49807364, limit=3145728
Nov 12 16:12:46 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=12451840
Nov 12 16:12:46 screep kernel: attempt to access beyond end of device
Nov 12 16:12:46 screep kernel: 07:02: rw=0, want=402391044, limit=3145728
Nov 12 16:12:46 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=100597760
Nov 12 16:12:46 screep kernel: attempt to access beyond end of device
Nov 12 16:12:46 screep kernel: 07:02: rw=0, want=49807364, limit=3145728
Nov 12 16:12:46 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=12451840
Nov 12 16:12:46 screep kernel: attempt to access beyond end of device
Nov 12 16:12:46 screep kernel: 07:02: rw=0, want=402391044, limit=3145728
Nov 12 16:12:46 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=100597760
Nov 12 16:12:46 screep kernel: attempt to access beyond end of device
Nov 12 16:12:46 screep kernel: 07:02: rw=0, want=49807364, limit=3145728
Nov 12 16:12:46 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=12451840
Nov 12 16:12:46 screep kernel: attempt to access beyond end of device
Nov 12 16:12:46 screep kernel: 07:02: rw=0, want=402391044, limit=3145728
Nov 12 16:12:46 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=100597760
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 83951616, count = 
1
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 16777216, count = 
1
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 33554432, count = 
1
Nov 12 16:12:47 screep kernel: attempt to access beyond end of device
Nov 12 16:12:47 screep kernel: 07:02: rw=0, want=52166660, limit=3145728
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=13041664
Nov 12 16:12:47 screep kernel: attempt to access beyond end of device
Nov 12 16:12:47 screep kernel: 07:02: rw=0, want=51904516, limit=3145728
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=12976128
Nov 12 16:12:47 screep kernel: attempt to access beyond end of device
Nov 12 16:12:47 screep kernel: 07:02: rw=0, want=52166660, limit=3145728
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=13041664
Nov 12 16:12:47 screep kernel: attempt to access beyond end of device
Nov 12 16:12:47 screep kernel: 07:02: rw=0, want=51904516, limit=3145728
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=12976128
Nov 12 16:12:47 screep kernel: attempt to access beyond end of device
Nov 12 16:12:47 screep kernel: 07:02: rw=0, want=52166660, limit=3145728
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=13041664
Nov 12 16:12:47 screep kernel: attempt to access beyond end of device
Nov 12 16:12:47 screep kernel: 07:02: rw=0, want=51904516, limit=3145728
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=12976128
Nov 12 16:12:47 screep kernel: attempt to access beyond end of device
Nov 12 16:12:47 screep kernel: 07:02: rw=0, want=52166660, limit=3145728
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=13041664
Nov 12 16:12:47 screep kernel: attempt to access beyond end of device
Nov 12 16:12:47 screep kernel: 07:02: rw=0, want=51904516, limit=3145728
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=12976128
Nov 12 16:12:47 screep kernel: attempt to access beyond end of device
Nov 12 16:12:47 screep kernel: 07:02: rw=0, want=52166660, limit=3145728
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=13041664
Nov 12 16:12:47 screep kernel: attempt to access beyond end of device
Nov 12 16:12:47 screep kernel: 07:02: rw=0, want=51904516, limit=3145728
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=12976128
Nov 12 16:12:47 screep kernel: attempt to access beyond end of device
Nov 12 16:12:47 screep kernel: 07:02: rw=0, want=52166660, limit=3145728
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=13041664
Nov 12 16:12:47 screep kernel: attempt to access beyond end of device
Nov 12 16:12:47 screep kernel: 07:02: rw=0, want=51904516, limit=3145728
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_branches: Read failure, inode=65581, block=12976128
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 1919090688, count 
= 1
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 544210944, count = 
1
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 1852964864, count 
= 1
Nov 12 16:12:47 screep kernel: EXT3-fs error (device loop(7,2)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 540672000, count = 
1
Nov 12 16:12:48 screep kernel: attempt to access beyond end of device
Nov 12 16:12:48 screep kernel: 07:02: rw=1, want=865075204, limit=3145728
Nov 12 16:12:48 screep kernel: attempt to access beyond end of device
Nov 12 16:12:48 screep kernel: 07:02: rw=1, want=868745220, limit=3145728
Nov 12 16:12:48 screep kernel: Assertion failure in 
__journal_remove_journal_head() at journal.c:1783: "buffer_jbd(bh)"
Nov 12 16:12:48 screep kernel: ------------[ cut here ]------------
Nov 12 16:12:48 screep kernel: kernel BUG at journal.c:1783!
Nov 12 16:12:48 screep kernel: invalid operand: 0000
Nov 12 16:12:48 screep kernel: cipher-aes cryptoloop loop cryptoapi 8139too 
mii ipt_REJECT iptable_filter ip_
Nov 12 16:12:48 screep kernel: CPU:    0
Nov 12 16:12:48 screep kernel: EIP:    0010:[<f88149f8>]    Not tainted
Nov 12 16:12:48 screep kernel: EFLAGS: 00010282
Nov 12 16:12:48 screep kernel: 
Nov 12 16:12:48 screep kernel: EIP is at __journal_remove_journal_head [jbd] 
0xe8 (2.4.18-14)
Nov 12 16:12:48 screep kernel: eax: 0000005c   ebx: d4d523c0   ecx: 00000001   
edx: f7ab0000
Nov 12 16:12:48 screep kernel: esi: d9abd550   edi: d9abd580   ebp: d977c790   
esp: f70d5e48
Nov 12 16:12:48 screep kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 16:12:48 screep kernel: Process kjournald (pid: 1562, 
stackpage=f70d5000)
Nov 12 16:12:48 screep kernel: Stack: f8816860 f8815425 f881523e 000006f7 
f8815453 d4d523c0 d9abd550 f8810827 
Nov 12 16:12:48 screep kernel:        d4d523c0 00000040 f70d5ea4 0000086d 
f70d5eb8 f70d4000 f70d4000 c3506af4 
Nov 12 16:12:48 screep kernel:        00000000 00000000 00000000 00000028 
f7acacc0 d8e1ab50 0000086d d49cc2a0 
Nov 12 16:12:48 screep kernel: Call Trace: [<f8816860>] .rodata.str1.32 [jbd] 
0x13a0 (0xf70d5e48))
Nov 12 16:12:48 screep kernel: [<f8815425>] .rodata.str1.1 [jbd] 0x6c5 
(0xf70d5e4c))
Nov 12 16:12:48 screep kernel: [<f881523e>] .rodata.str1.1 [jbd] 0x4de 
(0xf70d5e50))
Nov 12 16:12:48 screep kernel: [<f8815453>] .rodata.str1.1 [jbd] 0x6f3 
(0xf70d5e58))
Nov 12 16:12:48 screep kernel: [<f8810827>] journal_commit_transaction [jbd] 
0x10f7 (0xf70d5e64))
Nov 12 16:12:48 screep kernel: [<f8812c9e>] kjournald [jbd] 0x15e 
(0xf70d5fb4))
Nov 12 16:12:48 screep kernel: [<c01090c4>] ret_from_fork [kernel] 0x0 
(0xf70d5fc0))
Nov 12 16:12:48 screep kernel: [<f8812b20>] commit_timeout [jbd] 0x0 
(0xf70d5fd4))
Nov 12 16:12:48 screep kernel: [<c010744e>] kernel_thread [kernel] 0x2e 
(0xf70d5ff0))
Nov 12 16:12:48 screep kernel: [<f8812b40>] kjournald [jbd] 0x0 (0xf70d5ff8))
Nov 12 16:12:48 screep kernel: 
Nov 12 16:12:48 screep kernel: 
Nov 12 16:12:48 screep kernel: Code: 0f 0b f7 06 3e 52 81 f8 e9 5d ff ff ff 8b 
5c 24 14 8b 74 24 
Nov 12 16:13:00 screep kernel:  no vm86_info: BAD
Nov 12 16:18:16 screep kernel: attempt to access beyond end of device
Nov 12 16:18:16 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:18:16 screep kernel: attempt to access beyond end of device
Nov 12 16:18:16 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:18:16 screep kernel: attempt to access beyond end of device
Nov 12 16:18:16 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:18:16 screep kernel: attempt to access beyond end of device
Nov 12 16:18:16 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:18:16 screep kernel: attempt to access beyond end of device
Nov 12 16:18:16 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:18:16 screep kernel: attempt to access beyond end of device
Nov 12 16:18:16 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:18:16 screep kernel: attempt to access beyond end of device
Nov 12 16:18:16 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:18:16 screep kernel: attempt to access beyond end of device
Nov 12 16:18:16 screep kernel: 07:01: rw=0, want=3168500, limit=3145728
Nov 12 16:20:00 screep kernel: Unable to handle kernel paging request at 
virtual address 0000eff8
Nov 12 16:20:00 screep kernel:  printing eip:
Nov 12 16:20:00 screep kernel: c013d2f5
Nov 12 16:20:00 screep kernel: *pde = 00000000
Nov 12 16:20:00 screep kernel: Oops: 0000
Nov 12 16:20:00 screep kernel: cipher-aes cryptoloop loop cryptoapi 8139too 
mii ipt_REJECT iptable_filter ip_
Nov 12 16:20:00 screep kernel: CPU:    0
Nov 12 16:20:00 screep kernel: EIP:    0010:[<c013d2f5>]    Not tainted
Nov 12 16:20:00 screep kernel: EFLAGS: 00010202
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: EIP is at pte_chain_alloc [kernel] 0x15 
(2.4.18-14)
Nov 12 16:20:00 screep kernel: eax: c0305480   ebx: c0305480   ecx: 00000025   
edx: 0000eff8
Nov 12 16:20:00 screep kernel: esi: f724949c   edi: 3f435065   ebp: c153dba8   
esp: d4029ea8
Nov 12 16:20:00 screep kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 16:20:00 screep kernel: Process crond (pid: 2026, stackpage=d4029000)
Nov 12 16:20:00 screep kernel: Stack: e39f60b0 c153dba8 c013cfd3 c0305480 
c1dd6bc8 c1dd6bc8 c012b6c3 d7f59000 
Nov 12 16:20:00 screep kernel:        ffffb000 00001000 f72b88c0 f6ea7420 
42127518 00000001 c012bf74 f72b88c0 
Nov 12 16:20:00 screep kernel:        e3a18440 42127518 f724949c 3f435065 
0c000000 f72b88c0 f72b88dc 42127518 
Nov 12 16:20:00 screep kernel: Call Trace: [<c013cfd3>] page_add_rmap [kernel] 
0x53 (0xd4029eb0))
Nov 12 16:20:00 screep kernel: [<c012b6c3>] do_wp_page [kernel] 0x183 
(0xd4029ec0))
Nov 12 16:20:00 screep kernel: [<c012bf74>] handle_mm_fault [kernel] 0x114 
(0xd4029ee0))
Nov 12 16:20:00 screep kernel: [<c01169f8>] do_page_fault [kernel] 0x138 
(0xd4029f0c))
Nov 12 16:20:00 screep kernel: [<c01168c0>] do_page_fault [kernel] 0x0 
(0xd4029fb0))
Nov 12 16:20:00 screep kernel: [<c0109200>] error_code [kernel] 0x34 
(0xd4029fb8))
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: Code: 8b 02 89 83 d4 00 00 00 89 d0 c7 02 00 00 
00 00 8b 5c 24 04 
Nov 12 16:20:00 screep kernel:  <1>Unable to handle kernel paging request at 
virtual address 0000eff8
Nov 12 16:20:00 screep kernel:  printing eip:
Nov 12 16:20:00 screep kernel: c013d2f5
Nov 12 16:20:00 screep kernel: *pde = 00000000
Nov 12 16:20:00 screep kernel: Oops: 0000
Nov 12 16:20:00 screep kernel: cipher-aes cryptoloop loop cryptoapi 8139too 
mii ipt_REJECT iptable_filter ip_
Nov 12 16:20:00 screep kernel: CPU:    0
Nov 12 16:20:00 screep kernel: EIP:    0010:[<c013d2f5>]    Not tainted
Nov 12 16:20:00 screep kernel: EFLAGS: 00010202
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: EIP is at pte_chain_alloc [kernel] 0x15 
(2.4.18-14)
Nov 12 16:20:00 screep kernel: eax: c0305480   ebx: c0305480   ecx: c03054c4   
edx: 0000eff8
Nov 12 16:20:00 screep kernel: esi: f0f8b148   edi: f0f8b148   ebp: c1540960   
esp: d4025ea8
Nov 12 16:20:00 screep kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 16:20:00 screep kernel: Process crond (pid: 2028, stackpage=d4025000)
Nov 12 16:20:00 screep kernel: Stack: 00000001 c1540960 c013cfd3 c0305480 
1802a067 c1540960 c012bc20 d802a000 
Nov 12 16:20:00 screep kernel:        00000000 00001000 f72b86c0 f6e8e080 
080524cc 00000001 c012bee9 f72b86c0 
Nov 12 16:20:00 screep kernel:        f722cc00 f0f8b148 00000001 080524cc 
00029815 f72b86c0 f72b86dc 080524cc 
Nov 12 16:20:00 screep kernel: Call Trace: [<c013cfd3>] page_add_rmap [kernel] 
0x53 (0xd4025eb0))
Nov 12 16:20:00 screep kernel: [<c012bc20>] do_anonymous_page [kernel] 0xe0 
(0xd4025ec0))
Nov 12 16:20:00 screep kernel: [<c012bee9>] handle_mm_fault [kernel] 0x89 
(0xd4025ee0))
Nov 12 16:20:00 screep kernel: [<c01169f8>] do_page_fault [kernel] 0x138 
(0xd4025f0c))
Nov 12 16:20:00 screep kernel: [<c012dce9>] do_brk [kernel] 0x219 
(0xd4025f4c))
Nov 12 16:20:00 screep kernel: [<c012c917>] sys_brk [kernel] 0xf7 
(0xd4025f94))
Nov 12 16:20:00 screep kernel: [<c01168c0>] do_page_fault [kernel] 0x0 
(0xd4025fb0))
Nov 12 16:20:00 screep kernel: [<c0109200>] error_code [kernel] 0x34 
(0xd4025fb8))
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: Code: 8b 02 89 83 d4 00 00 00 89 d0 c7 02 00 00 
00 00 8b 5c 24 04 
Nov 12 16:20:00 screep kernel:  <1>Unable to handle kernel paging request at 
virtual address 0000eff8
Nov 12 16:20:00 screep kernel:  printing eip:
Nov 12 16:20:00 screep kernel: c013d2f5
Nov 12 16:20:00 screep kernel: *pde = 00000000
Nov 12 16:20:00 screep kernel: Oops: 0000
Nov 12 16:20:00 screep kernel: cipher-aes cryptoloop loop cryptoapi 8139too 
mii ipt_REJECT iptable_filter ip_
Nov 12 16:20:00 screep kernel: CPU:    0
Nov 12 16:20:00 screep kernel: EIP:    0010:[<c013d2f5>]    Not tainted
Nov 12 16:20:00 screep kernel: EFLAGS: 00010202
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: EIP is at pte_chain_alloc [kernel] 0x15 
(2.4.18-14)
Nov 12 16:20:00 screep kernel: eax: c0305480   ebx: c0305480   ecx: 00000025   
edx: 0000eff8
Nov 12 16:20:00 screep kernel: esi: f72ca140   edi: 3f8ec065   ebp: c1567ba8   
esp: d4023ea8
Nov 12 16:20:00 screep kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 16:20:00 screep kernel: Process crond (pid: 2029, stackpage=d4023000)
Nov 12 16:20:00 screep kernel: Stack: f71f5380 c1567ba8 c013cfd3 c0305480 
c1de73d0 c1de73d0 c012b6c3 d8b59000 
Nov 12 16:20:00 screep kernel:        ffffb000 00001000 f72b8140 f6e93080 
08050344 00000001 c012bf74 f72b8140 
Nov 12 16:20:00 screep kernel:        e39f4ec0 08050344 f72ca140 3f8ec065 
fdfbffd7 f72b8140 f72b815c 08050344 
Nov 12 16:20:00 screep kernel: Call Trace: [<c013cfd3>] page_add_rmap [kernel] 
0x53 (0xd4023eb0))
Nov 12 16:20:00 screep kernel: [<c012b6c3>] do_wp_page [kernel] 0x183 
(0xd4023ec0))
Nov 12 16:20:00 screep kernel: [<c012bf74>] handle_mm_fault [kernel] 0x114 
(0xd4023ee0))
Nov 12 16:20:00 screep kernel: [<c01169f8>] do_page_fault [kernel] 0x138 
(0xd4023f0c))
Nov 12 16:20:00 screep kernel: [<c01168c0>] do_page_fault [kernel] 0x0 
(0xd4023fb0))
Nov 12 16:20:00 screep kernel: [<c0109200>] error_code [kernel] 0x34 
(0xd4023fb8))
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: Code: 8b 02 89 83 d4 00 00 00 89 d0 c7 02 00 00 
00 00 8b 5c 24 04 
Nov 12 16:20:00 screep kernel:  <1>Unable to handle kernel paging request at 
virtual address 0000eff8
Nov 12 16:20:00 screep kernel:  printing eip:
Nov 12 16:20:00 screep kernel: c013d2f5
Nov 12 16:20:00 screep kernel: *pde = 00000000
Nov 12 16:20:00 screep kernel: Oops: 0000
Nov 12 16:20:00 screep kernel: cipher-aes cryptoloop loop cryptoapi 8139too 
mii ipt_REJECT iptable_filter ip_
Nov 12 16:20:00 screep kernel: CPU:    0
Nov 12 16:20:00 screep kernel: EIP:    0010:[<c013d2f5>]    Not tainted
Nov 12 16:20:00 screep kernel: EFLAGS: 00010202
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: EIP is at pte_chain_alloc [kernel] 0x15 
(2.4.18-14)
Nov 12 16:20:00 screep kernel: eax: c0305480   ebx: c0305480   ecx: 00000025   
edx: 0000eff8
Nov 12 16:20:00 screep kernel: esi: d875d140   edi: 3f8ec065   ebp: c194ba10   
esp: d4021ea8
Nov 12 16:20:00 screep kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 16:20:00 screep kernel: Process crond (pid: 2030, stackpage=d4021000)
Nov 12 16:20:00 screep kernel: Stack: f71b16b0 c194ba10 c013cfd3 c0305480 
c1de73d0 c1de73d0 c012b6c3 ea7e4000 
Nov 12 16:20:00 screep kernel:        ffffb000 00001000 f72b8340 f6e99080 
08050344 00000001 c012bf74 f72b8340 
Nov 12 16:20:00 screep kernel:        f72d8740 08050344 d875d140 3f8ec065 
affffffb f72b8340 f72b835c 08050344 
Nov 12 16:20:00 screep kernel: Call Trace: [<c013cfd3>] page_add_rmap [kernel] 
0x53 (0xd4021eb0))
Nov 12 16:20:00 screep kernel: [<c012b6c3>] do_wp_page [kernel] 0x183 
(0xd4021ec0))
Nov 12 16:20:00 screep kernel: [<c012bf74>] handle_mm_fault [kernel] 0x114 
(0xd4021ee0))
Nov 12 16:20:00 screep kernel: [<c01169f8>] do_page_fault [kernel] 0x138 
(0xd4021f0c))
Nov 12 16:20:00 screep kernel: [<c01168c0>] do_page_fault [kernel] 0x0 
(0xd4021fb0))
Nov 12 16:20:00 screep kernel: [<c0109200>] error_code [kernel] 0x34 
(0xd4021fb8))
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: Code: 8b 02 89 83 d4 00 00 00 89 d0 c7 02 00 00 
00 00 8b 5c 24 04 
Nov 12 16:20:00 screep kernel:  <1>Unable to handle kernel paging request at 
virtual address 0000eff8
Nov 12 16:20:00 screep kernel:  printing eip:
Nov 12 16:20:00 screep kernel: c013d2f5
Nov 12 16:20:00 screep kernel: *pde = 00000000
Nov 12 16:20:00 screep kernel: Oops: 0000
Nov 12 16:20:00 screep kernel: cipher-aes cryptoloop loop cryptoapi 8139too 
mii ipt_REJECT iptable_filter ip_
Nov 12 16:20:00 screep kernel: CPU:    0
Nov 12 16:20:00 screep kernel: EIP:    0010:[<c013d2f5>]    Not tainted
Nov 12 16:20:00 screep kernel: EFLAGS: 00010202
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: EIP is at pte_chain_alloc [kernel] 0x15 
(2.4.18-14)
Nov 12 16:20:00 screep kernel: eax: c0305480   ebx: c0305480   ecx: 00000025   
edx: 0000eff8
Nov 12 16:20:00 screep kernel: esi: f76294b0   edi: 3fcf2065   ebp: c19fde90   
esp: d4027ea8
Nov 12 16:20:00 screep kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 16:20:00 screep kernel: Process crond (pid: 2027, stackpage=d4027000)
Nov 12 16:20:00 screep kernel: Stack: f77d9070 c19fde90 c013cfd3 c0305480 
c1df5520 c1df5520 c012b6c3 edad4000 
Nov 12 16:20:00 screep kernel:        ffffb000 00001000 f72b8540 f6e84420 
4212c360 00000001 c012bf74 f72b8540 
Nov 12 16:20:00 screep kernel:        f722c780 4212c360 f76294b0 3fcf2065 
c01a25ac f72b8540 f72b855c 4212c360 
Nov 12 16:20:00 screep kernel: Call Trace: [<c013cfd3>] page_add_rmap [kernel] 
0x53 (0xd4027eb0))
Nov 12 16:20:00 screep kernel: [<c012b6c3>] do_wp_page [kernel] 0x183 
(0xd4027ec0))
Nov 12 16:20:00 screep kernel: [<c012bf74>] handle_mm_fault [kernel] 0x114 
(0xd4027ee0))
Nov 12 16:20:00 screep kernel: [<c01a25ac>] req_finished_io [kernel] 0x4c 
(0xd4027ef8))
Nov 12 16:20:00 screep kernel: [<c01169f8>] do_page_fault [kernel] 0x138 
(0xd4027f0c))
Nov 12 16:20:00 screep kernel: [<c01af532>] ide_do_request [kernel] 0x32 
(0xd4027f40))
Nov 12 16:20:00 screep kernel: [<c0125bc2>] sys_rt_sigaction [kernel] 0x82 
(0xd4027f64))
Nov 12 16:20:00 screep kernel: [<c01ea907>] sys_socketcall [kernel] 0x147 
(0xd4027f80))
Nov 12 16:20:00 screep kernel: [<c013f1fd>] filp_close [kernel] 0x4d 
(0xd4027f98))
Nov 12 16:20:00 screep kernel: [<c01168c0>] do_page_fault [kernel] 0x0 
(0xd4027fb0))
Nov 12 16:20:00 screep kernel: [<c0109200>] error_code [kernel] 0x34 
(0xd4027fb8))
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: 
Nov 12 16:20:00 screep kernel: Code: 8b 02 89 83 d4 00 00 00 89 d0 c7 02 00 00 
00 00 8b 5c 24 04 
Nov 12 16:20:02 screep kernel:  <1>Unable to handle kernel paging request at 
virtual address 0000eff8
Nov 12 16:20:02 screep kernel:  printing eip:
Nov 12 16:20:02 screep kernel: c013d2f5
Nov 12 16:20:02 screep kernel: *pde = 00000000
Nov 12 16:20:02 screep kernel: Oops: 0000
Nov 12 16:20:02 screep kernel: cipher-aes cryptoloop loop cryptoapi 8139too 
mii ipt_REJECT iptable_filter ip_
Nov 12 16:20:02 screep kernel: CPU:    0
Nov 12 16:20:02 screep kernel: EIP:    0010:[<c013d2f5>]    Not tainted
Nov 12 16:20:02 screep kernel: EFLAGS: 00010202
Nov 12 16:20:02 screep kernel: 
Nov 12 16:20:02 screep kernel: EIP is at pte_chain_alloc [kernel] 0x15 
(2.4.18-14)
Nov 12 16:20:02 screep kernel: eax: c0305480   ebx: c0305480   ecx: c03054c4   
edx: 0000eff8
Nov 12 16:20:02 screep kernel: esi: c1e38058   edi: c1e38058   ebp: c147c538   
esp: f767bea8
Nov 12 16:20:02 screep kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 16:20:02 screep kernel: Process nmbd (pid: 742, stackpage=f767b000)
Nov 12 16:20:02 screep kernel: Stack: 00000001 c147c538 c013cfd3 c0305480 
14817067 c147c538 c012bc20 d4817000 
Nov 12 16:20:02 screep kernel:        00000000 00001000 f7feb420 f767c400 
40016000 00000001 c012bee9 f7feb420 
Nov 12 16:20:02 screep kernel:        e3a18d40 c1e38058 00000001 40016000 
c0147ae2 f7feb420 f7feb43c 40016000 
Nov 12 16:20:02 screep kernel: Call Trace: [<c013cfd3>] page_add_rmap [kernel] 
0x53 (0xf767beb0))
Nov 12 16:20:02 screep kernel: [<c012bc20>] do_anonymous_page [kernel] 0xe0 
(0xf767bec0))
Nov 12 16:20:02 screep kernel: [<c012bee9>] handle_mm_fault [kernel] 0x89 
(0xf767bee0))
Nov 12 16:20:02 screep kernel: [<c0147ae2>] cp_new_stat64 [kernel] 0xb2 
(0xf767bef8))
Nov 12 16:20:02 screep kernel: [<c01169f8>] do_page_fault [kernel] 0x138 
(0xf767bf0c))
Nov 12 16:20:02 screep kernel: [<c012cff4>] do_mmap_pgoff [kernel] 0x454 
(0xf767bf44))
Nov 12 16:20:02 screep kernel: [<c010e487>] sys_mmap2 [kernel] 0x77 
(0xf767bf94))
Nov 12 16:20:02 screep kernel: [<c01168c0>] do_page_fault [kernel] 0x0 
(0xf767bfb0))
Nov 12 16:20:02 screep kernel: [<c0109200>] error_code [kernel] 0x34 
(0xf767bfb8))
Nov 12 16:20:02 screep kernel: 
Nov 12 16:20:02 screep kernel: 
Nov 12 16:20:02 screep kernel: Code: 8b 02 89 83 d4 00 00 00 89 d0 c7 02 00 00 
00 00 8b 5c 24 04 
Nov 12 16:20:04 screep kernel:  <1>Unable to handle kernel paging request at 
virtual address 0000eff8
Nov 12 16:20:04 screep kernel:  printing eip:
Nov 12 16:20:04 screep kernel: c013d2f5
Nov 12 16:20:04 screep kernel: *pde = 00000000
Nov 12 16:20:04 screep kernel: Oops: 0000
Nov 12 16:20:04 screep kernel: cipher-aes cryptoloop loop cryptoapi 8139too 
mii ipt_REJECT iptable_filter ip_
Nov 12 16:20:04 screep kernel: CPU:    0
Nov 12 16:20:04 screep kernel: EIP:    0010:[<c013d2f5>]    Not tainted
Nov 12 16:20:04 screep kernel: EFLAGS: 00010202
Nov 12 16:20:04 screep kernel: 
Nov 12 16:20:04 screep kernel: EIP is at pte_chain_alloc [kernel] 0x15 
(2.4.18-14)
Nov 12 16:20:04 screep kernel: eax: c0305480   ebx: c0305480   ecx: 00000000   
edx: 0000eff8
Nov 12 16:20:04 screep kernel: esi: f71d281c   edi: c14eefa8   ebp: f71d281c   
esp: ed201e98
Nov 12 16:20:04 screep kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 16:20:04 screep kernel: Process smbd (pid: 1657, stackpage=ed201000)
Nov 12 16:20:04 screep kernel: Stack: f76a0328 c14eefa8 c013cfd3 c0305480 
f4040960 00000027 c012bd4b f4040960 
Nov 12 16:20:04 screep kernel:        40207000 00000000 00000023 f71accf8 
00000023 00000000 f72b83c0 ed207400 
Nov 12 16:20:04 screep kernel:        40207384 00000000 c012bee9 f72b83c0 
f4040960 40207384 00000000 f71d281c 
Nov 12 16:20:04 screep kernel: Call Trace: [<c013cfd3>] page_add_rmap [kernel] 
0x53 (0xed201ea0))
Nov 12 16:20:04 screep kernel: [<c012bd4b>] do_no_page [kernel] 0xeb 
(0xed201eb0))
Nov 12 16:20:04 screep kernel: [<c012bee9>] handle_mm_fault [kernel] 0x89 
(0xed201ee0))
Nov 12 16:20:04 screep kernel: [<c01169f8>] do_page_fault [kernel] 0x138 
(0xed201f0c))
Nov 12 16:20:04 screep kernel: [<c0152b85>] fcntl_setlk64 [kernel] 0x75 
(0xed201f5c))
Nov 12 16:20:04 screep kernel: [<c014e85d>] sys_fcntl64 [kernel] 0x5d 
(0xed201f9c))
Nov 12 16:20:04 screep kernel: [<c01168c0>] do_page_fault [kernel] 0x0 
(0xed201fb0))
Nov 12 16:20:04 screep kernel: [<c0109200>] error_code [kernel] 0x34 
(0xed201fb8))
Nov 12 16:20:04 screep kernel: 
Nov 12 16:20:04 screep kernel: 
Nov 12 16:20:04 screep kernel: Code: 8b 02 89 83 d4 00 00 00 89 d0 c7 02 00 00 
00 00 8b 5c 24 04 
Nov 12 16:20:08 screep kernel:  <1>Unable to handle kernel paging request at 
virtual address 0000eff8
Nov 12 16:20:08 screep kernel:  printing eip:
Nov 12 16:20:08 screep kernel: c013d2f5
Nov 12 16:20:08 screep kernel: *pde = 00000000
Nov 12 16:20:08 screep kernel: Oops: 0000
Nov 12 16:20:08 screep kernel: cipher-aes cryptoloop loop cryptoapi 8139too 
mii ipt_REJECT iptable_filter ip_
Nov 12 16:20:08 screep kernel: CPU:    0
Nov 12 16:20:08 screep kernel: EIP:    0010:[<c013d2f5>]    Not tainted
Nov 12 16:20:08 screep kernel: EFLAGS: 00010202
Nov 12 16:20:08 screep kernel: 
Nov 12 16:20:08 screep kernel: EIP is at pte_chain_alloc [kernel] 0x15 
(2.4.18-14)
Nov 12 16:20:08 screep kernel: eax: c0305480   ebx: c0305480   ecx: 00000000   
edx: 0000eff8
Nov 12 16:20:08 screep kernel: esi: f741d99c   edi: c1585818   ebp: f741d99c   
esp: f7259e98
Nov 12 16:20:08 screep kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 16:20:08 screep kernel: Process smbd (pid: 1017, stackpage=f7259000)
Nov 12 16:20:08 screep kernel: Stack: f73dd288 c1585818 c013cfd3 c0305480 
e449fcc0 00000027 c012bd4b e449fcc0 
Nov 12 16:20:08 screep kernel:        40267000 00000000 00000029 f726ec78 
00000029 00000000 f7febaa0 f724b400 
Nov 12 16:20:08 screep kernel:        40267750 00000000 c012bee9 f7febaa0 
e449fcc0 40267750 00000000 f741d99c 
Nov 12 16:20:08 screep kernel: Call Trace: [<c013cfd3>] page_add_rmap [kernel] 
0x53 (0xf7259ea0))
Nov 12 16:20:08 screep kernel: [<c012bd4b>] do_no_page [kernel] 0xeb 
(0xf7259eb0))
Nov 12 16:20:08 screep kernel: [<c012bee9>] handle_mm_fault [kernel] 0x89 
(0xf7259ee0))
Nov 12 16:20:08 screep kernel: [<c01169f8>] do_page_fault [kernel] 0x138 
(0xf7259f0c))
Nov 12 16:20:08 screep kernel: [<c0152b85>] fcntl_setlk64 [kernel] 0x75 
(0xf7259f5c))
Nov 12 16:20:08 screep kernel: [<c014e85d>] sys_fcntl64 [kernel] 0x5d 
(0xf7259f9c))
Nov 12 16:20:08 screep kernel: [<c01168c0>] do_page_fault [kernel] 0x0 
(0xf7259fb0))
Nov 12 16:20:08 screep kernel: [<c0109200>] error_code [kernel] 0x34 
(0xf7259fb8))
Nov 12 16:20:08 screep kernel: 
Nov 12 16:20:08 screep kernel: 
Nov 12 16:20:08 screep kernel: Code: 8b 02 89 83 d4 00 00 00 89 d0 c7 02 00 00 
00 00 8b 5c 24 04 
Nov 12 16:24:54 screep kernel:  VM: killing process shutdown
Nov 12 16:24:54 screep kernel: swap_free: Unused swap offset entry 00800000
Nov 12 16:25:10 screep shutdown: shutting down for system reboot
Nov 12 16:25:10 screep init: Switching to runlevel: 6

/proc info:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.53GHz
stepping	: 4
cpu MHz		: 2533.231
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 
clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 5019.12

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
d000-d0ff : LSI Logic / Symbios Logic (formerly NCR) 53c895
d400-d4ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  d400-d4ff : 8139too
d800-d80f : VIA Technologies, Inc. Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
dc00-dc1f : VIA Technologies, Inc. UHCI USB
  dc00-dc1f : usb-uhci
e000-e01f : VIA Technologies, Inc. UHCI USB (#2)
  e000-e01f : usb-uhci
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d8000-000d81ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0024b8dd : Kernel code
  0024b8de-003457a3 : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
c0000000-cfffffff : VIA Technologies, Inc. VT8753 [P4X266 AGP]
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV11 (GeForce2 MX DDR)
d8000000-d9ffffff : PCI Bus #01
  d8000000-d8ffffff : nVidia Corporation NV11 (GeForce2 MX DDR)
db000000-db000fff : LSI Logic / Symbios Logic (formerly NCR) 53c895
db001000-db0010ff : LSI Logic / Symbios Logic (formerly NCR) 53c895
db002000-db0020ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  db002000-db0020ff : 8139too
ffff0000-ffffffff : reserved
00:00.0 Host bridge: VIA Technologies, Inc. VT8753 [P4X266 AGP] (rev 01)
	Subsystem: Elitegroup Computer Systems: Unknown device 0a73
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d8000000-d9ffffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
	Subsystem: Tekram Technology Co.,Ltd. DC-390U2W
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (7500ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at db001000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at db000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Surecom Technology EP-320X-R
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d400 [size=256]
	Region 1: Memory at db002000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: Elitegroup Computer Systems: Unknown device 0a73
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE 
(rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX DDR] 
(rev b2) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>



