Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318923AbSHMD3p>; Mon, 12 Aug 2002 23:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318924AbSHMD3p>; Mon, 12 Aug 2002 23:29:45 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:58382 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318923AbSHMD3n>; Mon, 12 Aug 2002 23:29:43 -0400
Date: Tue, 13 Aug 2002 00:31:42 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <Pine.LNX.3.96.1020812230127.7583D-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44L.0208130026420.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Bill Davidsen wrote:

> Now tell us how someone who isn't a VM developer can tell if that's bad
> or good. Is it good because it didn't swap more than it needed to, or
> bad because there were more things it could have swapped to make more
> buffer room?

Good point, just looking at the swap usage doesn't mean
much because we're interested in the _consequences_ of
that number and not in the number itself.

> Serious question, tuning the -aa VM sometimes makes the swap use higher,
> even as the response to starting small jobs while doing kernel compiles
> or mkisofs gets better. I don't normally tune -ac kernels much, so I
> can't comment there.

The key word here is "response", benchmarks really need
to be able to measure responsiveness.

Some benchmarks (eg. irman by Bob Matthews) do this
already, but we're still focussing too much on throughput.


In 1990 Margo Selzer wrote an excellent paper on disk IO
sorting and its effects on throughput and latency.  The
end result was that in order to get decent throughput by
doing just disk IO sorting you would need queues so deep
that IO latency would grow to about 30 seconds. ;)

Of course, if databases or online shops would increase
their throughput by going to deep queueing and every
request would get 30 second latencies ... they would
immediately lose their users (or customers) !!!

I'm pretty convinced that sysadmins aren't interested
in throughput, at least not until throughput is so low
that it starts affecting system response latency.


regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

