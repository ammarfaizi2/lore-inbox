Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSGDEOy>; Thu, 4 Jul 2002 00:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSGDEOx>; Thu, 4 Jul 2002 00:14:53 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53264 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317349AbSGDEOw>; Thu, 4 Jul 2002 00:14:52 -0400
Date: Thu, 4 Jul 2002 00:11:14 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Werner Almesberger <wa@almesberger.net>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
In-Reply-To: <20020702133658.I2295@almesberger.net>
Message-ID: <Pine.LNX.3.96.1020704000434.2248F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002, Werner Almesberger wrote:

> Actually, if module exit synchronizes properly, even the
> return-after-removal case shouldn't exist, because we'd simply
> wait for this call to return.
> 
> Hmm, interesting. Did I just make the whole problem go away,
> or is travel fatigue playing tricks on my brain ? :-)

You redefined it in what might be a useful way...

My question is, if the race condition involves use of a module after it's
removed, is removing it and leaving it in memory going to be better? With
a driver for an unregistered device be more likely do the right thing even
if it's in memory? Isn't the right thing to make everything stop using the
module before ending it, for any definition of ending? Because I certainly
can't define what the right thing to do would be otherwise, at least in
any general sense.

It seems slightly like that tree falling in the forest, and no one to hear
it. Much easier to handle removal right than service requests after close. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

