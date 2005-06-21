Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVFUPQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVFUPQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVFUPOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:14:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:10412 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262100AbVFUPNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:13:32 -0400
Date: Tue, 21 Jun 2005 17:13:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
In-Reply-To: <42B7D304.25920.5055F4E@rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.61.0506211708530.3728@scrub.home>
References: <1119287354.9947.22.camel@cog.beaverton.ibm.com>
 <42B7D304.25920.5055F4E@rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 21 Jun 2005, Ulrich Windl wrote:

> > You don't really answer the core question, why do you change everything to 
> > nanoseconds and 64bit values?
> 
> Because just multiplying the microseconds by one thousand doesn't really provide a 
> nanosecond clock, maybe?

What are you trying to tell me?

> > With -mm you can now choose the HZ value, so that's not really the 
> > problem anymore. A lot of archs even never changed to a higher HZ value. 
> 
> Did you ever do an analysis how this affected clock quality? See 
> comp.protocols.time.ntp for all the complains about broken kernels (I think Redhat 
> had it first, then the others followed).

So how exactly does this patch fix this?

> > So now I still like to know how does the complexity change compared to the 
> > old code?
> 
> You can have a look at the code. That's the point where you can decide about 
> complexity. I haven't looked closely, but I guess it was O(1) before, and now also 
> is O(1).

You guess or you know?

> > As m68k maintainer I see no reason to ever switch to your new code, which 
> > might leave you with the dilemma having to maintain two versions of the 
> > timer code. What reason could I have to switch to the new timer code?
> 
> I never knew the 68k has such a poor performance.

Usually it's code that either is efficient or performs badly.

bye, Roman
