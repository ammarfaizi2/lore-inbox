Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVBKAXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVBKAXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 19:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVBKAXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 19:23:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42657 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261963AbVBKAWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 19:22:43 -0500
Date: Thu, 10 Feb 2005 18:33:39 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Jeff Garzik <jgarzik@pobox.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Martins Krikis <mkrikis@yahoo.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
Message-ID: <20050210203339.GB20828@logos.cnet>
References: <420631BF.7060407@pobox.com> <420582C6.7060407@pobox.com> <58cb370e05020607197db9ecf4@mail.gmail.com> <420BB77B.3080508@tmr.com> <58cb370e05021012051518e912@mail.gmail.com> <58cb370e0502101404e4ddefa@mail.gmail.com> <20050210183934.GF20153@logos.cnet> <58cb370e050210152820d6fc96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e050210152820d6fc96@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Bart,

On Fri, Feb 11, 2005 at 12:28:04AM +0100, Bartlomiej Zolnierkiewicz wrote:

> > > [ This mail is just to explain why I don't like iswraid,
> > >   I don't care if it gets merged that much... ]
> > >
> > > another BTW: this driver adds another incompatibility between
> > > 2.4.x and 2.6.x.
> > 
> > What do you mean "adds another incompatibility" ?
> > 
> > That users will have to switch to dmraid when upgrading to v2.6.x ?
> 
> It is worse than that - AFAIR iswraid provides some features which
> are NOT available in 2.6.x kernels. 

Oh really?

> > > Also most 2.4.x users will want (or have to) migrate
> > > to 2.6.x one day and they will have to switch to using device mapper
> > > and dmraid anyway.  From my POV merging/supporting iswraid
> > > in any way is a lost of time for EVERYBODY in the long-term.
> > > Martins, I appreciate all hard work that went into iswraid driver but
> > > please face the simple fact, this driver was already obsoleted in
> > > the moment it was created (from Linux development process POV).
> > >
> > > I previously (October?) asked about merging device-mapper
> > > instead as it provides easier way to migrate to 2.6.x (not only for
> > > Intel "RAID component" users but for ALL "RAID components" users)
> > > as they would be able to use the same method for accessing their
> > > data in both kernels.  I was said that it is too late for such changes
> > > (I consider device-mapper a new driver, changes to existing code
> > > are REALLY minimal AFAIR) and that 2.4.x should stick to ataraid while
> > > 2.6.x to device-mapper which was just silly argument IMHO (why we
> > > don't stick to IDE drivers for SATA in 2.4.x?).
> > 
> > SATA is not the same case as sw-RAID in my POV Bart, it allows many
> > users to be _able_ use SATA controllers/drives.
> 
> Fully agreed but what is your point?  Mine was that we can different
> subsystems/drivers for the same device/functionality - like we have
> both IDE+siimage and libata+sata_sil drivers in 2.4.x.

My point is that the SATA subsystem is a very different case from 
device-mapper.

The SATA subsystem provides _hardware_ knowledge, it provides the ability 
for certain very popular devices to work, and improved functionality
for devices which could be driven by the IDE subsystem.

Now the device mapper can be thought of as a high-level abstraction in which 
LVM, RAID, and other functionality can be built on top of. We already have 
those in v2.4. 

They are quite different.

> Maybe Martins was forced to develop for ataraid in 2.4.x
> because lack of device-mapper.  In such case the current
> situations is our fault and we can learn something from it.

True. 

> > > I finally gave up because I didn't want to waste more my time on this and
> > > didn't want to go into
> > > politics etc... but damn iswraid wasn't merged so I feel stupid now. :-)
> > 
> > Good to hear your opinion.  


