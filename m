Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288558AbSAHX0t>; Tue, 8 Jan 2002 18:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSAHX0k>; Tue, 8 Jan 2002 18:26:40 -0500
Received: from Expansa.sns.it ([192.167.206.189]:3339 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S288558AbSAHX01>;
	Tue, 8 Jan 2002 18:26:27 -0500
Date: Wed, 9 Jan 2002 00:26:00 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16O3L5-0000B8-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0201090018440.1185-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jan 2002, Daniel Phillips wrote:

> On January 8, 2002 08:47 pm, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > > What a preemptible kernel can do that a non-preemptible kernel can't is:
> > > reschedule exactly as often as necessary, instead of having lots of extra
> > > schedule points inserted all over the place, firing when *they* think the
> > > time is right, which may well be earlier than necessary.
> >
> > Nope.  `if (current->need_resched)' -> the time is right (beyond right,
> > actually).
>
> Oops, sorry, right.
>
> The preemptible kernel can reschedule, on average, sooner than the
> scheduling-point kernel, which has to wait for a scheduling point to roll
> around.
>
mmhhh. At which cost? And then anyway if I have a spinlock, I still have
to wait for a scheduling point to roll around.



