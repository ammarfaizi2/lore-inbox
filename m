Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030976AbVIIXNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030976AbVIIXNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 19:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030977AbVIIXNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 19:13:54 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:29363 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1030976AbVIIXNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 19:13:53 -0400
Message-ID: <07e301c5b594$cacb3730$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
Subject: Reboot problen on panic
Date: Sat, 10 Sep 2005 01:18:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I get this about dayli:

Sep 10 00:25:51 192.168.2.50 kernel: ------------[ cut here ]------------
Sep 10 00:25:51 192.168.2.50 kernel: kernel BUG at mm/highmem.c:183!
Sep 10 00:25:51 192.168.2.50 kernel: invalid operand: 0000 [#1]
Sep 10 00:25:51 192.168.2.50 kernel: SMP
Sep 10 00:25:51 192.168.2.50 kernel: Modules linked in: gnbd
Sep 10 00:25:51 192.168.2.50 kernel: CPU:    0
Sep 10 00:25:51 192.168.2.50 kernel: EIP:    0060:[<c0150f77>]    Not
tainted VLI
Sep 10 00:25:51 192.168.2.50 kernel: EFLAGS: 00010246   (2.6.13)
Sep 10 00:25:51 192.168.2.50 kernel: EIP is at kunmap_high+0x1f/0x93
Sep 10 00:25:51 192.168.2.50 kernel: eax: 00000000   ebx: c3165880   ecx:
c079f608   edx: 00000292
Sep 10 00:25:51 192.168.2.50 kernel: esi: 00001000   edi: 00000000   ebp:
f6eb3df8   esp: f6eb3df0
Sep 10 00:25:51 192.168.2.50 kernel: ds: 007b   es: 007b   ss: 0068
Sep 10 00:25:51 192.168.2.50 kernel: Process md4_raid1 (pid: 2674,
threadinfo=f6eb2000 task=f7e9f020)
Sep 10 00:25:51 192.168.2.50 kernel: Stack: c3165880 de2bd610 f6eb3e00
c0118cb6 f6eb3e54 f895d9fd c3165880 00000001
Sep 10 00:25:51 192.168.2.50 kernel:        c8b38000 00001000 00004000
c8d60528 f7ccd71c f8961908 e03aa280 007ea037
Sep 10 00:25:51 192.168.2.50 kernel:        01000000 c84247cc c801518c
5f000000 0030b09e 00f00100 c84247cc f89618e0
Sep 10 00:25:51 192.168.2.50 kernel: Call Trace:
Sep 10 00:25:51 192.168.2.50 kernel:  [<c0103ca2>] show_stack+0x9a/0xd0
Sep 10 00:25:51 192.168.2.50 kernel:  [<c0103e6d>]
show_registers+0x175/0x209
Sep 10 00:25:51 192.168.2.50 kernel:  [<c010408c>] die+0xfa/0x17c
Sep 10 00:25:51 192.168.2.50 kernel:  [<c010418c>] do_trap+0x7e/0xb2
Sep 10 00:25:51 192.168.2.50 kernel:  [<c01044a8>] do_invalid_op+0xa9/0xb3
Sep 10 00:25:51 192.168.2.50 kernel:  [<c01038d7>] error_code+0x4f/0x54
Sep 10 00:25:51 192.168.2.50 kernel:  [<c0118cb6>] kunmap+0x42/0x44
Sep 10 00:25:51 192.168.2.50 kernel:  [<f895d9fd>]
__gnbd_send_req+0x1c7/0x28d [gnbd]
Sep 10 00:25:51 192.168.2.50 kernel:  [<f895df12>]
do_gnbd_request+0xe5/0x198 [gnbd]
Sep 10 00:25:51 192.168.2.50 kernel:  [<c03837ed>]
__generic_unplug_device+0x28/0x2e
Sep 10 00:25:51 192.168.2.50 kernel:  [<c03812ef>]
__elv_add_request+0xaa/0xac
Sep 10 00:25:51 192.168.2.50 kernel:  [<c0384c3b>]
__make_request+0x20d/0x512
Sep 10 00:25:51 192.168.2.50 kernel:  [<c0385270>]
generic_make_request+0xb2/0x27a
Sep 10 00:25:51 192.168.2.50 kernel:  [<c0472082>] raid1d+0xbf/0x2cb
Sep 10 00:25:51 192.168.2.50 kernel:  [<c047fdc5>] md_thread+0x134/0x16e
Sep 10 00:25:51 192.168.2.50 kernel:  [<c01010d5>]
kernel_thread_helper+0x5/0xb
Sep 10 00:25:51 192.168.2.50 kernel: Code: e8 08 06 00 00 89 c7 e9 38 ff ff
ff 55 89 e5 53 83 ec 04 89 c3 b8 80 3c 6c c0 e8 a9 9e 40 00 89 1c 24 e8 e6
05 00 00 85 c0 75 08 <0f> 0b b7 00 2a 52 57 c0 05 00 00 40 00 c1 e8 0c 8b 14
85 20 bc
Sep 10 00:25:51 192.168.2.50 kernel:  <0>Fatal exception: panic in 5 seconds

I know, this is a GNBD bug, but my second problem is, when I get this, my
server is freeze, and can't reboot. :-(

What can I do to solve (or to help to solve) this problem?

Thanks

Janos

