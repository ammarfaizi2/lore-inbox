Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280872AbRKYPaf>; Sun, 25 Nov 2001 10:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280892AbRKYPaZ>; Sun, 25 Nov 2001 10:30:25 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:63884 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280872AbRKYPaF>; Sun, 25 Nov 2001 10:30:05 -0500
Subject: Re: Severe Linux 2.4 kernel memory leakage
From: Chris Chabot <chabotc@reviewboard.com>
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <tgy9kuevtw.fsf@mercury.rus.uni-stuttgart.de>
In-Reply-To: <1006699767.1178.0.camel@gandalf.chabotc.com> 
	<tgy9kuevtw.fsf@mercury.rus.uni-stuttgart.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 25 Nov 2001 16:30:26 +0100
Message-Id: <1006702226.1316.2.camel@gandalf.chabotc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel i ran for about a month was kernel 2.4.11.

Ofcource i am aware that the memory usage grows as more memory is used
for buffers/cache. (specialy since its also a large file server). 

However if you check my 'free' output, and the ps aux output you will
notice that the 430Mb used is with the cache and buffer usage already
subtracted from the 'total usage' (else usage is just below 1 gig). 

Of 430Mb, (counting ps aux res values), just below 80 Mb is used by the
applications. the rest is just 'missing'.

So the current memory division is about (sources: application = added ps
aux output, buffer/cache/free = 'free' command, sysv shm from 'ipcs')

Applications:  80Mb
Buffers:       127Mb
Cache:         460Mb
Sysv shm:      0
Free:          9.5Mb

memory total   1Gb

Unaccounted    +/- 360Mb

ps, yes i did check /dev/shm, and 'ipcs' and no memory is used as sysv
shared memory 


	-- Chris


On Sun, 2001-11-25 at 16:03, Florian Weimer wrote:
> Chris Chabot <chabotc@reviewboard.com> writes:
> 
> > When the box keeps on running for about a month,
> 
> Which kernels have you run for about a month, and which ones showed
> this extreme behavior?  Obviously not 2.4.15...
> 
> The amount of available memory decreasing is quite normal, due to the
> growing cache.
> 
> -- 
> Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
> University of Stuttgart           http://cert.uni-stuttgart.de/
> RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


