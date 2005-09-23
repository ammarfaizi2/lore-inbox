Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVIWJRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVIWJRr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 05:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVIWJRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 05:17:47 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:15045 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750834AbVIWJRq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 05:17:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NXecxcNEYHCecvz/AHFGDbsNwXGkjjrr2rw9feICu7lmleM7wVVuVyWKpEPLIQLDm0ragXHpZfDGCZR2CavSWMnf+y2MZ3cFlI4MLVssWCbtlZZOsCaPevF2fHAplmFACUECLUbELeN5eQQOoldV+wrpPETqH2uMR4i6qpE40Ng=
Message-ID: <2cd57c9005092302174e0f657e@mail.gmail.com>
Date: Fri, 23 Sep 2005 17:17:44 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: making kmalloc BUG() might not be a good idea
Cc: "David S. Miller" <davem@davemloft.net>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, clameter@engr.sgi.com
In-Reply-To: <4333C4F4.9030402@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4333A109.2000908@yahoo.com.au>
	 <200509230909.54046.ioe-lkml@rameria.de>
	 <4333B588.9060503@yahoo.com.au>
	 <20050923.010939.11256142.davem@davemloft.net>
	 <4333C4F4.9030402@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/05, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> David S. Miller wrote:
> > From: Nick Piggin <nickpiggin@yahoo.com.au>
> > Date: Fri, 23 Sep 2005 17:58:00 +1000
> >
>
> > If we know how to make certain classes of bugs non-lethal, we should
> > do so because there will always be bugs. :-)  This change makes
> > previously non-lethal bugs potentially kill the machine.
> >
>
> Oh the BUG is bad, sure. I just thought WARN would be a better _compromise_
> than BUG in that it will achieve the same result without takeing the machine
> down.
>
> I think the CONFIG_DEBUG options are there for some major types of debugging
> that require significant infrastructure or can slow down the kernel quite
> a lot. With that said, I think there is an option somewhere to turn off all
> WARNs and remove strings from all BUGs.
>
> Regarding proliferation of assertions and warnings everywhere - without any
> official standard, I think we're mostly being sensible with them (at least
> in the core code that I look at). A warn in kmalloc for this wouldn't be
> anything radical.
>
> I don't much care for it, but I agree the BUG has to go.
>

Nice to see: + revert-oversized-kmalloc-check.patch added to -mm tree
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
