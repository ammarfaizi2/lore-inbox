Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282993AbRLQXMw>; Mon, 17 Dec 2001 18:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283012AbRLQXMm>; Mon, 17 Dec 2001 18:12:42 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:31759 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282993AbRLQXMe>; Mon, 17 Dec 2001 18:12:34 -0500
Date: Mon, 17 Dec 2001 15:15:15 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112171449520.1854-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0112171508330.1577-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Linus Torvalds wrote:

>
> On Mon, 17 Dec 2001, Davide Libenzi wrote:
>
> > On Sat, 15 Dec 2001, Linus Torvalds wrote:
> >
> > > I just don't find it very interesting. The scheduler is about 100 lines
> > > out of however-many-million (3.8 at least count), and doesn't even impact
> > > most normal performace very much.
> >
> > Linus, sharing queue and lock between CPUs for a "thing" highly frequency
> > ( schedule()s + wakeup()s ) accessed like the scheduler it's quite ugly
> > and it's not that much funny. And it's not only performance wise, it's
> > more design wise.
>
> "Design wise" is highly overrated.
>
> Simplicity is _much_ more important, if something commonly is only done a
> few hundred times a second. Locking overhead is basically zero for that
> case.

Few hundred is a nice definition because you can basically range from 0 to
infinite. Anyway i agree that we can spend days debating about what this
"few hundred" translate to, and i do not really want to.


> 4 cpu's are "high end" today. We can probably point to tens of thousands
> of UP machines for each 4-way out there. The ratio gets even worse for 8,
> and 16 CPU's is basically a rounding error.
>
> You have to prioritize. Scheduling overhead is way down the list.

You don't really have to serialize/prioritize, old Latins used to say
"Divide Et Impera" ;)




- Davide


