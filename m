Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281160AbRKPHHs>; Fri, 16 Nov 2001 02:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281215AbRKPHH2>; Fri, 16 Nov 2001 02:07:28 -0500
Received: from mail.bmlv.gv.at ([193.171.152.34]:6075 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S281160AbRKPHHU>;
	Fri, 16 Nov 2001 02:07:20 -0500
Message-Id: <3.0.6.32.20011116080809.009150b0@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Fri, 16 Nov 2001 08:08:09 +0100
To: linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: Re: Lockup in IDE code
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had the same problem.

Lockups with 2.4.14pre1 + ext3-patch, sysrq not possible, HD led is on.

This is a 7IXE4 (AMD756), Duron 650, 384MB. 2 HD's, 1 CDROM.

	
I've noted that on startup I got "spurious 8259A interrupt: IRQ7", and the
machine locked hard on IDE activity (sometimes).
after observing the above message and others like 
	hda: timeout waiting for DMA
	ide_dmaproc: chipset supported ide_dma timeoutfunc only: 14
	hda: read_intr: status=0x51
	hda: read_intr: status=0x04
	hda: read_intr: status=0x51
	hda: read_intr: status=0x04
	hda: read_intr: status=0x51
	hda: read_intr: status=0x04
	ide0: reset: success

The I've tested disabling some options.
So far my best result was disabling APIC on UP (both - IOAPIC and APIC) -
so far I've had no more lockups.

Will test further, but this seemed to be the problem for me.


Regards,

Phil


-
This message is RSA-encrypted: n=33389, e=257

