Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287532AbSBSSyD>; Tue, 19 Feb 2002 13:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287344AbSBSSxx>; Tue, 19 Feb 2002 13:53:53 -0500
Received: from air-2.osdl.org ([65.201.151.6]:35592 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S287828AbSBSSxF>;
	Tue, 19 Feb 2002 13:53:05 -0500
Date: Tue, 19 Feb 2002 10:48:05 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
cc: <jdthood@mail.com>
Subject: 2.5.4 PNPBIOS fault
Message-ID: <Pine.LNX.4.33L2.0202191042380.1465-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux 2.5.4 with PNPBIOS support enabled:

Looks like a PnP BIOS fault to me (i.e., in the system
BIOS, not the kernel).

System is a 4 GB 4-proc VA Linux 4400.

============================================================

ksymoops 2.4.1 on i686 2.5.4.  Options used
     -v vmlinux-254 (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map-254 (specified)

Unable to handle kernel paging request at virtual address 0000de3a
00004298
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0068:[<00004298>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010093
eax: 00000336   ebx: 00000002   ecx: 0000000f   edx: 0000134f
esi: 00000000   edi: 0000ce5b   ebp: c4d6de3e   esp: c4d6de16
ds: 0018   es: 0018   ss: 0018
Stack: ce5b0093 00000000 de3e0000 de38c4d6 0002c4d6 134f0000 000f0000 03360000
       67db0000 0001c012 4ec1de7a 8fad0000 4da50000 8fa7ce9e ce8f0c40 00000066
       de62de7a 00008fa6 020b000f 0000c16b 58e68dea 8deacd65 2f24c9fd c160c012
Call Trace: [<c020c4d3>] [<c010f7c0>] [<c010f7c0>] [<c018f7c0>] [<c018f7c0>]
   [<c020f7c0>] [<c020f7c0>] [<c028f7c0>] [<c028f7c0>] [<c010f7c1>] [<c010f7c1>]
   [<c018f7c1>] [<c018f7c1>] [<c020f7c1>] [<c020f7c1>] [<c028f7c1>] [<c028f7c1>]
   [<c010f7c2>] [<c010f7c2>] [<c018f7c2>] [<c018f7c2>] [<c020f7c2>] [<c020f7c2>]
   [<c028f7c2>] [<c028f7c2>] [<c010f7c3>] [<c010f7c3>] [<c018f7c3>] [<c018f7c3>]
   [<c020f7c3>] [<c020f7c3>] [<c028f7c3>] [<c028f7c3>] [<c010f7c4>] [<c010f7c4>]
   [<c018f7c4>] [<c018f7c4>] [<c020f7c4>] [<c020f7c4>] [<c028f7c4>] [<c028f7c4>]
   [<c010f7c5>] [<c010f7c5>] [<c018f7c5>] [<c018f7c5>] [<c020f7c5>] [<c020f7c5>]
   [<c028f7c5>] [<c028f7c5>] [<c010f7c6>] [<c010f7c6>] [<c018f7c6>] [<c018f7c6>]
   [<c020f7c6>] [<c020f7c6>] [<c028f7c6>] [<c028f7c6>] [<c010f7c7>] [<c010f7c7>]
   [<c018f7c7>] [<c018f7c7>] [<c020f7c7>] [<c020f7c7>] [<c028f7c7>] [<c028f7c7>]
   [<c010f7c8>] [<c010f7c8>] [<c018f7c8>] [<c018f7c8>] [<c020f7c8>] [<c020f7c8>]
   [<c028f7c8>] [<c028f7c8>] [<c010f7c9>] [<c010f7c9>] [<c018f7c9>] [<c018f7c9>]
   [<c020f7c9>] [<c020f7c9>] [<c028f7c9>] [<c028f7c9>] [<c010f7ca>] [<c010f7ca>]
   [<c018f7ca>] [<c018f7ca>] [<c020f7ca>] [<c020f7ca>] [<c028f7ca>] [<c028f7ca>]
   [<c010f7cb>] [<c010f7cb>] [<c018f7cb>] [<c018f7cb>] [<c020f7cb>] [<c020f7cb>]
   [<c028f7cb>] [<c028f7cb>] [<c010f7cc>] [<c010f7cc>] [<c018f7cc>] [<c018f7cc>]
   [<c020f7cc>] [<c020f7cc>] [<c028f7cc>] [<c028f7cc>] [<c010f7cd>] [<c010f7cd>]
   [<c018f7cd>] [<c018f7cd>] [<c020f7cd>] [<c020f7cd>] [<c028f7cd>] [<c028f7cd>]
   [<c010f7ce>] [<c010f7ce>] [<c018f7ce>] [<c018f7ce>] [<c020f7ce>] [<c020f7ce>]
   [<c028f7ce>] [<c028f7ce>] [<c010f7cf>] [<c010f7cf>] [<c018f7cf>] [<c018f7cf>]
   [<c020f7cf>] [<c020f7cf>] [<c028f7cf>] [<c028f7cf>] [<c010f7d0>] [<c010f7d0>]
   [<c018f7d0>] [<c018f7d0>] [<c020f7d0>] [<c020f7d0>] [<c028f7d0>] [<c028f7d0>]
   [<c010f7d1>] [<c010f7d1>] [<c018f7d1>] [<c018f7d1>] [<c020f7d1>] [<c020f7d1>]
   [<c028f7d1>] [<c028f7d1>] [<c010f7d2>] [<c010f7d2>] [<c018f7d2>] [<c018f7d2>]
   [<c020f7d2>] [<c020f7d2>] [<c028f7d2>] [<c028f7d2>] [<c010f7d3>] [<c010f7d3>]
   [<c018f7d3>] [<c018f7d3>] [<c020f7d3>] [<c020f7d3>] [<c028f7d3>] [<c028f7d3>]
   [<c010f7d4>] [<c010f7d4>] [<c018f7d4>] [<c018f7d4>] [<c020f7d4>] [<c020f7d4>]
   [<c028f7d4>] [<c028f7d4>] [<c010f7d5>] [<c010f7d5>] [<c018f7d5>] [<c018f7d5>]
   [<c020f7d5>] [<c020f7d5>] [<c028f7d5>] [<c028f7d5>] [<c010f7d6>] [<c010f7d6>]
   [<c018f7d6>] [<c018f7d6>] [<c020f7d6>] [<c020f7d6>] [<c028f7d6>] [<c028f7d6>]
   [<c010f7d7>] [<c010f7d7>] [<c018f7d7>] [<c018f7d7>] [<c020f7d7>] [<c020f7d7>]
   [<c028f7d7>] [<c028f7d7>] [<c010f7d8>] [<c010f7d8>] [<c018f7d8>] [<c018f7d8>]
   [<c020f7d8>] [<c020f7d8>] [<c028f7d8>] [<c028f7d8>] [<c010f7d9>] [<c010f7d9>]
   [<c018f7d9>] [<c018f7d9>] [<c020f7d9>] [<c020f7d9>] [<c028f7d9>] [<c028f7d9>]
   [<c010f7da>] [<c010f7da>] [<c018f7da>] [<c018f7da>] [<c020f7da>] [<c020f7da>]
   [<c028f7da>] [<c028f7da>] [<c010f7db>] [<c010f7db>] [<c018f7db>] [<c018f7db>]
   [<c020f7db>] [<c020f7db>] [<c028f7db>] [<c028f7db>] [<c010f7dc>] [<c010f7dc>]
   [<c018f7dc>] [<c018f7dc>] [<c020f7dc>] [<c020f7dc>] [<c028f7dc>] [<c028f7dc>]
   [<c010f7dd>] [<c010f7dd>] [<c018f7dd>] [<c018f7dd>] [<c020f7dd>] [<c020f7dd>]
   [<c028f7dd>] [<c028f7dd>] [<c010f7de>] [<c010f7de>] [<c018f7de>] [<c018f7de>]
   [<c020f7de>] [<c020f7de>] [<c028f7de>] [<c028f7de>] [<c010f7df>] [<c010f7df>]
   [<c018f7df>] [<c018f7df>] [<c020f7df>] [<c020f7df>] [<c028f7df>] [<c028f7df>]
   [<c010f7e0>] [<c010f7e0>] [<c018f7e0>] [<c018f7e0>] [<c020f7e0>] [<c020f7e0>]
   [<c028f7e0>] [<c028f7e0>] [<c010f7e1>] [<c010f7e1>] [<c018f7e1>] [<c018f7e1>]
   [<c020f7e1>] [<c020f7e1>] [<c028f7e1>] [<c028f7e1>] [<c010f7e2>] [<c010f7e2>]
   [<c018f7e2>] [<c018f7e2>] [<c020f7e2>] [<c020f7e2>] [<c028f7e2>] [<c028f7e2>]
   [<c010f7e3>] [<c010f7e3>] [<c018f7e3>] [<c018f7e3>] [<c020f7e3>] [<c020f7e3>]
   [<c028f7e3>] [<c028f7e3>] [<c010f7e4>] [<c010f7e4>] [<c018f7e4>] [<c018f7e4>]
   [<c020f7e4>] [<c020f7e4>] [<c028f7e4>] [<c028f7e4>] [<c010f7e5>] [<c010f7e5>]
   [<c018f7e5>] [<c018f7e5>] [<c020f7e5>] [<c020f7e5>] [<c028f7e5>] [<c028f7e5>]
   [<c010f7e6>] [<c010f7e6>] [<c018f7e6>] [<c018f7e6>] [<c020f7e6>] [<c020f7e6>]
   [<c028f7e6>] [<c028f7e6>] [<c010f7e7>] [<c010f7e7>] [<c018f7e7>] [<c018f7e7>]
   [<c020f7e7>] [<c020f7e7>] [<c028f7e7>] [<c028f7e7>] [<c010f7e8>] [<c010f7e8>]
   [<c018f7e8>] [<c018f7e8>] [<c020f7e8>] [<c020f7e8>] [<c028f7e8>] [<c028f7e8>]
   [<c010f7e9>] [<c010f7e9>] [<c018f7e9>] [<c018f7e9>] [<c020f7e9>] [<c020f7e9>]
   [<c028f7e9>] [<c028f7e9>] [<c010f7ea>] [<c010f7ea>] [<c018f7ea>] [<c018f7ea>]
   [<c020f7ea>] [<c020f7ea>] [<c028f7ea>] [<c028f7ea>] [<c010f7eb>] [<c010f7eb>]
   [<c018f7eb>] [<c018f7eb>] [<c020f7eb>] [<c020f7eb>] [<c028f7eb>] [<c028f7eb>]
   [<c010f7ec>] [<c010f7ec>] [<c018f7ec>] [<c018f7ec>] [<c020f7ec>] [<c020f7ec>]
   [<c028f7ec>] [<c028f7ec>] [<c010f7ed>] [<c010f7ed>] [<c018f7ed>] [<c018f7ed>]
   [<c020f7ed>] [<c020f7ed>] [<c028f7ed>] [<c028f7ed>] [<c010f7ee>] [<c010f7ee>]
   [<c018f7ee>] [<c018f7ee>] [<c020f7ee>] [<c020f7ee>] [<c028f7ee>] [<c028f7ee>]
   [<c010f7ef>] [<c010f7ef>] [<c018f7ef>] [<c018f7ef>] [<c020f7ef>] [<c020f7ef>]
   [<c028f7ef>] [<c028f7ef>] [<c010f7f0>] [<c010f7f0>] [<c018f7f0>] [<c018f7f0>]
   [<c020f7f0>] [<c020f7f0>] [<c028f7f0>] [<c028f7f0>] [<c010f7f1>] [<c010f7f1>]
   [<c018f7f1>] [<c018f7f1>] [<c020f7f1>] [<c020f7f1>] [<c028f7f1>] [<c028f7f1>]
   [<c010f7f2>] [<c010f7f2>] [<c018f7f2>] [<c018f7f2>] [<c020f7f2>] [<c020f7f2>]
   [<c028f7f2>] [<c028f7f2>] [<c010f7f3>] [<c010f7f3>] [<c018f7f3>] [<c018f7f3>]
   [<c020f7f3>] [<c020f7f3>] [<c028f7f3>] [<c028f7f3>] [<c010f7f4>] [<c010f7f4>]
   [<c018f7f4>] [<c018f7f4>] [<c020f7f4>] [<c020f7f4>] [<c028f7f4>] [<c028f7f4>]
   [<c010f7f5>] [<c010f7f5>] [<c018f7f5>] [<c018f7f5>] [<c020f7f5>] [<c020f7f5>]
   [<c028f7f5>] [<c028f7f5>] [<c010f7f6>] [<c010f7f6>] [<c018f7f6>] [<c018f7f6>]
   [<c020f7f6>] [<c020f7f6>] [<c028f7f6>] [<c028f7f6>] [<c010f7f7>] [<c010f7f7>]
   [<c018f7f7>] [<c018f7f7>] [<c020f7f7>] [<c020f7f7>] [<c028f7f7>] [<c028f7f7>]
   [<c010f7f8>] [<c010f7f8>] [<c018f7f8>] [<c018f7f8>] [<c020f7f8>] [<c020f7f8>]
   [<c028f7f8>] [<c028f7f8>] [<c010f7f9>] [<c010f7f9>] [<c018f7f9>] [<c018f7f9>]
   [<c020f7f9>] [<c020f7f9>] [<c028f7f9>] [<c028f7f9>] [<c010f7fa>] [<c010f7fa>]
   [<c018f7fa>] [<c018f7fa>] [<c020f7fa>] [<c020f7fa>] [<c028f7fa>] [<c028f7fa>]
   [<c010f7fb>] [<c010f7fb>] [<c018f7fb>] [<c018f7fb>] [<c020f7fb>] [<c020f7fb>]
   [<c028f7fb>] [<c028f7fb>] [<c010f7fc>] [<c010f7fc>] [<c018f7fc>] [<c018f7fc>]
   [<c020f7fc>] [<c020f7fc>] [<c028f7fc>] [<c028f7fc>] [<c010f7fd>] [<c010f7fd>]
   [<c018f7fd>] [<c018f7fd>] [<c020f7fd>] [<c020f7fd>] [<c028f7fd>] [<c028f7fd>]
   [<c010f7fe>] [<c010f7fe>] [<c018f7fe>] [<c018f7fe>] [<c020f7fe>] [<c020f7fe>]
   [<c028f7fe>] [<c028f7fe>] [<c010f7ff>] [<c010f7ff>] [<c018f7ff>] [<c018f7ff>]
   [<c020f7ff>] [<c020f7ff>] [<c028f7ff>] [<c028f7ff>]
   <1>Unable to handle kernel paging request at virtual address f8000000
c0109282
*pde = 00000000
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; 00004298 Before first symbol   <=====
Trace; c020c4d3 <ide_wait_taskfile+6f/10c>
Trace; c010f7c0 <restore_i387+154/1c4>
Trace; c010f7c0 <restore_i387+154/1c4>
Trace; c018f7c0 <fat_fill_inode+7c/23c>
Trace; c018f7c0 <fat_fill_inode+7c/23c>
Trace; c020f7c0 <revalidate_drives+28/70>
Trace; c020f7c0 <revalidate_drives+28/70>
Trace; c028f7c0 <tcp_clean_rtx_queue+2e4/304>
Trace; c028f7c0 <tcp_clean_rtx_queue+2e4/304>
Trace; c010f7c1 <restore_i387+155/1c4>
Trace; c010f7c1 <restore_i387+155/1c4>
Trace; c018f7c1 <fat_fill_inode+7d/23c>
Trace; c018f7c1 <fat_fill_inode+7d/23c>
Trace; c020f7c1 <revalidate_drives+29/70>
Trace; c020f7c1 <revalidate_drives+29/70>
Trace; c028f7c1 <tcp_clean_rtx_queue+2e5/304>
Trace; c028f7c1 <tcp_clean_rtx_queue+2e5/304>
Trace; c010f7c2 <restore_i387+156/1c4>
Trace; c010f7c2 <restore_i387+156/1c4>
Trace; c018f7c2 <fat_fill_inode+7e/23c>
Trace; c018f7c2 <fat_fill_inode+7e/23c>
Trace; c020f7c2 <revalidate_drives+2a/70>
Trace; c020f7c2 <revalidate_drives+2a/70>
Trace; c028f7c2 <tcp_clean_rtx_queue+2e6/304>
Trace; c028f7c2 <tcp_clean_rtx_queue+2e6/304>
Trace; c010f7c3 <restore_i387+157/1c4>
Trace; c010f7c3 <restore_i387+157/1c4>
Trace; c018f7c3 <fat_fill_inode+7f/23c>
Trace; c018f7c3 <fat_fill_inode+7f/23c>
Trace; c020f7c3 <revalidate_drives+2b/70>
Trace; c020f7c3 <revalidate_drives+2b/70>
Trace; c028f7c3 <tcp_clean_rtx_queue+2e7/304>
Trace; c028f7c3 <tcp_clean_rtx_queue+2e7/304>
Trace; c010f7c4 <restore_i387+158/1c4>
Trace; c010f7c4 <restore_i387+158/1c4>
Trace; c018f7c4 <fat_fill_inode+80/23c>
Trace; c018f7c4 <fat_fill_inode+80/23c>
Trace; c020f7c4 <revalidate_drives+2c/70>
Trace; c020f7c4 <revalidate_drives+2c/70>
Trace; c028f7c4 <tcp_clean_rtx_queue+2e8/304>
Trace; c028f7c4 <tcp_clean_rtx_queue+2e8/304>
Trace; c010f7c5 <restore_i387+159/1c4>
Trace; c010f7c5 <restore_i387+159/1c4>
Trace; c018f7c5 <fat_fill_inode+81/23c>
Trace; c018f7c5 <fat_fill_inode+81/23c>
Trace; c020f7c5 <revalidate_drives+2d/70>
Trace; c020f7c5 <revalidate_drives+2d/70>
Trace; c028f7c5 <tcp_clean_rtx_queue+2e9/304>
Trace; c028f7c5 <tcp_clean_rtx_queue+2e9/304>
Trace; c010f7c6 <restore_i387+15a/1c4>
Trace; c010f7c6 <restore_i387+15a/1c4>
Trace; c018f7c6 <fat_fill_inode+82/23c>
Trace; c018f7c6 <fat_fill_inode+82/23c>
Trace; c020f7c6 <revalidate_drives+2e/70>
Trace; c020f7c6 <revalidate_drives+2e/70>
Trace; c028f7c6 <tcp_clean_rtx_queue+2ea/304>
Trace; c028f7c6 <tcp_clean_rtx_queue+2ea/304>
Trace; c010f7c7 <restore_i387+15b/1c4>
Trace; c010f7c7 <restore_i387+15b/1c4>
Trace; c018f7c7 <fat_fill_inode+83/23c>
Trace; c018f7c7 <fat_fill_inode+83/23c>
Trace; c020f7c7 <revalidate_drives+2f/70>
Trace; c020f7c7 <revalidate_drives+2f/70>
Trace; c028f7c7 <tcp_clean_rtx_queue+2eb/304>
Trace; c028f7c7 <tcp_clean_rtx_queue+2eb/304>
Trace; c010f7c8 <restore_i387+15c/1c4>
Trace; c010f7c8 <restore_i387+15c/1c4>
Trace; c018f7c8 <fat_fill_inode+84/23c>
Trace; c018f7c8 <fat_fill_inode+84/23c>
Trace; c020f7c8 <revalidate_drives+30/70>
Trace; c020f7c8 <revalidate_drives+30/70>
Trace; c028f7c8 <tcp_clean_rtx_queue+2ec/304>
Trace; c028f7c8 <tcp_clean_rtx_queue+2ec/304>
Trace; c010f7c9 <restore_i387+15d/1c4>
Trace; c010f7c9 <restore_i387+15d/1c4>
Trace; c018f7c9 <fat_fill_inode+85/23c>
Trace; c018f7c9 <fat_fill_inode+85/23c>
Trace; c020f7c9 <revalidate_drives+31/70>
Trace; c020f7c9 <revalidate_drives+31/70>
Trace; c028f7c9 <tcp_clean_rtx_queue+2ed/304>
Trace; c028f7c9 <tcp_clean_rtx_queue+2ed/304>
Trace; c010f7ca <restore_i387+15e/1c4>
Trace; c010f7ca <restore_i387+15e/1c4>
Trace; c018f7ca <fat_fill_inode+86/23c>
Trace; c018f7ca <fat_fill_inode+86/23c>
Trace; c020f7ca <revalidate_drives+32/70>
Trace; c020f7ca <revalidate_drives+32/70>
Trace; c028f7ca <tcp_clean_rtx_queue+2ee/304>
Trace; c028f7ca <tcp_clean_rtx_queue+2ee/304>
Trace; c010f7cb <restore_i387+15f/1c4>
Trace; c010f7cb <restore_i387+15f/1c4>
Trace; c018f7cb <fat_fill_inode+87/23c>
Trace; c018f7cb <fat_fill_inode+87/23c>
Trace; c020f7cb <revalidate_drives+33/70>
Trace; c020f7cb <revalidate_drives+33/70>
Trace; c028f7cb <tcp_clean_rtx_queue+2ef/304>
Trace; c028f7cb <tcp_clean_rtx_queue+2ef/304>
Trace; c010f7cc <restore_i387+160/1c4>
Trace; c010f7cc <restore_i387+160/1c4>
Trace; c018f7cc <fat_fill_inode+88/23c>
Trace; c018f7cc <fat_fill_inode+88/23c>
Trace; c020f7cc <revalidate_drives+34/70>
Trace; c020f7cc <revalidate_drives+34/70>
Trace; c028f7cc <tcp_clean_rtx_queue+2f0/304>
Trace; c028f7cc <tcp_clean_rtx_queue+2f0/304>
Trace; c010f7cd <restore_i387+161/1c4>
Trace; c010f7cd <restore_i387+161/1c4>
Trace; c018f7cd <fat_fill_inode+89/23c>
Trace; c018f7cd <fat_fill_inode+89/23c>
Trace; c020f7cd <revalidate_drives+35/70>
Trace; c020f7cd <revalidate_drives+35/70>
Trace; c028f7cd <tcp_clean_rtx_queue+2f1/304>
Trace; c028f7cd <tcp_clean_rtx_queue+2f1/304>
Trace; c010f7ce <restore_i387+162/1c4>
Trace; c010f7ce <restore_i387+162/1c4>
Trace; c018f7ce <fat_fill_inode+8a/23c>
Trace; c018f7ce <fat_fill_inode+8a/23c>
Trace; c020f7ce <revalidate_drives+36/70>
Trace; c020f7ce <revalidate_drives+36/70>
Trace; c028f7ce <tcp_clean_rtx_queue+2f2/304>
Trace; c028f7ce <tcp_clean_rtx_queue+2f2/304>
Trace; c010f7cf <restore_i387+163/1c4>
Trace; c010f7cf <restore_i387+163/1c4>
Trace; c018f7cf <fat_fill_inode+8b/23c>
Trace; c018f7cf <fat_fill_inode+8b/23c>
Trace; c020f7cf <revalidate_drives+37/70>
Trace; c020f7cf <revalidate_drives+37/70>
Trace; c028f7cf <tcp_clean_rtx_queue+2f3/304>
Trace; c028f7cf <tcp_clean_rtx_queue+2f3/304>
Trace; c010f7d0 <restore_i387+164/1c4>
Trace; c010f7d0 <restore_i387+164/1c4>
Trace; c018f7d0 <fat_fill_inode+8c/23c>
Trace; c018f7d0 <fat_fill_inode+8c/23c>
Trace; c020f7d0 <revalidate_drives+38/70>
Trace; c020f7d0 <revalidate_drives+38/70>
Trace; c028f7d0 <tcp_clean_rtx_queue+2f4/304>
Trace; c028f7d0 <tcp_clean_rtx_queue+2f4/304>
Trace; c010f7d1 <restore_i387+165/1c4>
Trace; c010f7d1 <restore_i387+165/1c4>
Trace; c018f7d1 <fat_fill_inode+8d/23c>
Trace; c018f7d1 <fat_fill_inode+8d/23c>
Trace; c020f7d1 <revalidate_drives+39/70>
Trace; c020f7d1 <revalidate_drives+39/70>
Trace; c028f7d1 <tcp_clean_rtx_queue+2f5/304>
Trace; c028f7d1 <tcp_clean_rtx_queue+2f5/304>
Trace; c010f7d2 <restore_i387+166/1c4>
Trace; c010f7d2 <restore_i387+166/1c4>
Trace; c018f7d2 <fat_fill_inode+8e/23c>
Trace; c018f7d2 <fat_fill_inode+8e/23c>
Trace; c020f7d2 <revalidate_drives+3a/70>
Trace; c020f7d2 <revalidate_drives+3a/70>
Trace; c028f7d2 <tcp_clean_rtx_queue+2f6/304>
Trace; c028f7d2 <tcp_clean_rtx_queue+2f6/304>
Trace; c010f7d3 <restore_i387+167/1c4>
Trace; c010f7d3 <restore_i387+167/1c4>
Trace; c018f7d3 <fat_fill_inode+8f/23c>
Trace; c018f7d3 <fat_fill_inode+8f/23c>
Trace; c020f7d3 <revalidate_drives+3b/70>
Trace; c020f7d3 <revalidate_drives+3b/70>
Trace; c028f7d3 <tcp_clean_rtx_queue+2f7/304>
Trace; c028f7d3 <tcp_clean_rtx_queue+2f7/304>
Trace; c010f7d4 <restore_i387+168/1c4>
Trace; c010f7d4 <restore_i387+168/1c4>
Trace; c018f7d4 <fat_fill_inode+90/23c>
Trace; c018f7d4 <fat_fill_inode+90/23c>
Trace; c020f7d4 <revalidate_drives+3c/70>
Trace; c020f7d4 <revalidate_drives+3c/70>
Trace; c028f7d4 <tcp_clean_rtx_queue+2f8/304>
Trace; c028f7d4 <tcp_clean_rtx_queue+2f8/304>
Trace; c010f7d5 <restore_i387+169/1c4>
Trace; c010f7d5 <restore_i387+169/1c4>
Trace; c018f7d5 <fat_fill_inode+91/23c>
Trace; c018f7d5 <fat_fill_inode+91/23c>
Trace; c020f7d5 <revalidate_drives+3d/70>
Trace; c020f7d5 <revalidate_drives+3d/70>
Trace; c028f7d5 <tcp_clean_rtx_queue+2f9/304>
Trace; c028f7d5 <tcp_clean_rtx_queue+2f9/304>
Trace; c010f7d6 <restore_i387+16a/1c4>
Trace; c010f7d6 <restore_i387+16a/1c4>
Trace; c018f7d6 <fat_fill_inode+92/23c>
Trace; c018f7d6 <fat_fill_inode+92/23c>
Trace; c020f7d6 <revalidate_drives+3e/70>
Trace; c020f7d6 <revalidate_drives+3e/70>
Trace; c028f7d6 <tcp_clean_rtx_queue+2fa/304>
Trace; c028f7d6 <tcp_clean_rtx_queue+2fa/304>
Trace; c010f7d7 <restore_i387+16b/1c4>
Trace; c010f7d7 <restore_i387+16b/1c4>
Trace; c018f7d7 <fat_fill_inode+93/23c>
Trace; c018f7d7 <fat_fill_inode+93/23c>
Trace; c020f7d7 <revalidate_drives+3f/70>
Trace; c020f7d7 <revalidate_drives+3f/70>
Trace; c028f7d7 <tcp_clean_rtx_queue+2fb/304>
Trace; c028f7d7 <tcp_clean_rtx_queue+2fb/304>
Trace; c010f7d8 <restore_i387+16c/1c4>
Trace; c010f7d8 <restore_i387+16c/1c4>
Trace; c018f7d8 <fat_fill_inode+94/23c>
Trace; c018f7d8 <fat_fill_inode+94/23c>
Trace; c020f7d8 <revalidate_drives+40/70>
Trace; c020f7d8 <revalidate_drives+40/70>
Trace; c028f7d8 <tcp_clean_rtx_queue+2fc/304>
Trace; c028f7d8 <tcp_clean_rtx_queue+2fc/304>
Trace; c010f7d9 <restore_i387+16d/1c4>
Trace; c010f7d9 <restore_i387+16d/1c4>
Trace; c018f7d9 <fat_fill_inode+95/23c>
Trace; c018f7d9 <fat_fill_inode+95/23c>
Trace; c020f7d9 <revalidate_drives+41/70>
Trace; c020f7d9 <revalidate_drives+41/70>
Trace; c028f7d9 <tcp_clean_rtx_queue+2fd/304>
Trace; c028f7d9 <tcp_clean_rtx_queue+2fd/304>
Trace; c010f7da <restore_i387+16e/1c4>
Trace; c010f7da <restore_i387+16e/1c4>
Trace; c018f7da <fat_fill_inode+96/23c>
Trace; c018f7da <fat_fill_inode+96/23c>
Trace; c020f7da <revalidate_drives+42/70>
Trace; c020f7da <revalidate_drives+42/70>
Trace; c028f7da <tcp_clean_rtx_queue+2fe/304>
Trace; c028f7da <tcp_clean_rtx_queue+2fe/304>
Trace; c010f7db <restore_i387+16f/1c4>
Trace; c010f7db <restore_i387+16f/1c4>
Trace; c018f7db <fat_fill_inode+97/23c>
Trace; c018f7db <fat_fill_inode+97/23c>
Trace; c020f7db <revalidate_drives+43/70>
Trace; c020f7db <revalidate_drives+43/70>
Trace; c028f7db <tcp_clean_rtx_queue+2ff/304>
Trace; c028f7db <tcp_clean_rtx_queue+2ff/304>
Trace; c010f7dc <restore_i387+170/1c4>
Trace; c010f7dc <restore_i387+170/1c4>
Trace; c018f7dc <fat_fill_inode+98/23c>
Trace; c018f7dc <fat_fill_inode+98/23c>
Trace; c020f7dc <revalidate_drives+44/70>
Trace; c020f7dc <revalidate_drives+44/70>
Trace; c028f7dc <tcp_clean_rtx_queue+300/304>
Trace; c028f7dc <tcp_clean_rtx_queue+300/304>
Trace; c010f7dd <restore_i387+171/1c4>
Trace; c010f7dd <restore_i387+171/1c4>
Trace; c018f7dd <fat_fill_inode+99/23c>
Trace; c018f7dd <fat_fill_inode+99/23c>
Trace; c020f7dd <revalidate_drives+45/70>
Trace; c020f7dd <revalidate_drives+45/70>
Trace; c028f7dd <tcp_clean_rtx_queue+301/304>
Trace; c028f7dd <tcp_clean_rtx_queue+301/304>
Trace; c010f7de <restore_i387+172/1c4>
Trace; c010f7de <restore_i387+172/1c4>
Trace; c018f7de <fat_fill_inode+9a/23c>
Trace; c018f7de <fat_fill_inode+9a/23c>
Trace; c020f7de <revalidate_drives+46/70>
Trace; c020f7de <revalidate_drives+46/70>
Trace; c028f7de <tcp_clean_rtx_queue+302/304>
Trace; c028f7de <tcp_clean_rtx_queue+302/304>
Trace; c010f7df <restore_i387+173/1c4>
Trace; c010f7df <restore_i387+173/1c4>
Trace; c018f7df <fat_fill_inode+9b/23c>
Trace; c018f7df <fat_fill_inode+9b/23c>
Trace; c020f7df <revalidate_drives+47/70>
Trace; c020f7df <revalidate_drives+47/70>
Trace; c028f7df <tcp_clean_rtx_queue+303/304>
Trace; c028f7df <tcp_clean_rtx_queue+303/304>
Trace; c010f7e0 <restore_i387+174/1c4>
Trace; c010f7e0 <restore_i387+174/1c4>
Trace; c018f7e0 <fat_fill_inode+9c/23c>
Trace; c018f7e0 <fat_fill_inode+9c/23c>
Trace; c020f7e0 <revalidate_drives+48/70>
Trace; c020f7e0 <revalidate_drives+48/70>
Trace; c028f7e0 <tcp_ack_probe+0/a4>
Trace; c028f7e0 <tcp_ack_probe+0/a4>
Trace; c010f7e1 <restore_i387+175/1c4>
Trace; c010f7e1 <restore_i387+175/1c4>
Trace; c018f7e1 <fat_fill_inode+9d/23c>
Trace; c018f7e1 <fat_fill_inode+9d/23c>
Trace; c020f7e1 <revalidate_drives+49/70>
Trace; c020f7e1 <revalidate_drives+49/70>
Trace; c028f7e1 <tcp_ack_probe+1/a4>
Trace; c028f7e1 <tcp_ack_probe+1/a4>
Trace; c010f7e2 <restore_i387+176/1c4>
Trace; c010f7e2 <restore_i387+176/1c4>
Trace; c018f7e2 <fat_fill_inode+9e/23c>
Trace; c018f7e2 <fat_fill_inode+9e/23c>
Trace; c020f7e2 <revalidate_drives+4a/70>
Trace; c020f7e2 <revalidate_drives+4a/70>
Trace; c028f7e2 <tcp_ack_probe+2/a4>
Trace; c028f7e2 <tcp_ack_probe+2/a4>
Trace; c010f7e3 <restore_i387+177/1c4>
Trace; c010f7e3 <restore_i387+177/1c4>
Trace; c018f7e3 <fat_fill_inode+9f/23c>
Trace; c018f7e3 <fat_fill_inode+9f/23c>
Trace; c020f7e3 <revalidate_drives+4b/70>
Trace; c020f7e3 <revalidate_drives+4b/70>
Trace; c028f7e3 <tcp_ack_probe+3/a4>
Trace; c028f7e3 <tcp_ack_probe+3/a4>
Trace; c010f7e4 <restore_i387+178/1c4>
Trace; c010f7e4 <restore_i387+178/1c4>
Trace; c018f7e4 <fat_fill_inode+a0/23c>
Trace; c018f7e4 <fat_fill_inode+a0/23c>
Trace; c020f7e4 <revalidate_drives+4c/70>
Trace; c020f7e4 <revalidate_drives+4c/70>
Trace; c028f7e4 <tcp_ack_probe+4/a4>
Trace; c028f7e4 <tcp_ack_probe+4/a4>
Trace; c010f7e5 <restore_i387+179/1c4>
Trace; c010f7e5 <restore_i387+179/1c4>
Trace; c018f7e5 <fat_fill_inode+a1/23c>
Trace; c018f7e5 <fat_fill_inode+a1/23c>
Trace; c020f7e5 <revalidate_drives+4d/70>
Trace; c020f7e5 <revalidate_drives+4d/70>
Trace; c028f7e5 <tcp_ack_probe+5/a4>
Trace; c028f7e5 <tcp_ack_probe+5/a4>
Trace; c010f7e6 <restore_i387+17a/1c4>
Trace; c010f7e6 <restore_i387+17a/1c4>
Trace; c018f7e6 <fat_fill_inode+a2/23c>
Trace; c018f7e6 <fat_fill_inode+a2/23c>
Trace; c020f7e6 <revalidate_drives+4e/70>
Trace; c020f7e6 <revalidate_drives+4e/70>
Trace; c028f7e6 <tcp_ack_probe+6/a4>
Trace; c028f7e6 <tcp_ack_probe+6/a4>
Trace; c010f7e7 <restore_i387+17b/1c4>
Trace; c010f7e7 <restore_i387+17b/1c4>
Trace; c018f7e7 <fat_fill_inode+a3/23c>
Trace; c018f7e7 <fat_fill_inode+a3/23c>
Trace; c020f7e7 <revalidate_drives+4f/70>
Trace; c020f7e7 <revalidate_drives+4f/70>
Trace; c028f7e7 <tcp_ack_probe+7/a4>
Trace; c028f7e7 <tcp_ack_probe+7/a4>
Trace; c010f7e8 <restore_i387+17c/1c4>
Trace; c010f7e8 <restore_i387+17c/1c4>
Trace; c018f7e8 <fat_fill_inode+a4/23c>
Trace; c018f7e8 <fat_fill_inode+a4/23c>
Trace; c020f7e8 <revalidate_drives+50/70>
Trace; c020f7e8 <revalidate_drives+50/70>
Trace; c028f7e8 <tcp_ack_probe+8/a4>
Trace; c028f7e8 <tcp_ack_probe+8/a4>
Trace; c010f7e9 <restore_i387+17d/1c4>
Trace; c010f7e9 <restore_i387+17d/1c4>
Trace; c018f7e9 <fat_fill_inode+a5/23c>
Trace; c018f7e9 <fat_fill_inode+a5/23c>
Trace; c020f7e9 <revalidate_drives+51/70>
Trace; c020f7e9 <revalidate_drives+51/70>
Trace; c028f7e9 <tcp_ack_probe+9/a4>
Trace; c028f7e9 <tcp_ack_probe+9/a4>
Trace; c010f7ea <restore_i387+17e/1c4>
Trace; c010f7ea <restore_i387+17e/1c4>
Trace; c018f7ea <fat_fill_inode+a6/23c>
Trace; c018f7ea <fat_fill_inode+a6/23c>
Trace; c020f7ea <revalidate_drives+52/70>
Trace; c020f7ea <revalidate_drives+52/70>
Trace; c028f7ea <tcp_ack_probe+a/a4>
Trace; c028f7ea <tcp_ack_probe+a/a4>
Trace; c010f7eb <restore_i387+17f/1c4>
Trace; c010f7eb <restore_i387+17f/1c4>
Trace; c018f7eb <fat_fill_inode+a7/23c>
Trace; c018f7eb <fat_fill_inode+a7/23c>
Trace; c020f7eb <revalidate_drives+53/70>
Trace; c020f7eb <revalidate_drives+53/70>
Trace; c028f7eb <tcp_ack_probe+b/a4>
Trace; c028f7eb <tcp_ack_probe+b/a4>
Trace; c010f7ec <restore_i387+180/1c4>
Trace; c010f7ec <restore_i387+180/1c4>
Trace; c018f7ec <fat_fill_inode+a8/23c>
Trace; c018f7ec <fat_fill_inode+a8/23c>
Trace; c020f7ec <revalidate_drives+54/70>
Trace; c020f7ec <revalidate_drives+54/70>
Trace; c028f7ec <tcp_ack_probe+c/a4>
Trace; c028f7ec <tcp_ack_probe+c/a4>
Trace; c010f7ed <restore_i387+181/1c4>
Trace; c010f7ed <restore_i387+181/1c4>
Trace; c018f7ed <fat_fill_inode+a9/23c>
Trace; c018f7ed <fat_fill_inode+a9/23c>
Trace; c020f7ed <revalidate_drives+55/70>
Trace; c020f7ed <revalidate_drives+55/70>
Trace; c028f7ed <tcp_ack_probe+d/a4>
Trace; c028f7ed <tcp_ack_probe+d/a4>
Trace; c010f7ee <restore_i387+182/1c4>
Trace; c010f7ee <restore_i387+182/1c4>
Trace; c018f7ee <fat_fill_inode+aa/23c>
Trace; c018f7ee <fat_fill_inode+aa/23c>
Trace; c020f7ee <revalidate_drives+56/70>
Trace; c020f7ee <revalidate_drives+56/70>
Trace; c028f7ee <tcp_ack_probe+e/a4>
Trace; c028f7ee <tcp_ack_probe+e/a4>
Trace; c010f7ef <restore_i387+183/1c4>
Trace; c010f7ef <restore_i387+183/1c4>
Trace; c018f7ef <fat_fill_inode+ab/23c>
Trace; c018f7ef <fat_fill_inode+ab/23c>
Trace; c020f7ef <revalidate_drives+57/70>
Trace; c020f7ef <revalidate_drives+57/70>
Trace; c028f7ef <tcp_ack_probe+f/a4>
Trace; c028f7ef <tcp_ack_probe+f/a4>
Trace; c010f7f0 <restore_i387+184/1c4>
Trace; c010f7f0 <restore_i387+184/1c4>
Trace; c018f7f0 <fat_fill_inode+ac/23c>
Trace; c018f7f0 <fat_fill_inode+ac/23c>
Trace; c020f7f0 <revalidate_drives+58/70>
Trace; c020f7f0 <revalidate_drives+58/70>
Trace; c028f7f0 <tcp_ack_probe+10/a4>
Trace; c028f7f0 <tcp_ack_probe+10/a4>
Trace; c010f7f1 <restore_i387+185/1c4>
Trace; c010f7f1 <restore_i387+185/1c4>
Trace; c018f7f1 <fat_fill_inode+ad/23c>
Trace; c018f7f1 <fat_fill_inode+ad/23c>
Trace; c020f7f1 <revalidate_drives+59/70>
Trace; c020f7f1 <revalidate_drives+59/70>
Trace; c028f7f1 <tcp_ack_probe+11/a4>
Trace; c028f7f1 <tcp_ack_probe+11/a4>
Trace; c010f7f2 <restore_i387+186/1c4>
Trace; c010f7f2 <restore_i387+186/1c4>
Trace; c018f7f2 <fat_fill_inode+ae/23c>
Trace; c018f7f2 <fat_fill_inode+ae/23c>
Trace; c020f7f2 <revalidate_drives+5a/70>
Trace; c020f7f2 <revalidate_drives+5a/70>
Trace; c028f7f2 <tcp_ack_probe+12/a4>
Trace; c028f7f2 <tcp_ack_probe+12/a4>
Trace; c010f7f3 <restore_i387+187/1c4>
Trace; c010f7f3 <restore_i387+187/1c4>
Trace; c018f7f3 <fat_fill_inode+af/23c>
Trace; c018f7f3 <fat_fill_inode+af/23c>
Trace; c020f7f3 <revalidate_drives+5b/70>
Trace; c020f7f3 <revalidate_drives+5b/70>
Trace; c028f7f3 <tcp_ack_probe+13/a4>
Trace; c028f7f3 <tcp_ack_probe+13/a4>
Trace; c010f7f4 <restore_i387+188/1c4>
Trace; c010f7f4 <restore_i387+188/1c4>
Trace; c018f7f4 <fat_fill_inode+b0/23c>
Trace; c018f7f4 <fat_fill_inode+b0/23c>
Trace; c020f7f4 <revalidate_drives+5c/70>
Trace; c020f7f4 <revalidate_drives+5c/70>
Trace; c028f7f4 <tcp_ack_probe+14/a4>
Trace; c028f7f4 <tcp_ack_probe+14/a4>
Trace; c010f7f5 <restore_i387+189/1c4>
Trace; c010f7f5 <restore_i387+189/1c4>
Trace; c018f7f5 <fat_fill_inode+b1/23c>
Trace; c018f7f5 <fat_fill_inode+b1/23c>
Trace; c020f7f5 <revalidate_drives+5d/70>
Trace; c020f7f5 <revalidate_drives+5d/70>
Trace; c028f7f5 <tcp_ack_probe+15/a4>
Trace; c028f7f5 <tcp_ack_probe+15/a4>
Trace; c010f7f6 <restore_i387+18a/1c4>
Trace; c010f7f6 <restore_i387+18a/1c4>
Trace; c018f7f6 <fat_fill_inode+b2/23c>
Trace; c018f7f6 <fat_fill_inode+b2/23c>
Trace; c020f7f6 <revalidate_drives+5e/70>
Trace; c020f7f6 <revalidate_drives+5e/70>
Trace; c028f7f6 <tcp_ack_probe+16/a4>
Trace; c028f7f6 <tcp_ack_probe+16/a4>
Trace; c010f7f7 <restore_i387+18b/1c4>
Trace; c010f7f7 <restore_i387+18b/1c4>
Trace; c018f7f7 <fat_fill_inode+b3/23c>
Trace; c018f7f7 <fat_fill_inode+b3/23c>
Trace; c020f7f7 <revalidate_drives+5f/70>
Trace; c020f7f7 <revalidate_drives+5f/70>
Trace; c028f7f7 <tcp_ack_probe+17/a4>
Trace; c028f7f7 <tcp_ack_probe+17/a4>
Trace; c010f7f8 <restore_i387+18c/1c4>
Trace; c010f7f8 <restore_i387+18c/1c4>
Trace; c018f7f8 <fat_fill_inode+b4/23c>
Trace; c018f7f8 <fat_fill_inode+b4/23c>
Trace; c020f7f8 <revalidate_drives+60/70>
Trace; c020f7f8 <revalidate_drives+60/70>
Trace; c028f7f8 <tcp_ack_probe+18/a4>
Trace; c028f7f8 <tcp_ack_probe+18/a4>
Trace; c010f7f9 <restore_i387+18d/1c4>
Trace; c010f7f9 <restore_i387+18d/1c4>
Trace; c018f7f9 <fat_fill_inode+b5/23c>
Trace; c018f7f9 <fat_fill_inode+b5/23c>
Trace; c020f7f9 <revalidate_drives+61/70>
Trace; c020f7f9 <revalidate_drives+61/70>
Trace; c028f7f9 <tcp_ack_probe+19/a4>
Trace; c028f7f9 <tcp_ack_probe+19/a4>
Trace; c010f7fa <restore_i387+18e/1c4>
Trace; c010f7fa <restore_i387+18e/1c4>
Trace; c018f7fa <fat_fill_inode+b6/23c>
Trace; c018f7fa <fat_fill_inode+b6/23c>
Trace; c020f7fa <revalidate_drives+62/70>
Trace; c020f7fa <revalidate_drives+62/70>
Trace; c028f7fa <tcp_ack_probe+1a/a4>
Trace; c028f7fa <tcp_ack_probe+1a/a4>
Trace; c010f7fb <restore_i387+18f/1c4>
Trace; c010f7fb <restore_i387+18f/1c4>
Trace; c018f7fb <fat_fill_inode+b7/23c>
Trace; c018f7fb <fat_fill_inode+b7/23c>
Trace; c020f7fb <revalidate_drives+63/70>
Trace; c020f7fb <revalidate_drives+63/70>
Trace; c028f7fb <tcp_ack_probe+1b/a4>
Trace; c028f7fb <tcp_ack_probe+1b/a4>
Trace; c010f7fc <restore_i387+190/1c4>
Trace; c010f7fc <restore_i387+190/1c4>
Trace; c018f7fc <fat_fill_inode+b8/23c>
Trace; c018f7fc <fat_fill_inode+b8/23c>
Trace; c020f7fc <revalidate_drives+64/70>
Trace; c020f7fc <revalidate_drives+64/70>
Trace; c028f7fc <tcp_ack_probe+1c/a4>
Trace; c028f7fc <tcp_ack_probe+1c/a4>
Trace; c010f7fd <restore_i387+191/1c4>
Trace; c010f7fd <restore_i387+191/1c4>
Trace; c018f7fd <fat_fill_inode+b9/23c>
Trace; c018f7fd <fat_fill_inode+b9/23c>
Trace; c020f7fd <revalidate_drives+65/70>
Trace; c020f7fd <revalidate_drives+65/70>
Trace; c028f7fd <tcp_ack_probe+1d/a4>
Trace; c028f7fd <tcp_ack_probe+1d/a4>
Trace; c010f7fe <restore_i387+192/1c4>
Trace; c010f7fe <restore_i387+192/1c4>
Trace; c018f7fe <fat_fill_inode+ba/23c>
Trace; c018f7fe <fat_fill_inode+ba/23c>
Trace; c020f7fe <revalidate_drives+66/70>
Trace; c020f7fe <revalidate_drives+66/70>
Trace; c028f7fe <tcp_ack_probe+1e/a4>
Trace; c028f7fe <tcp_ack_probe+1e/a4>
Trace; c010f7ff <restore_i387+193/1c4>
Trace; c010f7ff <restore_i387+193/1c4>
Trace; c018f7ff <fat_fill_inode+bb/23c>
Trace; c018f7ff <fat_fill_inode+bb/23c>
Trace; c020f7ff <revalidate_drives+67/70>
Trace; c020f7ff <revalidate_drives+67/70>
Trace; c028f7ff <tcp_ack_probe+1f/a4>
Trace; c028f7ff <tcp_ack_probe+1f/a4>


1 warning issued.  Results may not be reliable.

============================================================

PnPBIOS: Found PnP BIOS installation structure at 0xc00f6010.
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb4a6, dseg 0x400.
Unable to handle kernel paging request at virtual address 0000de3a
 printing eip:
00004298
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0068:[<00004298>]    Not tainted
EFLAGS: 00010093
eax: 00000336   ebx: 00000002   ecx: 0000000f   edx: 0000134f
esi: 00000000   edi: 0000ce5b   ebp: c4d6de3e   esp: c4d6de16
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, threadinfo=c4d6c000 task=c4d75480)
Stack: ce5b0093 00000000 de3e0000 de38c4d6 0002c4d6 134f0000 000f0000 03360000
       67db0000 0001c012 4ec1de7a 8fad0000 4da50000 8fa7ce9e ce8f0c40 00000066
       de62de7a 00008fa6 020b000f 0000c16b 58e68dea 8deacd65 2f24c9fd c160c012
Call Trace: [<c020c4d3>] [<c010f7c0>] [<c010f7c0>] [<c018f7c0>] [<c018f7c0>]
   [<c020f7c0>] [<c020f7c0>] [<c028f7c0>] [<c028f7c0>] [<c010f7c1>] [<c010f7c1>]
   [<c018f7c1>] [<c018f7c1>] [<c020f7c1>] [<c020f7c1>] [<c028f7c1>] [<c028f7c1>]
   [<c010f7c2>] [<c010f7c2>] [<c018f7c2>] [<c018f7c2>] [<c020f7c2>] [<c020f7c2>]
   [<c028f7c2>] [<c028f7c2>] [<c010f7c3>] [<c010f7c3>] [<c018f7c3>] [<c018f7c3>]
   [<c020f7c3>] [<c020f7c3>] [<c028f7c3>] [<c028f7c3>] [<c010f7c4>] [<c010f7c4>]
   [<c018f7c4>] [<c018f7c4>] [<c020f7c4>] [<c020f7c4>] [<c028f7c4>] [<c028f7c4>]
   [<c010f7c5>] [<c010f7c5>] [<c018f7c5>] [<c018f7c5>] [<c020f7c5>] [<c020f7c5>]
   [<c028f7c5>] [<c028f7c5>] [<c010f7c6>] [<c010f7c6>] [<c018f7c6>] [<c018f7c6>]
   [<c020f7c6>] [<c020f7c6>] [<c028f7c6>] [<c028f7c6>] [<c010f7c7>] [<c010f7c7>]
   [<c018f7c7>] [<c018f7c7>] [<c020f7c7>] [<c020f7c7>] [<c028f7c7>] [<c028f7c7>]
   [<c010f7c8>] [<c010f7c8>] [<c018f7c8>] [<c018f7c8>] [<c020f7c8>] [<c020f7c8>]
   [<c028f7c8>] [<c028f7c8>] [<c010f7c9>] [<c010f7c9>] [<c018f7c9>] [<c018f7c9>]
   [<c020f7c9>] [<c020f7c9>] [<c028f7c9>] [<c028f7c9>] [<c010f7ca>] [<c010f7ca>]
   [<c018f7ca>] [<c018f7ca>] [<c020f7ca>] [<c020f7ca>] [<c028f7ca>] [<c028f7ca>]
   [<c010f7cb>] [<c010f7cb>] [<c018f7cb>] [<c018f7cb>] [<c020f7cb>] [<c020f7cb>]
   [<c028f7cb>] [<c028f7cb>] [<c010f7cc>] [<c010f7cc>] [<c018f7cc>] [<c018f7cc>]
   [<c020f7cc>] [<c020f7cc>] [<c028f7cc>] [<c028f7cc>] [<c010f7cd>] [<c010f7cd>]
   [<c018f7cd>] [<c018f7cd>] [<c020f7cd>] [<c020f7cd>] [<c028f7cd>] [<c028f7cd>]
   [<c010f7ce>] [<c010f7ce>] [<c018f7ce>] [<c018f7ce>] [<c020f7ce>] [<c020f7ce>]
   [<c028f7ce>] [<c028f7ce>] [<c010f7cf>] [<c010f7cf>] [<c018f7cf>] [<c018f7cf>]
   [<c020f7cf>] [<c020f7cf>] [<c028f7cf>] [<c028f7cf>] [<c010f7d0>] [<c010f7d0>]
   [<c018f7d0>] [<c018f7d0>] [<c020f7d0>] [<c020f7d0>] [<c028f7d0>] [<c028f7d0>]
   [<c010f7d1>] [<c010f7d1>] [<c018f7d1>] [<c018f7d1>] [<c020f7d1>] [<c020f7d1>]
   [<c028f7d1>] [<c028f7d1>] [<c010f7d2>] [<c010f7d2>] [<c018f7d2>] [<c018f7d2>]
   [<c020f7d2>] [<c020f7d2>] [<c028f7d2>] [<c028f7d2>] [<c010f7d3>] [<c010f7d3>]
   [<c018f7d3>] [<c018f7d3>] [<c020f7d3>] [<c020f7d3>] [<c028f7d3>] [<c028f7d3>]
   [<c010f7d4>] [<c010f7d4>] [<c018f7d4>] [<c018f7d4>] [<c020f7d4>] [<c020f7d4>]
   [<c028f7d4>] [<c028f7d4>] [<c010f7d5>] [<c010f7d5>] [<c018f7d5>] [<c018f7d5>]
   [<c020f7d5>] [<c020f7d5>] [<c028f7d5>] [<c028f7d5>] [<c010f7d6>] [<c010f7d6>]
   [<c018f7d6>] [<c018f7d6>] [<c020f7d6>] [<c020f7d6>] [<c028f7d6>] [<c028f7d6>]
   [<c010f7d7>] [<c010f7d7>] [<c018f7d7>] [<c018f7d7>] [<c020f7d7>] [<c020f7d7>]
   [<c028f7d7>] [<c028f7d7>] [<c010f7d8>] [<c010f7d8>] [<c018f7d8>] [<c018f7d8>]
   [<c020f7d8>] [<c020f7d8>] [<c028f7d8>] [<c028f7d8>] [<c010f7d9>] [<c010f7d9>]
   [<c018f7d9>] [<c018f7d9>] [<c020f7d9>] [<c020f7d9>] [<c028f7d9>] [<c028f7d9>]
   [<c010f7da>] [<c010f7da>] [<c018f7da>] [<c018f7da>] [<c020f7da>] [<c020f7da>]
   [<c028f7da>] [<c028f7da>] [<c010f7db>] [<c010f7db>] [<c018f7db>] [<c018f7db>]
   [<c020f7db>] [<c020f7db>] [<c028f7db>] [<c028f7db>] [<c010f7dc>] [<c010f7dc>]
   [<c018f7dc>] [<c018f7dc>] [<c020f7dc>] [<c020f7dc>] [<c028f7dc>] [<c028f7dc>]
   [<c010f7dd>] [<c010f7dd>] [<c018f7dd>] [<c018f7dd>] [<c020f7dd>] [<c020f7dd>]
   [<c028f7dd>] [<c028f7dd>] [<c010f7de>] [<c010f7de>] [<c018f7de>] [<c018f7de>]
   [<c020f7de>] [<c020f7de>] [<c028f7de>] [<c028f7de>] [<c010f7df>] [<c010f7df>]
   [<c018f7df>] [<c018f7df>] [<c020f7df>] [<c020f7df>] [<c028f7df>] [<c028f7df>]
   [<c010f7e0>] [<c010f7e0>] [<c018f7e0>] [<c018f7e0>] [<c020f7e0>] [<c020f7e0>]
   [<c028f7e0>] [<c028f7e0>] [<c010f7e1>] [<c010f7e1>] [<c018f7e1>] [<c018f7e1>]
   [<c020f7e1>] [<c020f7e1>] [<c028f7e1>] [<c028f7e1>] [<c010f7e2>] [<c010f7e2>]
   [<c018f7e2>] [<c018f7e2>] [<c020f7e2>] [<c020f7e2>] [<c028f7e2>] [<c028f7e2>]
   [<c010f7e3>] [<c010f7e3>] [<c018f7e3>] [<c018f7e3>] [<c020f7e3>] [<c020f7e3>]
   [<c028f7e3>] [<c028f7e3>] [<c010f7e4>] [<c010f7e4>] [<c018f7e4>] [<c018f7e4>]
   [<c020f7e4>] [<c020f7e4>] [<c028f7e4>] [<c028f7e4>] [<c010f7e5>] [<c010f7e5>]
   [<c018f7e5>] [<c018f7e5>] [<c020f7e5>] [<c020f7e5>] [<c028f7e5>] [<c028f7e5>]
   [<c010f7e6>] [<c010f7e6>] [<c018f7e6>] [<c018f7e6>] [<c020f7e6>] [<c020f7e6>]
   [<c028f7e6>] [<c028f7e6>] [<c010f7e7>] [<c010f7e7>] [<c018f7e7>] [<c018f7e7>]
   [<c020f7e7>] [<c020f7e7>] [<c028f7e7>] [<c028f7e7>] [<c010f7e8>] [<c010f7e8>]
   [<c018f7e8>] [<c018f7e8>] [<c020f7e8>] [<c020f7e8>] [<c028f7e8>] [<c028f7e8>]
   [<c010f7e9>] [<c010f7e9>] [<c018f7e9>] [<c018f7e9>] [<c020f7e9>] [<c020f7e9>]
   [<c028f7e9>] [<c028f7e9>] [<c010f7ea>] [<c010f7ea>] [<c018f7ea>] [<c018f7ea>]
   [<c020f7ea>] [<c020f7ea>] [<c028f7ea>] [<c028f7ea>] [<c010f7eb>] [<c010f7eb>]
   [<c018f7eb>] [<c018f7eb>] [<c020f7eb>] [<c020f7eb>] [<c028f7eb>] [<c028f7eb>]
   [<c010f7ec>] [<c010f7ec>] [<c018f7ec>] [<c018f7ec>] [<c020f7ec>] [<c020f7ec>]
   [<c028f7ec>] [<c028f7ec>] [<c010f7ed>] [<c010f7ed>] [<c018f7ed>] [<c018f7ed>]
   [<c020f7ed>] [<c020f7ed>] [<c028f7ed>] [<c028f7ed>] [<c010f7ee>] [<c010f7ee>]
   [<c018f7ee>] [<c018f7ee>] [<c020f7ee>] [<c020f7ee>] [<c028f7ee>] [<c028f7ee>]
   [<c010f7ef>] [<c010f7ef>] [<c018f7ef>] [<c018f7ef>] [<c020f7ef>] [<c020f7ef>]
   [<c028f7ef>] [<c028f7ef>] [<c010f7f0>] [<c010f7f0>] [<c018f7f0>] [<c018f7f0>]
   [<c020f7f0>] [<c020f7f0>] [<c028f7f0>] [<c028f7f0>] [<c010f7f1>] [<c010f7f1>]
   [<c018f7f1>] [<c018f7f1>] [<c020f7f1>] [<c020f7f1>] [<c028f7f1>] [<c028f7f1>]
   [<c010f7f2>] [<c010f7f2>] [<c018f7f2>] [<c018f7f2>] [<c020f7f2>] [<c020f7f2>]
   [<c028f7f2>] [<c028f7f2>] [<c010f7f3>] [<c010f7f3>] [<c018f7f3>] [<c018f7f3>]
   [<c020f7f3>] [<c020f7f3>] [<c028f7f3>] [<c028f7f3>] [<c010f7f4>] [<c010f7f4>]
   [<c018f7f4>] [<c018f7f4>] [<c020f7f4>] [<c020f7f4>] [<c028f7f4>] [<c028f7f4>]
   [<c010f7f5>] [<c010f7f5>] [<c018f7f5>] [<c018f7f5>] [<c020f7f5>] [<c020f7f5>]
   [<c028f7f5>] [<c028f7f5>] [<c010f7f6>] [<c010f7f6>] [<c018f7f6>] [<c018f7f6>]
   [<c020f7f6>] [<c020f7f6>] [<c028f7f6>] [<c028f7f6>] [<c010f7f7>] [<c010f7f7>]
   [<c018f7f7>] [<c018f7f7>] [<c020f7f7>] [<c020f7f7>] [<c028f7f7>] [<c028f7f7>]
   [<c010f7f8>] [<c010f7f8>] [<c018f7f8>] [<c018f7f8>] [<c020f7f8>] [<c020f7f8>]
   [<c028f7f8>] [<c028f7f8>] [<c010f7f9>] [<c010f7f9>] [<c018f7f9>] [<c018f7f9>]
   [<c020f7f9>] [<c020f7f9>] [<c028f7f9>] [<c028f7f9>] [<c010f7fa>] [<c010f7fa>]
   [<c018f7fa>] [<c018f7fa>] [<c020f7fa>] [<c020f7fa>] [<c028f7fa>] [<c028f7fa>]
   [<c010f7fb>] [<c010f7fb>] [<c018f7fb>] [<c018f7fb>] [<c020f7fb>] [<c020f7fb>]
   [<c028f7fb>] [<c028f7fb>] [<c010f7fc>] [<c010f7fc>] [<c018f7fc>] [<c018f7fc>]
   [<c020f7fc>] [<c020f7fc>] [<c028f7fc>] [<c028f7fc>] [<c010f7fd>] [<c010f7fd>]
   [<c018f7fd>] [<c018f7fd>] [<c020f7fd>] [<c020f7fd>] [<c028f7fd>] [<c028f7fd>]
   [<c010f7fe>] [<c010f7fe>] [<c018f7fe>] [<c018f7fe>] [<c020f7fe>] [<c020f7fe>]
   [<c028f7fe>] [<c028f7fe>] [<c010f7ff>] [<c010f7ff>] [<c018f7ff>] [<c018f7ff>]
   [<c020f7ff>] [<c020f7ff>] [<c028f7ff>] [<c028f7ff>]
   <1>Unable to handle kernel paging request at virtual address f8000000
 printing eip:
c0109282
*pde = 00000000

-- 
~Randy

