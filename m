Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSJNS2L>; Mon, 14 Oct 2002 14:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262049AbSJNS2L>; Mon, 14 Oct 2002 14:28:11 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52636 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262038AbSJNS2K>;
	Mon, 14 Oct 2002 14:28:10 -0400
Date: Mon, 14 Oct 2002 14:34:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Derrick J Brashear <shadow@dementia.org>
cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: AFS system call registration function (was Re: Two fixes
 for 2.4.19-pre5-ac3)
In-Reply-To: <Pine.LNX.4.44L-027.0210141405590.18909-100000@trafford.andrew.cmu.edu>
Message-ID: <Pine.GSO.4.21.0210141427410.6505-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Oct 2002, Derrick J Brashear wrote:

> Incidentally, nothing in the kernel source tree provides an example
> "explanation of the usage of nfsservctl"; I'll be happy to work out the
> new interface and provide appropriate information, but is there some place
> in particular such things end up being documented? I'm not averse to
> submitting information to go in /Documentation but it doesn't appear
> there's precedent for that.

Notice that in 2.5 (and that's backportable to 2.4 - I'll do that after
Oct 31) nfsservctl() is a trivial wrapper around open/write/read/close.
IOW, mountd and friends could stop using that syscall - all functionality
is available for userland without it.

See fs/nfsctl.c and fs/nfsd/nfsctl.c for example of doing that.

What things are done by afs_syscall()?  If you are passing some requests
to the afs driver - just tell what these requests are, writing that
stuff is a matter of an hour...

