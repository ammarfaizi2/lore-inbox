Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274145AbRI0Xhf>; Thu, 27 Sep 2001 19:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274134AbRI0XhY>; Thu, 27 Sep 2001 19:37:24 -0400
Received: from [195.223.140.107] ([195.223.140.107]:13052 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274133AbRI0XhO>;
	Thu, 27 Sep 2001 19:37:14 -0400
Date: Fri, 28 Sep 2001 01:37:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Macaulay <robert_macaulay@dell.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)]
Message-ID: <20010928013730.Y14277@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109271605550.25667-100000@penguin.transmeta.com> <Pine.LNX.4.33.0109271618120.25667-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109271618120.25667-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Sep 27, 2001 at 04:18:58PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 04:18:58PM -0700, Linus Torvalds wrote:
> 
> On Thu, 27 Sep 2001, Linus Torvalds wrote:
> >
> > Thinking about it, I think GFP_NOIO also implies "we must not wait for
> > other buffers", because that could deadlock for _other_ things too, like
> > loop and NBD (which use NOIO to make sure that they don't recurse - but
> > that should also imply not waiting for themselves). The GFP_xxx approach
> > should fix those deadlocks too.
> 
> Ie the patch would be something like the attached..

well this approch is much less finegrined... but yes, it would fix the
deadlock.

Andrea
