Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262147AbRETTL3>; Sun, 20 May 2001 15:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262148AbRETTLS>; Sun, 20 May 2001 15:11:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:40717 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262146AbRETTLF>; Sun, 20 May 2001 15:11:05 -0400
Date: Sun, 20 May 2001 12:10:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Matthew Wilcox <matthew@wil.cx>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <20010520195751.B1143@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0105201208360.7553-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 May 2001, Russell King wrote:
>
> On Sun, May 20, 2001 at 11:46:33AM -0700, Linus Torvalds wrote:
> > Nobody will expect the above to work, and everybody will agree that the
> > above is a BUG if the read() call will actually follow the pointer.
> 
> I didn't say anything about read().  I said write().  Obviously it
> wouldn't work for read()!

No, but the point is, everybody _would_ consider it a bug if a
low-level driver "write()" did anything but touched the explicit buffer.

Code like that would not pass through anybody's yuck-o-meter. People would
point fingers and say "That is not a legal write() function". Anybody who
tried to make write() follow pointers would be laughed at as a stupid git.

Anybody who makes "ioctl()" do the same is just following years of
standard practice, and the yuck-o-meter doesn't even register.

THAT is the importance of psychology.

Technology is meaningless. What matters is how people _think_ of it.

		Linus

