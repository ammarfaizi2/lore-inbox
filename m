Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVERFSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVERFSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 01:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVERFS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 01:18:29 -0400
Received: from dvhart.com ([64.146.134.43]:26274 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262095AbVERFSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 01:18:01 -0400
Date: Tue, 17 May 2005 22:18:00 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@muc.de>
Subject: Re: problems with mpt fusion driver since 2.6.12-rc3 (amd64 ?)
Message-ID: <325490000.1116393480@[10.10.2.4]>
In-Reply-To: <913740000.1116371521@flay>
References: <912220000.1116371234@flay> <913740000.1116371521@flay>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I get this on boot since -rc3 ... -rc2 worked fine.
>> Is on a 4-way Newisys amd64 box.
>> 
>> Is this a known bug, or something new?
>> 
>> ^M^@Fusion MPT base driver 3.01.20
>> ^M^@Copyright (c) 1999-2004 LSI Logic Corporation
>> ^M^@ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 27 (level, low) -> IRQ 27
>> ^M^@mptbase: Initiating ioc0 bringup
>> ^M^@mptbase: ioc0: ERROR - Wait IOC_READY state timeout(15)!
>> ^M^@mptbase: ioc0: ERROR - Enable Diagnostic mode FAILED! (00h)
>> ^M^@mptbase: ioc0 NOT READY WARNING!
>> ^M^@mptbase: WARNING - ioc0 did not initialize properly! (-1)
>> ^M^@mptbase: probe of 0000:02:04.0 failed with error -1
>> ^M^@Fusion MPT SCSI Host driver 3.01.20
> 
> I get strange errors on -rc4-mm2 as well ... and every kernel
> since -rc2-mm2 ... though they all fail in different ways.
> 
> ^M^@tg3.c:v3.27 (May 5, 2005)
> ^M^@ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 25 (level, low) -> IRQ 25
> ^M^@tg3: (0000:02:02.0) phy probe failed, err -16
> ^M^@BUG: soft lockup detected on CPU#3!
> ^M
> ^M^@Modules linked in:
> ^M^@Pid: 42, comm: swapper Not tainted 2.6.12-rc4-mm2-autokern1
> ^M^@RIP: 0010:[<ffffffff8037c42b>] <ffffffff8037c42b>{lock_kernel+27}
> ^M^@RSP: 0000:ffff8101ff401ec0  EFLAGS: 00000286
> ^M^@RAX: ffff8101ffb37070 RBX: 0000000000000000 RCX: 0000000000000010
> ^M^@RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> ^M^@RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8101ffbad940
> ^M^@R10: 0000000000000001 R11: ffffffff80258560 R12: 0000000000000000
> ^M^@R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> ^M^@FS:  0000000000000000(0000) GS:ffffffff804cf9c0(0000) knlGS:0000000000000000
> ^M^@CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> ^M^@CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
> ^M
> ^M^@Call Trace:<ffffffff802af516>{serio_thread+22} <ffffffff8012bdc0>{schedule_t
> ail+64}
> ^M^@       <ffffffff8010e47b>{child_rip+8} <ffffffff80258560>{vgacon_cursor+0}
> ^M^@       <ffffffff802af500>{serio_thread+0} <ffffffff8010e473>{child_rip+0}
> ^M^@       
> ^M^@tg3: Problem fetching invariants of chip, aborting.
> ^M^@tg3: probe of 0000:02:02.0 failed with error -16
> ^M^@ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 26 (level, low) -> IRQ 26
> ^M^@tg3: (0000:02:03.0) phy probe failed, err -16
> ^M^@tg3: Problem fetching invariants of chip, aborting.
> ^M^@tg3: probe of 0000:02:03.0 failed with error -16

OK, I tested -rc3 with the fusion code backed down to -rc2 level - no
difference. So it's looking more like it might be an interrupt prob?

M.
