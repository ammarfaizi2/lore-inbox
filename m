Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265595AbUA0Vth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265651AbUA0Vth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:49:37 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:21703 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S265595AbUA0Vte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:49:34 -0500
Date: Tue, 27 Jan 2004 22:49:31 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP AMD64 (Tyan S2882) problems.
Message-ID: <20040127224931.D24747@fi.muni.cz>
References: <20040127190911.B13769@fi.muni.cz.suse.lists.linux.kernel> <p73fze1fdk4.fsf@nielsen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73fze1fdk4.fsf@nielsen.suse.de>; from ak@suse.de on Tue, Jan 27, 2004 at 07:31:55PM +0100
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
: Jan Kasprzak <kas@informatics.muni.cz> writes:
: 
: You don't say if you run a 32bit or a 64bit kernel. I will assume 64bit.
:  
	Correct.

: > Is it normal? How can I set up some IRQ balancing (or at least hard-wire
: > 3ware for CPU1 and eth0 for CPU0)?
: 
: Run irqbalanced
:  
	Thanks (in my system - Fedora Core 0.96 - it is "irqbalance", without
the "d" at the end, from kernel-utils package). When I ran it it migrated
some IRQs to CPU1, so this is probably OK. Thanks.

: > Problem 2: the 3ware controller does not work correctly on the first
: > PCI bus (slot 1 and 2) - in slot 1 it hangs under bigger load (e.g.
: > an array rebuild), in slot 2 it hangs during boot in 3ware BIOS.
: > It is probably not Linux-specific, but has anyone seen the same problem?
: 
: I haven't seen it.
: 
: You can try if it goes away when you disable ACPI PCI routing
: (pci=noacpi) 

	I will try tomorrow.

: > Problem 3:
: > What the "PCI-DMA: Disabling IOMMU." message in dmesg output means?
: 
: Ok you run a 64bit kernel. You don't have enough memory to require
: the IOMMU. That's fine.

	This is what I expected. OK.

: > Problem 4:
: > Does Linux support the hardware sensors on this board? The i2c driver
: > AMD8111 seems to be working, but what sensors driver should I use?
: 
: Most likely the Winbond W83627HF
: 
: iirc it's not possible in 2.6.1 to enable it. You have to drop the
: ISA dependency for "I2C_ISA" in drivers/i2c/busses/Kconfig

	Exactly. Thanks for the hint.

: > Problem 5:
: > Is there a 3ware configuration program (tw_cli), which works on AMD64?
: 
: You can try if the 32bit program works. If not ask 3ware.

	Does not work:

ioctl32(tw_cli:32216): Unknown cmd fd(3) cmd(0000001f){00} arg(080dd2e0) on /dev/twe0

I have asked 3ware.

	Thanks for your help,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|  I actually have a lot of admiration and respect for the PATA knowledge  |
| embedded in drivers/ide. But I would never call it pretty:) -Jeff Garzik |
