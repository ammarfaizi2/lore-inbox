Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290669AbSA3WRw>; Wed, 30 Jan 2002 17:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290662AbSA3WPO>; Wed, 30 Jan 2002 17:15:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62481 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290664AbSA3WNw>; Wed, 30 Jan 2002 17:13:52 -0500
Date: Wed, 30 Jan 2002 17:12:27 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Calin A. Culianu" <calin@ajvar.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Steven Hassani <hassani@its.caltech.edu>, linux-kernel@vger.kernel.org
Subject: Re: Athlon Optimization Problem
In-Reply-To: <Pine.LNX.4.30.0201291604340.10200-100000@rtlab.med.cornell.edu>
Message-ID: <Pine.LNX.3.96.1020130170637.5584C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Calin A. Culianu wrote:

> On Mon, 28 Jan 2002, Alan Cox wrote:
> 
> > > Hmm.  What do you recommend?  I remember seeing a spec sheet and register
> > > 0x95 was the memory write queue timer.. but I could have dreamed it..
> > > Anyone know what register 0x95 does?
> >
> > It may well the case. All I know is that for some people at least leaving
> > 0x95 as the bios set it up works and touching it does not - while for
> > the 0x55 case on older chips it all seems to be positive. VIA's own stuff
> > doesn't touch 0x95 - maybe there is a reason
> >
> 
> Really?  VIA's own stuff doesn't touch 0x95?  Hmm.  Well is there ever a
> case where touching 0x95 solved ANYTHING?
> 
> What do you think?  Should I change the patch to not touch 0x95?

If this is the code I recall, we beat this to death ages ago. Some people
can't run without the fix, period, because user code will crash the
system. I have two like that, and while I could run the kernel as an i686
kernel, I can't protect the user code that way.

I haven't seen any case where this makes a system unstable, and I have
several which certainly are not stable without it. If there is really a
set of systems which are actively hurt by this feel free to make it an
optional feature, but let's not go back to the patch again. The code was
put in after much discussion, and I believe there were no documented cases
of a system being hurt by it. I could easily have missed something,
obviously, but "my system doesn't need it" isn't a good reason to pull
code.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

