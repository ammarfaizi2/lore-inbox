Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWHGH1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWHGH1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 03:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWHGH1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 03:27:31 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:19433 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751127AbWHGH1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 03:27:30 -0400
Subject: Re: [PATCH 3/4] x86 paravirt_ops: implementation of paravirt_ops
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <200608070820.09059.ak@muc.de>
References: <1154925835.21647.29.camel@localhost.localdomain>
	 <200608070739.33428.ak@muc.de>
	 <1154931222.7642.21.camel@localhost.localdomain>
	 <200608070820.09059.ak@muc.de>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 17:27:27 +1000
Message-Id: <1154935648.7642.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 08:20 +0200, Andi Kleen wrote:
> > > I think I would prefer to patch always. Is there a particular
> > > reason you can't do that?
> > 
> > We could patch all the indirect calls into direct calls, but I don't
> > think it's worth bothering: most simply don't matter.
> 
> I still think it would be better to patch always.

Actually, I just figured out a neat way to do this without having to
handle all the cases by hand.  I'll try it and get back to you...

> > Each backend wants a different patch, so alternative() doesn't cut it.
> > We could look at generalizing alternative() I guess, but it works fine
> > so I didn't want to touch it.
> 
> You could at least use a common function (with the replacement passed
> in as argument) for lock prefixes and your stuff

I don't want to rule out patching based on location (reg lifetime etc),
but there's definitely room for combining these two.  Good point.

Thanks!
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

