Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269742AbUJGHVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269742AbUJGHVG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 03:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269741AbUJGHVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 03:21:06 -0400
Received: from mout0.freenet.de ([194.97.50.131]:47320 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S269742AbUJGHTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 03:19:36 -0400
Date: Thu, 7 Oct 2004 09:19:30 +0200
From: Marian Eichholz <marian.eichholz@freenet-ag.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc3 does not like diablo news reader daemon
Message-ID: <20041007071930.GB27228@urmel.freenet-ag.de>
Reply-To: marian.eichholz@freenet-ag.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the kernel 2.6.9-rc3 tends to crash when executing our NNTP
reader daemon (dreaderd from diablo).

2.6.3-rc1 runs on the sibling machine like a charm.

Please apologise, if this posting is considered off topic.
You may CC me on this :)

Please see the kernel-log below for evidence. Hope it
helps anything.

The hardware is a usual Intel STL2, 2 Intel-P3 and so on.

Mit freundlichen Gruessen / Yours sincerely

Marian Eichholz

-------------------------------------------------

[...]
Oct  6 22:48:39 newsread5 kernel: c0132eb1
Oct  6 22:48:39 newsread5 kernel: *pde = 00000000
Oct  6 22:48:39 newsread5 kernel: Oops: 0002 [#1]
Oct  6 22:48:39 newsread5 kernel: SMP 
Oct  6 22:48:39 newsread5 kernel: CPU:    0
Oct  6 22:48:39 newsread5 kernel: EIP:    0060:[<c0132eb1>]    Not tainted VLI
Oct  6 22:48:39 newsread5 kernel: EFLAGS: 00010246   (2.6.9-rc3) 
Oct  6 22:48:39 newsread5 kernel: EIP is at generic_file_aio_write_nolock+0x1d1/0x500
Oct  6 22:48:39 newsread5 kernel: eax: 00014c38   ebx: 00000000   ecx: 00000000   edx: 00000000
Oct  6 22:48:39 newsread5 kernel: esi: de8fe000   edi: 00014c38   ebp: 00000000   esp: de8ffe38
Oct  6 22:48:39 newsread5 kernel: ds: 007b   es: 007b   ss: 0068
Oct  6 22:48:39 newsread5 kernel: Process dreaderd (pid: 166, threadinfo=de8fe000 task=de86d000)
Oct  6 22:48:39 newsread5 kernel: Stack: 00014c38 00000040 00000000 de8ffe48 00000000 ca258200 de8ffee0 c02a8f05 
Oct  6 22:48:39 newsread5 kernel:        de8ffee0 00000001 de8ffe8c ffffffff df37f3ec 00000000 00000000 df37f3ec 
Oct  6 22:48:39 newsread5 kernel:        00000048 df37f490 de961560 00000048 00014c38 00000000 de8ffeb4 de961560 
Oct  6 22:48:39 newsread5 kernel: Call Trace:
Oct  6 22:48:39 newsread5 kernel:  [<c02a8f05>] sock_aio_read+0xf5/0x110
Oct  6 22:48:39 newsread5 kernel:  [<c013328a>] generic_file_write_nolock+0xaa/0xd0
Oct  6 22:48:39 newsread5 kernel:  [<c0118460>] autoremove_wake_function+0x0/0x60
Oct  6 22:48:39 newsread5 kernel:  [<c0133406>] generic_file_write+0x56/0xd0
Oct  6 22:48:39 newsread5 kernel:  [<c01333b0>] generic_file_write+0x0/0xd0
Oct  6 22:48:39 newsread5 kernel:  [<c014f738>] vfs_write+0xb8/0x130
Oct  6 22:48:39 newsread5 kernel:  [<c014f881>] sys_write+0x51/0x80
Oct  6 22:48:39 newsread5 kernel:  [<c010422f>] syscall_call+0x7/0xb
Oct  6 22:48:39 newsread5 kernel: Code: 00 00 39 c7 0f 83 d2 01 00 00 8b 44 24 28 8b 4c 24 4c 29 c8 39 44 24 48 76 10 0f 83 58 01 00 00 8b 5c 24 48 31 f6 8b 48 1c 8b 50 <18> 01 fb 11 ee 39 ce 0f 83 24 01 00 00 31 c9 00 00 8b 74 24 30 
Oct  6 22:48:39 newsread5 kernel:  <0>Fatal exception: panic in 5 seconds
Oct  6 23:01:09 newsread5 kernel: klogd 1.4-0, log source = /proc/kmsg started.
Oct  6 23:01:09 newsread5 kernel: Cannot open map file: /boot/System.map.
Oct  6 23:01:09 newsread5 kernel: No module symbols loaded - kernel modules not enabled. 
Oct  6 23:01:09 newsread5 kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Oct  6 23:01:17 newsread5 kernel: eth0: no IPv6 routers present
