Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965297AbVIPLtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbVIPLtL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 07:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbVIPLtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 07:49:10 -0400
Received: from bay106-f33.bay106.hotmail.com ([65.54.161.43]:19599 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S965297AbVIPLtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 07:49:09 -0400
Message-ID: <BAY106-F33D70574CC7F3E44739F20C8910@phx.gbl>
X-Originating-IP: [151.41.156.134]
X-Originating-Email: [nchiellini@hotmail.com]
From: "Nicolo Chiellini" <nchiellini@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Oops on 2.6.12.3
Date: Fri, 16 Sep 2005 13:49:08 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
X-OriginalArrivalTime: 16 Sep 2005 11:49:08.0761 (UTC) FILETIME=[A5BFB090:01C5BAB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
i've got an oops, but i don't know why, i report the infos in my possession:

Unable to handle kernel NULL pointer dereference at virtual address 00000007
printing eip:
c01c114b
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: ohci_hcd ide_scsi rtc
CPU:    0
EIP:    0060:[<c01c114b>]    Not tainted VLI
EFLAGS: 00010287   (2.6.12.3)
EIP is at cleanup_bitmap_list+0x5b/0xe0
eax: 00000007   ebx: e0900000   ecx: e09000c4   edx: df0a5548
esi: ffffffff   edi: 00000bdf   ebp: e09000e4   esp: c2473e54
ds: 007b   es: 007b   ss: 0068
Process shutdown (pid: 23594, threadinfo=c2472000 task=c54cda20)
Stack: cddceb40 00000000 00000002 d8821700 d8821700 00000002 deebfe00 
c01c1792
       deebfe00 e09000e4 df09e800 c01c2296 deebfe00 d8821700 00000000 
00001000
       00000282 e0900068 00000000 00000000 e0900000 cddceb0c deebfe00 
00000001
Call Trace:
[<c01c1792>] cleanup_freed_for_journal_list+0x22/0x40
[<c01c2296>] flush_commit_list+0x1d6/0x4e0
[<c01c70f7>] do_journal_end+0x6b7/0xa30
[<c01c54d5>] do_journal_begin_r+0x25/0x2d0
[<c01c6055>] journal_end_sync+0x55/0xa0
[<c01ae859>] reiserfs_sync_fs+0x69/0x80
[<c0160a3d>] put_super+0x1d/0x40
[<c0161063>] sync_filesystems+0x103/0x150
[<c015b7dc>] do_sync+0x3c/0x80
[<c015b82f>] sys_sync+0xf/0x20
[<c0102c05>] syscall_call+0x7/0xb
Code: 8b 34 ba 85 f6 74 4a 8b 59 0c ff 8b b0 00 00 00 83 bb ac 00 00 00 64 
7f 57 8b 93 c4 00 00 00 8d 46 08 8d 8b c4 00 00 00 89 42 04 <89> 56 08 89 48 
04 ff 83 ac 00 00 00 89 83 c4 00 00 00 8b 45 04

Machines Infos:

Linux server 2.6.12.3 #2 Tue Jul 19 21:29:11 CEST 2005 i686 unknown unknown 
GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
jfsutils               1.1.6
reiserfsprogs          3.6.17
reiser4progs           line
xfsprogs               2.6.13
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   026
Modules Loaded         ohci_hcd ide_scsi rtc

lspci:

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0258
00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1258
00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2258
00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3258
00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4258
00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7258
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149 
(rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] 
(rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] 
(rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] 
(rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] 
(rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 
78)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY 
[Radeon 7000/VE]


