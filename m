Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264443AbRFISeb>; Sat, 9 Jun 2001 14:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264468AbRFISeU>; Sat, 9 Jun 2001 14:34:20 -0400
Received: from smtp3.xs4all.nl ([194.109.127.132]:15116 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S264443AbRFISeG>;
	Sat, 9 Jun 2001 14:34:06 -0400
From: thunder7@xs4all.nl
Date: Sat, 9 Jun 2001 20:15:22 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] usb.c: USB device not accepting new address=4 (error=-110)
Message-ID: <20010609201522.A5319@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20010609064123.V11815@nightmaster.csn.tu-chemnitz.de> <0ab501c0f0ac$10532720$cc07aace@brownell.org> <20010609091919.W11815@nightmaster.csn.tu-chemnitz.de> <0ae201c0f0e6$1b59fb00$cc07aace@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ae201c0f0e6$1b59fb00$cc07aace@brownell.org>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2001 at 06:14:24AM -0700, David Brownell wrote:
> Then whatever sets up your ServerWorks ServerSet III LE chipset
> needs its PCI IRQ setup fixed ... I'm not sure how to do this.
> 
> Perhaps someone who's familiar with arch/i386/kernel/pci-*.c
> irq setup can suggest the right patch for this problem.  I think
> the "dmesg" output in your original post probably had the info
> needed to figure that out.
> 
> - Dave
> 
> 
> > From: "Ingo Oeser" <ingo.oeser@informatik.tu-chemnitz.de>
> > Sent: Saturday, June 09, 2001 12:19 AM
> >
> > > David Brownell wrote:
> > > Can you verify, using /proc/interrupts, that you're actually
> > > getting interrupts on irq #30 when these timeouts happen?
> >  
> > I get none:
> >  30:          0          0   IO-APIC-level  usb-ohci
> >  
> > > One possibility:  the timeout happens because the HCD
> > > is not getting the interrupts it expects.  That would imply
> > > that the PCI IRQ setup for this device isn't quite right.
> > > Such problems have been seen before.
> > 
> > This seems to be my problem. How can I solve this?
> > 
> > My BIOS cannot set a specific IRQ for USB like other BIOSes do.
> > 
> > And now that you say^W it, I remember sth. like this on
> > linux-kernel... I just didn't know the messages...
> > 
A similar problem with USB on a VIA smp board was solved by Jeff Garzik,
so you might want to send him some info, like

dmesg
lspci -vvvxxx

Good luck,
Jurriaan
-- 
You have nothing to be afraid of. Well, that might not be true in the
larger scheme of things, but this ordeal is over, so off you go. Toodle-oo.
	Fraser, Due South
GNU/Linux 2.4.5-ac12 SMP/ReiserFS 2x1402 bogomips load av: 0.49 0.12 0.04
