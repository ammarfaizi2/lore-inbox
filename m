Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTBKC5j>; Mon, 10 Feb 2003 21:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbTBKC5j>; Mon, 10 Feb 2003 21:57:39 -0500
Received: from 12-252-67-253.client.attbi.com ([12.252.67.253]:23965 "EHLO
	morningstar.nowhere.lie") by vger.kernel.org with ESMTP
	id <S265863AbTBKC5i>; Mon, 10 Feb 2003 21:57:38 -0500
From: "John W. M. Stevens" <john@betelgeuse.us>
Date: Mon, 10 Feb 2003 20:06:25 -0700
To: Mark G <mark@nolab.conman.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Object system in Linux kernel?
Message-ID: <20030211030625.GA25474@morningstar.nowhere.lie>
References: <Pine.BSO.4.44.0302102126580.26851-100000@kwalitee.nolab.conman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.44.0302102126580.26851-100000@kwalitee.nolab.conman.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 09:28:16PM -0500, Mark G wrote:
> I saw your post to linux-kernel about wanting setjmp/longjmp for adding an
> OO infrastructure.

Having already developed the infrastructure, we had some "bits and
pieces" that we (me and my team) thought that the Linux development
team might find useful, including:

1) setjmp/longjmp
2) Atomic pointer swap with locking.
3) Atomic integer increment.
3) Atomic integer decrement.

for the PA-RISC, Itanium2 and IA32 architechtures.

I was not actually offering our OO Infrastructure to the Linux
development team, for what are probably obvious reasons by now.

But I thought that they might be interested  in the above list of
funtions.

I offered, the offer was rejected, and I consider the discussion closed.

> I have actually developed several OO "cores" -- is this
> something you wrote?

Myself, interacting with several team members who used this
infrastructure to write a USB bus driver, and some class
drivers.

> If you ever want to talk about designs, let me know...

I am interested in what solutions you've developed for solving the
interaction of exceptions and resources.  We developed three
different solutions, profiled, and chose the best of the three,
but I'm curious as to how other people might have solved this issue.

Our infrastructure supports Hot Patch, Package and Extension
Design patterns, among others.  What design patterns, in your
opinion, do you think are "required" for embedded/kernel
development?

Also, what is your take on support for messaging and true
polymorphism?  The C++ "nick-naming" thing just doesn't work in
a dynamic system, to say nothing of the much more serious issues
raised by constraining the abstract type system by the concrete type
of an object (shudder!).

Making those two things orthogonal was enough, all by itself, to
reduce the prospective inheritance depth of the driver from 18
to between 3 and 5 levels.

Thanks,
John S.
