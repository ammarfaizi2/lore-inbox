Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268012AbTB1Pze>; Fri, 28 Feb 2003 10:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268014AbTB1Pze>; Fri, 28 Feb 2003 10:55:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43786 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268012AbTB1Pzc>; Fri, 28 Feb 2003 10:55:32 -0500
Date: Fri, 28 Feb 2003 16:05:50 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030228160550.B31251@flint.arm.linux.org.uk>
Mail-Followup-To: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>,
	linux-kernel@vger.kernel.org
References: <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su>; from D.A.Fedorov@inp.nsk.su on Fri, Feb 28, 2003 at 09:44:14PM +0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 09:44:14PM +0600, Dmitry A. Fedorov wrote:
> On 28 Feb 2003, Alan Cox wrote:
> > On Fri, 2003-02-28 at 14:12, Matthew Wilcox wrote:
> > > i'm not the kind of person who just changes the header file and breaks all
> > > the drivers.  plan:
> > > 
> > >  - Add the GFP_ATOMIC_DMA & GFP_KERNEL_DMA definitions
> > >  - Change the drivers
> > >  - Delete the GFP_DMA definition
> > 
> > Needless pain for people maintaining cross release drivers. Save it for
> > 2.7 where we should finally do the honourable deed given x86-64 may well
> > be mainstream, and simply remove GFP_DMA and expect people to use 
> > pci_*
> 
> But why drivers of ISA bus devices with DMA should use pci_* functions?
> 
> I'm personally wouldn't have too much pain with GFP_DMA because I have
> compatibility headers and proposed change for them is tiny.

Umm, question - I've seen ISA bridges with the ability to perform 32-bit
DMA using the ISA DMA controllers.  AFAIK, Linux doesn't make use of this
feature, except on ARM PCI systems with ISA bridges.  Is there a reason
why this isn't used on x86 hardware?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

