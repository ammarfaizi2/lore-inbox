Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWIVJht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWIVJht (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWIVJhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:37:33 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:54031 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751125AbWIVJhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:37:06 -0400
Date: Fri, 22 Sep 2006 10:36:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] delay: add generic udelay(), mdelay() and ssleep()
Message-ID: <20060922093659.GA8609@flint.arm.linux.org.uk>
Mail-Followup-To: Denis Vlasenko <vda.linux@googlemail.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200609220955.35826.vda.linux@googlemail.com> <200609220957.43127.vda.linux@googlemail.com> <200609220958.52736.vda.linux@googlemail.com> <200609221000.33978.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609221000.33978.vda.linux@googlemail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 10:00:33AM +0200, Denis Vlasenko wrote:
> * __const_udelay for all arches is removed or renamed to
> ? __const_delay (it did not do microsecond delays anyway)

You never explained this properly - in fact I think your logic is
reversed.  Let me remind you of my reply (which afaics never got
a response):

On Wed, Aug 23, 2006 a 09:14:52AM +0100, Russell King wrote:
> On Wed, Aug 23, 2006 at 07:50:24AM +0200, Denis Vlasenko wrote:
> > On Tuesday 22 August 2006 18:55, Russell King wrote:
> > > Please keep a "const" version in ARM.  Thanks.
> >
> > Are you talking about this hunk? Why do you want to keep it?
> >
> > I mean, without it udelay(n) will become slower by the time
> > needed for one extra multiply. So we will have maybe
> > udelay(n) ==> udelay(n+0.1).
> 
> Why do you think that?  With the constant version, the additional
> unnecessary multiply is optimised away by the compiler (since
> constant * constant = constant), so it's actually slightly faster,
> not sligntly slower as you seem to think.
> 
> Since the multiply is pure overhead, it's better to get rid of it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
