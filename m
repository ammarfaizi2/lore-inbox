Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbVKDAgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbVKDAgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbVKDAgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:36:22 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:59061 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1030573AbVKDAgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:36:22 -0500
Message-ID: <028901c5e0d7$52fab640$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
Subject: Reboot problem.
Date: Fri, 4 Nov 2005 01:33:01 +0100
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

Is there any way to force reboot after this:

Nov  3 21:31:39 192.168.2.50 kernel: ------------[ cut here ]------------
Nov  3 21:31:39 192.168.2.50 kernel: kernel BUG at mm/highmem.c:183!
Nov  3 21:31:39 192.168.2.50 kernel: invalid operand: 0000 [#1]
Nov  3 21:31:39 192.168.2.50 kernel: SMP
Nov  3 21:31:39 192.168.2.50 kernel: Modules linked in: netconsole
Nov  3 21:31:39 192.168.2.50 kernel: CPU:    3
Nov  3 21:31:39 192.168.2.50 kernel: EIP:    0060:[<c015094f>]    Not
tainted VLI
Nov  3 21:31:39 192.168.2.50 kernel: EFLAGS: 00010246   (2.6.14)
Nov  3 21:31:39 192.168.2.50 kernel: EIP is at kunmap_high+0x1f/0x93
Nov  3 21:31:39 192.168.2.50 kernel: eax: 00000000   ebx: c30e1280   ecx:
c0764a78   edx: 00000286
Nov  3 21:31:39 192.168.2.50 kernel: esi: 00001000   edi: 00000000   ebp:
f6eade64   esp: f6eade5c
Nov  3 21:31:39 192.168.2.50 kernel: ds: 007b   es: 007b   ss: 0068
Nov  3 21:31:39 192.168.2.50 kernel: Process md4_raid1 (pid: 3367,
threadinfo=f6eac000 task=f7bd8030)
Nov  3 21:31:39 192.168.2.50 kernel: Stack: c30e1280 cc31b8d0 f6eade6c
c0118349 f6eadec4 c038f626 c30e1280 00000001
Nov  3 21:31:39 192.168.2.50 kernel:        ed143000 00001000 00004000
c0104e81 f6eadeec f7292d00 c07768ec f179e600
Nov  3 21:31:39 192.168.2.50 kernel:        13956025 01000000 e25b6edc
f6eadeec 22010000 00801bbc 00900100 c07768cc
Nov  3 21:31:39 192.168.2.50 kernel: Call Trace:
Nov  3 21:31:39 192.168.2.50 kernel:  [<c0103bf2>] show_stack+0x9a/0xd0
Nov  3 21:31:39 192.168.2.50 kernel:  [<c0103db2>]
show_registers+0x16a/0x1fa
Nov  3 21:31:39 192.168.2.50 kernel:  [<c0103fc3>] die+0xfa/0x17c
Nov  3 21:31:39 192.168.2.50 kernel:  [<c055510e>] do_trap+0x7e/0xb2
Nov  3 21:31:39 192.168.2.50 kernel:  [<c010432d>] do_invalid_op+0xa9/0xb3
Nov  3 21:31:39 192.168.2.50 kernel:  [<c01038ab>] error_code+0x4f/0x54
Nov  3 21:31:39 192.168.2.50 kernel:  [<c0118349>] kunmap+0x42/0x44
Nov  3 21:31:39 192.168.2.50 kernel:  [<c038f626>] nbd_send_req+0x1fc/0x297
Nov  3 21:31:39 192.168.2.50 kernel:  [<c038fb17>] do_nbd_request+0xf4/0x27d
Nov  3 21:31:39 192.168.2.50 kernel:  [<c0380e0c>]
__generic_unplug_device+0x28/0x2e
Nov  3 21:31:39 192.168.2.50 kernel:  [<c0380e2f>]
generic_unplug_device+0x1d/0x2e
Nov  3 21:31:39 192.168.2.50 kernel:  [<c046910b>] unplug_slaves+0x54/0xaf
Nov  3 21:31:39 192.168.2.50 kernel:  [<c046a81b>] raid1d+0x288/0x2cb
Nov  3 21:31:39 192.168.2.50 kernel:  [<c0478d4a>] md_thread+0x5f/0x10b
Nov  3 21:31:39 192.168.2.50 kernel:  [<c0132f07>] kthread+0xb1/0xb5
Nov  3 21:31:39 192.168.2.50 kernel:  [<c0101145>]
kernel_thread_helper+0x5/0xb
Nov  3 21:31:39 192.168.2.50 kernel: Code: e8 08 06 00 00 89 c7 e9 38 ff ff
ff 55 89 e5 53 83 ec 04 89 c3 b8 80 6c 68 c0 e8 3e
Nov  3 21:31:39 192.168.2.50 kernel:  <0>Fatal exception: panic in 5 seconds


At this point the system is freez, and only reset can help.

Thanks

Janos

