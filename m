Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271119AbTGQIEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 04:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271345AbTGQIEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 04:04:08 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:44948
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271119AbTGQIEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 04:04:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Danek Duvall <duvall@emufarm.org>
Subject: Re: [PATCH] O6.1int
Date: Thu, 17 Jul 2003 18:21:41 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307171213.02643.kernel@kolivas.org> <200307171635.25730.kernel@kolivas.org> <20030717080436.GA16509@lorien.emufarm.org>
In-Reply-To: <20030717080436.GA16509@lorien.emufarm.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307171821.41886.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003 18:04, Danek Duvall wrote:
> In 2.6.0-test1, the cc1 processes hover around 30 (early on they're

That's weird, unless you nice 5 them they shouldn't get any higher than 25. A 
quick code review doesn't reveal to me why that would be the case.

> lower, but they ramp up quickly).  Xmms stays fixed at 20 pretty much
> the entire time.  X stays fixed at 15, though sometimes with heavy

Also weird; it's almost impossible to get stuck at the static priority. 20 is 
what a nice 5 application would be.

> window moving it'll skyrocket to 16.  :)  Mozilla typically is at 20,

Also sounds like nice 5

> but after lots of scrolling, it edges up slowly (and, I think, pretty
> linearly) to 30.  Scrolling's bad by the time you get to 23 (with the

Same thing.

> compile going; if it's the only interesting thing happening, it's smooth
> all the way up).
>
> The jerkiness in mozilla scrolling repeatedly takes three to four
> seconds before it shows up.  Let it sit for a few more seconds and it's
> good to go again, at least for another three to four seconds.
>
> The python process updating the portage database is in the 23-25 range.
>
> In 2.6.0-test1-mm1 with O6.1int, mozilla takes longer to get jerky
> (15-20 seconds), but once it does, it gets stuck there pretty bad.  Over
> the 16 minutes it took to compile the kernel, I think I managed to get
> it unstuck twice (maybe I didn't know how to do it right -- I kept
> poking at it and maybe that was the wrong thing to do).  When left
> alone, it would settle at 24, though it would drop to 20 or 21 when
> either raised to the top of the window stack or lowered to the bottom
> (I'm using fvwm, in case that matters here).  It would come back up to
> 24 within a second or two.  Any scrolling instantly brought it up to 27
> and climbing.

Same. (how >25 ?)
>
> X, cc1, and xmms all had the same behavior as in vanilla (roughly the
> same amount of skippiness).
>
> The python process had a lower priority, spending most of its time in
> the 17-20 range.

That's more consistent.
>
> One other thing -- xmms skips seem to cause it to spit out
>
>     ** WARNING **: snd_pcm_wait: Input/output error
>     ** WARNING **: Buffer time reduced from 500 ms to 371 ms
>
> Not consistently one or the other or both, but at least one of those
> would show up each time.

Not sure what these really mean.

> Hope this helps,

Not entirely sure. I'll continue reviewing my code.

Con

