Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbRG2DTQ>; Sat, 28 Jul 2001 23:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbRG2DTG>; Sat, 28 Jul 2001 23:19:06 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:17560 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S267520AbRG2DSx>; Sat, 28 Jul 2001 23:18:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gav <gavbaker@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A / athlon / MMX
Date: Sun, 29 Jul 2001 04:03:29 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15QEP3-0006TF-00@the-village.bc.nu>
In-Reply-To: <E15QEP3-0006TF-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01072904032900.04737@box.penguin.power>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday 27 July 2001 20:40, Alan Cox wrote:

> > On Fri, Jul 27, 2001 at 09:19:21PM +0100, Alan Cox wrote:
> >     Its heavily tied to certain motherboards. Some people found a
> >     better PSU fixed it, others that altering memory settings
> >     helped. And in many cases, taking it back and buying a different
> >     vendors board worked.
> >
> > Does anyone know *why* stuff breaks? surely VIA do as they have a fix
> > for (some, all?) cases of breakage?
>
> At the moment the big problem is I don't have enough reliable info to
> see patterns that I can give to VIA for study. VIAs fixes for board
> problems are for the fifo problem normally seen with the 686B and SB Live
> but sometimes in other cases.
>
> (and it seems also we have a few via + promise weirdnesses on all sorts of
>  boards not yet explained)

Just FYI, I've been running 2.4.7-pre6 for a few weeks on a Abit-KT7-a 
(hpt370) that uses the KT133/VIA chipset, with a 1.33Ghz Athlon and the 
kernel compiled for an Athlon. 

The machine is now rock solid. I've given it the usual tests, k7burn for 5 
hours, cp'ing 30G+ across drives a few times etc, and all is good.

The broken sound (crackle/pop) with my SB128PCI (same problem as SBLive) 
still didn't go away though, but enabling PCI DRAM PREFETCH on the VT8363 
Bus-PCI Bridge does cure it. This took me a while to find as I can't set this 
in my bios, but powertweak came to the rescue.

While DRAM Prefetch is supposed to be an option to increase performance, my 
sound is totally unusable without this set. I've heard numerous people 
explain the same problem and it would be interesting to find out if this 
cures their sound troubles too. If this is the case, is this something that 
belongs in quirks, or is it too hardware specific? and would enabling this by 
default hurt anything anyway? Or is this just masking the underlaying problem 
?

-- Regards, Gavin Baker

