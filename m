Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286284AbRLJP1V>; Mon, 10 Dec 2001 10:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286287AbRLJP1M>; Mon, 10 Dec 2001 10:27:12 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:22033 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S286284AbRLJP05>; Mon, 10 Dec 2001 10:26:57 -0500
Date: Mon, 10 Dec 2001 10:26:20 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: Pavel Machek <pavel@suse.cz>
cc: Cory Bell <cory.bell@usa.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
In-Reply-To: <20011209131332.A37@toy.ucw.cz>
Message-ID: <Pine.LNX.4.33.0112101016140.15280-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2001, Pavel Machek wrote:

> Hi!
>
> > > Hey, this gross hack fixed USB on HP OmniBook xe3. Good! (Perhaps you
> > > know what interrupt is right for maestro3, also on omnibook? ;-).

I've updated my bios on my Pavilion N5430 and guess what is shows on
the bios boot screen (if you disable the bios splash screen)... Omnibook
XE3.  They are one in the same, at least model number wise.  weird,
considering there are no AMD omnibooks..

> Ouch, you said you have maestro on irq5. And does it *work*? For me,
> it plays mp3 but repeats portions even on wrong interrupt.

My maestro is on IRQ 5, and the pIRQ table says it should be on IRQ 5, and
it works fine. Earlier 2.4 kernels (before .8 or .9) had all sorts of
problems with the maestro3 (actually Allegro-1), but i haven't had any
problems in a while.. Try ALSA, see if that fixes your problems.

> > apply to both. If you want to help get the BIOS updated (the root cause,
> > IMHO), please call HP support and reference case number 1429683616 (that
> > 9 may be a 4 - my handwriting is horrible). That's the case I logged
> > with thim about the broken PIR table (USB irq showing 9; being 11) and
> > failure to enable sse on athlon 4/duron/xp chips.

Good luck.. I emailed HP support, and got the "we're forwarding your
request to the BIOS people".. and that was 4 months ago.

Ohh, and Marcelo accepted the K7/SSE patch for 2.4.17, so no need for that
patch anymore..

I will try the ACPI PCI routing stuff if i get time tonight (don't have
access to the machine right now).

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


