Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135704AbRDSU4T>; Thu, 19 Apr 2001 16:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135709AbRDSUzi>; Thu, 19 Apr 2001 16:55:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:775 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135714AbRDSUyl>; Thu, 19 Apr 2001 16:54:41 -0400
Date: Thu, 19 Apr 2001 13:54:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: light weight user level semaphores
In-Reply-To: <20010419224707.K682@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.31.0104191352041.1182-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Ingo Oeser wrote:

> On Thu, Apr 19, 2001 at 09:11:56AM -0700, Linus Torvalds wrote:
> > No, this is NOT what the UNIX dogmas are all about.
> >
> > When UNIX says "everything is a file", it really means that "everything is
> > a stream of bytes". Things like magic operations on file desciptors are
> > _anathema_ to UNIX. ioctl() is the worst wart of UNIX. Having magic
> > semantics of file descriptors is NOT Unix dogma at all, it is a horrible
> > corruption of the original UNIX cleanlyness.
>
> Right. And on semaphores, this stream is exactly 0 bytes long.
> This is perfectly normal and can be handled by all applications
> I'm aware of.

It's perfectly normal, but it does NOT conform to the idea "everything is
a file".

The fact that there are other ugly examples (ioctls and special files)
does not mean that adding a new one is a good idea.

When people say "everything is a file", they mean that it can be _used_ as
a file, not that it can passably return a valid error code.

		Linus

