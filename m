Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262686AbRFHSco>; Fri, 8 Jun 2001 14:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbRFHSce>; Fri, 8 Jun 2001 14:32:34 -0400
Received: from www.wen-online.de ([212.223.88.39]:58385 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S262686AbRFHScV>;
	Fri, 8 Jun 2001 14:32:21 -0400
Date: Fri, 8 Jun 2001 20:30:32 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: John Stoffel <stoffel@casc.com>
cc: Tobias Ringstrom <tori@unhappy.mine.nu>,
        Jonathan Morton <chromi@cyberspace.org>, Shane Nay <shane@minirl.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <15137.3796.287765.4809@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.33.0106082013500.672-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2001, John Stoffel wrote:

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

Hmm...

Tobias> Could you please explain what is good about this test?  I
Tobias> understand that it will stress the VM, but will it do so in a
Tobias> realistic and relevant way?

I agree, this isn't really a good test case.  I'd rather see what
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
happens when you fire up a gimp session to edit an image which is
*almost* the size of RAM, or even just 50% the size of ram.  Then how
does that affect your other processes that are running at the same
time?

...but anyway, yes it just one test from any number of possibles.

> Jonathan Morton has been using another large compile to also test the
> sub-system, and it includes a compile which puts a large, single
> process pressure on the VM.  I consider this to be a more
> representative test of how the VM deals with pressure.

What does 'more representative' mean given that the VM must react to
every situation it runs into?

> The kernel compile is an ok test of basic VM handling, but from what

Now we're communicating.  I never said it was more than that ;-)

> I've been hearing on linux-kernel and linux-mm is that the VM goes to
> crap when you have a mix of stuff running, and one (or more) processes
> starts up or grows much larger and starts impacting the system
> performance.
>
> I'm also not knocking your contributions to this discussion, so stop
> being so touchy.  I was trying to contribute and say (albeit poorly)
> that a *mix* of tests is needed to test the VM.

Yes, more people need to test. I don't need to do all of those other
tests (no have right toys), more people need to do repeatable tests.

> More importantly, a *repeatable* set of tests is what is needed to
> test the VM and get consistent results from run to run, so you can see
> how your changes are impacting performance.  The kernel compile
> doesn't really have any one process grow to a large fraction of
> memory, so dropping in a compile which *does* is a good thing.

I know I'm only watching basic functionality.  I'm watching basic
functionality with one very consistant test run very consistantly.

	-Mike

