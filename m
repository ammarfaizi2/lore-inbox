Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261571AbSIXFdf>; Tue, 24 Sep 2002 01:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261572AbSIXFdf>; Tue, 24 Sep 2002 01:33:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8859 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261571AbSIXFde>;
	Tue, 24 Sep 2002 01:33:34 -0400
Date: Tue, 24 Sep 2002 07:47:14 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: jlnance@intrex.net, <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020924104030.0e53b95e.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0209240741270.8943-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Sep 2002, Rusty Russell wrote:

> > > Is this related to the thread library work that IBM was doing or was
> > > this independently developed?
> > 
> > independently developed.
> 
> And, ironically, using the futex implementation developed on IBM time 8).

you are right, futexes are really important for all the userspace locking
primitives and thread-joining. And like basically all core kernel code,
futexes were a collaborative effort as well:

 *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
 *  enough at me, Linus for the original (flawed) idea, Matthew
 *  Kirkwood for proof-of-concept implementation.

there are so many prerequisites to this that it's impossible to list them
all. What i meant above were the specific patches developed for recent 2.5
kernels, and the library itself.

	Ingo

