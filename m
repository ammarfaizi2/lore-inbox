Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbRETGmq>; Sun, 20 May 2001 02:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbRETGmg>; Sun, 20 May 2001 02:42:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:21266 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261411AbRETGmY>; Sun, 20 May 2001 02:42:24 -0400
Date: Sun, 20 May 2001 03:42:18 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105200509130.488-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0105200339150.23366-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Mike Galbraith wrote:
> On Sat, 19 May 2001, Rik van Riel wrote:
> > On Sat, 19 May 2001, Mike Galbraith wrote:
> > > On Fri, 18 May 2001, Stephen C. Tweedie wrote:
> > >
> > > > That's the main problem with static parameters.  The problem you are
> > > > trying to solve is fundamentally dynamic in most cases (which is also
> > > > why magic numbers tend to suck in the VM.)
> > >
> > > Magic numbers might be sucking some performance right now ;-)
> >
> > ... so you replace them with some others ... ;)
>
> I reused one of our base numbers to classify the severity of the
> situation.. not the same as inventing new ones.  (well, not quite
> the same anyway.. half did come from the south fourty;)

*nod* ;)

(not that I'm saying this is bad ... it's just that I'd
like to know why things work before looking at applying
them)

> > > (yes, the last hunk looks out of place wrt my text.
> >
> > It also looks kind of bogus and geared completely towards this
> > particular workload ;)
>
> I'm not sure why that helps.  I didn't put it in as a trick or
> anything though.  I put it in because it didn't seem like a
> good idea to ever have more cleaned pages than free pages at a
> time when we're yammering for help.. so I did that and it helped.
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Note that this is not the normal situation. Now think
about the amount of data you'd be blowing away from the
inactive_clean pages after a bit of background aging
has gone on on a lightly loaded system.  Not Good(tm)

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

