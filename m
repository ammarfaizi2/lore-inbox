Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVENVXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVENVXo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 17:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVENVXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 17:23:44 -0400
Received: from CPE0020e06a7211-CM0011ae8cd564.cpe.net.cable.rogers.com ([70.28.191.94]:27267
	"EHLO kenichi") by vger.kernel.org with ESMTP id S261500AbVENVXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 17:23:38 -0400
From: Andrew James Wade 
	<ajwade@cpe0020e06a7211-cm0011ae8cd564.cpe.net.cable.rogers.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc4-mm1
Date: Sat, 14 May 2005 17:19:17 -0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050512033100.017958f6.akpm@osdl.org> <42834E6D.8060408@reub.net>
In-Reply-To: <42834E6D.8060408@reub.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505141719.17595.ajwade@cpe0020e06a7211-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a similar but slightly different bug:

kernel BUG at kernel/sched.c:2731!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c01160d5>]    Not tainted VLI
EFLAGS: 00010202   (2.6.12-rc4-mm1)
EIP is at sub_preempt_count+0x35/0x40
eax: dfbbe000   ebx: dfbbfe98   ecx: dfc1b4cc   edx: 00000001
esi: dfc1b450   edi: dfbbfdf4   ebp: dfbbfde4   esp: dfbbfde4
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 450, threadinfo=dfbbe000 task=dfcac5e0)
Stack: c14d6000 c01dc3a4 dfc1b450 dfbbfe98 4b1b5d0b 00000000 00000001 dfbbfe00
      dfbbfe00 00000000 dfbbfe0c dfbbfe0c 00000000 00000000 00000000 00000000
      00000000 dfbbfe28 dfbbfe28 dfbbfe34 00000000 00000001 00000000 dfbbfe40
Call Trace:
[<c01dc3a4>] reiser4_sync_inodes+0x44/0x90
[<c017c83e>] sync_sb_inodes+0x2e/0x40
[<c017c9c4>] sync_inodes_sb+0x74/0x80
[<c0158af8>] fsync_super+0x18/0xb0
[<c015e87d>] do_remount_sb+0x3d/0x100
[<c0175c23>] do_remount+0x93/0xd0
[<c01766c7>] do_mount+0x187/0x1a0
[<c01764e3>] copy_mount_options+0x63/0xc0
[<c0176b2f>] sys_mount+0x9f/0xe0
[<c0102fc1>] syscall_call+0x7/0xb
Code: 89 e5 3b 50 14 7f 24 81 fa fe 00 00 00 76 0c b8 00 e0 ff ff 21 e0 29 50 14 c9 c3 80 78 14 00 75 ee 0f 0b af 0a d2 85 3f c0 eb e4 <0f> 0b ab 0a d2
85 3f c0 eb d2 90 55 89 e5 8b 45 08 8b 50 04 89
/etc/init.d/rcS: line 290:   450 Segmentation fault      mount -n -o remount,$rootopts,$rootmode $fstabroot / 2>/dev/null

I'm assuming the source is the same.

Unfortunately, I'm going to be away until Tuesday.

Andrew Wade
