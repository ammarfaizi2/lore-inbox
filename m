Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVEaKS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVEaKS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 06:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVEaKS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 06:18:26 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:11282 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261629AbVEaKSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 06:18:20 -0400
Date: Tue, 31 May 2005 03:23:14 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: James Bruce <bruce@andrew.cmu.edu>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050531102314.GA11116@nietzsche.lynx.com>
References: <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <20050530222747.GB9972@nietzsche.lynx.com> <429BBC2D.70406@yahoo.com.au> <20050531020957.GA10814@nietzsche.lynx.com> <429C2A64.1040204@andrew.cmu.edu> <429C2F72.7060300@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C2F72.7060300@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 07:33:38PM +1000, Nick Piggin wrote:
> James Bruce wrote:
> >claims he's made, but I think a lot of people have read his posts too 
> >quickly and misinterpreted what he's claiming for the current patch. 
> >This includes people on both sides of the fence.  He's also been silent 
> >for much of this discussion as its gotten out of hand, showing he's 
> >clearly wiser than all of us.
> 
> I have never been in any doubt as to the specific claims I have
> made. I continually have been talking about hard realtime from
> start to finish, and it appears that everyone now agrees with me
> that for hard-RT, a nanokernel solution is better or at least
> not obviously worse at this stage.

No, not true. That's large a myth created by dual kernel folks. The
scheduling and interrupt paths are highly optimized in Linux it's
unlikely that any other OS can really make it significantly better
in this area since the paths are branch hinted and cache sensitive.
This core logic is pretty much similar across most RTOSes.

> Ingo actually of course has been completely rational and honest
> the whole time - he actually emailed me to basically say "there
> will be pros and cons of both, and until things develop further
> I'm not completely sure".

There will be pro and cons of both, but in the end single kernel
aspects will win because app programmability issues. The dual kernel
boundary only exists because nobody took on the task of full kernel
preemptibility because of the broad amount of knowledge needed to
get the lock ordering correct as well as other concurrent conversions.

It's done now and dual kernel will have less of a strangle hold on
RT development in Linux. This will be inevitable as the technology
propagates.

> Which I was pretty satisfied with. Then along came the lynch mob.

The lynch mob is right. They have first hand experience with this
kind of work and understand the associated problem with this kind
of software development. This isn't some piecewise kernel hack that's
an easy tack on to the kernel, but a fundamentally different way
of looking at things. Understanding the concepts is mandatory here.

That's something that you're still not willing to learn which makes
discussions with you on the subject useless and pisses off the rest
of us.

bill

