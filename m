Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318468AbSHURab>; Wed, 21 Aug 2002 13:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318500AbSHURab>; Wed, 21 Aug 2002 13:30:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:2544 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318468AbSHURaa>; Wed, 21 Aug 2002 13:30:30 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
In-Reply-To: <20020821171725.GJ1117@dualathlon.random>
References: <1028860246.1117.34.camel@cog>
	<20020815165617.GE14394@dualathlon.random>
	<1029496559.31487.48.camel@irongate.swansea.linux.org.uk>
	<15708.64483.439939.850493@kim.it.uu.se>
	<20020821131223.GB1117@dualathlon.random>
	<1029939024.26425.49.camel@irongate.swansea.linux.org.uk>
	<20020821143323.GF1117@dualathlon.random>
	<1029942115.26411.81.camel@irongate.swansea.linux.org.uk>
	<20020821161317.GI1117@dualathlon.random>
	<1029947135.26845.98.camel@irongate.swansea.linux.org.uk> 
	<20020821171725.GJ1117@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 18:34:17 +0100
Message-Id: <1029951257.26411.112.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 18:17, Andrea Arcangeli wrote:
> > Fixed in the -ac tree for the non APM triggered case because we use
> > cpufreq code
> 
> if the reduced loops is supposed to work fine what was there left to fix?

Support for doing it right in case someone finds a marginal component
where it doesnt. Incidentally the APM case is it appears fixable.

> > And you can test that with notsc. Oh and you might also want the code
> > that makes notsc on a tsc only kernel print a warning btw. badtsc lets
> > you say "I have a brain cell" notsc lets you select "clueless app
> > checking mode"
> 
> what's wrong with a sysctl to specify you have a brain cell? I'm not
> advocating not to let you specify you have a brain cell, I'm only don't
> see why we should assume it when we very know apps will break silenty,
> and that it will be not noticeable except with subtle breakage after
> some runtime in -ac.

The default behaviours are unchanged. badtsc is simply an extra mode. If
anything the new tree is far better because "notsc" on a 686 kernel
actually warns people it is being ignored. Thats the important bit.
Badtsc is just a handy thing.

