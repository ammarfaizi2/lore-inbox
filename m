Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWGDLeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWGDLeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWGDLeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:34:44 -0400
Received: from colin.muc.de ([193.149.48.1]:27144 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932211AbWGDLen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:34:43 -0400
Date: 4 Jul 2006 13:34:41 +0200
Date: Tue, 4 Jul 2006 13:34:41 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Doug Thompson <norsk5@yahoo.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
Message-ID: <20060704113441.GA26023@muc.de>
References: <20060701150430.GA38488@muc.de> <20060703172633.50366.qmail@web50109.mail.yahoo.com> <20060703184836.GA46236@muc.de> <1151962114.16528.18.camel@localhost.localdomain> <20060704092358.GA13805@muc.de> <1152007787.28597.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152007787.28597.20.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 11:09:47AM +0100, Alan Cox wrote:
> Ar Maw, 2006-07-04 am 11:23 +0200, ysgrifennodd Andi Kleen:
> > Regarding your buzzwords: I don't think mcelog is in any way
> > less "manageable" or "consistent" than EDAC.
> 
> Its chip specific rather than generalised so you need awareness of it.

You mean the final output?

I guess it would be possible to add a generic output format
for memory errors in mcelog, but it's not clear you can always get
the same information from different chipsets.


> > > > Hmm, i haven't checked, but my understanding was that the newer
> > > > Intel chipsets all forwarded the memory errors as machine 
> > > > check anyways.
> > > 
> > > Quite a few still in use do not. We also have no idea where the future
> > 
> > New ones?  Would surprise me.
> 
> All the world is not x86. 

The rest of the world either doesn't do significant error handling 
(embedded, lowend) or has its own similar to mcelog error handling machine 
check systems (POWER, IA64) 

Ok Sparc, pa-risc, old SGI mips are left out currently but I'm sure the 
maintainers will attack that eventually if there is need. 

> > We don't have a generic interface for logging some of the other errors
> > (like PCI-E errors), but I don't see EDAC solving that. In some ways
> > it's understandable because there is no generic PCI-E error handling
> > code at all yet.
> 
> EDAC solves that for the PCI bus side. It's only solving the logging
> side not the "ok it exploded, now what" question - although there are
> some unrelated IBM patches in that area.

Yes some of that might be useful still for legacy systems.

In the future it should be more standardized with the standard x86
machine check architecture and standardized PCI Express advanced
error handling. So generic drivers should do the heavy lifting.

I'm not disputing it is still useful for some old systems, it just
doesn't seem to be the right part forward for new ones.

Is there work going on to hook up the old EDAC drivers for PCI errors to 
the new error handling? 


> > > The ecc code predates the MCE bits by years. The re-doing occurred
> > > rather earlier. Rather more useful would be to get the common interface
> > 
> > Earlier than the x86-64 machine check code?
> 
> Linux 1.2 I believe, certainly by 2.0

Doubtful you wrote a K8 error handler at this time frame ;-)

> 
> > Giving a consistent sysfs interface is a bit harder, but I suppose one 
> > could change the code to provide pseudo banks for enable/disable too.
> > However that would be system specific again, so a default "all on/all off" 
> > policy might be quite ok.
> 
> I think we need the basic consistent sysfs case. Whether that is

What should i do?

-Andi
