Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271882AbRIIEaM>; Sun, 9 Sep 2001 00:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271881AbRIIEaD>; Sun, 9 Sep 2001 00:30:03 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:4087 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271884AbRIIE3u>; Sun, 9 Sep 2001 00:29:50 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Sat, 8 Sep 2001 22:29:24 -0600
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010908222923.H32553@turbolinux.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010909053015.L11329@athlon.random> <Pine.LNX.4.33.0109082051040.1161-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109082051040.1161-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 08, 2001  20:58 -0700, Linus Torvalds wrote:
> On Sun, 9 Sep 2001, Andrea Arcangeli wrote:
> > I wish the cache coherency logic would be simpler but just doing
> > something unconditionally it's going to break things in one way or
> > another as far I can tell.
> 
> I'd rather fix that, then.
> 
> Otherwise we'll just end up carrying broken baggage around forever. Which
> is not the way to do things.
> 
> Anyway, at this point this definitely sounds like a 2.5.x patch. Which I
> always pretty much assumed it would be anyway.

So basically - when we move block devices to the page cache, get rid of
buffer cache usage in the filesystems as well?  Ext2 is nearly there at
least.  One alternative is as Daniel Phillips did in the indexed-ext2-
directory patch, where he kept the "bread" interface, but backed it
with the page cache, so it required relatively little change to the
filesystem.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

