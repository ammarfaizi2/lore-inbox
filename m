Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276399AbRI2BUx>; Fri, 28 Sep 2001 21:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276400AbRI2BUc>; Fri, 28 Sep 2001 21:20:32 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:16648 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S276399AbRI2BUZ>;
	Fri, 28 Sep 2001 21:20:25 -0400
Date: Fri, 28 Sep 2001 22:20:37 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac16 good perfomer?
In-Reply-To: <20010928180819.A29756@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.33L.0109282217530.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001, Mike Fedyk wrote:

> Is it normal to have Inact_target 1/4 of main memory (64MB of 256MB RAM)?
> In previous versions, this value would fluctuate with the load of the system.
>
> Is this expected?

Yes, this is a 'compensation' for the fact that page aging changed
from exponential to linear.  The combination of linear page aging
with a large inactive_target results in a good combination of
frequency- and recency-based page eviction.

Doing just linear page aging with a small inactive target resulted
in worse throughput than exponential page aging for some workloads,
better for other workloads.  Linear page aging with a large inactive
target results in good througput and latency under all workloads I've
found up to now.  As usual, thanks go out to Matt Dillon for finding
this balancing point.

I guess it really is time to stop reinventing the wheel ;)

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

