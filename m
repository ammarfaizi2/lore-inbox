Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315343AbSDWVnV>; Tue, 23 Apr 2002 17:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315347AbSDWVnU>; Tue, 23 Apr 2002 17:43:20 -0400
Received: from Expansa.sns.it ([192.167.206.189]:24333 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S315343AbSDWVnT>;
	Tue, 23 Apr 2002 17:43:19 -0400
Date: Tue, 23 Apr 2002 23:43:09 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: m.knoblauch@TeraPort.de
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: XFS in the main kernel
In-Reply-To: <3CC56355.E5086E46@TeraPort.de>
Message-ID: <Pine.LNX.4.44.0204232330430.4925-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Apr 2002, Martin Knoblauch wrote:

> > Re: XFS in the main kernel
> >
>  definitely. Unless XFS is in the mainline kernel (marked as
> experimantal if necessary) it will not get good exposure.

XFS needs 2.5, not 2.4, because of a lot of reasons.
If I do remember well a strong obiection to XFS is that it introduces a
kernel thread to emulate Irix behavious to talk with pagebuf (a la Irix),
end to have an interface with VM and Block Device layer.

This forces some vincles.

It is a lot of time that I do not try XFS, so maybe things changed, but
XFS has has data block of the same size of memory pages (4 or 8 Kb
depending on architecture), not that I have some remak about that, but I
use XFS on Irix on an Origin 2000 with a couple of TB disk space, it is
another thing in front of Linux ports.

On the other side delayed allocation is quite cool ;)

>
>  The most important (only) reason I do not use it (and recommend our
> customers against using it) is that at the moment it is impossible to
> track both the kernel and XFS at the same time. This is a shame, because
> I think that for some application XFS is superior to the other
> alternatives (can be said about the other alternatives to :-).

Every FS has its strenght points and its weackness.

For example on MC^2 I found reiserFS on LVM to have a really good
interaction with the way MC^2 works, expecially because
I have a lot of small|medium sized files, I suppose.

I also tied XFS and JFS on MC^2, and maybe with other file size
and I/O loads they would be better. I just talk for my systems needs.

(all test were with latest 2.4 kernels, a month ago.
I cannot risk corruption on this
storage system, so 2.5 is not for me there :( ).

>
> > That said, it is important to
> > consider the technical reasons to include XFS in 2.5 or not; if this
> > inclusion could cause some troubles, if XFS fits the requirements
> > Linus asks for the inclusion and what impact the inclusion would have on
> > the kernel (Think to JFS as a good example of an easy inclusion, with low
> > impact).
> >
>
>  so, what were the main obstacles again? The VFS layer?
>
See my previous comments...


