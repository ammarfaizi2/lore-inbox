Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267496AbTBRBBN>; Mon, 17 Feb 2003 20:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbTBRBBN>; Mon, 17 Feb 2003 20:01:13 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:65080 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S267496AbTBRBBM>; Mon, 17 Feb 2003 20:01:12 -0500
Date: Mon, 17 Feb 2003 20:11:08 -0500
From: Daniel Franke <daniel@franke.homeip.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.62: ide_scsi + sr_mod = kernel panic
Message-ID: <20030218011108.GA426@silmaril>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In both 2.5.60 and 2.5.62, I'm getting a kernel panic when I attempt to load
the ide-scsi and sr_mod kernel modules at the same time.  My hdc is a DVD-ROM 
and my hdd is a CD-RW.  My chipset is a VIA KT333.  Both SCSI emulation and
low-level SCSI support are compiled as modules.

Unable to handle kernel NULL pointer dereference at virtual address 00000000.
printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0000:[<00000000>]  Not Tainted
EFLAGS: 00010246
EIP is at 0x0
eax: c02f2fdc  ebx: c02f3088  ecx: f7df0040  edx: 00000174
esi: f657f640  esi: f657f640  edi: f7df0040  ebp: 00000001
ds: 0076  es: 0076  ss: 0068

Process swapper (pid: 0, threadinfo=c0294000 task=c025f0a0)
Stack: f8b3cd06 c02f3088 00000174 f657f680 c02f3088 f7df4710
       c02f3088 00000000 f7df42c0 0000000f c01cbe99 c00f3088
       f657f640 00000000 00000088 0000001e c1a70b80 f7df42c0
       c02f3088 c1a70b80 c01cc099 c02f3088 f7df42c0 c02f31bc

Call Trace:
[<f8b3cd06>] idescsi_issue_pc+0x1b6/0x1f0 [ide_scsi]
[<c01cbe99>] start_request+0xf9/0x1b0
[<c01cc099>] ide_do_request+0xf9/0x210
[<c01cc688>] ide_intr+0x128/0x180
[<f8b3c760>] idescsi_pc_intr+0x0/0x2d0 [ide_scsi]
[<c010b527>] do_IRQ+0x97/0x120
[<c0106f70>] default_idle+0x0/0x30
[<c0106f70>] default_idle+0x0/0x30
[<c0109dcc>] common_interrupt+0x18/0x20
[<c0106f70>] default_idle+0x0/0x30
[<c0106f70>] default_idle+0x0/0x30
[<c0106f94>] cpu_idle+0x2e/0x40
[<c0105000>] _stext+0x0/0x30

Code: Bad EIP value.
<0> Panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
