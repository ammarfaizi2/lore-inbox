Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbSIWOIp>; Mon, 23 Sep 2002 10:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbSIWOIp>; Mon, 23 Sep 2002 10:08:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54658 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261487AbSIWOIo>; Mon, 23 Sep 2002 10:08:44 -0400
Date: Mon, 23 Sep 2002 10:15:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ryan Anderson <ryan@michonline.com>
cc: Con Kolivas <conman@kolivas.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
In-Reply-To: <20020923140241.GQ1425@mythical.michonline.com>
Message-ID: <Pine.LNX.3.95.1020923101125.3233A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Ryan Anderson wrote:

> On Mon, Sep 23, 2002 at 08:30:21PM +1000, Con Kolivas wrote:
> > Quoting Ingo Molnar <mingo@elte.hu>:
> > > On Mon, 23 Sep 2002, Con Kolivas wrote:
> > > 
> > > how many times are you running each test? You should run them at least
> > > twice (ideally 3 times at least), to establish some sort of statistical
> > > noise measure. Especially IO benchmarks tend to fluctuate very heavily
> > > depending on various things - they are also very dependent on the initial
> > > state - ie. how the pagecache happens to lay out, etc. Ie. a meaningful
> > > measurement result would be something like:
> > 
> > Yes you make a very valid point and something I've been stewing over privately
> > for some time. contest runs benchmarks in a fixed order with a "priming" compile
> > to try and get pagecaches etc back to some sort of baseline (I've been trying
> > hard to make the results accurate and repeatable). 
> 
> Well, run contest once, discard the results.  Run it 3 more times, and
> you should have started the second, third and fourth runs with similar initial conditions.
> 
> Or you could run the contest 3 times, rebooting between each run....
> (automating that is a little harder, of course.)
> 
> IANAS, however.
> 

(1)	Obtain statistics from a number of runs.
(2)	Throw away the smallest and largest.
(3)	Average whatever remains.

This works for many "real-world" things because it removes noise-spikes
that could unfairly poison the average.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

