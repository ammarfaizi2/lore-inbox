Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVIMXPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVIMXPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVIMXPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:15:06 -0400
Received: from iabervon.org ([66.92.72.58]:27660 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751077AbVIMXPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:15:04 -0400
Date: Tue, 13 Sep 2005 19:19:11 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Mark Hounschell <markh@compro.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: HZ question
In-Reply-To: <432725E3.70304@compro.net>
Message-ID: <Pine.LNX.4.63.0509131855570.23242@iabervon.org>
References: <4326CAB3.6020109@compro.net> <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com>
 <4326DB8A.7040109@compro.net> <Pine.LNX.4.53.0509131615160.13574@gockel.physik3.uni-rostock.de>
 <4326EAD7.50004@compro.net> <Pine.LNX.4.53.0509131750580.15000@gockel.physik3.uni-rostock.de>
 <43270294.9010509@compro.net> <43271CA3.7050706@stesmi.com> <432725E3.70304@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, Mark Hounschell wrote:

> Stefan Smietanowski wrote:
> > Mark Hounschell wrote:
> > > >Tim Schmielau wrote:
> > > >
> > > > >Do you also want to know about CONFIG_PREEMPT, SMP, current load,
> > > > >future
> > > > >load in order to estimate the delay you want to ask for?
> > > >
> > > >Are not CONFIG_PREEMPT, SMP, and current load, all determinable from
> > > >userland anyway? Why not HZ?
> > 
> > And with dynamic HZ?
> > 
> > Do you want
> > a) The HZ that was used when we booted
> > b) The HZ that is currently used (say 22, but could be 573 in 0.1s)
> > c) The MIN HZ (if there is such a thing and it is configured)
> >    that the kernel will use.
> > d) The MAX HZ (same) that the kernel will use.
> > 
> > Or do you want USER_HZ?
> > 
> > Or are you after something else entirely.
> > 
> > // Stefan
> 
> If dynamic HZ means dynamic timer resolutions I don't want it at all.
> 
> I guess the 'terms' John just used, ie timer resolutions, as opposed to
> HZ was maybe what I really should have asked for to begin with.
> 
> However since they are both bascially the same or at least one derived
> from the other......?

There's nothing to say that the kernel couldn't have hardware programmed 
to give an interrupt and schedule your process at some point that wouldn't 
normally be a scheduler tick. So the HRT interface could give you better 
than HZ. Also, there's the possibility that the kernel could slack off on 
HZ when you're not using HRT, and then there are patches for "tickless", 
where it just programs the timer for the next time something is scheduled 
to happen, and there's no fixed rate outside of actual activity.

	-Daniel
*This .sig left intentionally blank*
