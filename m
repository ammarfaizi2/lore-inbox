Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSFBB7I>; Sat, 1 Jun 2002 21:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317113AbSFBB7H>; Sat, 1 Jun 2002 21:59:07 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40140 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317112AbSFBB7G>; Sat, 1 Jun 2002 21:59:06 -0400
Date: Sun, 2 Jun 2002 03:58:56 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Hedrick <andre@linux-ide.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Anthony Spinillo <tspinillo@linuxmail.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: INTEL 845G Chipset IDE Quandry
Message-ID: <Pine.SOL.4.30.0206020318090.29792-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Alan,
>
> This is one of the versions of INTEL which has extra bandwidth if you
> want
> wanted to the async IO.  Meaning the device could be set faster than the
> host when reading from the host.  However when writing to the host the
> device "must" be set to match.  The buffer is not capable of safely
> handling the extra push.
>
> So in 2.4 we will properly time the host, unlike 2.5 which has elected
> to overdrive the hardware.

Only in piix driver (Intel & Efar) and user have to explicitly compile
support for it, it have nothing to do with kernel version and everything
with driver version.

> The effect is the following.  "LINUS are you listening?"
				 ^^^^^^^^^^^^^^^^^^^^^^^^
Andre, you forgot to cc Linus ;)

> Ultra DMA 100 uses 4 data clocks to transfer "X" amount of data.
> Ultra DMA 133 uses 3 data clocks to transfer "X" amount of data.
>
> So if a bad host trys to push the limits, it ends up missing a data
> strobe and the DATA goes away quietly without warning.  NICE!
>
> Maybe now people will understand why 2.5 is falling apart and it is not
> Martin's fault.  He is just getting bad information and bad patches.

Poor Marcin, he is so misinformed by bad people trying to spoil ATA stuff.

Bad patches? Who is the bad guy making the bad patches?
Let me guess, it is Vojtech removing others people copyrighted "sick
timing tables". Or maybe it is Jens doing at least TCQ?
Or maybe it is me... etc.

> He actual has nearly the same model I was working on to use fucntion

It is really funny... but some people read code and know facts...

> pointers in the style of "MiniPort (tm)".  I will explain why this is
> desired later.

in Q4 I guess

> Cheers,

Greets...

> Andre Hedrick
> LAD Storage Consulting Group
>
> PS AntonA, my promise to you to inform Linus of one of the major design
> flaws of 2.5 is now met.

What a nice FUD.
What is this major design flaw? Experimental (on demand) code in piix
driver? Or you no longer being ATA maintainer?

Ok, I really wanted to be quiet, but this time it is too much...
sorry for bad words/irony but that is how things look like...

Some people (me included) are putting much effort in cleaning/improving
all this mess, and you keep spreading FUD and discrediting them.

--
Bartlomiej


