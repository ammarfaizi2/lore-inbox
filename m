Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132450AbQKDNGR>; Sat, 4 Nov 2000 08:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132710AbQKDNGI>; Sat, 4 Nov 2000 08:06:08 -0500
Received: from humbolt.geo.uu.nl ([131.211.28.48]:30480 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S132450AbQKDNFy>; Sat, 4 Nov 2000 08:05:54 -0500
Date: Sat, 4 Nov 2000 14:05:29 +0100 (CET)
From: Rik van Riel <riel@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
cc: Jonathan George <Jonathan.George@trcinc.com>,
        "'matthew@mattshouse.com'" <matthew@mattshouse.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test10 Sluggish After Load
In-Reply-To: <qwwy9z16wsb.fsf@sap.com>
Message-ID: <Pine.LNX.4.05.10011041403590.4511-100000@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Nov 2000, Christoph Rohland wrote:
> On Wed, 1 Nov 2000, Rik van Riel wrote:
> > The 2.4 VM is basically pretty good when you're not
> > thrashing and has efficient management of the VM until
> > your working set reaches the size of physical memory.
> > 
> > But once you hit the thrashing point, the VM falls
> > flat on its face. This is a nasty surprise to many
> > people and I am working on (trivial) thrashing control,
> > but it's not there yet (and not all that important).
> 
> I looked into this argument a little bit further:  In my usual stress
> tests 12 processes select a random memory object out of 15 to mmap()
> or shmat() it and then access it serially. Each segment is 666000000
> bytes and I have 8GB of memory. So at one time there are at most
> 666000000*12 bytes = 7.45GB memory attached and in use. So I do not
> see that the machine qualifies as thrashing. Of course the memory
> pressure is very high all the time since we have to swap out unused
> segments.
> 
> But the current VM does not behave good at all on that load.

Indeed, shared memory performance still sucks rocks.

I have not had time to fix this and I'm afraid I probably
won't have time to fix this in the near future. I'm willing
to give some advice to people who do want to take on the job
of fixing SHM performance, though..

regards,

Rik
--
The Internet is not a network of computers. It is a network
of people. That is its real strength.

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
