Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319104AbSHFOot>; Tue, 6 Aug 2002 10:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319105AbSHFOot>; Tue, 6 Aug 2002 10:44:49 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:18698 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S319104AbSHFOoq>; Tue, 6 Aug 2002 10:44:46 -0400
Date: Tue, 6 Aug 2002 09:59:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Steven Cole <elenstev@mesatop.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>,
       Steven Cole <scole@lanl.gov>
Subject: Re: Linux v2.4.19-rc5
In-Reply-To: <Pine.LNX.3.96.1020805234423.4423A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44L.0208060957220.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, Bill Davidsen wrote:

> > Here are some dbench numbers, from the "for what it's worth" department.
>
> Call me an optimist, but after all the reliability problems we had win the
> 2.5 series, I sort of hoped it would be better in performance, not
> increasingly worse. Am I misreading this? Can we fall back to the faster
> 2.4 code :-(

Dbench is at its best when half (or more) of the dbench processes
are stuck semi-infinitely in __get_request_wait and the others can
operate in RAM without ever touching the disk.

In effect, if you want the best dbench throughput you should make
the system completely unsuitable for real world applications ;)

There are a few things that are good for both real world performance
and dbench performance, but those are easily dwarved by random factors
like IO scheduling, timeslice length, etc...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

