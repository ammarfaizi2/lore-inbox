Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318541AbSHURMA>; Wed, 21 Aug 2002 13:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318542AbSHURMA>; Wed, 21 Aug 2002 13:12:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18781 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318541AbSHURL7>; Wed, 21 Aug 2002 13:11:59 -0400
Date: Wed, 21 Aug 2002 19:17:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
Message-ID: <20020821171725.GJ1117@dualathlon.random>
References: <1028860246.1117.34.camel@cog> <20020815165617.GE14394@dualathlon.random> <1029496559.31487.48.camel@irongate.swansea.linux.org.uk> <15708.64483.439939.850493@kim.it.uu.se> <20020821131223.GB1117@dualathlon.random> <1029939024.26425.49.camel@irongate.swansea.linux.org.uk> <20020821143323.GF1117@dualathlon.random> <1029942115.26411.81.camel@irongate.swansea.linux.org.uk> <20020821161317.GI1117@dualathlon.random> <1029947135.26845.98.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029947135.26845.98.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 05:25:35PM +0100, Alan Cox wrote:
> > certainly fair enough argument in theory, but in practice you're not
> > going to risk running those apps in a laptop or in general with any
> > power management that will decrease the frequency of the cpu anytime.
> 
> Any PIII with speedstep, any Athlon and PIV.
> 
> > Furthmore the speedstep right now today can crash any laptop that boots
> > at reduced mhz and that switches to higher mhz at runtime, that change
> 
> Actually the reduced loops in the kernel seem to work fine
> 
> > of the tsc frequency simply make udelay run faster, and it'll break
> > drivers easily. I suspect there's even an unfixable race condition in
> > the speedstep hardware since it's not the kernel asking for the change
> 
> Fixed in the -ac tree for the non APM triggered case because we use
> cpufreq code

if the reduced loops is supposed to work fine what was there left to fix?

> 
> > significant info via the tsc to userspace, and there's no way to know
> > that your app isn't breaking because of numa, unless you disable the tsc
> > to userspace.
> 
> And you can test that with notsc. Oh and you might also want the code
> that makes notsc on a tsc only kernel print a warning btw. badtsc lets
> you say "I have a brain cell" notsc lets you select "clueless app
> checking mode"

what's wrong with a sysctl to specify you have a brain cell? I'm not
advocating not to let you specify you have a brain cell, I'm only don't
see why we should assume it when we very know apps will break silenty,
and that it will be not noticeable except with subtle breakage after
some runtime in -ac.

Andrea
