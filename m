Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289224AbSBNAXh>; Wed, 13 Feb 2002 19:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289226AbSBNAX2>; Wed, 13 Feb 2002 19:23:28 -0500
Received: from iggy.triode.net.au ([203.63.235.1]:29374 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S289224AbSBNAXL>; Wed, 13 Feb 2002 19:23:11 -0500
Date: Thu, 14 Feb 2002 11:22:20 +1100
From: Linux Kernel Mailing List <kernel@iggy.triode.net.au>
To: bob@dwcs.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x ALI IDE strangeness
Message-ID: <20020214112220.A21385@iggy.triode.net.au>
In-Reply-To: <Pine.LNX.4.40.0202131655290.3878-100000@dwcs.net> <20020214100511.A11641@iggy.triode.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020214100511.A11641@iggy.triode.net.au>; from kernel@iggy.triode.net.au on Thu, Feb 14, 2002 at 10:05:11AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just compiled 2.4.17 with  patch-2.4.18-pre9-ac3, the result is
that the machine locks up when compiling a kernel with DMA off
or DMA on. 

With 2.4.17 and patch-2.4.18-pre9 my machine only locks up when 
DMA is turned on. 

As part of the testing I've taken out all of the LILO append
parameters.

I'd appreciate any suggestions on how to proceed with testing
on what I suspect is an ALI chipset related issue.

Regards.  Paul



On Thu, Feb 14, 2002 at 10:05:11AM +1100, Linux Kernel Mailing List wrote:
> Bob,
> 
> I'm also experiencing strange hangs with DMA on and ALI15x3.
> I'm using an ASUS A7A266 motherboard.
> 
> Make sure that the BIOS setting of "PNP OS" is off
> 
> I can turn DMA on using hdparm, however my system freezes up
> if I try some heavy work like a kernel compile.
> 
> I'm sure there is a kernel bug here, I'm trying to find
> a kernel developer who is interested in investigating it.
> 
> Regards.  Paul
> 
> 
> 
> On Wed, Feb 13, 2002 at 05:32:35PM -0500, bob@dwcs.net wrote:
> > When using any 2.4.x kernel, including the very latest one, with my
> > Fujitsu Lifebook P which uses the ALI  M5229 IDE controller it acts much
> > different than when using any 2.2.x  kernels that I have tried.  When
> > using the latest 2.2 kernels and not including specific support for the
> > ALI controller the kernel detects the controller and lets me use DMA.
> > When compiling in ALI IDE support in either 2.2 or 2.4 kernels the system
> > hangs when the controller is detected.
> > That isn't really much of a problem in the 2.2 kernels because I can just
> > use the generic IDE support.  In the 2.4 kernel series though, I can't
> > enable DMA.  When booting with a 2.4 kernel I get this:
> > 
> > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > ALI15X3: IDE controller on PCI bus 00 dev 78
> > PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using
> > pci=biosirq.
> > ALI15X3: chipset revision 195
> > ALI15X3: not 100% native mode: will probe irqs later
> > ALI15X3: simplex device:  DMA disabled
> > ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
> > ALI15X3: simplex device:  DMA disabled
> > ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
> > 
> > Then hdparm absolutely will not let me enable DMA giving me this error:
> > 
> > /dev/hda:
> >  setting using_dma to 1 (on)
> >  HDIO_SET_DMA failed: Operation not permitted
> >  using_dma    =  0 (off)
> > 
> > 
> > Changing the PNP OS value in the BIOS to either Yes or No does absolutely
> > nothing and using "pci=biosirq" just makes the part that says "Please try
> > using pci=biosirq." go away.
> > 
> > However, on accident I discovered if I boot with a 2.2 kernel, reset the
> > computer instead of powering off, then boot with a 2.4 kernel it will let
> > me enable DMA.
> > 
> > Is there anything I could try to make DMA work with the 2.4 series?
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
