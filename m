Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbRCBQMb>; Fri, 2 Mar 2001 11:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbRCBQMV>; Fri, 2 Mar 2001 11:12:21 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:20728 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129289AbRCBQMQ>; Fri, 2 Mar 2001 11:12:16 -0500
Date: Fri, 2 Mar 2001 13:12:02 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <97n299$f4l$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0103021307170.19620-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Mar 2001, Linus Torvalds wrote:
> In article <Pine.LNX.4.33.0103011747560.1961-100000@duckman.distro.conectiva>,
> Rik van Riel  <riel@conectiva.com.br> wrote:
> >
> >I haven't tested it yet for a number of reasons. The most
> >important one is that the FreeBSD people have been playing
> >with this thing for a few years now and Matt Dillon has
> >told me the result of their tests ;)
>
> Note that the Linux VM is certainly different enough that I
> doubt the comparisons are all that valid. Especially actual
> virtual memory mapping is basically from another planet
> altogether, and heuristics that are appropriate for *BSD may not
> really translate all that better.

The main difference is that under Linux the size of the
inactive list is dynamic, while under FreeBSD the system
always tries to keep a (very) large inactive list around.

I'm not sure if, or how, this would influence the percentage
of dirty pages on the inactive list or how often we'd need to
flush something to disk as opposed to reclaiming clean pages.

> I'll take numbers over talk any day.  At least Mike had numbers,

The only number I saw when reading over this thread was that
Mike found that under one workload he tested the Linux kernel
ended up doing IO anyway about 2/3rds of the time.

This would also mean we'd be able to _avoid_ IO 1/3rd of the
time ;)

> In short, please don't argue against numbers.

I'm not arguing against his numbers, all I want to know is
if the patch has the same positive effect on other workloads
as well...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

