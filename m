Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132579AbRAIXK1>; Tue, 9 Jan 2001 18:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132578AbRAIXKW>; Tue, 9 Jan 2001 18:10:22 -0500
Received: from anime.net ([63.172.78.150]:32521 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S132575AbRAIXKM>;
	Tue, 9 Jan 2001 18:10:12 -0500
Date: Tue, 9 Jan 2001 15:11:34 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Ingo Molnar <mingo@elte.hu>
cc: "David S. Miller" <davem@redhat.com>, <stephenl@zeus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.30.0101092358000.9990-100000@e2>
Message-ID: <Pine.LNX.4.30.0101091504520.7403-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Ingo Molnar wrote:
> On Tue, 9 Jan 2001, Dan Hollis wrote:
> > > This is not what senfile() does, it sends (to a network socket) a
> > > file (from the page cache), nothing more.
> > Ok in any case, it would be nice to have a generic sendfile() which works
> > on any fd's - socket or otherwise.
> it's a bad name in that case. We dont 'send any file' if we in fact are
> receiving a data stream from a socket and writing it into a file :-)

So we should have different system calls just so one can handle socket
and one can handle disk fd? :P

Ok so now will have special case sendfile() for each different kind of
fd's.

To connect socket-socket we can call it electrician() and to connect
pipe-pipe we can call it plumber() [1].

:P :b :P :b

-Dan

[1] Yes, Alex Belits, I know i've now stolen your joke...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
