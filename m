Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268001AbTB1Ps0>; Fri, 28 Feb 2003 10:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268003AbTB1Ps0>; Fri, 28 Feb 2003 10:48:26 -0500
Received: from havoc.daloft.com ([64.213.145.173]:24501 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268001AbTB1PsZ>;
	Fri, 28 Feb 2003 10:48:25 -0500
Date: Fri, 28 Feb 2003 10:58:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030228155841.GA4678@gtf.org>
References: <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su>
User-Agent: Mutt/1.3.28i
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

Do not let the name "pci_" distract, it works for ISA too :)

We can #define pci_xxx isa_xxx if you like :)

	Jeff



