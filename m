Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbRESToH>; Sat, 19 May 2001 15:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262173AbRESTn5>; Sat, 19 May 2001 15:43:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3596 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262083AbRESTnt>; Sat, 19 May 2001 15:43:49 -0400
Date: Sat, 19 May 2001 21:43:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending Device Number Registrants]
Message-ID: <20010519214321.A9550@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010519211717.A7961@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0105191231020.14472-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0105191231020.14472-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, May 19, 2001 at 12:35:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, if we did something like modify(int fd, char *how), you could do
> > 
> > modify(0, "nonblock,9600") 
> 
> What you're really proposing is to make ioctl's be ASCII strings.

Yup.

> Which is not necessarily a bad idea, and I think plan9 did something
> similar (or rather, if I remember correctly, plan9 has control streams
> that were ASCII. Or am I confused?).

I think that plan9 uses something different -- they have ttyS0 and
ttyS0ctl. This would leave us with problem "how do I get handle to
ttyS0ctl when I only have handle to ttyS0"?

...

> However, you can't really use a string. It would really have to be two
> memory regions: incoming and outgoing, with an ASCII representation being
> the _preferred_ method for stuff that isn't obviously structured or
> performance-critical.

What are cases where it is usefull to pass data back from kernel?
...aha, serial controls include possibility to read stuff, right?

								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
