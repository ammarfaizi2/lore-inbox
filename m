Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293041AbSCFCBj>; Tue, 5 Mar 2002 21:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293046AbSCFCBZ>; Tue, 5 Mar 2002 21:01:25 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:8459 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293041AbSCFCAR>; Tue, 5 Mar 2002 21:00:17 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 5 Mar 2002 18:03:46 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: <E16iQVe-0005ss-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0203051803030.1475-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0203051433400.1475-100000@blue1.dev.mcafeelabs.com> y
> ou write:
> > On Tue, 5 Mar 2002, Rusty Russell wrote:
> >
> > > +	pos_in_page = ((unsigned long)uaddr) % PAGE_SIZE;
> > > +
> > > +	/* Must be "naturally" aligned, and not on page boundary. */
> > > +	if ((pos_in_page % __alignof__(atomic_t)) != 0
> > > +	    || pos_in_page + sizeof(atomic_t) > PAGE_SIZE)
> > > +		return -EINVAL;
> >
> > How can this :
> >
> > 	(pos_in_page % __alignof__(atomic_t)) != 0
> >
> > to be false, and together this :
> >
> > 	pos_in_page + sizeof(atomic_t) > PAGE_SIZE
> >
> > to be true ?
>
> You're assuming that __alignof__(atomic_t) = N * sizeof(atomic_t),
> where N is an integer.
>
> If alignof == 1, and sizeof == 4, you lose.  I prefer to be
> future-proof.
>
> This means I should clarify the comment...

No i should do less things at a time :-(



- Davide


