Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264472AbRFINS7>; Sat, 9 Jun 2001 09:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264471AbRFINSu>; Sat, 9 Jun 2001 09:18:50 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:11986 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264470AbRFINSj>; Sat, 9 Jun 2001 09:18:39 -0400
Date: Sat, 09 Jun 2001 06:14:24 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] usb.c: USB device not accepting new address=4
 (error=-110)
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-usb-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Message-id: <0ae201c0f0e6$1b59fb00$cc07aace@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20010609064123.V11815@nightmaster.csn.tu-chemnitz.de>
 <0ab501c0f0ac$10532720$cc07aace@brownell.org>
 <20010609091919.W11815@nightmaster.csn.tu-chemnitz.de>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Then whatever sets up your ServerWorks ServerSet III LE chipset
needs its PCI IRQ setup fixed ... I'm not sure how to do this.

Perhaps someone who's familiar with arch/i386/kernel/pci-*.c
irq setup can suggest the right patch for this problem.  I think
the "dmesg" output in your original post probably had the info
needed to figure that out.

- Dave


> From: "Ingo Oeser" <ingo.oeser@informatik.tu-chemnitz.de>
> Sent: Saturday, June 09, 2001 12:19 AM
>
> > David Brownell wrote:
> > Can you verify, using /proc/interrupts, that you're actually
> > getting interrupts on irq #30 when these timeouts happen?
>  
> I get none:
>  30:          0          0   IO-APIC-level  usb-ohci
>  
> > One possibility:  the timeout happens because the HCD
> > is not getting the interrupts it expects.  That would imply
> > that the PCI IRQ setup for this device isn't quite right.
> > Such problems have been seen before.
> 
> This seems to be my problem. How can I solve this?
> 
> My BIOS cannot set a specific IRQ for USB like other BIOSes do.
> 
> And now that you say^W it, I remember sth. like this on
> linux-kernel... I just didn't know the messages...
> 
> Thanks and Regards
> 
> Ingo Oeser


