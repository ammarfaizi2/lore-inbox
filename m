Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129225AbRBAGwd>; Thu, 1 Feb 2001 01:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129182AbRBAGwX>; Thu, 1 Feb 2001 01:52:23 -0500
Received: from styx.suse.cz ([195.70.145.226]:51192 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129142AbRBAGwP>;
	Thu, 1 Feb 2001 01:52:15 -0500
Date: Thu, 1 Feb 2001 07:52:11 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: safemode <safemode@voicenet.com>
Cc: Byron Stanoszek <gandalf@winds.org>, linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
Message-ID: <20010201075211.B980@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0101311937380.21983-100000@winds.org> <3A78C17A.B06F74FC@voicenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A78C17A.B06F74FC@voicenet.com>; from safemode@voicenet.com on Wed, Jan 31, 2001 at 08:52:58PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 08:52:58PM -0500, safemode wrote:

> My KA7 can go over 160Mhz FSB
> Yes i know about memory speed limitions ..that's why you are able to choose
> HW clock - PCI   so  at those high speeds it's actually   say  120Mhz - 33
> keeping you below or near 100 and not well over the spec of the ram.    Anyway i
> dont go that high    110 is safe an doesn't cause any heat increase and gives me
> 100Mhz more.  nbench shows my performance about equal to t-bird 1ghz.  at least in
> memory and integer.   The KA7 lets you increase the FSB without increasing the
> PCI bus speed,  so i dont have to worry about changing ide bus timings, PCI is
> still at 33 - 34   not enough to hurt any cards.

Ugh. What chips your KA7 has? As far as I know the KX133 chip (vt8731)
can't do asynchronous PCI, allowing for 2x, 3x and 4x FSB/PCI divisors
only. So I don't a way to have your FSB at 114 and your PCI at 34 with
this chip.

> OK ok..  just forget i ever mentioned it ..  It has nothing to do with anything
> i've been talking about problem wise because i _JUST_ did it now ...   It is the
> cause of nothing because they all happened before i did anything to the speed.
> This is a 2.4.x kernel problem.  It has nothing to do with overclocking because at
> the time i didn't.  When i used 2.2.x it did not have any problems and i did not
> overclock.    As of now i have no problems with ide resets or dma timeouts (which
> is what i said before), regardless of if i'm overclocking it now or not.  It's
> working great (better than great) without changing anyhing in 2.2.19-pre7.
>  heh.   so everyone can stop flipping out over overclocking because i made sure
> hardware settings were default failsafe even before deciding it was definitely a
> kernel problem and i never had the settings over spec before the problem surfaced.

Ok. So do you still have a working 2.2 setup and a non-working 2.4
setup? Would you be able to send me the usual (lspci -vvxxx, dmesg,
hdparm -t /dev/hd*, hdparm -i /dev/hd*, cat /proc/ide/via) data for both
so that I can compare them?

If I find any differences, I'll know what the bug is.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
