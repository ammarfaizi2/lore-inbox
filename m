Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262778AbREOPQm>; Tue, 15 May 2001 11:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbREOPQc>; Tue, 15 May 2001 11:16:32 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:51466 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262778AbREOPQX>; Tue, 15 May 2001 11:16:23 -0400
Date: Tue, 15 May 2001 08:15:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Neil Brown <neilb@cse.unsw.edu.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zb8O-0002G8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105150811170.1802-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Alan Cox wrote:
> 
> For block devices that seems to work well. char devices are harder and I'd
> rather issue the occasional new major than have people registering automatic
> cabbage slicers as a tty or a disk because they cant get a device id.

What are the valid cases that couldn't just register as a misc'ish
driver? The one that stands out is serial devices (you have hundreds of
them), but that's the same argument as a disk anyway.

I'd be much happier with trying to expand on /proc/devices etc, so that
the user _can_ get valid information. Otherwise you end up with the stupid
setup where we keep track of static allocations of numbers for truly
specialty hardware ("I have a lip-frobnicator made by Acme Industries that
I wrote a driver for, and I need 16 minor numbers for it").

Right now we have wasted the minors in the misc device the same way we
wasted the majors in general, and for the same (bogus) reasons.

		Linus

