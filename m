Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVGaXMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVGaXMz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 19:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVGaXMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 19:12:40 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:16709 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262083AbVGaXKM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 19:10:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZFJBErM3sqqB6l/peRo8aT1ZVMA2A6NMk8QfW+O854Q6vS+VF3pUepBKVnPjWwyCo1Sp2yS7LrvR0YxUtUy4AXwr6/f7jnV7GPJcS+7M+CtXtbq3hU5udC3gEzpXG0fj/gerrnqlUaGTcdlfn6czCYSxhP7YJpdnnc1hTlOz9L0=
Message-ID: <21d7e99705073116101073708f@mail.gmail.com>
Date: Mon, 1 Aug 2005 09:10:08 +1000
From: Dave Airlie <airlied@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: revert yenta free_irq on suspend
Cc: ambx1@neo.rr.com, Pavel Machek <pavel@ucw.cz>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2e00842e116e.2e116e2e0084@columbus.rr.com>
	 <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > In general, I think that calling free_irq is the right behavior.
> 
> I DO NOT CARE!
> 
> It breaks hundreds of drivers. End of discussion.
> 
> You can do the free_irq() and request_irq() changes _without_ breaking
> hundreds of drivers by just doing one driver at a time.
> 

So are driver writers supposed to start accepting patches to
free/request irqs? in a sense of making it all go forward so at some
point we can switch over to doing the correct thing? but my patch for
yenta breaks setups for some strange reason..... (maybe just APM
ones..)

If so we should put the patch to break links into -mm and then start
fixing up drivers...

Dave.
