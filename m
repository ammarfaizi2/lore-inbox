Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318707AbSHLQc1>; Mon, 12 Aug 2002 12:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318737AbSHLQc1>; Mon, 12 Aug 2002 12:32:27 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:40204 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S318707AbSHLQc0>;
	Mon, 12 Aug 2002 12:32:26 -0400
Date: Mon, 12 Aug 2002 17:36:09 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@arcor.de>,
       Bernd Eckenfels <ecki-news2002-08@lina.inka.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] VM Regress - A VM regression and test tool
In-Reply-To: <Pine.LNX.4.44L.0208121310180.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0208121715340.16360-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Rik van Riel wrote:

> The thing is that the indivual 'users' will be downloading
> files at modem and adsl speeds, meaning a LOT of apache
> daemons could be sitting around on the server.

At the moment, VM Regress cannot run multiple instances of the same test
(although it should be SMP safe and is written with SMP in mind) but I
plan to address that. The problem is not the code running, it's printing
out test results but I know how to address it, I just haven't implemented
it yet.

Because this is a benchmark and not a straight-forward test, another
parameter could be added called page reference delay. It would be a time a
page would be locked while it was been "transmitted" and then run multiple
instances of the test for different transmission speeds. I digress because
benchmarks like this are vapourware in VM Regress land at the moment and
I'm not prepared to discuss individual benchmarks just yet.

> You are right though that this is more of an overall system
> benchmark than a pure VM test.  On the other hand, the VM
> doesn't function on its own, it really needs to be part of
> a larger system ;)
>

I understand that but I believe there is a number of benchmarks that
already demonstrate overall performance. A normal benchmark will tell you
X bytes was transmitted but won't tell you where time in the kernel was
spent and won't tell you anything about the end state of the system.

Using VM Regress, you could tell if delays were in page allocation, disk
reads, bad swap decisions etc. by running individual micro benchmarks (you
can already test __alloc_pages and mmap related routines).  A normal
benchmark won't tell you and I'm not aware of any tool that can do the
equivilant outside of stress testing. That is one of my "selling point".

> > Not for that particular benchmark, but how useful would the VM Regress
> > equivilant be?
>
> I can't say in advance how useful it would be, but my gut
> feeling is that it might help getting things right.
>

ok, that is more or less what I was looking for. If I can get some sort of
indication from experienced VM developers on whether such a tool is
useful, I'll keep developing the tool. I know it doesn't do enough to be
truly useful yet. This first release was to find if there was any "What
sort of uselessness is that?", "haha, we already have all this
information" or "we don't need such data" reactions.

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel

