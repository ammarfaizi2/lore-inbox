Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132838AbRARV6K>; Thu, 18 Jan 2001 16:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132754AbRARV5v>; Thu, 18 Jan 2001 16:57:51 -0500
Received: from chiara.elte.hu ([157.181.150.200]:4868 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132838AbRARV5s>;
	Thu, 18 Jan 2001 16:57:48 -0500
Date: Thu, 18 Jan 2001 22:57:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <20010118225432.K28276@athlon.random>
Message-ID: <Pine.LNX.4.30.0101182254170.2880-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Jan 2001, Andrea Arcangeli wrote:

> > {
> >         int val = 1;
> >         setsockopt(req->sock, IPPROTO_TCP, TCP_CORK,
> > 			(char *)&val,sizeof(val));
> >         val = 0;
> >         setsockopt(req->sock, IPPROTO_TCP, TCP_CORK,
> > 			(char *)&val,sizeof(val));
> > }
> >
> > differ from what you posted. It does the same in my opinion. Maybe we are
> > not talking about the same thing?
>
> The above is equivalent to SIOCPUSH _only_ if the caller wasn't using either
> TCP_NODELAY or TCP_CORK.

why? I can restore whatever state i want, the above is just a mechanizm to
force the push.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
