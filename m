Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280959AbRLAFPZ>; Sat, 1 Dec 2001 00:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283951AbRLAFPQ>; Sat, 1 Dec 2001 00:15:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:657 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280959AbRLAFPE>;
	Sat, 1 Dec 2001 00:15:04 -0500
Date: Sat, 1 Dec 2001 00:14:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Henning Schmiedehausen <hps@intermeta.de>, Larry McVoy <lm@bitmover.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
In-Reply-To: <20011130201235.A489@mikef-linux.matchmail.com>
Message-ID: <Pine.GSO.4.21.0112010003410.7958-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Nov 2001, Mike Fedyk wrote:

> This is Linux-Kernel.  Each developer is on their own on how they pay the
> their bills.  The question is... Why not accept a *driver* that *works* but
> the source doesn't look so good?

Because this "works" may very well include exploitable buffer overruns in
kernel mode.  I had seen that - ioctl() assuming that nobody would pass
it deliberately incorrect arguments and doing something like
	copy_from_user(&foo, arg, sizeof(foo));
	copy_from_user(bar, foo.addr, foo.len);

The problem being, seeing what really happens required half an hour of
wading through the shitload of #defines.  _After_ seeing copy_from_user()
in a macro during greap over the tree - that's what had triggered the
further search.
 
> What really needs to happen...
> 
> Accept the driver, but also accept future submissions that *only* clean up
> the comments.  It has been said that patches with comments and without code
> have been notoriously droped.

Commented pile of shit is still nothing but a pile of shit.  If you comment
Netscape to hell and back it will still remain a festering dungpile.  Same
for NT, GNOME, yodda, yodda...

