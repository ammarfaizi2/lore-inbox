Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268540AbUILJOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268540AbUILJOS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268541AbUILJOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:14:18 -0400
Received: from witte.sonytel.be ([80.88.33.193]:43182 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268540AbUILJOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:14:12 -0400
Date: Sun, 12 Sep 2004 11:13:58 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Hamie <hamish@travellingkiwi.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
In-Reply-To: <1094944787.21702.3.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.58.0409121111330.3377@waterleaf.sonytel.be>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
 <9e47339104091010221f03ec06@mail.gmail.com> <1094835846.17932.11.camel@localhost.localdomain>
 <9e47339104091011402e8341d0@mail.gmail.com> <Pine.LNX.4.58.0409102254250.13921@skynet>
 <1094853588.18235.12.camel@localhost.localdomain> <Pine.LNX.4.58.0409110137590.26651@skynet>
 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
 <Pine.LNX.4.58.0409110600120.26651@skynet> <1094913222.21157.61.camel@localhost.localdomain>
 <9e47339104091109463694ffd3@mail.gmail.com> <1094919681.21157.119.camel@localhost.localdomain>
 <41434DA0.3050408@travellingkiwi.com> <1094944787.21702.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004, Alan Cox wrote:
> > What about if you want to use fb when in text mode (Because you get
> > 200x75 on a 1600x1200 screen) AND run DRI because the rest of the time
> > you want to run fast 3D. Plus you want to be able to CTRL-ALT-F1/F2/F7
> > back & forth between X & fb... (i.e. how I currently use it but with
> > unaccelerated x.org radeon drivers, becaus ethe 3D ones WON'T play nicely).
>
> Thats actually the easy case. We don't care if it takes another 30th of
> a second to flip console. The hard one Jon was trying to point out is

BTW, it's not always O(30th of seconds): if we have to reprogram the PLLs
(someone else may have changed the hardware state, let's play safe), it can
take much longer.

People already complained about long switching times between different VCs
using the same video mode, due to reprogramming the PLL from scratch, just to
be safe no one else did something to the hardware state we don't know about.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
