Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318027AbSHLOD3>; Mon, 12 Aug 2002 10:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318028AbSHLOD3>; Mon, 12 Aug 2002 10:03:29 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59654 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318027AbSHLOD1>; Mon, 12 Aug 2002 10:03:27 -0400
Date: Mon, 12 Aug 2002 11:06:58 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] VM Regress - A VM regression and test tool
In-Reply-To: <E17eBTd-0001nR-00@starship>
Message-ID: <Pine.LNX.4.44L.0208121101090.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Daniel Phillips wrote:

> If you want to help with 'interactive performance', i.e., user
> experience, then *quantify what contributes to that* and write a
> micro-measurement tool that measures such things.  E.g, latency of
> response to keyboard events under load.  It's not rocket science, it
> just takes time and effort to set this kind of thing up so it's accurate
> and predictive.

http://people.redhat.com/bmatthews/irman/

I've already asked Randy Hwron(sp?) to include this in
his regular benchmarking.

> It's an incredible waste of developer's time to be running 'reality
> tests' all the time, and never using more precise measurement methods.
> Anyone who wants to run reality tests and post the results is more than
> welcome to, and this is valuable.  It's not valuable to throw mud at a
> testing/measurement tool because you think it's not 'realistic'.

The thing is that developers need some benchmarking thing
they can script to run overnight.  Watching vmstat for
hours on end is not a useful way of spending development
time.

On the other hand, if somebody could code up some scriptable
benchmarks that approximate real workloads better than the
current benchmarks do, I'd certainly appreciate it.

For web serving, for example, I wouldn't mind a benchmark that:

1) simulates a number of users, that:
    1a) load a page with 10 to 20 associated images
    1b) sleep for a random time between 3 and 60 seconds,
        "reading the page"
    1c) follow a link and grab another page with N images
2) varies the number of users from 1 to N
3) measures
    3a) the server's response time until it starts
        answering the request
    3b) the time it takes to download each full page

Then we can plot both kinds of response time against the number
of users and we have an idea of the web serving performance of
a particular system ... without focussing on, or even measuring,
the unrealistic "servers N pages per minute" number.

Volunteers ? ;)

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

