Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129400AbRA3T3d>; Tue, 30 Jan 2001 14:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRA3T3X>; Tue, 30 Jan 2001 14:29:23 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:54266 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129400AbRA3T3P>; Tue, 30 Jan 2001 14:29:15 -0500
Date: Tue, 30 Jan 2001 17:28:35 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: alex@foogod.com
cc: Alan Olsen <alan@clueserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Recommended swap for 2.4.x.
In-Reply-To: <20010130111359.C13819@draco.foogod.com>
Message-ID: <Pine.LNX.4.21.0101301719560.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001 alex@foogod.com wrote:
> On Tue, Jan 30, 2001 at 04:22:20PM -0200, Rik van Riel wrote:
> > At the moment there is no way to reclaim the swap space if
> > the page is shared, and for non-shared pages we haven't
> > implemented a way to reclaim swap space.
> > 
> > While reclaiming swap space when you run out is pretty
> > trivial to do, Linus doesn't seem to like the idea all
> > that much and Disk Space Is Cheap(tm) so it's not very
> > high on my list of things to do.
> 
> In general, I agree that Disk Space Is Cheap(tm)

I don't, in this case. I have proposed a scheme to reclaim
swap space and disk space is cheap was one of Linus' arguments
for rejecting the extra complexity of swap space reclaiming(IIRC).

That said, reclaiming swap space isn't very high on my priority
list since most people do have enough memory/swap anyway and
there are a few VM things to sort out that affect everybody, and
not just those unfortunate people who are short on memory and
swap.

Once I get some more time, however, I will make a patch to
reclaim swap space ... at least for non-shared pages.

> my primary concern is for migration of existing configurations.

This isn't a very big concern for me, though I must admit
that's mostly because I've never seen a production machine
use more than half of its swap space.  ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
