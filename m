Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVCIKgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVCIKgD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVCIKew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:34:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56591 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262273AbVCIKcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:32:47 -0500
Date: Wed, 9 Mar 2005 10:32:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@muc.de>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309103223.C17289@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Andi Kleen <ak@muc.de>, Greg KH <greg@kroah.com>,
	Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de> <1110363060.6280.74.camel@laptopd505.fenrus.org> <20050309101728.A17289@flint.arm.linux.org.uk> <1110363899.6280.77.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1110363899.6280.77.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Wed, Mar 09, 2005 at 11:24:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 11:24:58AM +0100, Arjan van de Ven wrote:
> On Wed, 2005-03-09 at 10:17 +0000, Russell King wrote:
> > What about the case (as highlighted in previous discussions) that the
> > stable tree needs a simple "dirty" fix, whereas mainline takes the
> > complex "clean" fix?
> 
> that's the exception I talked about a bit later in my mail. It should be
> rare and very deliberate. And in fact once the mainline change ripples
> out into maturity I rather replace the -stable one with that later on,
> even if it's a bit more invasive. 

Is that really necessary with a stable tree which may only be around
for about 2 months before the next stable tree is forked (which would
have the mature mainline fix in) ?

There is another point here though, which I think is much more important.
Remember that the original issue which caused the -stable tree to be
created was a concern over the testing that Linus' kernels were getting.
Also, realise that by creating a -stable tree, we haven't increased the
number of testers which Linus' kernels are seeing.

Given that, how can we decide that a complex fix has matured enough
in Linus' kernel to warrant replacing a (proven) fix which users are
perfectly happy with in the corresponding -stable tree?

I thought the -stable tree is targeted towards stability, not towards
"lets replace this change with some other because we as developers think
it's better".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
