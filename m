Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311270AbSCLQ14>; Tue, 12 Mar 2002 11:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311269AbSCLQ1i>; Tue, 12 Mar 2002 11:27:38 -0500
Received: from [195.63.194.11] ([195.63.194.11]:44554 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311268AbSCLQ11>; Tue, 12 Mar 2002 11:27:27 -0500
Message-ID: <3C8E2C2C.2080202@evision-ventures.com>
Date: Tue, 12 Mar 2002 17:26:20 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com> <20020312165937.A4987@ucw.cz> <3C8E28A1.1070902@evision-ventures.com> <20020312172134.A5026@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:


> Well, as much as I'd like to use safe pre-computed register values for
> the chips, that ain't possible - even when we assumed the system bus
> (PCI, VLB, whatever) was always 33 MHz, still the drives have various
> ideas about what DMA and PIO modes should look like, see the tDMA and
> tPIO entries in hdparm -t.  

Yes yes yes of course some of the drivers are confused. And I don't
argue that precomputation is adequate right now. It just wasn't for
the CMD640 those times... I only wanted to reffer to history and
why my timings where different then the computed.

> So, arithmetics has to stay. Hopefully just one instance in
> ide-timing.c.
> 
> 
>>>I plan to focus on the most important drivers first, to fix and clean
>>>them, working with the authors where possible.
>>>
>>PIIX na VIA comes to mind first ;-)...
>>
> 
> VIA is already OK, well, it has my name in it. :) AMD is now also (well,

Oh of course I was reffering to VIA as important.

> that one wasn't broken, just ugly), SiS is being revamped by Lionel
> Bouton (whom I'm trying to help as much as I can), so yes, PIIX would be
> next.

I swallowed his SiS stuff already, since my home main machine is
a SiS735 based board. (Awfoul cheap that thing and quite good price/performance
ratio ;-).

> PIIX and ICH are pretty crazy hardware from the design perspective, very
> legacy-bound back to the first Intel PIIX chip. And the driver for these

Yes I "love" the bound together DMA areas as well ;-).

> in the kernel has similarly evolved following the hardware. However, it
> doesn't seem to be wrong at the first glance. Nevertheless, I'll take a
> look at it. Unfortunately, I don't have any Intel hardware at hand to
> test it with.

Just another hint: dmaproc is silly nomenclature is should be
dma_strategy <- this would better reflect it's purpose.

