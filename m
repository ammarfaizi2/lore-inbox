Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288903AbSAIGda>; Wed, 9 Jan 2002 01:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288900AbSAIGdL>; Wed, 9 Jan 2002 01:33:11 -0500
Received: from dsl-213-023-043-044.arcor-ip.net ([213.23.43.44]:11276 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288905AbSAIGdA>;
	Wed, 9 Jan 2002 01:33:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Luigi Genoni <kernel@Expansa.sns.it>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Wed, 9 Jan 2002 07:36:16 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
In-Reply-To: <Pine.LNX.4.33.0201090018440.1185-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.33.0201090018440.1185-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16OCLQ-0000CO-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 9, 2002 12:26 am, Luigi Genoni wrote:
> On Tue, 8 Jan 2002, Daniel Phillips wrote:
> 
> > On January 8, 2002 08:47 pm, Andrew Morton wrote:
> > > Daniel Phillips wrote:
> > > > What a preemptible kernel can do that a non-preemptible kernel can't 
is:
> > > > reschedule exactly as often as necessary, instead of having lots of 
extra
> > > > schedule points inserted all over the place, firing when *they* think 
the
> > > > time is right, which may well be earlier than necessary.
> > >
> > > Nope.  `if (current->need_resched)' -> the time is right (beyond right,
> > > actually).
> >
> > Oops, sorry, right.
> >
> > The preemptible kernel can reschedule, on average, sooner than the
> > scheduling-point kernel, which has to wait for a scheduling point to roll
> > around.
>
> mmhhh. At which cost? And then anyway if I have a spinlock, I still have
> to wait for a scheduling point to roll around.

Did you read the thread?  Think about the relative amount of time spent in
spinlocks vs the amount of time spent in the regular kernel.

--
Daniel
