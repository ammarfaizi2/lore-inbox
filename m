Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVAJUkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVAJUkP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVAJUg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:36:58 -0500
Received: from mail.tyan.com ([66.122.195.4]:37134 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262511AbVAJUfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:35:22 -0500
Message-ID: <3174569B9743D511922F00A0C9431423072913A7@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: "'Mikael Pettersson'" <mikpe@csd.uu.se>, jamesclv@us.ibm.com,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Mon, 10 Jan 2005 12:46:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With lifting cpu0 apic id to 0x10, on Nvidia chip set, it could pass the
calibrate_delay in bsp. But it can not start core1/node0.


Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1019432k/1048576k available (3006k kernel code, 0k reserved, 1317k
data, 548k init)
LYH calibrating 0 jiffies = 4294667567, now=1622307524
LYH calibrating 1 jiffies = 4294667572, now=1633421978
LYH calibrating 3 jiffies = 4294667601, now=1699336699
4374.52 BogoMIPS (lpj=2187264)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0
CPU: Physical Processor ID: 0
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0
CPU: Physical Processor ID: 0
CPU0:  stepping 00
per-CPU timeslice cutoff: 1023.91 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/17 rip 6000 rsp ffff810002217f58
Initializing CPU#1
LYH calibrating 0 jiffies = 4294667674, now=1860098546
LYH calibrating 1 jiffies = 4294667674, now=1860104172
Calibrating delay loop... <7>Calibrating delay loop... <7>spurious 8259A
interrupt: IRQ7.
APIC error on CPU0: 00(08)
APIC error on CPU1: 00(08)
APIC error on CPU1: 08(08)
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at timer:416
invalid operand: 0000 [1] SMP 
CPU 1 
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.10-bk13
RIP: 0010:[<ffffffff8013958d>] <ffffffff8013958d>{cascade+45}
RSP: 0018:ffff81000221fed8  EFLAGS: 00010007
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff810001e15820
RBP: ffff810001e16838 R08: 00000000fffffff2 R09: 0000000000000009
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff810001e15820
R13: 0000000000000000 R14: ffff81000221ff08 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffffffff80579080(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006a0
Process swapper (pid: 0, threadinfo ffff810002216000, task ffff810002210dd0)
Stack: 0000000000000000 0000000000000000 ffffffff8057a510 ffff810001e15820 
       ffffffff80609900 ffffffff8013970e ffff81000221ff08 ffff81000221ff08 
       ffffffff8057a764 fffffffffffffffe 
Call Trace:<IRQ> <ffffffff8013970e>{run_timer_softirq+126}
<ffffffff801361b1>{__do_softirq+113} 
       <ffffffff80136265>{do_softirq+53} <ffffffff8010ff3f>{do_IRQ+63} 
       <ffffffff8010d865>{ret_from_intr+0}  <EOI>
<ffffffff805880e1>{calibrate_delay+289} 
       <ffffffff8058d83b>{smp_callin+171}
<ffffffff8058d92e>{start_secondary+14} 
       

