Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263460AbUERUO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUERUO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbUERUO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 16:14:27 -0400
Received: from waste.org ([209.173.204.2]:44205 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263460AbUERUOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 16:14:25 -0400
Date: Tue, 18 May 2004 15:14:16 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [patch] kill off PC9800
Message-ID: <20040518201416.GT5414@waste.org>
References: <1084729840.10938.13.camel@mulgrave> <20040516142123.2fd8611b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516142123.2fd8611b.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 02:21:23PM -0700, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> >     Randy.Dunlap" <rddunlap@osdl.org> wrote:
> >     >
> >     >  PC9800 sub-arch is incomplete, hackish (at least in IDE), maintainers
> >     >  don't reply to emails and haven't touched it in awhile.
> >     
> >     And the hardware is obsolete, isn't it?  Does anyone know when they were
> >     last manufactured, and how popular they are?
> >     
> > Hey, just being obsolete is no grounds for eliminating a
> > subarchitecture...
> 
> Well it's a question of whether we're likely to see increasing demand for
> it in the future.  If so then it would be prudent to put some effort into
> fixing it up rather than removing it.
> 
> Seems that's not the case.  I don't see a huge rush on this but if after
> this discussion nobody steps up to take care of the code over the next few
> weeks, it's best to remove it.

Perhaps a nicer way to do this is to add a compile warning or error:

#warning "arch/i386/mach-pc9800 unmaintained since xx/xx/xx, nominated
for removal xx/xx/xx if unclaimed"

..where the second date is, say, 3+ months after the warning goes in.
Then people can nominate stuff for removal with one liners and users
will get ample opportunity to complain.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
