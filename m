Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbSKGQbJ>; Thu, 7 Nov 2002 11:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261423AbSKGQbJ>; Thu, 7 Nov 2002 11:31:09 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:4005 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S261406AbSKGQbI>;
	Thu, 7 Nov 2002 11:31:08 -0500
Subject: SMP, ACPI and USB
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 Nov 2002 17:38:11 +0100
Message-Id: <1036687091.1127.5.camel@chevrolet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I posted this to acpi-devel as well yesterday, but I guess there are
more people to understand the problem here :) (Or so I hope)

I have an ASUS CUV266-DLS motherboard with two P3 1ghz cpu's. I have
never managed to get USB to work on this motherboard (nor did I on my
old Rioworks SDVIA smp-board, they both just said something like "device
not accepting address"). But I never had any use of usb, since my only
usb device was a Logitech Cordless Desktop, which have adapters for the
PS/2 ports. But I'm now going to buy a scanner, and thus I need to get
usb working. 

That was not easy! I found in the faq at http://www.linux-usb.org that
there are problems with smp machines. That I should try to set MPS to
1.1 instead of 1.4, that some motherboards might need a "noapic" boot
option and that ACPI sometimes confuses this.

I have a 2.4.20-rc1 kernel with the latest acpi-patch. I do need the
acpi-patch for two reasons. I'm not able to boot the pc without the acpi
patch if the secondary ide-channel is activated. And I need it to be
able to turn of the computer.

I tried the noapic boot option, which absolutely not worked. I got lots
and lots of cpu-errors, or something, and then it hung. Then I tried
MPS1.1 (What's the benefit with 1.4? I know that with 1.4 it uses irq's
above 15, but...) Still no luck. then boot option acpi=off did it. Now
my USB works quite flawlessly.

But I would very, very much like to be able to use ACPI, so I can get to
turn of my computer, without pushing the power-button for four seconds.
Am I the only one using usb on smp-machines, or are my two motherboards
just about the only ones incompatible?

Sorry for this long post.

Best regards,
Stian Jordet


