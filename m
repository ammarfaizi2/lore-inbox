Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbREZOeU>; Sat, 26 May 2001 10:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261355AbREZOeB>; Sat, 26 May 2001 10:34:01 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:777 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262659AbREZOdA>; Sat, 26 May 2001 10:33:00 -0400
Date: Sat, 26 May 2001 16:32:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526163233.U9634@athlon.random>
In-Reply-To: <20010526051156.S9634@athlon.random> <Pine.LNX.4.21.0105260137140.30264-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105260137140.30264-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sat, May 26, 2001 at 01:45:27AM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 01:45:27AM -0300, Rik van Riel wrote:
> 3) If the device driver needs to allocate something, it
>    has from zone->pages_min*3/4 down to zone->pages_min/4
>    space to allocate stuff, this should be very useful
>    for swap or mmap() over the network, or to encrypted
>    block devices, etc...

Anything supposed to work because there's enough memory between
zone->pages_min*3/4 and zone->pages_min/4 is just obviously broken
period.

> > Can you try to simply change NR_RESERVED to say 200*MAX_BUF_PER_PAGE
> > and see if it makes a difference?
> 
> No Comment(tm)   *grin*

I'm having lots of fun, thanks.

Andrea
