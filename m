Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313762AbSEGSQa>; Tue, 7 May 2002 14:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315896AbSEGSQ3>; Tue, 7 May 2002 14:16:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54801 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313762AbSEGSQ2>; Tue, 7 May 2002 14:16:28 -0400
Date: Tue, 7 May 2002 11:16:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, <benh@kernel.crashing.org>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <E1759fR-0008Dg-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0205071114200.975-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 May 2002, Alan Cox wrote:
>
> > > Fugly. What's wrong with readlink(2) as this "magic syscall"?
> > Ehh - like the fact that it doesn't work on device files?
>
> I can't find anything in Posix/SuS that says it isnt allowed to however 8)

We can certainly do it, it just doesn't buy us much of anything, since
none of the standard tools (ie "ls") will actually do the readlink() for
anything but a symlink.

So at that point it's just another magic syscall, except we've overloaded
an old one.

Which may certainly be acceptable, of course.

		Linus

