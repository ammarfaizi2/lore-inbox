Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262133AbRETSrW>; Sun, 20 May 2001 14:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262135AbRETSrM>; Sun, 20 May 2001 14:47:12 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:17165 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262133AbRETSrF>; Sun, 20 May 2001 14:47:05 -0400
Date: Sun, 20 May 2001 11:46:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Matthew Wilcox <matthew@wil.cx>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <20010520112351.A32544@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0105201144580.7553-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 May 2001, Russell King wrote:
>
> On Sat, May 19, 2001 at 08:26:20PM -0700, Linus Torvalds wrote:
> > You're missing the point.
> 
> I don't think Richard is actually.  I think Richard has hit a nail
> dead on its head.
> 
> > It's ok to do "read()/write()" on structures.
> 
> Ok, we can read()/write() structures.  So someone invents the following
> structure:
> 
> 	struct foo {
> 		int cmd;
> 		void *data;
> 	} foo;
> 
> Now they use write(fd, &foo, sizeof(foo)); Haven't they just swapped
> the ioctl() interface for write() instead?

Wrong.

Nobody will expect the above to work, and everybody will agree that the
above is a BUG if the read() call will actually follow the pointer.

Read my email. And read the last line: "psychology is important".

Step #1 in programming: understand people.

		Linus

