Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVF2Su6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVF2Su6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVF2StP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:49:15 -0400
Received: from mail.tyan.com ([66.122.195.4]:48144 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262402AbVF2SqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:46:22 -0400
Message-ID: <3174569B9743D511922F00A0C94314230AF9744A@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org
Subject: RE: 2.6.13-rc1 with dual way dual core ck804 MB
Date: Wed, 29 Jun 2005 11:50:09 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

setup_secondary_APIC_clock fail for core0/node1.

YH


++++++++++++++++++++=_---CPU UP  1
Booting processor 1/1 rip 6000 rsp ffff81007ffbdf58
Setting warm reset code and vector.
1.
2.
3.
Initializing CPU#1
CPU#1 (phys ID: 1) waiting for CALLOUT
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
Calibrating delay using timer specific routine.. 4153.87 BogoMIPS
(lpj=8307759)
Stack at about ffff81007ffbdef4
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
 stepping 00
cpu 1: setting up apic clock
cpu 1: enabling apic timer
CPU 1: Syncing TSC to CPU 0.
CPU has booted.
waiting for cpu 1
++++++++++++++++++++=_---CPU UP  2
Booting processor 2/2 rip 6000 rsp ffff81013ff1df58
Setting warm reset code and vector.
1.
2.
3.
Initializing CPU#2
CPU#2 (phys ID: 2) waiting for CALLOUT
Before Callout 2.
After Callout 2.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#2
CPU 1: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 596 cycles)
Calibrating delay using timer specific routine.. 4422.55 BogoMIPS
(lpj=8845105)
Stack at about ffff81013ff1def4
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(2) -> Node 1 -> Core 0
 stepping 00
cpu 2: setting up apic clock
Unable to handle kernel paging request at ffff81007ffbc000 RIP: 
[<ffff81007ffbc000>]
PGD 8063 PUD a063 PMD 800000007fe001e3 PTE 0
Oops: 0011 [1] SMP 
CPU 2 
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.13-rc1
RIP: 0010:[<ffff81007ffbc000>] [<ffff81007ffbc000>]
RSP: 0018:ffff81007ff67fa0  EFLAGS: 00010006
RAX: ffff81013ff1dfd8 RBX: 0000000000000001 RCX: 0000000000008000
RDX: ffff81007ffbc000 RSI: ffffffff8043b9e2 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff8060e900(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffff81007ffbc000 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff81013ff1c000, task ffff81007ff614f0)
Stack: ffffffff80118139 0000000000000d06 ffffffff8010e483 ffff81013ff1de58
<EOI> 
       0000000000000002 0000000000002814 0000000000008000 0000000000000000 
       0000000000000000 ffffffff8060f180 
Call Trace: <IRQ> <ffffffff80118139>{smp_call_function_interrupt+73}
       <ffffffff8010e483>{call_function_interrupt+99}  <EOI>
<ffffffff80622e05>{setup_secondary_APIC_clock+21}
       <ffffffff80622653>{start_secondary+51} 

Code: f0 4d fd 3f 01 81 ff ff a0 12 4d 80 ff ff ff ff 00 00 00 00 
RIP [<ffff81007ffbc000>] RSP <ffff81007ff67fa0>
CR2: ffff81007ffbc000
CPU has booted.
