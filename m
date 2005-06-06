Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVFFGF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVFFGF5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 02:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVFFGF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 02:05:57 -0400
Received: from agmk.net ([217.73.17.121]:20999 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S261178AbVFFGFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 02:05:48 -0400
From: Pawel Sikora <pluto@agmk.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6.11.12] oops in scheduler_tick
Date: Mon, 6 Jun 2005 08:05:38 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506060805.38799.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops: 0002 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c0112e1f>]    Not tainted VLI
EFLAGS: 00010013   (2.6.11.11-2.1)
EIP is at scheduler_tick+0x3a/0x233
eax: 00000000   ebx: d0063500   ecx: 00000000   edx: 000f41fb
esi: 00000000   edi: 00000000   ebp: d0137eb0   esp: d0137e9c
ds: 007b   es: 007b   ss: 0068
Process  (pid: 24947, threadinfo=d0136000 task=d0063500)
Stack:
d0137f14 d0137f14 d0137f14 00000000 00000000 d0137ec4
c0106ebf 00000000 c02a7000 00000000 d0137eec c01292ed
00000000 00000000 d0137f14 d0137f14 00000000 c031ea80
00000000 c02a7000 d0137f04 c01293a7 d0137f14 d0063500
Call Trace:
 [<c0103fdd>] show_stack+0x78/0x83
 [<c01040f3>] show_registers+0xf1/0x15d
 [<c0104290>] die+0xac/0x120
 [<c01113aa>] do_page_fault+0x44a/0x5d9
 [<c0103c1f>] error_code+0x4f/0x60
 [<c0106ebf>] timer_interrupt+0x47/0xeb
 [<c01292ed>] handle_IRQ_event+0x26/0x56
 [<c01293a7>] __do_IRQ+0x8a/0xc7
 [<c0104fec>] do_IRQ+0x1c/0x28
 [<c0103b2a>] common_interrupt+0x1a/0x20
 [<c0117d80>] do_wait+0x75/0x364
 [<c01180fb>] sys_wait4+0x28/0x2d
 [<c0118113>] sys_waitpid+0x13/0x15
 [<c0102ac7>] syscall_call+0x7/0xb
Code:
8b 18 e8 02 85 ff ff a3 34 27 36 c0 89 15 38 27 36 c0 3b 1d 40
27 36 c0 0f 84 fe 01 00 00 a1 48 27 36 c0 39 43 28 74 0d 8b 43
04 <0f> ba 68 08 03 e9 e7 01 00 00 8b 43 18 89 45 f0 83 f8 63 7f 43
   ^^^^^^^^^^^^^
   btsl $0x3,0x8(%eax)
   ^^^^^^^^^^^^
   set_bit(...) inlined form of set_tsk_need_resched(p)

 <0>Kernel panic - not syncing: Fatal exception in interrupt

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
