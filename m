Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132623AbRDXAmB>; Mon, 23 Apr 2001 20:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132625AbRDXAlw>; Mon, 23 Apr 2001 20:41:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:16537 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132623AbRDXAlt>;
	Mon, 23 Apr 2001 20:41:49 -0400
Date: Mon, 23 Apr 2001 20:41:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: David Wagner <daw@mozart.cs.berkeley.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: light weight user level semaphores
In-Reply-To: <9c2gr2$u7s$1@abraham.cs.berkeley.edu>
Message-ID: <Pine.GSO.4.21.0104232035070.4968-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 Apr 2001, David Wagner wrote:

> Linus Torvalds  wrote:
> >Ehh.. I will bet you $10 USD that if libc allocates the next file
> >descriptor on the first "malloc()" in user space (in order to use the
> >semaphores for mm protection), programs _will_ break.
> >
> >You want to take the bet?
> 
> Good point.  Speaking of which:
>   ioctl(fd, UIOCATTACHSEMA, ...);
> seems to act like dup(fd) if fd was opened on "/dev/usemaclone"
> (see drivers/sgi/char/usema.c).  According to usema(7), this is
> intended to help libraries implement semaphores.
> 
> Is this a bad coding?

Yes. Not to mention side effects, it's just plain ugly. Anyone who invents
identifiers of _that_ level of ugliness should be forced to read them
aloud for a week or so, until somebody will shoot him out of mercy.
Out of curiosity: who was the author? It looks unusually nasty, even for
SGI.

