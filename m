Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129493AbRBABxX>; Wed, 31 Jan 2001 20:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbRBABxN>; Wed, 31 Jan 2001 20:53:13 -0500
Received: from mail09.voicenet.com ([207.103.0.35]:44706 "HELO
	mail09.voicenet.com") by vger.kernel.org with SMTP
	id <S129208AbRBABxF>; Wed, 31 Jan 2001 20:53:05 -0500
Message-ID: <3A78C17A.B06F74FC@voicenet.com>
Date: Wed, 31 Jan 2001 20:52:58 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Byron Stanoszek <gandalf@winds.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <Pine.LNX.4.21.0101311937380.21983-100000@winds.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Byron Stanoszek wrote:

> On Wed, 31 Jan 2001, safemode wrote:
>
> > yea i know. . same mode       i also had a big problem with DMA timeouts on
> > 2.4 so  .. i dont know what's up with 2.4 and my motherboard ...    2.2
> > hasn't shown a single irq or DMA error yet since going back to it.
> > currently 2.2.19-pre7 is using UDMA4     i just flashed the bios today so ..
> > hopefully that should have fixed any problems.  I get 24MB/s each according
> > to hdparm -t   on my hdd's and both are on the same channel.   This is much
> > better than i ever got with 2.4 even when only one drive was on a channel.
> > Right now my k7-2 750 is at 849mhz with a FSB of 114Mhz and PCI at 34Mhz.
> > my nbench performance under 2.2 is comparable to results for 1Ghz t-bird's so
> > i'm happy with 2.2.  The only thing that would make me want to upgrade would
> > be latency patches.  I'm convinced 2.4 has performance issues so i guess i'll
> > be using 2.2 until 2.5 begins.      Is it really only 1 or 2 people having
> > this Via corruption problem?   i doubt it's a bios problem because wouldn't
> > 2.2 be effected by a bios bug if 2.4 is?   In either case the changelogs dont
> > show any  fixes for it.
>
> If your FSB is running at 114 MHz, you should try the kernel parameter
> idebus=37 to get DMA working correctly. Otherwise you'll see an ide-reset error
> on bootup because the instructions are too fast. The VIA driver on 2.2 doesn't
> correctly program the PCI card, so you don't see weird behavior running 2.2
> with a faster PCI clock.
>
> (Note: 1.14 * 33 = 37.6 PCI Clk)
>
> It also matters what motherboard you're using, and if it can support speeds up
> past 100. If you're serious about overclocking, buy one of the new KT133A
> boards that support speeds up to 133 (or an average overclocked 145 limit).
>
> For instance, my Epox KX133 board is unstable at anything above 110 FSB, but
> I've seen the Abit KT7 go as high as 116. You should also have some good
> memory that is rated for 150MHz, otherwise you're just asking for trouble.

My KA7 can go over 160Mhz FSB
Yes i know about memory speed limitions ..that's why you are able to choose
HW clock - PCI   so  at those high speeds it's actually   say  120Mhz - 33
keeping you below or near 100 and not well over the spec of the ram.    Anyway i
dont go that high    110 is safe an doesn't cause any heat increase and gives me
100Mhz more.  nbench shows my performance about equal to t-bird 1ghz.  at least in
memory and integer.   The KA7 lets you increase the FSB without increasing the
PCI bus speed,  so i dont have to worry about changing ide bus timings, PCI is
still at 33 - 34   not enough to hurt any cards.

>
> As always, if you have problems with the kernel and want to submit a bug
> report, please put all the settings back to normal and test thoroughly before
> continuing. It's funny how many bug reports I've heard from people who've
> overclocked their FSB and expected the IDE DMA to be set appropriately under
> 2.4... maybe this should be mentioned somewhere in ide.txt, even though
> overclocking is frowned upon.

As i mentioned in older emails, i did this _today_   i mentioned this "bug" over
two weeks ago.   I turned off DMA in the bios and kernel and the "bug" was still
present.   you can read the old emails and see for yourself.

>
> Regards,
>  Byron
>
> --
> Byron Stanoszek                         Ph: (330) 644-3059
> Systems Programmer                      Fax: (330) 644-8110
> Commercial Timesharing Inc.             Email: bstanoszek@comtime.com

OK ok..  just forget i ever mentioned it ..  It has nothing to do with anything
i've been talking about problem wise because i _JUST_ did it now ...   It is the
cause of nothing because they all happened before i did anything to the speed.
This is a 2.4.x kernel problem.  It has nothing to do with overclocking because at
the time i didn't.  When i used 2.2.x it did not have any problems and i did not
overclock.    As of now i have no problems with ide resets or dma timeouts (which
is what i said before), regardless of if i'm overclocking it now or not.  It's
working great (better than great) without changing anyhing in 2.2.19-pre7.
 heh.   so everyone can stop flipping out over overclocking because i made sure
hardware settings were default failsafe even before deciding it was definitely a
kernel problem and i never had the settings over spec before the problem surfaced.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
