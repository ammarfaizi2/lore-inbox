Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129158AbRBALcs>; Thu, 1 Feb 2001 06:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbRBALci>; Thu, 1 Feb 2001 06:32:38 -0500
Received: from mail08.voicenet.com ([207.103.0.34]:21217 "HELO mail08")
	by vger.kernel.org with SMTP id <S129080AbRBALc2>;
	Thu, 1 Feb 2001 06:32:28 -0500
Message-ID: <3A794945.5F652819@voicenet.com>
Date: Thu, 01 Feb 2001 06:32:21 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Byron Stanoszek <gandalf@winds.org>, linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <Pine.LNX.4.21.0101311937380.21983-100000@winds.org> <3A78C17A.B06F74FC@voicenet.com> <20010201075211.B980@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> On Wed, Jan 31, 2001 at 08:52:58PM -0500, safemode wrote:
>
> > My KA7 can go over 160Mhz FSB
> > Yes i know about memory speed limitions ..that's why you are able to choose
> > HW clock - PCI   so  at those high speeds it's actually   say  120Mhz - 33
> > keeping you below or near 100 and not well over the spec of the ram.    Anyway i
> > dont go that high    110 is safe an doesn't cause any heat increase and gives me
> > 100Mhz more.  nbench shows my performance about equal to t-bird 1ghz.  at least in
> > memory and integer.   The KA7 lets you increase the FSB without increasing the
> > PCI bus speed,  so i dont have to worry about changing ide bus timings, PCI is
> > still at 33 - 34   not enough to hurt any cards.
>
> Ugh. What chips your KA7 has? As far as I know the KX133 chip (vt8731)
> can't do asynchronous PCI, allowing for 2x, 3x and 4x FSB/PCI divisors
> only. So I don't a way to have your FSB at 114 and your PCI at 34 with
> this chip.

Actually it can and it's a simple bios option.  I'd show you but it's in the manual and
it's hard to scan stuff without a scanner.     You can have asynchronous FSB up to
28Mhz    so i can have 128Mhz FSB with 33Mhz PCI      after that i have to use the
synchronous increase which changes PCI as i change the FSB value   but the other value
gets added onto that asynchronously.  It's really a standard feature of this board.
I'm not making it up and the proof is me not changing idebus at all and still working
after a day at full load and semi-constant usage and MANY compiles.   also the bios
screen doesn't lie.


>
> > OK ok..  just forget i ever mentioned it ..  It has nothing to do with anything
> > i've been talking about problem wise because i _JUST_ did it now ...   It is the
> > cause of nothing because they all happened before i did anything to the speed.
> > This is a 2.4.x kernel problem.  It has nothing to do with overclocking because at
> > the time i didn't.  When i used 2.2.x it did not have any problems and i did not
> > overclock.    As of now i have no problems with ide resets or dma timeouts (which
> > is what i said before), regardless of if i'm overclocking it now or not.  It's
> > working great (better than great) without changing anyhing in 2.2.19-pre7.
> >  heh.   so everyone can stop flipping out over overclocking because i made sure
> > hardware settings were default failsafe even before deciding it was definitely a
> > kernel problem and i never had the settings over spec before the problem surfaced.
>
> Ok. So do you still have a working 2.2 setup and a non-working 2.4
> setup? Would you be able to send me the usual (lspci -vvxxx, dmesg,
> hdparm -t /dev/hd*, hdparm -i /dev/hd*, cat /proc/ide/via) data for both
> so that I can compare them?
>
> If I find any differences, I'll know what the bug is.
>
> --
> Vojtech Pavlik
> SuSE Labs

I cant get anything from 2.4 because I kind of dont want to re-format and re-install
debian again and lose my email and logs and config scripts.  It's seriously that bad.
fsck would say it fixed everything ..  I would reboot and immediately it would come up
with certain files having IO errors and then inode errors.   Strangely though, this
didn't occur the very first time i booted with the kernel...   it took about 3 days
until it happened, but after that it would happen all the time and even after
reboots.   I even disabled DMA support for both and it still happened .  So i really
doubt it has to do with the via specific driver for DMA support in the kernel (ie.
there is no /proc/ide/via).    i'll look into finding some way of running 2.4 so that
it cant destroy my filesystems.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
