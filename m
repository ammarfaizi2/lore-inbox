Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280002AbRLRPyf>; Tue, 18 Dec 2001 10:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284124AbRLRPyZ>; Tue, 18 Dec 2001 10:54:25 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:30621 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S280002AbRLRPyN>;
	Tue, 18 Dec 2001 10:54:13 -0500
Date: Tue, 18 Dec 2001 16:51:45 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Linus Torvalds <torvalds@transmeta.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112172153410.2416-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0112181639240.11499-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Linus Torvalds wrote:

> 
> On Mon, 17 Dec 2001, William Lee Irwin III wrote:
> >
> >   5:   46490271          XT-PIC  soundblaster
> >
> > Approximately 4 times more often than the timer interrupt.
> > That's not nice...

  0:   24867181          XT-PIC  timer
  5:    9070614          XT-PIC  soundblaster

After I bootup I start X and then xmms and then my system plays mp3's
almost all the time.

> > > Which sound driver are you using, just in case this _is_ the reason?
> >
> > SoundBlaster 16

I have an old ISA SoundBlaster 16
 
> Raising that min_fragment thing from 5 to 10 would make the minimum DMA
> buffer go from 32 bytes to 1kB, which is a _lot_ more reasonable (what,
> at 2*2 bytes per sample and 44kHz would mean that a 1kB DMA buffer empties
> in less than 1/100th of a second, but at least it should be < 200 irqs/sec
> rather than >400).

After watchning /proc/interrupts with 30 second intervals I see that I
only get 43 interrupts/second when playing 16bit 44.1kHz stereo.

And according to vmstat I have 153-158 interrupts/second in total
(it's probably the networktraffic that increases it a little above 143).

/Martin

