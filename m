Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135990AbRAHSEp>; Mon, 8 Jan 2001 13:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136271AbRAHSEf>; Mon, 8 Jan 2001 13:04:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:22168 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135990AbRAHSE0>;
	Mon, 8 Jan 2001 13:04:26 -0500
Date: Mon, 8 Jan 2001 13:04:24 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Mohammad A. Haque" <mhaque@haque.net>, linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <20010108185518.G27646@athlon.random>
Message-ID: <Pine.GSO.4.21.0101081259230.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Andrea Arcangeli wrote:

> in userspace, but I think the old behaviour was more flexible (it was also
> showing how much our dcache is powerful) and I still don't see why it's been
> removed.  Maybe it was to remove a branch from a fast path? (if so I don't
> think it was a good idea, there are many more overhead things that matters more
> and that aren't even visible to userspace)

Racy. Nonportable. Has portable and simple equivalent. Again, don't
bother with chdir at all - if you know the name of directory even
../name will work. It's not about the current directory. It's about
the invalid last component of the name.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
