Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267212AbSK3EBq>; Fri, 29 Nov 2002 23:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbSK3EBq>; Fri, 29 Nov 2002 23:01:46 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:52049
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267212AbSK3EBp>; Fri, 29 Nov 2002 23:01:45 -0500
Date: Fri, 29 Nov 2002 23:12:17 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: Javier Marcet <jmarcet@pobox.com>, Rik van Riel <riel@conectiva.com.br>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: Exaggerated swap usage
In-Reply-To: <3DE82A4C.B8332D8E@digeo.com>
Message-ID: <Pine.LNX.4.50.0211292306000.2495-100000@montezuma.mastecende.com>
References: <20021130013832.GF15682@jerry.marcet.dyndns.org>
 <Pine.LNX.4.50.0211292103200.26051-100000@montezuma.mastecende.com>
 <3DE82A4C.B8332D8E@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Nov 2002, Andrew Morton wrote:

> Zwane Mwaikambo wrote:
> >
> > Hmm i'm using 2.4.19-rmap15
>
> Don't think so.

hmm

> > Inactive:       194068 kB
> > HighTotal:           0 kB
> > HighFree:            0 kB
> > LowTotal:       513020 kB
> > LowFree:          2308 kB
> > SwapTotal:     2104432 kB
> > SwapFree:      1251256 kB
>
> That's stock 2.4 meminfo output.

Looks like the little patch monkey (namely me) which puts my kernels
together forgot to apply a patch. You know you need a break when you don't
even know which kernel you're running! All rather embarassing.

> -               "Inactive:     %8u kB\n"
> +               "Inact_dirty:  %8u kB\n"
> +               "Inact_laundry:%8u kB\n"
> +               "Inact_clean:  %8u kB\n"
> +               "Inact_target: %8lu kB\n"
>
>
> You're using an extraordinary amount of swap.  Is something leaking?

I wouldn't think so, some vmware sessions with 128M RAM which seems to
really use a lot of shmem(?)

nodev                 1.0G  361M  663M  36% /tmp

9.2M    /tmp
9.2M    total

Then there is all the other crap running.

Cheers,
	Zwane (Who is officially taking an extended break)

-- 
function.linuxpower.ca
