Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266060AbRF1Rwp>; Thu, 28 Jun 2001 13:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbRF1Rwh>; Thu, 28 Jun 2001 13:52:37 -0400
Received: from altus.drgw.net ([209.234.73.40]:15884 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S266060AbRF1Rwc>;
	Thu, 28 Jun 2001 13:52:32 -0400
Date: Thu, 28 Jun 2001 12:50:45 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Dreker <patrick@dreker.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
Message-ID: <20010628125045.P8027@altus.drgw.net>
In-Reply-To: <01062809432100.00590@wintermute> <Pine.LNX.4.33.0106280956030.15199-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106280956030.15199-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jun 28, 2001 at 10:05:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> Let's make it policy that we _never_ print out annoying messages that have
> no useful purpose for debugging or running the system, ok?
> 
> "Informational" messages aren't informational, they're just annoying, and
> they hide the _real_ stuff.

Sometimes, but I've run into WAY too many occasions where all I know about
why this sytem died was "what was the last annoying informational boot
message". This gets really usefull when you have either old crufty
hardware that's questionable OR fresh alpha silicon for some new
whizz-bang processor.

> Things like version strings etc sound useful, but the fact is that the
> only _real_ problem it has ever solved for anybody is when somebody thinks
> they install a new kernel, and forgets to run "lilo" or something. But
> even that information you really get from a simple "uname -a".
> 
> Do we care that when you boot kernel-2.4.5 you get "net-3"? No. Do we care
> that we have quota version "dquot_6.4.0"? No. Do we want to get the
> version printed for every single driver we load? No.
> 
> If people care about version printing, it (a) only makes sense for modules
> and (b) should therefore maybe be done by the module loader. And modules
> already have the MODULE_DESCRIPTION() thing, so they should NOT printk it
> on their own.  modprobe can do it if it wants to.
> 
> So let's simply disallow versions, author information, and "good status"
> messages, ok? For stuff that is useful for debugging (but that the driver
> doesn't _know_ is needed), use KERN_DEBUG, so that it doesn't actually end
> up printed on the screen normally.
> 
> Authors willing to start sending me patches?
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
