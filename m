Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318300AbSHZTiL>; Mon, 26 Aug 2002 15:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318302AbSHZTiL>; Mon, 26 Aug 2002 15:38:11 -0400
Received: from jabberwock.ucw.cz ([212.71.128.53]:12807 "HELO
	jabberwock.ucw.cz") by vger.kernel.org with SMTP id <S318300AbSHZTiK>;
	Mon, 26 Aug 2002 15:38:10 -0400
Date: Mon, 26 Aug 2002 21:42:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Pavel Machek <pavel@elf.ucw.cz>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
Message-ID: <20020826214226.L24056@ucw.cz>
References: <159220000.1030387536@flay> <Pine.LNX.3.95.1020826151445.6296A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1020826151445.6296A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Mon, Aug 26, 2002 at 03:18:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > >> And following your argument that these apps have been silenty broken
> > >> since 1999, if there's no broken app out there, nobody will ever get the
> > >> instruction fault. If there's any app broken out there we probably like
> > > 
> > > No. rdtsc is still usefull if you are clever and statistically filter
> > > out. Also rdtsc provides you number of cycles, so if you want to know
> > > how many cycles mov %eax,%ebx takes, you can do that even on
> > > speedstep. Anything that correlates rdtsc to real time is broken, however.
> > 
> > It's not correlating it to real time that's the problem. It's getting resceduled
> > inbetween calls that hurts. Take your example.
> > 
> > rdtsc
> > mov %eax,%ebx
> > 			<- get rescheduled here
> > rdtsc
> > 
> > Broken. May even take negative "time".
> > 
> > M.
> 
> The CPU counters are synchronized on SMP machines. How can you
> ever get negative time? Even GHz machines take several months
> to wrap the count.

This thread was about numa machines that do not keep tsc synchronized.
