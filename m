Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266101AbUFWD4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266101AbUFWD4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 23:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbUFWD4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 23:56:55 -0400
Received: from dialup-4.246.250.177.Dial1.SanJose1.Level3.net ([4.246.250.177]:24963
	"EHLO nofear.bounceme.net") by vger.kernel.org with ESMTP
	id S266101AbUFWD4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 23:56:23 -0400
Reply-To: <syphir@syphir.sytes.net>
From: "C.Y.M." <syphir@syphir.sytes.net>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kernel Oops introduced in kernel-2.6.7-bk4+
Date: Tue, 22 Jun 2004 20:57:09 -0700
Organization: CooLNeT
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAqxghqCbPzkC/s9JQk+S1aAEAAAAA@syphir.sytes.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <40D8F1EE.4080106@pobox.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRYzme67XQ1lLbBTXe+dDGI67FKJgABrQbg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When bk6 comes out tomorrow, I will give it a try and write down the Oops
message by hand when/if it occurs again.  It seems that on June 20th, there
was a large list of changes.  But I have a feeling this has to do with
something using an invalid irq.  Starting with kernel 2.6.7-bk3, the ACPI on
the VIA chipsets seem to now be handling irqs differently.  The ACPI
messages in dmesg have significantly changed:

PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:11.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:11.2[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:11.3[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:11.4[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11

Best Regards..
C.Y.M.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jeff Garzik
> Sent: Tuesday, June 22, 2004 7:59 PM
> To: syphir@syphir.sytes.net
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Kernel Oops introduced in kernel-2.6.7-bk4+
> 
> C.Y.M. wrote:
> > After installing kernel-2.6.7-bk4 and bk5, my machine fails 
> to start (with
> > an Oops) right about when Samba attempts to load from the 
> init.d script.
> > Kernel-2.6.7-bk3 works perfectly, so it must be something 
> that was changed
> > right about on June 20th.
> [...]
> > P.S. I would have included the actual Oops message in this 
> email but it was
> > not in any of the logs.  The error is occuring before the 
> machine can get
> > started.
> 
> 
> This doesn't help us a while lot :(
> 
> See if you can copy the oops by hand, or use a serial console 
> to copy it 
> onto another computer.
> 
> 	Jeff
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

