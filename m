Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129531AbRCEHGy>; Mon, 5 Mar 2001 02:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130655AbRCEHGo>; Mon, 5 Mar 2001 02:06:44 -0500
Received: from www.wen-online.de ([212.223.88.39]:62216 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129531AbRCEHGY>;
	Mon, 5 Mar 2001 02:06:24 -0500
Date: Mon, 5 Mar 2001 08:05:13 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Adrian Bunk <bunk@fs.tum.de>, Rik van Riel <riel@conectiva.com.br>,
        Adam Sampson <azz@gnu.org>, <linux-kernel@vger.kernel.org>
Subject: Re: VM balancing problems under 2.4.2-ac1
In-Reply-To: <20010304182601.D27675@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.33.0103050703290.809-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Mar 2001, Ingo Oeser wrote:

> On Sat, Mar 03, 2001 at 01:03:26AM +0100, Adrian Bunk wrote:
> > > If anybody as a good idea to make this code auto-balancing,
> > > please let me know.
> >
> > I have no idea for auto-balancing but another idea: It's one possibility
> > to let the user choose when doing "make *config" what he wants:
> >
> > - A VM optimized for servers that swaps out applications in favor of
> >   caching.
> > or
> > - A VM optimized for workstations that won't swap out applications in
> >   favor of caching.
>
> I thought about the same thing sometimes (but for other troughput
> vs. latency decisions, too).
>
> But I realized, that my very own workstation is also a server,
> since it runs an httpd, mysqld, smbd, ftpd etc.
>
> And somtimes the servers become very busy in our LAN[1].
>
> IF we want that tuning, we should have it as a sysctl. Most of it
> is already possible with /proc/sys/vm/*, but balancing decisions
> are still missing.

I think sysctls for balancing knobs is a great idea.  The VM has no
clue concerning the cost of rebuilding cache eg but a human may.

Automatic tuning would be wonderful, but it requires information
which the VM flat doesn't have.. so it should ask the boss for help.

Three handy knobs I can think of off the top of my head are swap_size,
flush_size [for page_launder().. bdflush has that] and cache_stickiness.

	-Mike

