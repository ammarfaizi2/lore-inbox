Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVBJXdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVBJXdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 18:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVBJXdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 18:33:32 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:14704 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261950AbVBJXdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 18:33:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=t5ieAJ8bS8sjUZn4qXxbvxkc5FzxVPCph+hc9gWZ2/UFpSl4McunSbLKugeeAYg2TpSJ8ZLC1RS1Msk4MWgiUopzAEaV+zgrt/NMFcCPKgf4wFjH8JG6jrdreAZ3FluWKsGEKXx5DfxqL5GpD0nfBL81NWTMiMJiS+ICaQ2ZDJo=
Message-ID: <58cb370e050210152820d6fc96@mail.gmail.com>
Date: Fri, 11 Feb 2005 00:28:04 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
Cc: Bill Davidsen <davidsen@tmr.com>, Jeff Garzik <jgarzik@pobox.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Martins Krikis <mkrikis@yahoo.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <20050210183934.GF20153@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <420631BF.7060407@pobox.com> <420582C6.7060407@pobox.com>
	 <58cb370e05020607197db9ecf4@mail.gmail.com> <420BB77B.3080508@tmr.com>
	 <58cb370e05021012051518e912@mail.gmail.com>
	 <58cb370e0502101404e4ddefa@mail.gmail.com>
	 <20050210183934.GF20153@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 16:39:34 -0200, Marcelo Tosatti
<marcelo.tosatti@cyclades.com> wrote:
> On Thu, Feb 10, 2005 at 11:04:09PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Thu, 10 Feb 2005 21:05:13 +0100, Bartlomiej Zolnierkiewicz
> > <bzolnier@gmail.com> wrote:
> > > On Thu, 10 Feb 2005 14:35:23 -0500, Bill Davidsen <davidsen@tmr.com> wrote:
> > > > Bartlomiej Zolnierkiewicz wrote:
> > > > > On Sun, 06 Feb 2005 10:03:27 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> > > > >
> > > > >>Arjan van de Ven wrote:
> > > > >>
> > > > >>>>I consider it not a new feature, but a missing feature, since otherwise
> > > > >>>>user data cannot be accessed in the RAID setups.
> > > > >>>
> > > > >>>
> > > > >>>the same is true for all new hardware drivers and hardware support
> > > > >>>patches. And for new DRM (since new X may need it) and new .. and
> > > > >>>new ... where is the line?
> > > > >>>
> > > > >>>for me a deep maintenance mode is about keeping existing stuff working;
> > > > >>>all new hw support and derivative hardware support (such as this) can be
> > > > >>>pointed at the new stable series... which has been out for quite some
> > > > >>>time now..
> > > > >>
> > > > >>Red herring.
> > > > >>
> > > > >>2.4.x has ICH5/6 support -- but is missing the RAID support component.
> > > > >>
> > > > >>We are talking about hardware that is ALREADY supported by 2.4.x kernel,
> > > > >>not new hardware.
> > > > >>
> > > > >>We are also talking about inability to access data on hardware supported
> > > > >>by 2.4.x, not something that can easily be ignored or papered over with
> > > > >>a compatibility mode.
> > > > >
> > > > >
> > > > > the same arguments can be used for crypto support etc.,
> > > > > answer is - use 2.6.x or add extra patches to get 2.4.x working
> > > >
> > > > It's fix in a sense. The hardware is supported now, just not very well.
> > > > If an IDE chipset was capable of UDA4 and the driver only allowed UDA2
> > > > it would be a fix, in this case thehardware is supported partially, the
> > > > RAID conponent isn't working, and this is the fix.
> > >
> > > The so called "RAID component" is 100% *software* solution.
> > >
> > > BTW What is UDA?
> >
> > [ This mail is just to explain why I don't like iswraid,
> >   I don't care if it gets merged that much... ]
> >
> > another BTW: this driver adds another incompatibility between
> > 2.4.x and 2.6.x.
> 
> What do you mean "adds another incompatibility" ?
> 
> That users will have to switch to dmraid when upgrading to v2.6.x ?

It is worse than that - AFAIR iswraid provides some features which
are NOT available in 2.6.x kernels.

> > Also most 2.4.x users will want (or have to) migrate
> > to 2.6.x one day and they will have to switch to using device mapper
> > and dmraid anyway.  From my POV merging/supporting iswraid
> > in any way is a lost of time for EVERYBODY in the long-term.
> > Martins, I appreciate all hard work that went into iswraid driver but
> > please face the simple fact, this driver was already obsoleted in
> > the moment it was created (from Linux development process POV).
> >
> > I previously (October?) asked about merging device-mapper
> > instead as it provides easier way to migrate to 2.6.x (not only for
> > Intel "RAID component" users but for ALL "RAID components" users)
> > as they would be able to use the same method for accessing their
> > data in both kernels.  I was said that it is too late for such changes
> > (I consider device-mapper a new driver, changes to existing code
> > are REALLY minimal AFAIR) and that 2.4.x should stick to ataraid while
> > 2.6.x to device-mapper which was just silly argument IMHO (why we
> > don't stick to IDE drivers for SATA in 2.4.x?).
> 
> SATA is not the same case as sw-RAID in my POV Bart, it allows many
> users to be _able_ use SATA controllers/drives.

Fully agreed but what is your point?  Mine was that we can different
subsystems/drivers for the same device/functionality - like we have
both IDE+siimage and libata+sata_sil drivers in 2.4.x.

Maybe Martins was forced to develop for ataraid in 2.4.x
because lack of device-mapper.  In such case the current
situations is our fault and we can learn something from it.

> > I finally gave up because I didn't want to waste more my time on this and
> > didn't want to go into
> > politics etc... but damn iswraid wasn't merged so I feel stupid now. :-)
> 
> Good to hear your opinion.
