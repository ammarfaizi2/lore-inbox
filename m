Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262656AbREOG3H>; Tue, 15 May 2001 02:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbREOG26>; Tue, 15 May 2001 02:28:58 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:4883 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262652AbREOG2w>; Tue, 15 May 2001 02:28:52 -0400
Date: Mon, 14 May 2001 23:28:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <200105150620.f4F6KKd22491@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.21.0105142324140.23912-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Richard Gooch wrote:
> 
> However, what about simply invalidating an entry in the buffer cache
> when you do a write from the page cache?

And how do you do the invalidate the other way, pray tell?

What happens if you create a buffer cache entry? Does that invalidate the
page cache one? Or do you just allow invalidates one way, and not the
other? And why=

> Actually, I'd kind of like it if the page cache steals from the buffer
> cache on read. The buffer cache is mostly populated by fsck. Once I've
> done the fsck, those buffers are useless to me. They might be useful
> again if they are steal-able by the page cache.

Ehh.. And then you'll be unhappy _again_, when we early in 2.5.x start
using the page cache for block device accesses. Which we _have_ to do if
we want to be able to mmap block devices. Which we _do_ want to do (hint:
DVD's etc).

Face it. What you ask for is stupid and fundamentally unworkable. 

Tell me WHY you are completely ignoring my arguments, when I (a) tell you
why your way is bad and stupid (and when you ignore the arguments, don't
complain when I call you stupid) and (b) I give you alternate ways to do
the same thing, except my suggestion is _faster_ and has none of the
downside yours has.

WHY?

		Linus

