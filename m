Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262537AbREZCAU>; Fri, 25 May 2001 22:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262535AbREZCAL>; Fri, 25 May 2001 22:00:11 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28722 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262531AbREZCAG>; Fri, 25 May 2001 22:00:06 -0400
Date: Sat, 26 May 2001 03:59:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526035936.P9634@athlon.random>
In-Reply-To: <Pine.LNX.4.31.0105251826290.1126-100000@penguin.transmeta.com> <Pine.LNX.4.33.0105252138550.3806-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105252138550.3806-100000@toomuch.toronto.redhat.com>; from bcrl@redhat.com on Fri, May 25, 2001 at 09:39:36PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 09:39:36PM -0400, Ben LaHaise wrote:
> Sorry, this doesn't fix the problem.  It still hangs on highmem machines.
> Try running cerberus on a PAE kernel sometime.

There can be more bugs of course, two patches I posted are only meant to
fix deadlocks in the allocation fail path of alloc_bounces() and the
second patch in getblk() allocation fail path, nothing more. Those are
strictly necessary fixes as far I can tell, and their implementation was
quite obviously right to my eyes.

Now if you send some debugging info with deadlocks you gets with 2.4.5
vanilla I will be certainly interested to found their source. Also Rik
just said to have a fix for other bugs in that area, I didn't checked
that part.

What I can say is that with my tree I didn't reproduced deadlocks
highmem related with cerberus but I'm using highmem emulation not real
highmem.

Andrea
