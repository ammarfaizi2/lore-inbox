Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318758AbSHLRba>; Mon, 12 Aug 2002 13:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318765AbSHLRak>; Mon, 12 Aug 2002 13:30:40 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:4075 "HELO
	wind.cocodriloo.com") by vger.kernel.org with SMTP
	id <S318758AbSHLR3Y>; Mon, 12 Aug 2002 13:29:24 -0400
Date: Sat, 10 Aug 2002 21:39:11 +0200
From: wind@cocodriloo.com
To: linux-kernel@vger.kernel.org
Subject: [wind@cocodriloo.com: Re: GCC still keeps empty loops?  (was: [patch 4/21] fix ARCH_HAS_PREFETCH)]
Message-ID: <20020810193911.GB8486@wind.holaquehay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from wind@cocodriloo.com -----

Date: Sat, 10 Aug 2002 20:43:13 +0200
From: wind@cocodriloo.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: GCC still keeps empty loops?  (was: [patch 4/21] fix ARCH_HAS_PREFETCH)
Message-ID: <20020810184313.GA8486@wind.holaquehay.com>
References: <3D56B13A.D3F741D1@zip.com.au> <Pine.LNX.4.44.0208111203520.9930-100000@home.transmeta.com> <20020811210718.B3206@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020811210718.B3206@kushida.apsleyroad.org>
User-Agent: Mutt/1.3.28i
Status: RO

On Sun, Aug 11, 2002 at 09:07:18PM +0100, Jamie Lokier wrote:
> Linus Torvalds wrote:
> > I thought that special case was removed long ago, because it is untenable 
> > in C++ etc (where such empty loops happen due to various abstraction 
> > issues, and not optimizing them away is just silly).
> > 
> > But testing shows that you're right at least for 2.95 and 2.96. Argh
> 
> Unbelievably, 3.1 doesn't remove empty loops either.
> I think there's a case for a compiler flag, `-fremove-empty-loops'.
> 
> Empty loop delays aren't portable acrosss compilers in general.  If you
> _really_ want an empty loop that must always work with GCC, it's easy
> enough to write:
> 
> 	for (i = 0; i < 100000; i++)
> 		__asm__ __volatile__ ("");
> 

Of course this delay-loop code will delay a diff. amount of time
depending on processor speed. Don't we have the bogomips stuff
exactly for this sort of small wait times?

What about using internal time-counters from various processors (think
RTDSC on i586+ and it's equivalent on PowerPC, for a start...)

I can still the shakeout when most code which assumed 7mhz 68000
processors for timming got to run on 14mhz 68020 with caches
on the amiga world... your floppies would change tracks a little
bit too fast :)

-- 
es verano y hace calor, el resto de implicaciones son triviales.

::: Antonio Vargas :::

----- End forwarded message -----

-- 
es verano y hace calor, el resto de implicaciones son triviales.

::: winden/network :::
