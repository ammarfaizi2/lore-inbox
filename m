Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277071AbRJDBmg>; Wed, 3 Oct 2001 21:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277072AbRJDBmZ>; Wed, 3 Oct 2001 21:42:25 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:1209 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S277071AbRJDBmP>;
	Wed, 3 Oct 2001 21:42:15 -0400
Date: Wed, 3 Oct 2001 21:39:50 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: <kuznet@ms2.inr.ac.ru>, <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
        <Robert.Olsson@data.slu.se>, <netdev@oss.sgi.com>,
        <torvalds@transmeta.com>, <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <20011003213010.F3780@redhat.com>
Message-ID: <Pine.GSO.4.30.0110032130370.8016-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Benjamin LaHaise wrote:

> On Wed, Oct 03, 2001 at 09:10:10PM -0400, jamal wrote:
> > > Well, this sounds like a 2.5 patch.  When do we get to merge it?
> >
> >
> > It is backward compatible to 2.4 netif_rx() which means it can go in now.
> > The problem is netdrivers that want to use the interface have to be
> > morphed.
>
> I'm alluding to the fact that we need a place to put in-development patches.
>

Sorry ;-> Yes, where is is 2.5 again? ;->

> > As a general disclaimer, i really dont mean to put down Ingo's efforts i
> > just think the irq mitigation idea as is now is wrong for both 2.4 and 2.5
>
> What is your solution to the problem?  Leaving it up to the driver authors
> doesn't work as they're not perfect.  Yes, drivers should attempt to do a
> good job at irq mitigation, but sometimes a safety net is needed.
>

To be honest i am getting a little nervous with what i saw in something
that seems to be a stable kernel. I was nervous  when i saw ksoftirq, but
its already in there. I think we can use the ksoftirq replacement pending
testing to show if latency is improved. I have time this weekend, if that
patch can be isolated it can be tested with NAPI etc.
As for the irq mitigation, in its current form it is insufficient; but
would be OK to go into 2.5 with plans to go and implement the isolation
feature. I would put NAPI into this same category. We can then backport
both back to 2.4.
With current 2.4, i say yes, we leave it to the drivers (and infact claim
we have a sustainable solution if conformed to)

cheers,
jamal

