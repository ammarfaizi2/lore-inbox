Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTIATgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTIATgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:36:24 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:47344 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263238AbTIATgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:36:20 -0400
Date: Mon, 1 Sep 2003 21:36:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Antonio Vargas <wind@cocodriloo.com>
cc: Ian Kumlien <pomac@vapor.com>, Robert Love <rml@tech9.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [SHED] Questions.
In-Reply-To: <20030901142128.GB2359@wind.cocodriloo.com>
Message-ID: <Pine.GSO.4.21.0309012129510.5831-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003, Antonio Vargas wrote:
> On Mon, Sep 01, 2003 at 02:00:09AM +0200, Ian Kumlien wrote:
> > On Mon, 2003-09-01 at 01:41, Robert Love wrote:
> > > On Sun, 2003-08-31 at 18:41, Ian Kumlien wrote:
> Ian, I came from Amiga to Linux many moons ago, and their target are
> very different... on Amiga, the mouse pointer is drawn as a hardware
> sprite (same as an C64 or an arcade machine), and the mouse
> movement counters are handled in hardware too, so your mouse pointer
> can't _EVER_ get laggy.

That's not completely true...

The hardware keeps track of the mouse counter (but may overflow).
The mouse counters are checked periodically (in an interrupt, IIRC) and the
sprite position is updated.

So there's no real difference from a hardware point of view between Amiga
mouse/sprite hardware and PCs with PS/2 or serial mice and hardware cursors.
Both mouse counters and serial buffers can overflow, though ;-)

> Geert, perhaps you could tell us how linux music playing feels
> for a desktop m68k machine? 

Last time I tried it was worse than AmigaOS.

> [ I'm CCing you since you are the only one from the m68k port    
>   which I can see posting on a regular basis.]

What about Roman Zippel? And you can always try the linux-m68k list ;-)

> > > Agreed.  But at the same time, not every "interactive" task should be
> > > real-time.  In fact, nearly all should not.  I do not want my text
> > > editor or mailer to be RT, for example.
> > 
> > Well, there is latency and there is latency. To take the AmigaOS
> > example. Voyager, a webbrowser for AmigaOS uses MUI (a fully dynamic gui
> > with weighted(prioritized) sections) and renders images. It's responsive
> > even on a 40mhz 68040 using Executive with the feedback scheduler.

The biggest part of the responsiveness comes from the cheap context switching.
Not needing a MMU can have its advantages... Plus there's no demand paging or
swapping to wait for.

That's also the reason why you can have higher serial speed under AmigaOS than
under Linux/m68k: a serial port with a 1-byte buffer needs fast and cheap
context switching.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

