Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261324AbRELWSY>; Sat, 12 May 2001 18:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbRELWSO>; Sat, 12 May 2001 18:18:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28658 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261324AbRELWSI>;
	Sat, 12 May 2001 18:18:08 -0400
Date: Sat, 12 May 2001 18:18:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: <200105122141.f4CLfH7G001009@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0105121817020.11973-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 May 2001, Andreas Dilger wrote:

> We could use the "buffer_uptodate" flag on the buffer to signal that
> the block has been checked.  AFAIK, a new buffer will not be uptodate,
> and once it is it will not be read from disk again...  However, if a
> user-space process read the buffer would also mark it uptodate without
> doing the check...  Maybe we should use a new BH_ pointer... Just need
> to factor out the ext2_check_page() code so that it works on a generic
> memory pointer and end pointer.

Or you could simply use ext2_get_page() and forget about this crap.

