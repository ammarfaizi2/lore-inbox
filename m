Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276050AbRJHERT>; Mon, 8 Oct 2001 00:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276312AbRJHERI>; Mon, 8 Oct 2001 00:17:08 -0400
Received: from femail10.sdc1.sfba.home.com ([24.0.95.106]:49392 "EHLO
	femail10.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S276050AbRJHERF>; Mon, 8 Oct 2001 00:17:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: sis630/celeron perf sucks?
Date: Sat, 6 Oct 2001 18:24:18 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011006130647.B26223@work.bitmover.com>
In-Reply-To: <20011006130647.B26223@work.bitmover.com>
MIME-Version: 1.0
Message-Id: <01100618241801.05593@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 October 2001 16:06, Larry McVoy wrote:
> Has anyone out there seen similar problems with SIS630 motherboards?
> I know that we discussed this recently and people said that the graphics
> chip is eating memory bandwidth but I am not using it, it isn't even in
> SVGA mode, it's in text mode and screen blanked.  I also tried setting
> the AGP mem down to 2MB and that made no difference.
>
> The reason I care is that I like these little cheap boxes called "book pcs"
> and the older model was BK810 and used the i810 chipset but the newer ones
> are BK630 and use the SIS630 chipset.
>
> The new ones suck on all the stuff I care about, compiles, BitKeeper
> regressions, just general software dev stuff.
>
> Any insight appreciated.

Run memtest86 to see what your memory bandwidth is.

You can also compare a tight loop ala bogomips with dirtying about as many 
pages as you have cache (memtest86 can find this), with dirtying more pages 
than you have cache in a big evil loop.

If this shows that your problem ISN'T memory bandwidth, then you'll have 
learned something.

> The bummer is that the memory subsystem sucks doggy doo doo on the former.
> Is this a motherboard problem or do the newer celerons suck that bad on
> purpose?

All the celerons I know about have a 66 mhz front side bus speed.  (Actually 
there was a notebook version with a 100mhz fsb, but no desktop ones I know 
of.)  It's a totally artificial limitation to get you to buy a real Pentium 
III.  Intel crippling its low-end to avoid hurting the high end.  (They let 
AMD do that for them. :)

I've got links bookmarked about this somewhere.  You can probably find it on 
Tom's Hardware, or check google...

> Check out the bandwidth stuff, the second row should be faster but isn't:

Yup.  Blame Intel's marketing department.  This isn't a SIS problem, that's 
pure Intel's crippling of the DeCeleron...

Rob
