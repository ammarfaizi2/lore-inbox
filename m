Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRCUBV4>; Tue, 20 Mar 2001 20:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129478AbRCUBVt>; Tue, 20 Mar 2001 20:21:49 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:17924 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S129460AbRCUBVh>; Tue, 20 Mar 2001 20:21:37 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Serge Orlov <sorlov@con.mcst.ru>, <linux-kernel@vger.kernel.org>,
        Jakob Østergaard <jakob@unthought.net>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Linus Torvalds's message of "Tue, 20 Mar 2001 10:43:33 -0800 (PST)"
Date: 20 Mar 2001 19:20:28 -0600
Message-ID: <vba1yrr7w9v.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> 
> Cool. Somebody actually found a real case.
> 
> I'll fix the mmap case asap. Its' not hard, I just waited to see if it
> ever actually triggers. Something like g++ certainly counts as major.

I frequently build Mozilla from scratch on my (aging) dual Celeron
machine.  That's about 65 megs of actual C++ source, and it takes
about an hour of real time to compile.  I see times for the whole
build like this:

    real    60m4.574s
    user    101m18.260s
    sys     3m23.520s

with gcc 2.95.2 20000220 (Debian GNU/Linux) under Linux 2.4.2.

The sys-to-user ratio seems much closer to Serge's 2.2.13 numbers than
his 2.4.2 numbers, and I'm wondering why.

If I recall correctly, RedHat's 2.96 was a modified development
snapshot of GCC 3.0, not an official GCC release.  If this is just a
quirk in 2.96 that can be fixed before the official release of 3.0 by
a trivial patch to libiberty, maybe your original hunch was right and
the kernel should be left as-is.

> Are you willing to test out patches?

I'm willing to help test out the patch; I'd be curious to see what
effect it has on the performance of 2.95.2.

Kevin <buhr@stat.wisc.edu>
