Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261471AbRETHlv>; Sun, 20 May 2001 03:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbRETHll>; Sun, 20 May 2001 03:41:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32680 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261471AbRETHl1>;
	Sun, 20 May 2001 03:41:27 -0400
Date: Sun, 20 May 2001 03:41:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@suse.cz>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNumber
  Registrants]
In-Reply-To: <3B076FE2.A8B49526@alsa-project.org>
Message-ID: <Pine.GSO.4.21.0105200329310.7162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Abramo Bagnara wrote:

> I've just had a "so simple to risk to be stupid" idea.
> 
> To have /proc/self/fd/N/ioctl would not have the potential to suppress
> ioctl needs for *all* current uses?

No, it wouldn't. For one thing, it messes the only half-decent part of
procfs. For another, the real issue is how to eliminate the bogus
ioctls from userland programs and what to replace them with.

Crappy API won't become better if you simply change the calling conventions.
And problem with ioctls is that most of them are crappy APIs. Coming from
authors' laziness and/or debility.

So there is no easy way to solve that stuff - we'll need to rethink tons
of badly designed interfaces. Finding a way to represent them in fs is
the least of the problems.

And we really need to rethink them. Repackaged shit remains shit and the
whole point of exrecise is to get rid of it, not to shove it into a new
pile.

