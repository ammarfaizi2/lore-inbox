Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264284AbRFHRqK>; Fri, 8 Jun 2001 13:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264287AbRFHRqA>; Fri, 8 Jun 2001 13:46:00 -0400
Received: from alpo.casc.com ([152.148.10.6]:38788 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S264284AbRFHRpt>;
	Fri, 8 Jun 2001 13:45:49 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15137.3796.287765.4809@gargle.gargle.HOWL>
Date: Fri, 8 Jun 2001 13:43:48 -0400
To: Mike Galbraith <mikeg@wen-online.de>
Cc: John Stoffel <stoffel@casc.com>, Tobias Ringstrom <tori@unhappy.mine.nu>,
        Jonathan Morton <chromi@cyberspace.org>, Shane Nay <shane@minirl.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106081853400.418-100000@mikeg.weiden.de>
In-Reply-To: <15136.62579.588726.954053@gargle.gargle.HOWL>
	<Pine.LNX.4.33.0106081853400.418-100000@mikeg.weiden.de>
X-Mailer: VM 6.92 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mike> OK, riddle me this.  If this test is a crummy test, just how is
Mike> it that I was able to warn Rik in advance that when 2.4.5 was
Mike> released, he should expect complaints?  How did I _know_ that?
Mike> The answer is that I fiddle with Rik's code a lot, and I test
Mike> with this test because it tells me a lot.  It may not tell you
Mike> anything, but it does me.

I never said it was a crummy test, please do not read more into my
words than was written.  What I was trying to get across is that just
one test (such as a compile of the kernel) isn't perfect at showing
where the problems are with the VM sub-system.

Jonathan Morton has been using another large compile to also test the
sub-system, and it includes a compile which puts a large, single
process pressure on the VM.  I consider this to be a more
representative test of how the VM deals with pressure.  

The kernel compile is an ok test of basic VM handling, but from what
I've been hearing on linux-kernel and linux-mm is that the VM goes to
crap when you have a mix of stuff running, and one (or more) processes
starts up or grows much larger and starts impacting the system
performance.

I'm also not knocking your contributions to this discussion, so stop
being so touchy.  I was trying to contribute and say (albeit poorly)
that a *mix* of tests is needed to test the VM.

More importantly, a *repeatable* set of tests is what is needed to
test the VM and get consistent results from run to run, so you can see
how your changes are impacting performance.  The kernel compile
doesn't really have any one process grow to a large fraction of
memory, so dropping in a compile which *does* is a good thing.

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548

