Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTENJfn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 05:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTENJfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 05:35:42 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:60827 "HELO
	vaxjo.synopsys.com") by vger.kernel.org with SMTP id S261408AbTENJfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 05:35:39 -0400
Date: Wed, 14 May 2003 11:48:13 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-laptop@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 2.5.69+bk: oops in apmd after waking up from suspend mode
Message-ID: <20030514094813.GA14904@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an old Compaq Armada 1592DT. The thing goes automagically into
suspend mode after being forgotten for a while. And there is this button
to wake it up (the blue one, above the keyboard).

Last time i tried to wake it up it produced the attached oops.
"Unknown key"s are probable the blue button.
After printing out the oops, the system went back into suspend.

-alex

Suspending devices
Suspending device c03219ac
Unable to handle kernel NULL pointer dereference at virtual address 00000090
 printing eip:
c011459f
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c011459f>]    Not tainted
EFLAGS: 00010202
EIP is at fix_processor_context+0x5f/0x100
eax: 0000007c   ebx: c5f0e000   ecx: 00000002   edx: 00000000
esi: 00000060   edi: 00000000   ebp: c5f0ff5c   esp: c5f0ff54
ds: 007b   es: 007b   ss: 0068
Process kapmd (pid: 4, threadinfo=c5f0e000 task=c5fbc640)
Stack: c5f0e000 00000060 c5f0ff64 c0114529 c5f0ff78 c01135c8 00000002 00000000 
       00000002 c5f0ff8c c0113845 00000001 c5f0e000 c5f0ffb4 c5f0ffdc c0113aa4 
       00000000 c5fbc640 c0117950 00000000 00000000 c0290000 c030f6b4 00000000 
Call Trace:
 [<c0114529>] restore_processor_state+0x69/0x80
 [<c01135c8>] suspend+0x138/0x200
 [<c0113845>] check_events+0xf5/0x230
 [<c0113aa4>] apm_mainloop+0x94/0xb0
 [<c0117950>] default_wake_function+0x0/0x20
 [<c0117950>] default_wake_function+0x0/0x20
 [<c01141a0>] apm+0x0/0x280
 [<c0114262>] apm+0xc2/0x280
 [<c0107255>] kernel_thread_helper+0x5/0x10

Code: 8b 48 14 8b 42 7c 85 c0 75 0a b9 00 10 29 c0 b8 05 00 00 00 
 <6>note: kapmd[4] exited with preempt_count 2
hda: dma_timer_expiry: dma status == 0x61
atkbd.c: Unknown key (set 2, scancode 0xb6, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x19d, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.



