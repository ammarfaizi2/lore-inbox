Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281077AbRKDSVV>; Sun, 4 Nov 2001 13:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281056AbRKDSVM>; Sun, 4 Nov 2001 13:21:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3535 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281074AbRKDSVA>;
	Sun, 4 Nov 2001 13:21:00 -0500
Date: Sun, 4 Nov 2001 13:20:58 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] ramfs/tmpfs readdir()
In-Reply-To: <Pine.LNX.4.33.0111040943160.6919-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111041314330.21449-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, Linus Torvalds wrote:

> This is better than what we have, though, so I wouldn't object to the
> patch. I wonder why you export the internal dcache functions, though? The
> only thing that _should_ need exporting is "dcache_dir_ops", no? We don't
> want other filesystems mucking with the internals of this, as far as I can
> tell.

I would love to.  But autofs4 doesn't allow that, what with ioctls on
root directory...  It's the only place that uses individual functions,
though - the rest just uses dcache_dir_ops.

> Admittedly linear traversal is the _common_ case, and arguably the much
> more important of the two. However, right is right, and a true quality
> implementation gets seekdir/telldir right too.
> 
> Have you looked at how nasty the d_offset thing would be?

I'll look into that, but frankly, I'm not too optimistic.

