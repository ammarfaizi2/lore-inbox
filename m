Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274701AbRITXjj>; Thu, 20 Sep 2001 19:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274706AbRITXjZ>; Thu, 20 Sep 2001 19:39:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9857 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274701AbRITXjD>;
	Thu, 20 Sep 2001 19:39:03 -0400
Date: Thu, 20 Sep 2001 19:39:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Peter Bornemann <eduard.epi@t-online.de>
cc: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: noexec-flag does not work in Linux 2.4.10-pre10
In-Reply-To: <Pine.LNX.4.33.0109210114430.3966-100000@eduard.t-online.de>
Message-ID: <Pine.GSO.4.21.0109201932220.5631-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Sep 2001, Peter Bornemann wrote:

> This is no problem for me but an inconvenience. If You see all
> the x-flags You believe in the executability (is that right?), moreover,
> as on my system executables are displayed in red colour, I feel my eyes
> are deceived to some extent.

Then you've never used noexec on normal filesystems (after all, _that_
is the intended use - prohibit execution of binaries from potentially
unsafe place, and in that case you are interested in all mode bits, so
you want them to be reported).  Try to remount some normal fs noexec
(_not_ one that contains mount(8), or you'll have really big trouble
on hands).  Then look at it - exec bits are still there and they
are still reported.

> But, as umask=111 works, I will switch to that.
> 
> Thanks a lot!
> 
> Peter B
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

