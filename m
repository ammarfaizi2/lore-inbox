Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264217AbRFIMio>; Sat, 9 Jun 2001 08:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264470AbRFIMie>; Sat, 9 Jun 2001 08:38:34 -0400
Received: from inje.iskon.hr ([213.191.128.16]:17558 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S264217AbRFIMiZ>;
	Sat, 9 Jun 2001 08:38:25 -0400
To: Mike Galbraith <mikeg@wen-online.de>
Cc: John Stoffel <stoffel@casc.com>, Tobias Ringstrom <tori@unhappy.mine.nu>,
        Jonathan Morton <chromi@cyberspace.org>, Shane Nay <shane@minirl.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106082013500.672-100000@mikeg.weiden.de>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 09 Jun 2001 14:31:49 +0200
In-Reply-To: <Pine.LNX.4.33.0106082013500.672-100000@mikeg.weiden.de> (Mike Galbraith's message of "Fri, 8 Jun 2001 20:30:32 +0200 (CEST)")
Message-ID: <87u21p3kcq.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mike Galbraith <mikeg@wen-online.de> writes:

> On Fri, 8 Jun 2001, John Stoffel wrote:
> 
> > Mike> OK, riddle me this.  If this test is a crummy test, just how is
> > Mike> it that I was able to warn Rik in advance that when 2.4.5 was
> > Mike> released, he should expect complaints?  How did I _know_ that?
> > Mike> The answer is that I fiddle with Rik's code a lot, and I test
> > Mike> with this test because it tells me a lot.  It may not tell you
> > Mike> anything, but it does me.
> >
> > I never said it was a crummy test, please do not read more into my
> > words than was written.  What I was trying to get across is that just
> > one test (such as a compile of the kernel) isn't perfect at showing
> > where the problems are with the VM sub-system.
> 
> Hmm...
> 
> Tobias> Could you please explain what is good about this test?  I
> Tobias> understand that it will stress the VM, but will it do so in a
> Tobias> realistic and relevant way?
> 
> I agree, this isn't really a good test case.  I'd rather see what
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> happens when you fire up a gimp session to edit an image which is
> *almost* the size of RAM, or even just 50% the size of ram.  Then how
> does that affect your other processes that are running at the same
> time?
> 
> ...but anyway, yes it just one test from any number of possibles.

One great test that I'm using regularly to see what's goin' on, is at
http://lxr.linux.no/. It is a cool utility to cross reference your
Linux kernel source tree, and in the mean time eat gobs of memory, do
lots of I/O, and burn many CPU cycles (all at the same time). Ideal
test, if you ask me and if anybody has the time, it would be nice to
see different timing numbers when run on different kernels. Just make
sure you run it on the same kernel tree to make reproducable results.
It has three passes, and the third one is the most interesting one
(use vmstat 1 to see why). When run with 64MB RAM configuration, it
would swap heavily, with 128MB somewhat, and at 192MB maybe not
(depending on the other applications running at the same time).

Try it, it is a nice utility, and a great test. :)
-- 
Zlatko
