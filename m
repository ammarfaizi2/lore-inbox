Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVBKGnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVBKGnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 01:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVBKGnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 01:43:11 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:4259 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262156AbVBKGnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 01:43:02 -0500
Subject: Re: 2.6.11-rc3-mm2
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       rlrevell@joe-job.com, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <420C51DF.3000707@bigpond.net.au>
References: <200502110341.j1B3fS8o017685@localhost.localdomain>
	 <1108098286.5098.41.camel@npiggin-nld.site>
	 <420C51DF.3000707@bigpond.net.au>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 17:42:53 +1100
Message-Id: <1108104173.5098.49.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 17:34 +1100, Peter Williams wrote:
> Nick Piggin wrote:

> > I can't say much about it because I'm not putting my hand up to
> > do anything. Just mentioning that rlimit would be better if not
> > for the userspace side of the equation. I think most were already
> > agreed on that point anyway though.
> 
> I think that the rlimits are a good idea in themselves but not as a 
> solution to this problem.  I.e. having a RT CPU rate rlimit should not 
> be a sufficient (or necessary for that matter) condition to change 
> policy to SCHED_OTHER or SCHED_RR but could still be used to limit the 
> possibility of lock out.

Ah well that may be a good way to do it indeed. As I said, I
don't know much about privileges etc.

But I just want to be clear that I'm not trying to stop RT-LSM
going in (if only because I don't care one way or the other
about it).

>   (But I guess even that is a violation of RT 
> semantics?)
> 

I'd have to re-read the standard, but it may not be. For example,
a compliant system advertises the minimum and maximum priority
levels available - you may be able to adjust these based on what
the rlimit is set to. On the other hand, yes it may violate the
stanards.

Nick



