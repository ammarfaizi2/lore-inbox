Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272971AbRIMKQd>; Thu, 13 Sep 2001 06:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272970AbRIMKQX>; Thu, 13 Sep 2001 06:16:23 -0400
Received: from pc-62-31-69-129-ed.blueyonder.co.uk ([62.31.69.129]:18956 "EHLO
	darkfox.thenorth.org") by vger.kernel.org with ESMTP
	id <S272964AbRIMKQN>; Thu, 13 Sep 2001 06:16:13 -0400
From: "Alistair Phipps" <aphipps@thenorth.org>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [GOLDMINE!!!] Athlon optimisation bug (was Re: Duron kernel crash)
Date: Thu, 13 Sep 2001 11:20:10 +0100
Message-ID: <000e01c13c3d$ac011bf0$0200000a@alistair>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20010912214430.A2866@zed.dlitz.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Today I updated the BIOS of my motherboard, a ABIT KT7A (VIA Apollo
KT133A
> >chipset). The kernel I had (2.4.9) started crashing on boot with an
> >invalid page fault, usually right after starting init. I tryed a i686
> >kernel and noticed it works OK, so I recompiled my crashy kernel only
> >switching the processor type and it also worked. changed it back to
> >Athlon/K7/Duron and it starts crashing.
> >
> >Anyone else experiencing this?
>
> BINGO!
>
> This problem is known about, but this is the first report we've had
> of it on a Duron (as opposed to Athlon), and you've successfully
> tracked it down to the updated BIOS.
>
> We need the versions of your old and new BIOSes, as accurately as you
> can make it.

I don't know if this is relevant, but on the Abit KT7 w/Duron 700 I'm using
right now, I upgraded from the -ZT BIOS to the -3R BIOS, and immediately had
problems booting.  I ran memtest86 (www.memtest86.com) and found that on
test 5 I was getting many errors at a particular address range (there had
been no errors with the previous BIOS).  I tried turning down the RAM speed
settings in the BIOS, but none helped - then I tried setting the "MD driving
strength" to "Lo" instead of "Hi" (Hi had been the default) and suddenly got
complete stability and no memory errors with memtest86, even at the high
performance RAM settings.

I can't test if this is related to the i686 vs Athlon "kernel" bug as I'm
not running Linux right now (long story - this isn't my own machine) but it
might be something worth checking.  The crashing occuring may actually be
caused by memory problems - I suggest everyone experiencing this test their
system with memtest86 - particularly tests 5 and 6.  It takes a long time
but may be worth it to rule out problematic RAM / BIOS settings for RAM.

- Alistair Phipps

