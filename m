Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267871AbTB1OCO>; Fri, 28 Feb 2003 09:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267881AbTB1OCO>; Fri, 28 Feb 2003 09:02:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19219 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267871AbTB1OCN>;
	Fri, 28 Feb 2003 09:02:13 -0500
Date: Fri, 28 Feb 2003 14:12:34 +0000
From: Matthew Wilcox <willy@debian.org>
To: Andi Kleen <ak@suse.de>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73heao7ph2.fsf@amdsimf.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73heao7ph2.fsf@amdsimf.suse.de>; from ak@suse.de on Fri, Feb 28, 2003 at 09:56:41AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 09:56:41AM +0100, Andi Kleen wrote:
> Matthew Wilcox <willy@debian.org> writes:
> > -
> > +#define GFP_ATOMIC_DMA (GFP_ATOMIC | __GFP_DMA)
> > +#define GFP_KERNEL_DMA (GFP_KERNEL | __GFP_DMA)
> > 
> > combined with changing some users to use __GFP_DMA if they really do mean
> > the bitmask.  Comments?
> 
> Sounds like a good 2.7.x early project. Currently we still have too much
> driver breakage for the next release to break even more right now.

i'm not the kind of person who just changes the header file and breaks all
the drivers.  plan:

 - Add the GFP_ATOMIC_DMA & GFP_KERNEL_DMA definitions
 - Change the drivers
 - Delete the GFP_DMA definition

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
