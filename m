Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278125AbRKAGlr>; Thu, 1 Nov 2001 01:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278133AbRKAGlh>; Thu, 1 Nov 2001 01:41:37 -0500
Received: from mail12.speakeasy.net ([216.254.0.212]:4112 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S278125AbRKAGld>; Thu, 1 Nov 2001 01:41:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: graphical swap comparison of aa and rik vm
Date: Thu, 1 Nov 2001 01:41:31 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10111010056100.31484-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10111010056100.31484-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011101064134Z278125-17408+8714@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 November 2001 01:23, Mark Hahn wrote:
> > Here is the graph   http://safemode.homeip.net/vm_swapcomparison.png   .
> > It's
>
> here's my munge of the same data:
> 	http://mhahn.mcmaster.ca/~hahn/foo.png
> the measures I find interesting are the SI/SO rates.  first, the most
> obvious feature is that Rik-VM has a serious problem knowing when to *stop*
> swapping out.  but SO isn't a bad thing unless it's obsessive: it's when
> you see high *swap-in* that you know the VM has previously chosen bad pages
> to SO. and this is the second big difference: Rik-VM doesn't make nearly as
> many mistakes - especially look at Andrea-VM thrashing out-in-out at ~
> samples 26-32.
>
> also, if you merely sum the SI and SO columns for each:
> 		sum(SI)		sum(SO)		sum(SI+SO)
>       Rik-VM	43564		317448		290032
>       AA-VM	118284		171748		361012
> to me, this looks like the same point: Rik being SO-happy,
> Andrea having to SI a lot more.  interesting also that Andrea wins the
> race, in spite of poorer SO choices and more swap traffic overall.
>
> > Neadless to say that while running the test on either box, the entire
> > computer became unresponsive multiple times for extended lengths of
> > times.
>
> yes, unfortunately this corrupts the value of the data, since the
> timecourses are not really comparable, and samples are only vaguely related
> to time...

If you miss anything you miss the plateu data that would be found  when the 
IO peaks.  But i doubt much at all was really lost in this case.  
> regards, mark hahn.

Actually i found that most if not all of the vmstat's that weren't being 
displayed were displayed immediately after the "locks", ie. I got flooded 
with vmstats upon the computer becoming responsive again.   
Of course I should have been timing each run with a stopwatch, but that never 
crossed my mind that the vmstat would be lost.   In other words i thought of 
it as analogous to having burst-lag on irc.  Guess that's for tomorrow after 
work.  
