Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbUCIU5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 15:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbUCIU5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 15:57:35 -0500
Received: from mail19f.dulles19-verio.com ([198.170.241.24]:21572 "HELO
	mail19f.dulles19-verio.com") by vger.kernel.org with SMTP
	id S262178AbUCIU52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 15:57:28 -0500
Message-ID: <006301c40619$1cbaa6c0$6a00a8c0@reddy>
From: "Sasidhar Mukkmalla" <msreddy@guardiansolutions.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel Oops and crashes
Date: Tue, 9 Mar 2004 15:57:16 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
We have many servers running with Intel 2.4GHz processor on ATX MBD 845E
chipset. These machines have 512MB ram and two hard drives of 200GB. All are
raided at level 1.

Our systems crash often and these are the messages I got from logs from two
different instances of crashes. Both these logs are from the same machine.
Any help to fix these problems would be greatly appreciated. Thank you



LOG 1

Feb 19 16:12:10 DVRS10-3 kernel: Unable to handle kernel paging request at
virtual address 2524
1f1f
Feb 19 16:12:10 DVRS10-3 kernel:  printing eip:
Feb 19 16:12:10 DVRS10-3 kernel: c013a181
Feb 19 16:12:10 DVRS10-3 kernel: *pde = 00000000
Feb 19 16:12:10 DVRS10-3 kernel: Oops: 0002
Feb 19 16:12:10 DVRS10-3 kernel: softdog parport_pc lp parport
iptable_filter ip_tables autofs
bttv soundcore i2c-algo-bit i2c-core videodev e100 sg sr_mod microcode
ide-scsi scsi_mod ide-cd

Feb 19 16:12:10 DVRS10-3 kernel: CPU:    0
Feb 19 16:12:10 DVRS10-3 kernel: EIP:    0060:[<c013a181>]    Tainted: GF
Feb 19 16:12:10 DVRS10-3 kernel: EFLAGS: 00010046
Feb 19 16:12:10 DVRS10-3 kernel:
Feb 19 16:12:10 DVRS10-3 kernel: EIP is at kmem_cache_free_one [kernel] 0x71
(2.4.20-6)
Feb 19 16:12:10 DVRS10-3 kernel: eax: 25241f1b   ebx: c25a7f58   ecx:
c2098000   edx: c4897000
Feb 19 16:12:10 DVRS10-3 kernel: esi: 00000004   edi: c2098300   ebp:
c1447b78   esp: c23a7f58
Feb 19 16:12:10 DVRS10-3 kernel: ds: 0068   es: 0068   ss: 0068
Feb 19 16:12:10 DVRS10-3 kernel: Process kswapd (pid: 5, stackpage=c23a7000)
Feb 19 16:12:10 DVRS10-3 kernel: Stack: 00000286 00000292 c2098300 c0139a1e
c25a7f58 c2098300 c
2098300 c0149137
Feb 19 16:12:10 DVRS10-3 kernel:        c25a7f58 c2098300 c014b4e6 c2098300
c1447b78 c1447b94 0
00001d0 c030d2b4
Feb 19 16:12:10 DVRS10-3 kernel:        c013be1a c1447b78 000001d0 00000001
00000033 c030d080 0
000000c c013ca4c
Feb 19 16:12:10 DVRS10-3 kernel: Call Trace:   [<c0139a1e>] kmem_cache_free
[kernel] 0x1e (0xc2
3a7f64))
Feb 19 16:12:10 DVRS10-3 kernel: [<c0149137>] __put_unused_buffer_head
[kernel] 0x57 (0xc23a7f7
4))
Feb 19 16:12:10 DVRS10-3 kernel: [<c014b4e6>] try_to_free_buffers [kernel]
0x66 (0xc23a7f80))
Feb 19 16:12:10 DVRS10-3 kernel: [<c013be1a>] launder_page [kernel] 0x53a
(0xc23a7f98))
Feb 19 16:12:10 DVRS10-3 kernel: [<c013ca4c>] rebalance_dirty_zone [kernel]
0x5c (0xc23a7fb4))
Feb 19 16:12:10 DVRS10-3 kernel: [<c013d06c>] kswapd [kernel] 0x15c
(0xc23a7fd4))
Feb 19 16:12:10 DVRS10-3 kernel: [<c013cf10>] kswapd [kernel] 0x0
(0xc23a7fe4))
Feb 19 16:12:10 DVRS10-3 kernel: [<c010742d>] kernel_thread_helper [kernel]
0x5 (0xc23a7ff0))
Feb 19 16:12:10 DVRS10-3 kernel:
Feb 19 16:12:10 DVRS10-3 kernel:
Feb 19 16:12:10 DVRS10-3 kernel: Code: 89 50 04 8b 43 08 8d 53 08 89 48 04
89 01 89 51 04 89 4b
 08
