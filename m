Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277060AbRJDBMt>; Wed, 3 Oct 2001 21:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277061AbRJDBMj>; Wed, 3 Oct 2001 21:12:39 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:61624 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S277060AbRJDBMc>;
	Wed, 3 Oct 2001 21:12:32 -0400
Date: Wed, 3 Oct 2001 21:10:10 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: <kuznet@ms2.inr.ac.ru>, <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
        <Robert.Olsson@data.slu.se>, <netdev@oss.sgi.com>,
        <torvalds@transmeta.com>, <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <20011003150355.A3780@redhat.com>
Message-ID: <Pine.GSO.4.30.0110032105150.8016-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Benjamin LaHaise wrote:

> On Wed, Oct 03, 2001 at 08:53:58PM +0400, kuznet@ms2.inr.ac.ru wrote:
> > Citing my old explanation:
> >
> > >"Polling" is not a real polling in fact, it just accepts irqs as
> > >events waking rx softirq with blocking subsequent irqs.
> > >Actual receive happens at softirq.
> > >
> > >Seems, this approach solves the worst half of livelock problem completely:
> > >irqs are throttled and tuned to load automatically.
> > >Well, and drivers become cleaner.
>
> Well, this sounds like a 2.5 patch.  When do we get to merge it?


It is backward compatible to 2.4 netif_rx() which means it can go in now.
The problem is netdrivers that want to use the interface have to be
morphed.
As a general disclaimer, i really dont mean to put down Ingo's efforts i
just think the irq mitigation idea as is now is wrong for both 2.4 and 2.5

cheers,
jamal

