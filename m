Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWEBSuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWEBSuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWEBSuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:50:24 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:4939 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964967AbWEBSuX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:50:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gHvZP9gOnCTR7mWUBs6VGZKxt3UgN1DSdeEd2cBVMBwYdpcNJKHvKNtSe5jFgYnowO2NCbX6GC9QDT4gDTsvz+fZk6b/Cpm+ioFmnfjF9H/PYyhtXWpIu2/0q/5w3v6YyYF/JrEALbwliI7vAW+OTCqI297b70Ltbts88qBxaxA=
Message-ID: <632b79000605021150u59c6e9e5lece6acce3512640b@mail.gmail.com>
Date: Tue, 2 May 2006 13:50:21 -0500
From: "Don Dupuis" <dondster@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: BUG: soft lockup detected on CPU#0! on kernel 2.6.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone else seeing these soft lockup detected errors? This is
happening on an HP DL380G4.

BUG: soft lockup detected on CPU#0!

Pid: 0, comm:              swapper
EIP: 0060:[<c0122aa4>] CPU: 0
EIP is at __do_softirq+0x58/0xca
 EFLAGS: 00000282    Not tainted  (2.6.16.1 #10)
EAX: c18062e0 EBX: 00000008 ECX: 00000000 EDX: 00000000
ESI: c0437f00 EDI: c0474380 EBP: c047dff8 DS: 007b ES: 007b
CR0: 8005003b CR2: 886504e4 CR3: 37f5d000 CR4: 000006d0
 =======================
BUG: soft lockup detected on CPU#0!

Pid: 0, comm:              swapper
EIP: 0060:[<c0136c76>] CPU: 0
EIP is at handle_IRQ_event+0x1e/0x51
 EFLAGS: 00000246    Not tainted  (2.6.16.1 #10)
EAX: 00000004 EBX: f7e57300 ECX: f7e57300 EDX: c04c6d20
ESI: 00000000 EDI: 00000000 EBP: c0481fdc DS: 007b ES: 007b
CR0: 8005003b CR2: 886504e4 CR3: 37f5d000 CR4: 000006d0
 [<c01041b6>] show_trace+0xd/0xf
 [<c0101ba2>] show_regs+0x10c/0x116
 [<c0136b2e>] softlockup_tick+0x67/0x78
 [<c0126174>] do_timer+0xa6/0xaa
 [<c01066e4>] timer_interrupt+0x48/0x7d
 [<c0136c7e>] handle_IRQ_event+0x26/0x51
 [<c0136d2e>] __do_IRQ+0x85/0xd7
 [<c01054f7>] do_IRQ+0x7b/0x8d
 [<c0103dd6>] common_interrupt+0x1a/0x20
 [<c0136d2e>] __do_IRQ+0x85/0xd7
 [<c01054ea>] do_IRQ+0x6e/0x8d
 =======================
 [<c0103dd6>] common_interrupt+0x1a/0x20
 [<c01055e5>] do_softirq+0x47/0x4f
 =======================
 [<c0122bb4>] irq_exit+0x35/0x37
 [<c01054fc>] do_IRQ+0x80/0x8d
 [<c0103dd6>] common_interrupt+0x1a/0x20
 [<c0101903>] cpu_idle+0x5d/0x72
 [<c01002bb>] rest_init+0x23/0x25
 [<c04427c1>] start_kernel+0x18a/0x18c
 [<c0100210>] 0xc0100210
BUG: soft lockup detected on CPU#0!

Pid: 0, comm:              swapper
EIP: 0060:[<c0136c76>] CPU: 0
EIP is at handle_IRQ_event+0x1e/0x51
 EFLAGS: 00000246    Not tainted  (2.6.16.1 #10)
EAX: 00000004 EBX: f7e57300 ECX: f7e57300 EDX: c04c6d20
ESI: 00000000 EDI: 00000000 EBP: c0481fdc DS: 007b ES: 007b
CR0: 8005003b CR2: 886504e4 CR3: 37f5d000 CR4: 000006d0
 [<c01041b6>] show_trace+0xd/0xf
 [<c0101ba2>] show_regs+0x10c/0x116
 [<c0136b2e>] softlockup_tick+0x67/0x78
 [<c0126174>] do_timer+0xa6/0xaa
 [<c01066e4>] timer_interrupt+0x48/0x7d
 [<c0136c7e>] handle_IRQ_event+0x26/0x51
 [<c0136d2e>] __do_IRQ+0x85/0xd7
 [<c01054f7>] do_IRQ+0x7b/0x8d
 [<c0103dd6>] common_interrupt+0x1a/0x20
 [<c0136d2e>] __do_IRQ+0x85/0xd7
 [<c01054ea>] do_IRQ+0x6e/0x8d
 =======================
 [<c0103dd6>] common_interrupt+0x1a/0x20
 [<c01055e5>] do_softirq+0x47/0x4f
 =======================
 [<c0122bb4>] irq_exit+0x35/0x37
 [<c01054fc>] do_IRQ+0x80/0x8d
 [<c0103dd6>] common_interrupt+0x1a/0x20
 [<c0101903>] cpu_idle+0x5d/0x72
 [<c01002bb>] rest_init+0x23/0x25
 [<c04427c1>] start_kernel+0x18a/0x18c
 [<c0100210>] 0xc0100210
BUG: soft lockup detected on CPU#0!

Pid: 0, comm:              swapper
EIP: 0060:[<c0136c76>] CPU: 0
EIP is at handle_IRQ_event+0x1e/0x51
 EFLAGS: 00000246    Not tainted  (2.6.16.1 #10)
EAX: 00000004 EBX: f7e57300 ECX: f7e57300 EDX: c04c6d20
ESI: 00000000 EDI: 00000000 EBP: c0481fdc DS: 007b ES: 007b
CR0: 8005003b CR2: 886504e4 CR3: 37f5d000 CR4: 000006d0
 [<c01041b6>] show_trace+0xd/0xf
 [<c0101ba2>] show_regs+0x10c/0x116
 [<c0136b2e>] softlockup_tick+0x67/0x78
 [<c0126174>] do_timer+0xa6/0xaa
 [<c01066e4>] timer_interrupt+0x48/0x7d
 [<c0136c7e>] handle_IRQ_event+0x26/0x51
 [<c0136d2e>] __do_IRQ+0x85/0xd7
 [<c01054f7>] do_IRQ+0x7b/0x8d
 [<c0103dd6>] common_interrupt+0x1a/0x20
 [<c0136d2e>] __do_IRQ+0x85/0xd7
 [<c01054ea>] do_IRQ+0x6e/0x8d
 =======================
 [<c0103dd6>] common_interrupt+0x1a/0x20
 [<c01055e5>] do_softirq+0x47/0x4f
 =======================
 [<c0122bb4>] irq_exit+0x35/0x37
 [<c01054fc>] do_IRQ+0x80/0x8d
 [<c0103dd6>] common_interrupt+0x1a/0x20
 [<c0101903>] cpu_idle+0x5d/0x72
 [<c01002bb>] rest_init+0x23/0x25
 [<c04427c1>] start_kernel+0x18a/0x18c
 [<c0100210>] 0xc0100210

I had posted this problem before but no one has responded.

Thanks

Don Dupuis
