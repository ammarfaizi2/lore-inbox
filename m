Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318752AbSHBIVP>; Fri, 2 Aug 2002 04:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318754AbSHBIVP>; Fri, 2 Aug 2002 04:21:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37391 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S318752AbSHBIVO>; Fri, 2 Aug 2002 04:21:14 -0400
Date: Fri, 2 Aug 2002 10:24:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Pavel Machek <pavel@elf.ucw.cz>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)
Message-ID: <20020802082443.GB12868@atrey.karlin.mff.cuni.cz>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > For a lot of applications like multimedia you actually want a counting
> > of time not any relation to real time except that you can tell how many
> > ticks elapse a second.
> 
> Absolutely. I think "jiffies64" is fine (as long as is it converted to
> some "standard" time-measure like microseconds or nanoseconds so that
> people don't have to care about internal kernel state) per se.
> 
> The only thing that I think makes it less than wonderful is really the
> fact that we cannot give an accurate measure for it. We can _say_ that
> what we count in microseconds, but it might turn out that instead of the
> perfect 1000000 ticks a second ther would really be 983671 ticks.
> 
> A 2% error may not be a big problem for most people, of course. But it
> might be a huge problem for others. Those people would have to do their
> own re-calibration..

I don't think so.

Imagine DVD playback. If you have 2% error, your audio is going to get
1 second off each minute. It is going to be off by one minute at the
end of hour. 2% is probably not acceptable.

[I'm not sure how exactly video/audio synchronization works, besides
fact it does not; but 2% could be huge problem for something like
that.]
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
