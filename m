Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSEYD1G>; Fri, 24 May 2002 23:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSEYD1F>; Fri, 24 May 2002 23:27:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21775 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313305AbSEYD1F>; Fri, 24 May 2002 23:27:05 -0400
Date: Fri, 24 May 2002 20:25:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Karim Yaghmour <karim@opersys.com>
cc: Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <3CEF0157.ACF6518E@opersys.com>
Message-ID: <Pine.LNX.4.44.0205242020010.4051-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Karim Yaghmour wrote:
>
> > The RT part of an app under RTLinux has to be a kernel module anyway,
>
> This is incorrect, see below.

This is _correct_.

The fact that under RTAI it isn't the case does not change the fact that
under RTLinux it _is_.

> I'm sorry, but I'm missing the point here about visualization tools.
> Such tools are not part of any of the real-time Linux community's
> concerns.

With RTLinux, you have to split the app up into the "hard realtime" part
(which ends up being in kernel space) and the "rest".

Which is, in my opinion, the only sane way to handle hard realtime. No
confusion about priority inversions, no crap. Clear borders between what
is "has to happen _now_" and "this can do with the regular soft realtime".

Your claim was that RTLinux made realtime hard to do with licensing
concerns. MY claim is that if you actually were to use RTLinux, you
wouldn't _have_ any licensing concerns: the kernel module would have to be
GPL (both because the kernel wants it that way _and_ because you get the
liences to the patent that way), and the user-level code that uses
whatever data the RT module produces is no longer hard realtime at all.

Clean separation, both from a license standpoint _and_ from a purely
technical standpoint.

		Linus


