Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267959AbTB1Piy>; Fri, 28 Feb 2003 10:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267970AbTB1Piy>; Fri, 28 Feb 2003 10:38:54 -0500
Received: from inpbox.inp.nsk.su ([193.124.167.24]:12705 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP
	id <S267959AbTB1Piy>; Fri, 28 Feb 2003 10:38:54 -0500
Date: Fri, 28 Feb 2003 21:44:14 +0600
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: linux-kernel@vger.kernel.org
Subject: Re: Proposal: Eliminate GFP_DMA
In-Reply-To: <1046445897.16599.60.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Feb 2003, Alan Cox wrote:
> On Fri, 2003-02-28 at 14:12, Matthew Wilcox wrote:
> > i'm not the kind of person who just changes the header file and breaks all
> > the drivers.  plan:
> > 
> >  - Add the GFP_ATOMIC_DMA & GFP_KERNEL_DMA definitions
> >  - Change the drivers
> >  - Delete the GFP_DMA definition
> 
> Needless pain for people maintaining cross release drivers. Save it for
> 2.7 where we should finally do the honourable deed given x86-64 may well
> be mainstream, and simply remove GFP_DMA and expect people to use 
> pci_*

But why drivers of ISA bus devices with DMA should use pci_* functions?

I'm personally wouldn't have too much pain with GFP_DMA because I have
compatibility headers and proposed change for them is tiny.

