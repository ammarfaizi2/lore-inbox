Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVL2XSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVL2XSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVL2XSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:18:16 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:62987 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751116AbVL2XSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:18:15 -0500
Date: Fri, 30 Dec 2005 00:16:16 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229231615.GV15993@alpha.home.local>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 09:41:12AM -0800, Linus Torvalds wrote:
 
> There have been situations where documented gcc semantics changed, and 
> instead of saying "sorry", the gcc people changed the documentation. What 
> the hell is the point of documented semantics if you can't depend on them 
> anyway?

Remember the #arg and ##arg mess in macros between gcc2 and gcc3 ?

I fell like I start to understand where your hate for specifications
comes from. As much as I like to stick to specs, which is generally
OK for hardware and network protocols, I can say that with GCC, there
is clearly no rule telling you whether your program will still compile
with version N+1 or not.

Can't we elect a recommended gcc version that distro makers could
ship under the name kgcc as it has been the case for some time,
and try to stick to that version for as long as possible ? The only
real reason to upgrade it would be to support newer archs, while at
the moment, we try to support compilers which are shipped as default
*user-space* compilers.

Willy

