Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318962AbSHMHhz>; Tue, 13 Aug 2002 03:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318963AbSHMHhz>; Tue, 13 Aug 2002 03:37:55 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:37650 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S318962AbSHMHhy>; Tue, 13 Aug 2002 03:37:54 -0400
Message-ID: <3D58B89E.1C9F8AEF@aitel.hist.no>
Date: Tue, 13 Aug 2002 09:43:26 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.31 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Daniel Phillips <phillips@arcor.de>,
       Bernd Eckenfels <ecki-news2002-08@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] VM Regress - A VM regression and test tool
References: <Pine.LNX.4.44L.0208121101090.23404-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> The thing is that developers need some benchmarking thing
> they can script to run overnight.  Watching vmstat for
> hours on end is not a useful way of spending development
> time.
> 
> On the other hand, if somebody could code up some scriptable
> benchmarks that approximate real workloads better than the
> current benchmarks do, I'd certainly appreciate it.
> 
> For web serving, for example, I wouldn't mind a benchmark that:
> 
> 1) simulates a number of users, that:
>     1a) load a page with 10 to 20 associated images
>     1b) sleep for a random time between 3 and 60 seconds,
>         "reading the page"
>     1c) follow a link and grab another page with N images
> 2) varies the number of users from 1 to N
> 3) measures
>     3a) the server's response time until it starts
>         answering the request
>     3b) the time it takes to download each full page
> 
> Then we can plot both kinds of response time against the number
> of users and we have an idea of the web serving performance of
> a particular system ... without focussing on, or even measuring,
> the unrealistic "servers N pages per minute" number.
> 
Don't forget to count the total amount of
swap & block io.  (i.e. vmstat 1 > logfile & sum it up)

Good strategies for page replacement may result in
less io for the same job, which means a lot for
performance whenever you get disk-bound.  Many
a web server serves more than fits in cache, and of
course there are file servers too...

Helge Hafting
