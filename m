Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbSL3I4G>; Mon, 30 Dec 2002 03:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266777AbSL3I4G>; Mon, 30 Dec 2002 03:56:06 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:21734 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S266772AbSL3I4F>;
	Mon, 30 Dec 2002 03:56:05 -0500
To: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA and hermer/orinoco_cs drivers b0rken?
References: <87u1h3fim2.fsf@lapper.ihatent.com>
	<20021226003405.014f0638.joshk@mspencer.net>
	<87u1gwuomh.fsf@lapper.ihatent.com> <20021230085529.GA12575@localhost>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 30 Dec 2002 10:04:26 +0100
In-Reply-To: <20021230085529.GA12575@localhost>
Message-ID: <87znqn5145.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks

"Joshua M. Kwan" <joshk@ludicrus.ath.cx> writes:

> > Warning: Driver for device eth1 has been compiled with version 14
> > of Wireless Extension, while this program is using version 13.
> > Some things may be broken...
> 
> First of all, what kernel are you using? That's an ancient version of 
> the WE. If this is 2.4.2[01], download the following diffs from Jean's 
> fine site:
> 
> * http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/iw240_we15-6.diff
> * http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/iw241_we16-3.diff
> 

I'll have a look in there. I'm on 2.4.20 with acpi and preempt patches
applied in that order. In addition I'm using pcmcia-cs and not the
built-in stuff. I'm fixing that on another machine here now so that I
can try it out, but it seems to give me no grief and no worries or
errors starting it up and plugging the card in, and PnP finds
resources nicely and I get a nice double beep to indicate all went
well, assigning IPs and everything looks sane.

I'll try later tonight to go for the newer stuff.

> Patch these against the top of your source tree with -p1. This might fix 
> your problem, otherwise it's just eliminating one potential cause of the 
> problem. Then copy include/linux/wireless.h to 
> /usr/include/linux/wireless.h, so that things that require WE to compile 
> (notably pcmcia-cs' wireless modules) will be using the right version.
> 
> Next of all, try upgrading the firmware on your card.
> 

WIll do.

> The error writing packet to BAP error always seemed just like a small 
> nuisance to me during large file transfers. It did not correlate with 
> any connectivity problems, so I just commented it out in the 
> orinoco/hermes/orinoco_cs source (it's in one of those files.)
> 
> Yes, rebuild wireless-tools once you have patched to WE16 and copied it 
> to /usr/include. If you use debian, the easiest way is to apt-get source 
> wireless-tools and just tweak it to look at wireless.h v16, then 
> fakeroot debian/rules binary and replace your package with that. This is 
> probably feasible with SRPMs too, but I don't know how.
> 

I'm on gentoo :)

> Hope your wireless endeavors succeed - I just spent all week getting 
> hostap_plx to work (and I'm now reaping the benefits because I now have 
> wifi access all over my house) :)
> 

I'm trying to solve a 2 meter stretch here, but I also want to get
ready as I always seem to bump into an airport or hotell with WLAN,
and end up having to use it from Windows. And that's boring. :)

> Regards
> -Josh

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
