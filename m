Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287631AbSAHRpB>; Tue, 8 Jan 2002 12:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287953AbSAHRov>; Tue, 8 Jan 2002 12:44:51 -0500
Received: from Expansa.sns.it ([192.167.206.189]:62982 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S287631AbSAHRop>;
	Tue, 8 Jan 2002 12:44:45 -0500
Date: Tue, 8 Jan 2002 18:41:14 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Andrea Arcangeli <andrea@suse.de>
cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108142117.F3221@inspiron.school.suse.de>
Message-ID: <Pine.LNX.4.33.0201081833260.31474-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jan 2002, Andrea Arcangeli wrote:

> On Tue, Jan 08, 2002 at 11:55:59AM +0100, Luigi Genoni wrote:
> >
> >
> > On Tue, 8 Jan 2002, Dieter [iso-8859-15] Nützel wrote (passim):
> >
> > > Is it possible to decide, now what should go into 2.4.18 (maybe -pre3) -aa or
> > > -rmap?
> > [...]
> > > Maybe preemption? It is disengageable so nobody should be harmed but we get
> > > the chance for wider testing.
> > >
> > > Any comments?
> > preemption?? this is eventually 2.5 stuff, and should not be integrated
>
> indeed ("eventually" in the italian sense btw, obvious to me, but not
> for l-k).
>
> I'm not against preemption (I can see the benefits about the mean
> latency for real time DSP) but the claims about preemption making the
> kernel faster doesn't make sense to me. more frequent scheduling,
> overhead of branches in the locks (you've to conditional_schedule after
> the last preemption lock is released and the cachelines for the per-cpu
> preemption locks) and the other preemption stuff can only make the
> kernel slower.  Furthmore for multimedia playback any sane kernel out
> there with lowlatency fixes applied will work as well as a preemption
> kernel that pays for all the preemption overhead.
I would add that preemption simply gives a felling of more speed with
interactive usage (with one single user on the system), and also has some
advantages for dedicated servers, but except of those conditions it never
showed in my experience to be a real and decisive advantage.
Of course we are supposing that the preemptive scheduler is very well
done, because otherway (bad working scheduler) there is nothing worse than
preemption.
>
> About the other claim that as the kernel becomes more granular
> performance will increase with preemption in kernel, that's obviously
> wrong as well, it's clearly the other way around. Maybe it was meant
> "latency will decrease further", that's right, but also performance will
> decrease if something.
>
> So yes, mean latency will decrease with preemptive kernel, but your CPU
> is definitely paying something for it.
agreed. Obviously this choice depends on what you want to do with your
system. If you have more than a couple of interactive users (and here I
have also 50 interactive users at the same time on every single system),
preemption is not what you want, period. If you have a desktop system,
well, it is a different situation.
>
> > into 2.4 stable tree. Of course a backport is possible, when/if it will be
> > quite well tested and well working on 2.5
> >
> Andrea


Luigi

