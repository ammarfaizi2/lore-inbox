Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSHZTNy>; Mon, 26 Aug 2002 15:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317624AbSHZTNy>; Mon, 26 Aug 2002 15:13:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:30336 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317622AbSHZTNx>; Mon, 26 Aug 2002 15:13:53 -0400
Date: Mon, 26 Aug 2002 15:18:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Pavel Machek <pavel@elf.ucw.cz>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
In-Reply-To: <159220000.1030387536@flay>
Message-ID: <Pine.LNX.3.95.1020826151445.6296A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2002, Martin J. Bligh wrote:

> >> And following your argument that these apps have been silenty broken
> >> since 1999, if there's no broken app out there, nobody will ever get the
> >> instruction fault. If there's any app broken out there we probably like
> > 
> > No. rdtsc is still usefull if you are clever and statistically filter
> > out. Also rdtsc provides you number of cycles, so if you want to know
> > how many cycles mov %eax,%ebx takes, you can do that even on
> > speedstep. Anything that correlates rdtsc to real time is broken, however.
> 
> It's not correlating it to real time that's the problem. It's getting resceduled
> inbetween calls that hurts. Take your example.
> 
> rdtsc
> mov %eax,%ebx
> 			<- get rescheduled here
> rdtsc
> 
> Broken. May even take negative "time".
> 
> M.

The CPU counters are synchronized on SMP machines. How can you
ever get negative time? Even GHz machines take several months
to wrap the count.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

