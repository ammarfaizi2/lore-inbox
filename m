Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVCCSkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVCCSkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVCCSkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:40:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37638 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262516AbVCCRIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:08:11 -0500
Date: Thu, 3 Mar 2005 18:08:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303170808.GG4608@stusta.de>
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 08:23:39AM -0800, Linus Torvalds wrote:
>...
> But look at how to solve it. The _logical_ solution is to have a third
> line of defense: we have the -mm trees (wild and wacky patches), and we
> have my tree (hopefully not wacky any more), and it would be good to have
> a third level tree (which I'm just not interested in, because that one
> doesn't do any development any more) which only takes the "so totally not
> wild that it's really boring" patches.
> 
> In fact, if somebody maintained that kind of tree, especially in BK, it 
> would be trivial for me to just pull from it every once in a while (like 
> ever _day_ if necessary). But for that to work, then that tree would have 
> to be about so _obviously_ not wild patches that it's a no-brainer.
> 
> So what's the problem with this approach? It would seem to make everybody
> happy: it would reduce my load, it would give people the alternate "2.6.x
> base kernel plus fixes only" parallell track, and it would _not_ have the 
> testability issue (because I think a lot of people would be happy to test 
> that tree, and if it was always based on the last 2.6.x release, there 
> would be no issues.
>... 
>  - some very _technical_ and objective rules on patches. And they should 
>    limit the patches severely, so that people can never blame the sucker 
>    who does the job. For example, I would suggest that "size" be one hard 
>    technical rule. If the patch is more than 100 lines (with context) in
>    size, it's not trivial any more. Really. Two big screenfuls (or four, 
>    for people who still use the ISO-ANSI standard 80x24 vt100)
>...

This only attacks part of the problem.

Most regressions that annoy users aren't in some core system, they are 
in drivers.

What if $big_driver_update in 2.6.12 fixed a serious bug for some people 
but broke the driver for many other people, and both reverting this 
patch and fixing the driver for the people it's broken for exceeds such 
size limits?

> 			Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

