Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267271AbTBQSZu>; Mon, 17 Feb 2003 13:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTBQSZu>; Mon, 17 Feb 2003 13:25:50 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18707 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267271AbTBQSZt>; Mon, 17 Feb 2003 13:25:49 -0500
Date: Mon, 17 Feb 2003 13:32:21 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Thomas Schlichter <schlicht@rumms.uni-mannheim.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.60-mm2
In-Reply-To: <1045485310.3e50d6fe94f1e@rumms.uni-mannheim.de>
Message-ID: <Pine.LNX.3.96.1030217132545.32676A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Thomas Schlichter wrote:

> Quoting Bill Davidsen <davidsen@tmr.com>:

> > > I was looking for network issues when I started timing pings, and didn't
> > > see any. I thought it was bad timing, like not raining when you have a
> > > coat, but maybe I was curing it.
> > 
> > Since it's possible that pings will actually change the problem rather
> > than measure it, I'll tcpdump for a while and see if that tells me
> > anything. I suspected network problems, since tcp has priority over udp in
> > some places.
> > 
> > I looked at the code last night, but I don't see anything explaining a
> > ping making things better. Something getting flushed?
> 
> I'm sorry, I don't exactly know what you want me to do... I'm not involved in
> the linux net code and I did not even try to understand it yet...

Thanks, you've already done it! I assumed that when I didn't see any
problems while the ping was running that it was just bad timing, and the
problem didn't happen while I was looking. Your note that the pinging
actually prevents the problem gives me something new to investigate.

> I just have a small environment with a FreeBSD 4.6 box using my Linux box as a
> NFS file server. This worked fine with my 2.4 kernel but with the 2.5.x test
> kernels I've got the problem the FreeBSD box says 'NFS server not responding'
> until I do simple pings (ICMP echo request, ICMP echo respond) to the linux box
> (the NFS server)...
> 
> Letting the ping run all the time NFS works so stable I even can do lots of
> compilations over it without any problems.
> 
> So I don't have any answer WHY this helps, but it does... Perhaps it really is
> just a timing issue, I just don't know... If you can tell me what to measure and
> which values would be interesting I'll do these tests and send you the
> results...

I someone can suggest "what to do" I'll do it as well. At the moment I'm
building a table of 2.5.59 client against 2.4.19, AIX, BSD, etc, and vice
versa. I am looking for hangs with and without the ping running, in hopes
that the results will be useful, possibly to me but more likely to someone
who can see what's happening.

For the record, I see severe hangs with 2.4.19 server and 2.5.59 client,
I'll know what effect the ping has in a few minutes.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

