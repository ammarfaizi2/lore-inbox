Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130129AbRCBWru>; Fri, 2 Mar 2001 17:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRCBWrk>; Fri, 2 Mar 2001 17:47:40 -0500
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:5625 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S130129AbRCBWre>;
	Fri, 2 Mar 2001 17:47:34 -0500
Date: Fri, 2 Mar 2001 17:48:15 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, pat@isis.co.za,
        linux-kernel@vger.kernel.org, Alan@redhat.com
Subject: Re: PROBLEM: Network hanging - Tulip driver with Netgear (Lite-On)
In-Reply-To: <3AA01CAF.98726DEC@colorfullife.com>
Message-ID: <Pine.LNX.4.10.10103021743390.879-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Manfred Spraul wrote:
> Jeff Garzik wrote:
> > Manfred Spraul wrote:
> > > Could you double check the code in tulip_core.c, around line 1450?
> > > IMHO it's bogus.
> > >
> > > 1) if the network card contains multiple mii's, then the the advertised
> > > value of all mii's is changed to the advertised value of the first mii.
...
> > If you have a single controller with multiple MII phys...  how does one
> > select the phy of choice (for tulip, in the absence of SROM media
> > table...)?
> 
> I'd choose the first one with a link partner.

Well, yes, but what is "first"?

Are there any Tulip cards (besides the Comet-2 w/HPNA) that have multiple
MII transceivers?

The Comet2 is a special case, since only one transceiver is powered and
visible at a time.  Polling the other transceiver switches off the
first.

> > And once phy A has been selected out of N available as the
> > active phy, should you care about the others at all?
> 
> Not until the link beat disappears.

Uhmm, but you don't always know when you have lost link beat.  In some
cases the driver does basic polling to check for duplex changes, but
the semantics are not as clean as you would expect.


Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

