Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269782AbRHDEXi>; Sat, 4 Aug 2001 00:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269789AbRHDEXZ>; Sat, 4 Aug 2001 00:23:25 -0400
Received: from [63.209.4.196] ([63.209.4.196]:59920 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269782AbRHDEXP>; Sat, 4 Aug 2001 00:23:15 -0400
Date: Fri, 3 Aug 2001 21:20:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108040012020.14842-100000@touchme.toronto.redhat.com>
Message-ID: <Pine.LNX.4.33.0108032116130.25779-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 4 Aug 2001, Ben LaHaise wrote:
> On Fri, 3 Aug 2001, Linus Torvalds wrote:
>
> > For nicer interactive behaviour while flushing things out, the
> > inode_fsync() thing should really use "write_locked_buffers()". That's a
> > separate patch, though.
>
> Mildly better interactive performance, but absolutely horrid io
> throughput.  The system degrades to the point where blocks are getting
> flushed to disk at ~2MB/s vs the 80MB/s its capable of.  Not instrumented
> since I'm trying to actually relax.

That implies that we are trying to flush way too few buffers at a time and
do not get any overlapping IO.

Btw, how did you test this? Do you have a patch for inode_fsync() already?

		Linus

