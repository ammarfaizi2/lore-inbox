Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269356AbRHQB1M>; Thu, 16 Aug 2001 21:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269372AbRHQB1C>; Thu, 16 Aug 2001 21:27:02 -0400
Received: from mail.erisksecurity.com ([208.179.59.234]:14378 "EHLO
	Tidal.eRiskSecurity.com") by vger.kernel.org with ESMTP
	id <S269356AbRHQB0s>; Thu, 16 Aug 2001 21:26:48 -0400
Message-ID: <3B7C72CE.60601@blue-labs.org>
Date: Thu, 16 Aug 2001 21:26:38 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jakob =?ISO-8859-1?Q?=D8stergaard?= <jakob@unthought.net>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: "VM watchdog"? [was Re: VM nuisance]
In-Reply-To: <3B748AA8.4010105@blue-labs.org> <20010814140011.B38@toy.ucw.cz> <20010817002420.C30521@unthought.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it is an excellent way to do it.  Nobody said you have to run 
the program and nobody forces you to use a particular program with a 
particular policy.  It puts the OOM policy in userland where -you- 
decide when and how things happen.

David

Jakob Østergaard wrote:

>>Maybe creating userland program that
>>*) allocates few megs
>>*) while 1 sleep 1m, gettimeofday. If more tha two minutes elapsed,
>>	tell OOM handler to kick in.
>>
>
>On my compute-server in the basement this is completely unacceptable because it
>*may* just be working hard on something big.  The excessive swapping may just
>be 10-30 minutes where some app is using way more memory than the box has RAM,
>in this case it's no problem at all, and all your suggestion would give me is
>randomly dying compute jobs.
>
>On my desktop this is unacceptable as well. You want the system to be frozen
>for more than two minutes before doing anything about it ?
>
>The problem with using such vague heuristics against fixed (arbitrary) limits
>is that the effect will almost always be completely unacceptable.  Either your
>arbitrary limit is way too high, or way too low.
>
>I can't tell you how to do it - but I think your suggestion is an excellent way
>to *not* do it     :)
>
>>Or maybe kernel could have some "VM watchdog", which would trigger OOM if
>>it is not polled once a minute...
>>
>
>Didn't everyone pretty much agree that if we could turn off overcommit
>completely and reliably, that would be the preferred solution ?   Simply sig11
>the app that's unlucky enough to want more memory than there's in the system
>(or, horror, have malloc() fail)
>
>Now, I don't remember the entire thread, but IIRC it was difficult to kill
>overcommit completely.
>

The kernel allocates memory within itself.  We will still reach OOM 
conditions.  It can't be avoided.

David


