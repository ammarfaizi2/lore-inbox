Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264256AbRFHTQb>; Fri, 8 Jun 2001 15:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264303AbRFHTQL>; Fri, 8 Jun 2001 15:16:11 -0400
Received: from zeus.kernel.org ([209.10.41.242]:10683 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S264256AbRFHTQF>;
	Fri, 8 Jun 2001 15:16:05 -0400
Date: Fri, 8 Jun 2001 14:35:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: John Stoffel <stoffel@casc.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Tobias Ringstrom <tori@unhappy.mine.nu>,
        Jonathan Morton <chromi@cyberspace.org>, Shane Nay <shane@minirl.com>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <15137.3796.287765.4809@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.21.0106081426010.2422-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Jun 2001, John Stoffel wrote:

> 
> Mike> OK, riddle me this.  If this test is a crummy test, just how is
> Mike> it that I was able to warn Rik in advance that when 2.4.5 was
> Mike> released, he should expect complaints?  How did I _know_ that?
> Mike> The answer is that I fiddle with Rik's code a lot, and I test
> Mike> with this test because it tells me a lot.  It may not tell you
> Mike> anything, but it does me.
> 
> I never said it was a crummy test, please do not read more into my
> words than was written.  What I was trying to get across is that just
> one test (such as a compile of the kernel) isn't perfect at showing
> where the problems are with the VM sub-system.
> 
> Jonathan Morton has been using another large compile to also test the
> sub-system, and it includes a compile which puts a large, single
> process pressure on the VM.  I consider this to be a more
> representative test of how the VM deals with pressure.  
> 
> The kernel compile is an ok test of basic VM handling, but from what
> I've been hearing on linux-kernel and linux-mm is that the VM goes to
> crap when you have a mix of stuff running, and one (or more) processes
> starts up or grows much larger and starts impacting the system
> performance.
> 
> I'm also not knocking your contributions to this discussion, so stop
> being so touchy.  I was trying to contribute and say (albeit poorly)
> that a *mix* of tests is needed to test the VM.
> 
> More importantly, a *repeatable* set of tests is what is needed to
> test the VM and get consistent results from run to run, so you can see
> how your changes are impacting performance.  The kernel compile
> doesn't really have any one process grow to a large fraction of
> memory, so dropping in a compile which *does* is a good thing.

I agree with you. 

Mike, I'm sure you have noticed that stock kernel gives much better
results than mine or Jonathan's patch.

Now the stock kernel gives us crappy interactivity compared to my patch.
(Note: my patch still does not gives me the interactivity I want under
high VM loads, but I hope to get there soon).

BTW, we are talking with the OSDL (http://www.osdlab.org) guys about a
possibility to setup a test system which would run a different variety of
benchmarks to give us results of different kinds of workloads. If that
ever happens, we'll probably get rid of most of this testing problems.

