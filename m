Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265184AbSK1ExW>; Wed, 27 Nov 2002 23:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbSK1ExV>; Wed, 27 Nov 2002 23:53:21 -0500
Received: from h014.c007.snv.cp.net ([209.228.33.242]:34196 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S265179AbSK1ExU>;
	Wed, 27 Nov 2002 23:53:20 -0500
X-Sent: 28 Nov 2002 05:00:39 GMT
Date: Wed, 27 Nov 2002 21:00:45 -0800
From: Paul Laufer <pelaufer@adelphia.net>
To: Adam Belay <ambx1@neo.rr.com>, Zwane Mwaikambo <zwane@holomorphy.com>,
       To:  Joseph Fannin <jhf@rivenstone.net>, Shawn Starr <spstarr@sh0n.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM][SOUND][2.5] - ALSA & OSS cannot find SBAWE32 Card
Message-ID: <20021128050045.GA17700@Hal9000.r2d2.dhs.org>
Mail-Followup-To: Paul Laufer <pelaufer@adelphia.net>,
	Adam Belay <ambx1@neo.rr.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>, To: 
	Joseph Fannin <jhf@rivenstone.net>, Shawn Starr <spstarr@sh0n.net>,
	linux-kernel@vger.kernel.org
References: <200211260258.05564.spstarr@sh0n.net> <20021126085840.GA1033@zion.rivenstone.net> <Pine.LNX.4.50.0211261044070.1462-100000@montezuma.mastecende.com> <20021127200559.GA6305@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021127200559.GA6305@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have nearly finished rewrite of OSS sb_card.c for the new PnP API. I
am only waiting on Rusty's module_param stuff to go in before I finish
and submit.

Let me know if you want to test it as it is without module options
working (defaults should be fine).

I will then update the sbawe driver.

Paul

On Wed, Nov 27, 2002 at 08:05:59PM +0000 or thereabouts, Adam Belay wrote:
> On Tue, Nov 26, 2002 at 10:47:03AM -0500, Zwane Mwaikambo wrote:
> > On Tue, 26 Nov 2002, Joseph Fannin wrote:
> > 
> > > On Tue, Nov 26, 2002 at 02:58:05AM -0500, Shawn Starr wrote:
> > >
> > > > ALSA device list:
> > > >    No soundcards found.
> > > >
> > > > dmesg 2.4.20-pre7 - OSS: - WORKS
> > > > ============================
> > >
> > >     Me too!
> > >
> > >     In 2.5.47 mainline and 2.5.49-ac1 the ALSA drivers (either sb16 or
> > > sbawe) load but don't detect devices if PNP support is built in.  The
> > > same card (an awe64) works fine under 2.4.19.
> > >
> > >     Without PNP sb16 works (with only sb16 features) but sbawe will
> > > not load, complaining that it can't find the awe bits.
> > 
> > My guess would be the new isapnp registration layer, which ALSA
> > doesn't seem to be using. I might have a go at it later, looks like it
> > might need conversion.
> > 
> > Cheers,
> > 	Zwane
> 
> That is indeed the case.  I just released a patch for pnp card support.
> This new API can be used to convert these drivers.
> 
> Thanks,
> Adam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
