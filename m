Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266660AbSLJGZ1>; Tue, 10 Dec 2002 01:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbSLJGZ1>; Tue, 10 Dec 2002 01:25:27 -0500
Received: from ilanz.monex.li ([164.128.93.104]:37547 "EHLO ilanz.monex.li")
	by vger.kernel.org with ESMTP id <S266660AbSLJGZ0>;
	Tue, 10 Dec 2002 01:25:26 -0500
Subject: Problems using /proc/scsi/gdth/ with 2.4.20aa1
From: Oliver Jehle <oliver.jehle@monex.li>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1039502939.1054.12.camel@vorab.monex.li>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Dec 2002 07:49:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running linux 2.4.20-aa1 and the gdth driver works ,but accessing
/proc/scsi/gdth/0 for example with cat or the supplied icpcon utility
don't work...

these messages are in system log when accessing /proc/scsi/gdth/0 with
cat for example (works with 2.4.18)
...

Dec 10 06:37:47 arena1 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Dec 10 06:37:47 arena1 kernel:  printing eip:
Dec 10 06:37:47 arena1 kernel: c024c879
Dec 10 06:37:47 arena1 kernel: *pde = 00000000
Dec 10 06:37:47 arena1 kernel: Oops: 0002 2.4.20aa1 #2 SMP Mon Dec 9
16:55:18 CET 2002
Dec 10 06:37:47 arena1 kernel: CPU:    0
Dec 10 06:37:47 arena1 kernel: EIP:   
0010:[scsi_release_commandblocks+17/92]    Not tainted
Dec 10 06:37:47 arena1 kernel: EFLAGS: 00010046
Dec 10 06:37:47 arena1 kernel: eax: 00000000   ebx: c283c000   ecx:
00000000   edx: 000000bd
Dec 10 06:37:47 arena1 kernel: esi: c283c000   edi: c283c018   ebp:
00000246   esp: c96a1b24
Dec 10 06:37:47 arena1 kernel: ds: 0018   es: 0018   ss: 0018
Dec 10 06:37:47 arena1 kernel: Process cat (pid: 2573,
stackpage=c96a1000)
Dec 10 06:37:47 arena1 kernel: Stack: c283c000 c92ce600 c283c000
c039f000 c024da34 c283c000 c283c018 00000c44
Dec 10 06:37:47 arena1 kernel:        c0258cd8 c283c000 c92ce600
00000c00 00000000 c96af000 00000c00 00000001
Dec 10 06:37:47 arena1 kernel:        c96a1db4 00000a10 c044a0c4
00000060 00000296 c96a1be8 c96a1bd8 c96a1db4
Dec 10 06:37:47 arena1 kernel: Call Trace:    [scsi_free_host_dev+44/56]
[gdth_get_info+4972/5048] [do_no_page+470/844] [handle_mm_fault+125/344]
[do_page_fault+0/1445]
Dec 10 06:37:47 arena1 kernel:   [rb_insert_color+81/196]
[__vma_link+98/176] [error_code+52/60] [__vma_link+98/176]
[error_code+52/60] [clear_user+46/60]
Dec 10 06:37:47 arena1 kernel:   [padzero+28/32]
[load_elf_binary+2381/2760] [load_elf_binary+0/2760]
[__alloc_pages+122/708] [getblk+56/108] [getblk+99/108]
Dec 10 06:37:47 arena1 kernel:   [gdth_proc_info+144/152]
[proc_scsi_read+68/96] [proc_file_read+262/440] [sys_read+143/256]
[system_call+51/56]
Dec 10 06:37:47 arena1 kernel: Code: f0 fe 08 0f 88 68 14 00 00 8b 86 a8
00 00 00 85 c0 74 1c 8d

