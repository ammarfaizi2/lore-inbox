Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262762AbSJGUXg>; Mon, 7 Oct 2002 16:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262763AbSJGUXg>; Mon, 7 Oct 2002 16:23:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39178 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262762AbSJGUXf>; Mon, 7 Oct 2002 16:23:35 -0400
Date: Mon, 7 Oct 2002 13:28:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
 3.0 -  (NUMA))
In-Reply-To: <E17ye5U-0003ul-00@starship>
Message-ID: <Pine.LNX.4.33.0210071325260.10749-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Daniel Phillips wrote:
> 
> If that's a bet, I'll take you up on it.

Sure. The mey is:
 - we can more easily fix the f*cking filesystems to be sane
 - then trying to add prescient read-ahead to the kernel

In other words, trying to do an impossibly good job on read-ahead is 
_stupid_, when the real problem is that ext2 lays out files in total crap 
ways. 

> I did say difficult.  It really is, but there are big gains to be had.

But why do the horribly stupid thing, when Andrew has already shown that a
one-liner change to ext2/3 gives you platter speeds (and better speeds
than your approach _can_ get, since you still are going to end up seeking
a lot, even if you can make your read-ahead prescient).

In other words, you're overcompensating.

		Linus

