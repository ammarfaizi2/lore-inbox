Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbTB1OXp>; Fri, 28 Feb 2003 09:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbTB1OXp>; Fri, 28 Feb 2003 09:23:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28435 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262425AbTB1OXo>;
	Fri, 28 Feb 2003 09:23:44 -0500
Date: Fri, 28 Feb 2003 14:34:05 +0000
From: Matthew Wilcox <willy@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <willy@debian.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73heao7ph2.fsf@amdsimf.suse.de> <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk> <1046445897.16599.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1046445897.16599.60.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 28, 2003 at 03:24:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 03:24:58PM +0000, Alan Cox wrote:
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

umm.  are you volunteering to convert drivers/net/macmace.c to the pci_*
API then?  also, GFP_DMA is used on, eg, s390 to get memory below 2GB and
on ia64 to get memory below 4GB.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
