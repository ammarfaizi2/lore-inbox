Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269257AbRHGSYJ>; Tue, 7 Aug 2001 14:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269255AbRHGSX7>; Tue, 7 Aug 2001 14:23:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:19096 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269274AbRHGSXu>;
	Tue, 7 Aug 2001 14:23:50 -0400
Date: Tue, 7 Aug 2001 14:23:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108071811.f77IBqq06242@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0108071419470.18565-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001, Richard Gooch wrote:

> OK, I've implemented variant 2. Everything looked OK, but then I
> noticed that pwd no longer works in subdirectories in devfs. Sigh.

Very interesting. pwd should be using getcwd(2), which doesn't
give a damn for inode numbers. If you have seriously old pwd binary
that tries to track the thing down to root by hands - yes, it doesn't
work.

> I'll have to get back to it tonight and track this one down. How
> annoying. Still, it was satisfying to rip out the table code.
> 
> BTW: I'm not bothering to update atime in the symlink methods. It's
> not important anyway. And if you get you VFS change in, then it should
> just magically save atimes for symlinks again, right?

Yes.

