Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288686AbSANCnz>; Sun, 13 Jan 2002 21:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288689AbSANCnq>; Sun, 13 Jan 2002 21:43:46 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:33296 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S288686AbSANCnf>; Sun, 13 Jan 2002 21:43:35 -0500
Date: Sun, 13 Jan 2002 18:49:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Manfred Spraul <manfred@colorfullife.com>, <mingo@elte.hu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: cross-cpu balancing with the new scheduler
In-Reply-To: <20020114131925.4fcbd127.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.40.0201131842570.937-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Rusty Russell wrote:

> On Sun, 13 Jan 2002 18:01:40 +0100
> Manfred Spraul <manfred@colorfullife.com> wrote:
>
> > Is it possible that the inter-cpu balancing is broken in 2.5.2-pre11?
> >
> > eatcpu is a simple cpu hog ("for(;;);"). Dual CPU i386.
> >
> > $nice -19 ./eatcpu&;
> >  <wait>
> > $nice -19 ./eatcpu&;
> >  <wait>
> > $./eatcpu&.
> >
> > IMHO it should be
> > * both niced process run on one cpu.
> > * the non-niced process runs with a 100% timeslice.
> >
> > But it's the other way around:
> > One niced process runs with 100%. The non-niced process with 50%, and
> > the second niced process with 50%.
>
> This could be fixed by making "nr_running" closer to a "priority sum".

I've a very simple phrase when QA is bugging me with these corner cases :

"As Designed"

It's much much better than adding code and "Return To QA" :-)
I tried priority balancing in BMQS but i still prefer "As Designed" ...




- Davide


