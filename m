Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288889AbSAIGXa>; Wed, 9 Jan 2002 01:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288876AbSAIGXV>; Wed, 9 Jan 2002 01:23:21 -0500
Received: from dsl-213-023-043-044.arcor-ip.net ([213.23.43.44]:4108 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288889AbSAIGXG>;
	Wed, 9 Jan 2002 01:23:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Luigi Genoni <kernel@Expansa.sns.it>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Wed, 9 Jan 2002 07:26:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, Anton Blanchard <anton@samba.org>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
In-Reply-To: <Pine.LNX.4.33.0201082351020.1185-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.33.0201082351020.1185-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16OCCE-0000CJ-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 9, 2002 12:02 am, Luigi Genoni wrote:
> On Tue, 8 Jan 2002, Daniel Phillips wrote:
> > On January 8, 2002 04:29 pm, Andrea Arcangeli wrote:
> > > but I just wanted to make clear that the
> > > idea that is floating around that preemptive kernel is all goodness is
> > > very far from reality, you get very low mean latency but at a price.
> >
> > A price lots of people are willing to pay
>
> Probably sometimes they are not making a good business.

Perhaps.  But they are happy customers and their music sounds better.

Note: the dominating cost of -preempt is not Robert's patch, but the fact 
that you need to have CONFIG_SMP enabled, even for uniprocessor, turning all 
those stub macros into real spinlocks.  For a dual processor you have to have 
this anyway and it just isn't an issue.

Personally, I don't intend to ever get another single-processor machine, 
except maybe a laptop, and that's only if Transmeta doesn't come up with a 
dual-processor laptop configuration.

> > By the way, have you measured the cost of -preempt in practice?
>
> Yes, I did a lot of tests, and with current preempt patch definitelly
> I was seeing a too big performance loss.

Was this on uniprocessor machines, or your dual Athlons?  How did you measure 
the performance?

--
Daniel
