Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbSJZEdq>; Sat, 26 Oct 2002 00:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSJZEdp>; Sat, 26 Oct 2002 00:33:45 -0400
Received: from gate.gau.hu ([192.188.242.65]:44440 "EHLO gate.gau.hu")
	by vger.kernel.org with ESMTP id <S261851AbSJZEdo>;
	Sat, 26 Oct 2002 00:33:44 -0400
Date: Sat, 26 Oct 2002 06:32:20 +0200 (CEST)
From: Cajoline <cajoline@andaxin.gau.hu>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: ASUS TUSL2-C and Promise Ultra100 TX2
In-Reply-To: <15801.20136.556691.985301@kim.it.uu.se>
Message-ID: <Pine.LNX.4.44.0210252219040.25901-100000@andaxin.gau.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Oct 2002, Mikael Pettersson wrote:

> Cajoline writes:
>  > I recently setup a box with the following components:
>  > Intel Celeron 1300 MHz
>  > ASUS TUSL2-C motherboard
>  > 2 x Promise Ultra100 TX2 controllers
>
> Those have the 20268 chip, right?

Yes it is the 20268 chip.

>
>  > Any 2.4 kernel I have tried on this machine displays this strange
>  > behavior: any drives attached to the PDC controllers only work at udma
>  > mode 2 (UDMA33).
>
> I've recently installed a Ultra133 TX2 (PDC 20269) in a box, and it
> also only does UDMA33 in 2.4.20-pre11. 2.5.44 with the PDC driver
> for "new" chips does UDMA100, however. (The disk is only UDMA100.)
>
> The latest 2.4.20-pre-ac is supposed to have new IDE drivers, but
> I haven't had time to test it myself.

I tested with up to 2.4.19, with the same results. Since there were no
errors and I couldn't find any relevant information in LKML, I didn't
bother to try 2.4.20 test or ac kernels.

This is interesting information, however it still looks very strange to
me, since this is not exactly brand-spanking-new hardware (Ultra 100 TX2
has been around for quite some time) and it does work just fine with other
boards (see below). Also, how come there are absolutely no
errors? Finally, could the motherboard's IDE chipset really have such a
huge impact on the performance of the PDC driver? I mean, after all, PIIX4
is a very widely used chipset, afaik.

>
>  > So I have come to the conclusion there must be some rather bizarre
>  > incompatibility between the PDCs and this motherboard.
>
> Unlikely.
>
>  > Let me note that the PDC controllers do work just fine with other older
>  > motherboards. And another thing, during boot-up, the PDCs do show the
>  > drives attached to it, detected at the right udma mode.
>
> Did those boards also use standard 2.4 kernels?

I can assure you the controllers work just fine on some older QDI
Advance 10F motherboard (VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66
controller), but there were others too.

And yes, I am talking about the same kernels: stock 2.4.18, .19, and Red
Hat's 2.4.18 kernels, among others.

>
> /Mikael
>

I appreciate your insight & help on this. I hope my questions are not too
naive, but I was totally in the dark on this issue until now.

Regards,
Cajoline Leblanc

