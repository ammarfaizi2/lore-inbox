Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278046AbRKAGKq>; Thu, 1 Nov 2001 01:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278042AbRKAGKh>; Thu, 1 Nov 2001 01:10:37 -0500
Received: from mail11.speakeasy.net ([216.254.0.211]:63247 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S278046AbRKAGK0>; Thu, 1 Nov 2001 01:10:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: graphical swap comparison of aa and rik vm
Date: Thu, 1 Nov 2001 01:10:24 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011101031823Z277713-17408+8578@vger.kernel.org>
In-Reply-To: <20011101031823Z277713-17408+8578@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011101061034Z278046-17408+8680@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I decided it would be nice to see the actual swap io as well.   since 
allocating and writing and reading are two different things.  

http://safemode.homeip.net/si-swap.png    (max   24508)
http://safemode.homeip.net/so-swap.png   (max   118132)
http://safemode.homeip.net/bi-swap.png    (max   24536)	

finally, i redid the swap one i have posted before.  This time it has correct 
scaling.  Because of this you'll see a final dropoff of the aa's graph to 0, 
disregard it,  as well as all of the 0 data in the other graphs as they're 
there to keep scale correct.  Everything after 52 seconds in the aa graphs is 
filler.  

http://safemode.homeip.net/swap.png    (max   290740)

All of these are larger than before due to the larger dimensions of the graph 
files.  feel free to mirror them if i end up not being fast enough. 




On Wednesday 31 October 2001 22:18, safemode wrote:
> In an earlier post i mentioned a way of locking up my vm easily and
> repeatedly but that has since been fixed in one way or another.  I reran
> the test and took vmstat 1 's of both runnings on a 2.4.14-pre6-preempt
> kernel and a 2.4.13-ac5-preempt kernel.  I began both vmstat's at the same
> time (about 4 seconds before running each).  What i did was run kghostview
> on a postscript file located here http://safemode.homeip.net/test.ps  .  It
> is 224K.  kmail was loaded previously in both trials so kdeinit was already
> loaded as were all libs.   After kghostview became responsive, i waited a
> few seconds (again about 5) and then exited the app.
>
> No other interaction or running programs were present while doing this.
> I have 771580 KB of ram and 290740 KB of swap.
>
> Now to explain the graphs.
> The blue is AA's vm.  The red is Rik's vm.  Rik's vm finished in 66
> seconds. AA's vm finished in 52 seconds.  Both start at 0 swap usage.  Both
> from clean boots.
>
> Here is the graph   http://safemode.homeip.net/vm_swapcomparison.png   .
> It's about 4.6K.
>
> When you look at the graph it goes like this.
> The left side is 0 seconds, the right side is 66 seconds.  bottom is 0KB,
> top is 290740KB.
>
> These are generated from data from the orignal vmstat outputs.  These are
> at http://safemode.homeip.net/aa_vmstat
> and
> http://safemode.homeip.net/rik_vmstat
>
> I'll leave the actual interpretation of the data of both the graph and raw
> data up to those who actually know the code.
>
> Neadless to say that while running the test on either box, the entire
> computer became unresponsive multiple times for extended lengths of times.
> No OOM was generated on either run.