Feb 19 16:27:36 DVRS10-3 syslogd 1.4.1: restart.





LOG 2

Mar  8 07:36:13 DVRS10-3 kernel: Unable to handle kernel paging request at
virtual address 7f7e
848d
Mar  8 07:36:13 DVRS10-3 kernel:  printing eip:
Mar  8 07:36:13 DVRS10-3 kernel: c0139c30
Mar  8 07:36:13 DVRS10-3 kernel: *pde = 00000000
Mar  8 07:36:13 DVRS10-3 kernel: Oops: 0000
Mar  8 07:36:13 DVRS10-3 kernel: softdog parport_pc lp parport
iptable_filter ip_tables autofs
bttv soundcore i2c-algo-bit i2c-core videodev e100 sg sr_mod microcode
ide-scsi scsi_mod ide-cd

Mar  8 07:36:13 DVRS10-3 kernel: CPU:    0
Mar  8 07:36:13 DVRS10-3 kernel: EIP:    0060:[<c0139c30>]    Tainted: GF
Mar  8 07:36:13 DVRS10-3 kernel: EFLAGS: 00010883
Mar  8 07:36:13 DVRS10-3 kernel:
Mar  8 07:36:13 DVRS10-3 kernel: EIP is at kmem_cache_reap [kernel] 0x150
(2.4.20-6)
Mar  8 07:36:13 DVRS10-3 kernel: eax: 7f7e848d   ebx: 00000020   ecx:
c25a55a4   edx: c25a55b4
Mar  8 07:36:13 DVRS10-3 kernel: esi: 00000007   edi: 00000000   ebp:
00000000   esp: cbc17e2c
Mar  8 07:36:13 DVRS10-3 kernel: ds: 0068   es: 0068   ss: 0068
Mar  8 07:36:14 DVRS10-3 kernel: Process guard-fixvis103 (pid: 20746,
stackpage=cbc17000)
Mar  8 07:36:14 DVRS10-3 kernel: Stack: c039fdd8 00000006 c25a55a4 00000000
00000000 00000000 0
0002e89 000001d2
Mar  8 07:36:14 DVRS10-3 kernel:        000001d2 00000000 c013cc6e c25a51d8
000001d2 cbc16000 0
0000001 c013d311
Mar  8 07:36:14 DVRS10-3 kernel:        000001d2 c030d6ac 0000061e c013e9dc
c030d6a0 00000000 0
0000001 00000001
Mar  8 07:36:14 DVRS10-3 kernel: Call Trace:   [<c013cc6e>]
do_try_to_free_pages [kernel] 0x5e
(0xcbc17e54))
Mar  8 07:36:14 DVRS10-3 kernel: [<c013d311>] try_to_free_pages [kernel]
0x51 (0xcbc17e68))
Mar  8 07:36:14 DVRS10-3 kernel: [<c013e9dc>] __alloc_pages [kernel] 0x17c
(0xcbc17e78))
Mar  8 07:36:14 DVRS10-3 kernel: [<c01303c8>] do_anonymous_page [kernel]
0x78 (0xcbc17eb4))
Mar  8 07:36:14 DVRS10-3 kernel: [<c01308e1>] handle_mm_fault [kernel] 0x81
(0xcbc17ed8))
Mar  8 07:36:14 DVRS10-3 kernel: [<c011737c>] do_page_fault [kernel] 0x18c
(0xcbc17f08))
Mar  8 07:36:14 DVRS10-3 kernel: [<c01328a0>] arch_get_unmapped_area
[kernel] 0x70 (0xcbc17f2c)
)
Mar  8 07:36:14 DVRS10-3 kernel: [<c0131a6a>] do_mmap_pgoff [kernel] 0x4ba
(0xcbc17f48))
Mar  8 07:36:14 DVRS10-3 kernel: [<c010f097>] sys_mmap2 [kernel] 0x77
(0xcbc17f94))
Mar  8 07:36:14 DVRS10-3 kernel: [<c01171f0>] do_page_fault [kernel] 0x0
(0xcbc17fb0))
Mar  8 07:36:14 DVRS10-3 kernel: [<c0109628>] error_code [kernel] 0x34
(0xcbc17fb8))
Mar  8 07:36:14 DVRS10-3 kernel:
Mar  8 07:36:14 DVRS10-3 kernel:
Mar  8 07:36:14 DVRS10-3 kernel: Code: 8b 00 43 39 d0 75 f9 8b 44 24 08 89
da 8b 78 24 8b 40 44
 89




Regards,
---Reddy

