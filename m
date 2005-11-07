Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVKGRX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVKGRX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVKGRX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:23:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965033AbVKGRXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:23:24 -0500
Date: Mon, 7 Nov 2005 09:22:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christopher Friesen <cfriesen@nortel.com>
cc: Krzysztof Halasa <khc@pm.waw.pl>, Eric Sandall <eric@sandall.us>,
       Willy Tarreau <willy@w.ods.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
In-Reply-To: <436F8ABE.9020605@nortel.com>
Message-ID: <Pine.LNX.4.64.0511070915350.3193@g5.osdl.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
 <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
 <20051029195115.GD14039@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
 <20051031064109.GO22601@alpha.home.local> <Pine.LNX.4.63.0511062052590.24477@cerberus>
 <m3k6fkxwqe.fsf@defiant.localdomain> <436F8ABE.9020605@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Nov 2005, Christopher Friesen wrote:
> 
> The safe bet is to simply rename the final -rc with no further changes.

That's not actually a very safe bet at all.

Why? Because only a small percentage of people actually test -rc kernels 
in the first place. 

So if you release the last -rc as the standard kernel, you (a) get no real 
coverage advantage anyway and (b) you just wasted a week in order to try 
to get some coverage that you aren't getting.

The current kernel development model is to merge stuff early, which 
hopefully motivates the people who _do_ test -rc kernels to actually test 
-rc1, since they know that that's the one that has _all_ the really 
relevant goodies.

And most of those that do test -rc1 will never see any problems at all. 
Those that do, are now more likely to test the rest of the -rcs, hopefully 
until their problem is resolved. And those that don't test -rc releases 
(because they simply don't upgrade very often) will _never_ test an -rc 
release, whether it's the first one or the last one.

So what we have to fight this problem is the stable kernel series. We 
release the final 2.6.x kernel with as much testing as we can, but it's 
just an undeniable fact that a lot of people will try that kernel only 
after the release, and often it might be weeks after the release. Doing 
-rc kernels didn't do anything for those cases.

But when they find a problem (or somebody who _did_ test an -rc kernel, 
but didn't notice a problem until much later), we try to have a process to 
get those issues fixed. 

So repeat after me: "Most people never test -rc kernels". 

			Linus
