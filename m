Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311263AbSCLQMn>; Tue, 12 Mar 2002 11:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311264AbSCLQMe>; Tue, 12 Mar 2002 11:12:34 -0500
Received: from [195.63.194.11] ([195.63.194.11]:28938 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311263AbSCLQMV>; Tue, 12 Mar 2002 11:12:21 -0500
Message-ID: <3C8E28A1.1070902@evision-ventures.com>
Date: Tue, 12 Mar 2002 17:11:13 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com> <20020312165937.A4987@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Mar 12, 2002 at 12:00:24PM +0100, Martin Dalecki wrote:
> 
> 
>>Hello Vojtech.
>>
>>I have noticed that the ide-timings.h and ide_modules.h are running
>>much in aprallel in the purpose they serve. Are the any
>>chances you could dare to care about propagating the
>>fairly nice ide-timings.h stuff in favour of
>>ide_modules.h more.
>>
>>BTW.> I think some stuff from ide-timings.h just belongs
>>as generic functions intro ide.c, and right now there is
>>nobody who you need to work from behind ;-).
>>
>>So please feel free to do the changes you apparently desired
>>to do a long time ago...
>>
> 
> Hmm, ok. Try this. It shouldn't change any functionality, yet makes a
> small step towards cleaning the chipset specific drivers.
> 
> Reading through them as I was doing the changes, I found out that most
> of them compute the timings incorrectly. Because of that I also removed
> the pio blacklist (which is going to come back in a more powerful form,
> merged together with the DMA blacklist), because that one is based on
> ancient experiments with the broken CMD640 chip and a driver which
> doesn't get the timings correct either. The blacklist is plain invalid.

Amen to this. May "the force" be with you! (I mean the force in you fingers!)

AS you may know I was once (an eon ago)
during the Marc Lord "era" involved in the initial developement of the cmd640
support. And well we got it working, but after that some friend got to the idea
of the black list and my disk went from georgious 5M/sec to only lame 2.8M/sec
rates (remember it was a conner 400MB drive then one of those "buggy" Quantums!)
for no good reason. I was long time patching every single kernel those time for
this. So if anything I very well know that the list found there is both:
obsolete and invalid. Further on my CMD640 code wasn't even trying to compute
the timing values in any dynamic ways. I was just using the original tables from
CMD directly, but unfortunately the maintainer enjoyed Z/ ring arithmetics too
much ;-)

> I plan to focus on the most important drivers first, to fix and clean
> them, working with the authors where possible.

PIIX na VIA comes to mind first ;-)...

