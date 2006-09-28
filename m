Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWI1VEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWI1VEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWI1VEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:04:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:20667 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750897AbWI1VEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:04:46 -0400
Date: Thu, 28 Sep 2006 23:01:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] exponential update_wall_time
In-Reply-To: <1159403333.7297.24.camel@localhost>
Message-ID: <Pine.LNX.4.64.0609282254450.6761@scrub.home>
References: <1159385734.29040.9.camel@localhost>  <Pine.LNX.4.64.0609280031550.6761@scrub.home>
  <1159398793.7297.9.camel@localhost>  <Pine.LNX.4.64.0609280128330.6761@scrub.home>
 <1159403333.7297.24.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Sep 2006, john stultz wrote:

> > You have to keep in mind that ntp time is basically advanced in 1 second 
> > steps (or HZ ticks or freq cycles to be precise) and you have to keep that 
> > property. You can slice that second however you like, but it still has to 
> > add up to 1 second. Right now we slice it into HZ steps, but this can be 
> > rather easily changed now.
> 
> Right off, it seems it would then make sense to make the ntp "ticks" one
> second in length. And set the interval values accordingly.
> 
> However, there might be clocksources that are incapable of running
> freely for a full second w/o overflowing. In that case we would need to
> set the interval values and the ntp tick length accordingly. It seems we
> need some sort of interface to ntp to define that base tick length.
> Would that be ok by you?

I don't see how you want to do this without some rather complex 
calculations. I doubt this will make anything easier.

bye, Roman
