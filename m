Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265034AbSK1BCa>; Wed, 27 Nov 2002 20:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265023AbSK1BCa>; Wed, 27 Nov 2002 20:02:30 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:53132 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S265003AbSK1BC3>;
	Wed, 27 Nov 2002 20:02:29 -0500
Date: Wed, 27 Nov 2002 20:05:59 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: To:  Joseph Fannin <jhf@rivenstone.net>, Shawn Starr <spstarr@sh0n.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM][SOUND][2.5] - ALSA & OSS cannot find SBAWE32 Card
Message-ID: <20021127200559.GA6305@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>, To: 
	Joseph Fannin <jhf@rivenstone.net>, Shawn Starr <spstarr@sh0n.net>,
	linux-kernel@vger.kernel.org
References: <200211260258.05564.spstarr@sh0n.net> <20021126085840.GA1033@zion.rivenstone.net> <Pine.LNX.4.50.0211261044070.1462-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0211261044070.1462-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 10:47:03AM -0500, Zwane Mwaikambo wrote:
> On Tue, 26 Nov 2002, Joseph Fannin wrote:
> 
> > On Tue, Nov 26, 2002 at 02:58:05AM -0500, Shawn Starr wrote:
> >
> > > ALSA device list:
> > >    No soundcards found.
> > >
> > > dmesg 2.4.20-pre7 - OSS: - WORKS
> > > ============================
> >
> >     Me too!
> >
> >     In 2.5.47 mainline and 2.5.49-ac1 the ALSA drivers (either sb16 or
> > sbawe) load but don't detect devices if PNP support is built in.  The
> > same card (an awe64) works fine under 2.4.19.
> >
> >     Without PNP sb16 works (with only sb16 features) but sbawe will
> > not load, complaining that it can't find the awe bits.
> 
> My guess would be the new isapnp registration layer, which ALSA
> doesn't seem to be using. I might have a go at it later, looks like it
> might need conversion.
> 
> Cheers,
> 	Zwane

That is indeed the case.  I just released a patch for pnp card support.
This new API can be used to convert these drivers.

Thanks,
Adam
