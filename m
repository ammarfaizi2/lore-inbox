Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268882AbRG0Q0K>; Fri, 27 Jul 2001 12:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268879AbRG0QZt>; Fri, 27 Jul 2001 12:25:49 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:7941 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268883AbRG0QZl>; Fri, 27 Jul 2001 12:25:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Date: Fri, 27 Jul 2001 18:30:22 +0200
X-Mailer: KMail [version 1.2]
Cc: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107271706460G.00285@starship> <3B6189E2.77F072DD@namesys.com>
In-Reply-To: <3B6189E2.77F072DD@namesys.com>
MIME-Version: 1.0
Message-Id: <0107271830220J.00285@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday 27 July 2001 17:33, Hans Reiser wrote:
> Daniel Phillips wrote:
> > On Friday 27 July 2001 16:18, Joshua Schmidlkofer wrote:
> > > I've almost quit using reiser, because everytime I have a power
> > > outage, the last 2 or three files that I've editted, even ones
> > > that I haven't touched in a while, will usually be hopelessly
> > > corrupted.
> >
> > My early flush patch will fix this, or at least it will if I get
> > together with the ReiserFS guys and figure out how to integrate
> > their flushing mechanism with the standard bdflush.  Or they could
> > incorporate the ideas from my early flush in their own flush
> > daemon, though generalizing the standard flush would have more
> > value in the long run.
>
> Can you describe early flush?

The idea is to do what amounts to a sync within a tenth of a second of 
disk bandwidth usage falling below a certain threshhold.

The original posts/patches are here:

    [RFC] Early flush (was: spindown)
    [RFC] Early flush: new, improved (updated)

and there are long threads attached to each of them.  The clearest 
explanation is probably Jonathan Corbet's writeup on lwn:

   http://lwn.net/2001/0628/kernel.php3

(Thanks, Jonathan, I often get the feeling I understand what I actually 
did only *after* reading your writeups:-)

The second of the two patches needs more work - I think I goofed on 
some needed "volatile" handling, see the current flam^H^H^H^H thread 
about that.

--
Daniel
