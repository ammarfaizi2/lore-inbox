Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVCCABM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVCCABM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVCBX7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:59:48 -0500
Received: from waste.org ([216.27.176.166]:31904 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261389AbVCBXw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:52:27 -0500
Date: Wed, 2 Mar 2005 15:52:07 -0800
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050302235206.GK3163@waste.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 02:21:38PM -0800, Linus Torvalds wrote:
> 
> This is an idea that has been brewing for some time: Andrew has mentioned
> it a couple of times, I've talked to some people about it, and today Davem
> sent a suggestion along similar lines to me for 2.6.12.
> 
> Namely that we could adopt the even/odd numbering scheme that we used to 
> do on a minor number basis, and instead of dropping it entirely like we 
> did, we could have just moved it to the release number, as an indication 
> of what was the intent of the release.

One last plea for the 2.4 scheme:

 a) all the crazy stuff goes in 2.6.x-preN, which ends up being
    equivalent to 2.6.<odd> and friends in your scheme
 b) bugfixes only in 2.6.x-rcN, which ends up being equivalent to
    2.6.<even>-* in your scheme.
 c) 2.6.x is always 2.6.x-rc<last> with just a version number change[1]

This has some nice features:

 - alternates as rapidly as you want between stable and development
 - no brown paper bag bugs sneaking in between -rc<last> and 2.6.x 
 - 2.6.* is suitable for all users, 2.6.*-rc* is suitable for almost
   all users
 - it's already in use for 2.4 and people are happy with it

I _really_ don't want to explain to people that they don't want to use
2.6.13 because it's an odd number but that 2.4.31 is just fine (and so
is 2.6.9). Nor do I want to teach my ketchup tool the difference
between 2.6-stable and 2.6-unstable.

> The problem with major development trees like 2.4.x vs 2.5.x was that the 
> release cycles were too long, and that people hated the back- and 
> forward-porting. That said, it did serve a purpose - people kind of knew 
> where they stood, even though we always ended up having to have big 
> changes in the stable tree too, just to keep up with a changing landscape.

I think naming the interim releases -pre/-rc has done this admirably
for 2.4.

--
Mathematics is the supreme nostalgia of our time.
