Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVL3IRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVL3IRo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 03:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVL3IRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 03:17:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:64267 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751213AbVL3IRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 03:17:43 -0500
Date: Fri, 30 Dec 2005 09:15:36 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230081536.GA30503@alpha.home.local>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229231615.GV15993@alpha.home.local> <1135929917.2941.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135929917.2941.0.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 09:05:17AM +0100, Arjan van de Ven wrote:
> 
> > Can't we elect a recommended gcc version that distro makers could
> > ship under the name kgcc as it has been the case for some time,
> 
> speaking as someone who used to work for a distro: this sucks for
> distros. Shipping 2 compilers is NOT fun. Not fun at all! It's double
> the maintenance, actually more since 1 of the 2 is only used in 1
> package, so it gets a lot less testing.

I trust your experience on this, but wasn't the lack of testing
primarily due to the use of a "special" version of the compiler ?
For instance, if we put a short howto in Documentation/ explaining
how to build a kgcc toolchain describing what versions to use, there
are chances that most LKML users will use the exact same version.
Distro maintainers may want to follow the same version too. Also,
the fact that the kernel would be designed to work with *that*
compiler will limit the maintenance trouble you certainly have
encountered trying to keep the compiler up-to-date with more recent
kernel patches and updates.

Of course I may be wrong, but I think that kernel developpers spend
a huge time adapting the kernel to newer versions gcc (and fixing
bugs caused by new versions too), and this time would better be spent
developping new features and fixing bugs (and of course sometimes
maintaining the kgcc toolchain when needed).

Willy

