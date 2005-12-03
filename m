Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVLCPXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVLCPXj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVLCPXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:23:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18182 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751276AbVLCPXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:23:38 -0500
Date: Sat, 3 Dec 2005 16:23:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203152339.GK31395@stusta.de>
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133620598.22170.14.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 03:36:38PM +0100, Arjan van de Ven wrote:
> > ase for a stable series.
> > 
> > After 2.6.16, there will be a 2.6.16.y series with the usual stable 
> > rules.
> > 
> > After the release of 2.6.17, this 2.6.16.y series will be continued with 
> > more relaxed rules similar to the rules in kernel 2.4 since the release 
> > of kernel 2.6.0 (e.g. driver updates will be allowed).
> > 
> 
> 
> this is a contradiction. You can't eat a cake and have it; either you're
> really low churn (like existing -stable) or you start adding new
> features like hardware support. the problem with hardware support is
> that it's not just a tiny driver update. If involves midlayer updates as
> well usually, and especially if those midlayers diverge between your
> stable and mainline, the "backports" are getting increasingly unsafe and
> hard.

In the beginning, backporting hardware support is relatively easy, and 
therefore cherry-picking from mainline 2.6 should be relatively safe.

Things will change as time passes by, but then there's the possibility 
to open the next branch and bring the older branch into a security-fixes 
only mode.

> If the current model doesn't work as you claim it doesn't, then maybe
> the model needs finetuning. Right now the biggest pain is the userland
> ABI changes that need new packages; sometimes (often) for no real hard
> reason. Maybe we should just stop doing those bits, they're not in any
> fundamental way blocking general progress (sure there's some code bloat
> due to it, but I guess we'll just have to live with that).

IOW, we should e.g. ensure that today's udev will still work flawlessly 
with kernel 2.6.30 (sic)?

This could work, but it should be officially announced that e.g. a 
userspace running kernel 2.6.15 must work flawlessly with _any_ future 
2.6 kernel.

For how many years do you think we will be able to ensure that this will 
stay true?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

