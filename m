Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbREOJKB>; Tue, 15 May 2001 05:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262696AbREOJJv>; Tue, 15 May 2001 05:09:51 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:19206 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262694AbREOJJi>; Tue, 15 May 2001 05:09:38 -0400
Date: Tue, 15 May 2001 02:08:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Neil Brown <neilb@cse.unsw.edu.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zadw-0002DZ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105150204020.1078-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Alan Cox wrote:
> > 
> > Nobody really uses it because it would require you to add a line or two to
> > your init scripts to pick up the major number from /proc/devices, and
> > that's obviously too hard. Much better to just hardcode randome numbers,
> > right?
> 
> modprobe ?

I was being ironic.

Yes, it's used. Not very widely at all, and historically what has actually
happened is that people have used the dynamic numbers for a while, but in
order to become "real members of society" they've applied for a real
static major number even if the dynamic one worked fine.

Silly, yes. 

Note that my whole argument is that we do NOT need more of the static
numbers, and we should NOT expand the major number space
unnecessarily. We _can_ make do with devfs (trivially - no need to do
anything at all, as devfs already handles the case of dynamic major
numbers quite well). 

But the fact remains that some users want to (a) avoid devfs and (b) have
static maintenance. And I'm ok with that too, but only if the static major
number is in the form of a _generic_ number that has absolutely nothing to
do with any specific drivers (which is why I'd be perfecly ok with still
adding a "disk" major number, but which is why I do NOT want to have Peter
give out "the random number of today" to various stupid device drivers).

So we seem to be in violent agreement here.

		Linus

