Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318190AbSHZSIN>; Mon, 26 Aug 2002 14:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSHZSIM>; Mon, 26 Aug 2002 14:08:12 -0400
Received: from [195.39.17.254] ([195.39.17.254]:23168 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318190AbSHZSIA>;
	Mon, 26 Aug 2002 14:08:00 -0400
Date: Mon, 26 Aug 2002 18:10:34 +0200
From: Pavel Machek <pavel@elf.ucw.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@csd.uu.se>,
       john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
Message-ID: <20020826161031.GA479@elf.ucw.cz>
References: <1028812663.28883.32.camel@irongate.swansea.linux.org.uk> <1028860246.1117.34.camel@cog> <20020815165617.GE14394@dualathlon.random> <1029496559.31487.48.camel@irongate.swansea.linux.org.uk> <15708.64483.439939.850493@kim.it.uu.se> <20020821131223.GB1117@dualathlon.random> <1029939024.26425.49.camel@irongate.swansea.linux.org.uk> <20020821143323.GF1117@dualathlon.random> <1029942115.26411.81.camel@irongate.swansea.linux.org.uk> <20020821161317.GI1117@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020821161317.GI1117@dualathlon.random>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > But silenty breaking apps and not allowing in any way to apps to learn
> > > if the tsc is returning random or if it's returning something
> > > significant (I understand that's the way you did it in -ac) is a no-way
> > > by default IMHO.
> > 
> > All such apps and libraries are already broken have been silently broken
> > since about 1999 and will continue to be broken. Thats been true since
> > speedstep cpus appeared if not before.
> 
> certainly fair enough argument in theory, but in practice you're not
> going to risk running those apps in a laptop or in general with any

So those apps are broken. They don't work on pretty common hardware.

NUMA-Q is just another kind of hardware where broken applications
break. What's the problem?

> And following your argument that these apps have been silenty broken
> since 1999, if there's no broken app out there, nobody will ever get the
> instruction fault. If there's any app broken out there we probably like

No. rdtsc is still usefull if you are clever and statistically filter
out. Also rdtsc provides you number of cycles, so if you want to know
how many cycles mov %eax,%ebx takes, you can do that even on
speedstep. Anything that correlates rdtsc to real time is broken, however.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
