Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFJiO>; Wed, 6 Dec 2000 04:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130000AbQLFJiF>; Wed, 6 Dec 2000 04:38:05 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10743 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129183AbQLFJhx>;
	Wed, 6 Dec 2000 04:37:53 -0500
Date: Wed, 6 Dec 2000 04:07:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test12-pre6
In-Reply-To: <Pine.LNX.4.21.0012060854090.1044-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0012060356290.14974-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2000, Tigran Aivazian wrote:

> On Wed, 6 Dec 2000, Tigran Aivazian wrote:
> >  	error = -EPERM;
> >  	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
> >  		goto dput_and_out;
> 
> also, while we are here -- are you sure that EPERM is a good idea for
> IS_IMMUTABLE(inode)? Other parts of Linux return EACCES in this
> case. Maybe it would be more consistent to do EACCES here too? This would
> simply mean remove IS_IMMUTABLE() from the above if because
> vfs_permission() does return -EACCES if we ask MAY_WRITE for IS_IMMUTABLE
> inode.
> 
> Since, the SuSv2 standard is silent on the issue of immutable files (they
> are Linux-specific) then it may make sense to be consistent?

They are not Linux-specific (check where they came from), so I would rather
check 4.4BSD and SuSv2[1] be damned. I'll look it up tomorrow, right now I'm
going down. Sorry.

[1] gotta love the CaPiTaLi2aTi0n, BTW.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
