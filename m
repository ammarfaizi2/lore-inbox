Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWGLHI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWGLHI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 03:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWGLHI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 03:08:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:53398 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750759AbWGLHIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 03:08:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Uw4YQzdPpXwQVZ3yxwPzbhQQ68Kd6YzTRtuA2BJqyYKr+phulXJNQYjBfd/LEmjcByBFrM/XP45uMgOEo7fZ9w9PnR23i+z/ugpfv2cqOQuZuA/5lkCHBlPHhT7SZsOs6QemJqaWVwfyM6Bh6DnVPkAgM3MaVyZJuRQ0GIRFVCY=
Message-ID: <40a4ed590607120008y3f78ed4co6de7e1a9ad820110@mail.gmail.com>
Date: Wed, 12 Jul 2006 09:08:55 +0200
From: "Zeno Davatz" <zdavatz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at mm/rmap.c:493!
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------[ cut here ]------------
kernel BUG at mm/rmap.c:493!
invalid operand: 0000 [#2]
PREEMPT SMP
Modules linked in: usbcore
CPU:    0
EIP:    0060:[<c01569f9>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12.2)
EIP is at page_remove_rmap+0x39/0x50
eax: ffffffff   ebx: d6e6020c   ecx: c1b28440   edx: c1b28440
esi: c1b28440   edi: b7083000   ebp: 00000020   esp: d6abfb94
ds: 007b   es: 007b   ss: 0068
Process cc1 (pid: 11671, threadinfo=d6abe000 task=d73b1040)
Stack: 00000010 d6e6020c c014fd5d c1b28440 00000000 d6f79b70 b7089000 b7089000
       b7088fff c014ff55 c200f900 d6f79b70 b7081000 b7089000 00000000 00008000
       b7089000 b7089000 f7687bcc c0150076 c200f900 f7687bcc b7081000 b7089000
Call Trace:
 [<c014fd5d>] zap_pte_range+0xed/0x250
 [<c014ff55>] unmap_page_range+0x95/0xc0
 [<c0150076>] unmap_vmas+0xf6/0x280
 [<c0154bdf>] exit_mmap+0x9f/0x190
 [<c011ba18>] mmput+0x38/0xa0
 [<c0120bd7>] do_exit+0xb7/0x370
 [<c01046a8>] die+0x188/0x190
 [<c011610a>] do_page_fault+0x2da/0x5d5
 [<c01337bf>] autoremove_wake_function+0x2f/0x60
 [<c0119206>] scheduler_tick+0xb6/0x430
 [<c0127b06>] run_timer_softirq+0x126/0x1c0
 [<c0123506>] __do_softirq+0xd6/0xf0
 [<c0115e30>] do_page_fault+0x0/0x5d5
 [<c0103ebb>] error_code+0x4f/0x54
 [<c0145ddc>] buffered_rmqueue+0x6c/0x230
 [<c0146457>] __alloc_pages+0x407/0x430
 [<c0151675>] do_anonymous_page+0x95/0x180
 [<c01517c0>] do_no_page+0x60/0x330
 [<c014f8e5>] pte_alloc_map+0x95/0xd0
 [<c0151c96>] handle_mm_fault+0xf6/0x170
 [<c01530be>] vma_adjust+0x1ce/0x380
 [<c0115fcc>] do_page_fault+0x19c/0x5d5
 [<c0119206>] scheduler_tick+0xb6/0x430
 [<c0127b06>] run_timer_softirq+0x126/0x1c0
 [<c0123506>] __do_softirq+0xd6/0xf0
 [<c0115e30>] do_page_fault+0x0/0x5d5
 [<c0103ebb>] error_code+0x4f/0x54
Code: f0 83 42 08 ff 0f 98 c0 84 c0 74 1b 8b 42 08 40 78 19 c7 04 24
10 00 00 00 b8 ff ff ff ff 89 44 24 04 e8 bb fe fe ff 83 c4 08 c3 <0f>
0b ed 01 c7 f2 38 c0 eb dd 0f 0b ea 01 c7 f2 38 c0 eb c1 8d
 <6>note: cc1[11671] exited with preempt_count 2
