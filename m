Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135936AbRDZVQm>; Thu, 26 Apr 2001 17:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135935AbRDZVQS>; Thu, 26 Apr 2001 17:16:18 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:29514 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135939AbRDZVQM>; Thu, 26 Apr 2001 17:16:12 -0400
Date: Thu, 26 Apr 2001 23:16:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010426231603.A21873@athlon.random>
In-Reply-To: <20010426221109.E819@athlon.random> <Pine.LNX.4.31.0104261325220.1118-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0104261325220.1118-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Apr 26, 2001 at 01:26:15PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 01:26:15PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 26 Apr 2001, Andrea Arcangeli wrote:
> >
> > What I'm saying above is that even without the wait_on_buffer ext2 can
> > screwup itself because the splice happens after the buffer are just all
> > uptodate so any "reader" (I mean any reader through ext2 not through
> > block_dev) will never try to do a bread on that blocks before they're
> > just zeroed and uptodate.
> 
> I assume you meant "..can _not_ screw up itself..", otherwise the rest of

yes, it was a typo sorry.

Andrea
