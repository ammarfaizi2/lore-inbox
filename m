Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261277AbRELXmy>; Sat, 12 May 2001 19:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbRELXmo>; Sat, 12 May 2001 19:42:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5859 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261348AbRELXm3>;
	Sat, 12 May 2001 19:42:29 -0400
Date: Sat, 12 May 2001 19:42:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: BERECZ Szabolcs <szabi@inf.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: mount /dev/hdb2 /usr; swapon /dev/hdb2  keeps flooding
In-Reply-To: <E14yis0-0004c9-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105121939310.11973-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 May 2001, Alan Cox wrote:

> > > root@kama3:/home/szabi# cat /proc/mounts
> > > /dev/hdb2 /usr ext2 rw 0 0
> > > root@kama3:/home/szabi# swapon /dev/hdb2
> > 
> > - Doctor, it hurts when I do it!
> > - Don't do it, then.
> > 
> > Just what behaviour had you expected?
> 
> EBUSY would be somewhat nicer.

Probably. Try to convince Linus that we need such exclusion. All stuff
needed to implement it is already there - see blkdev_open() for details.
OTOH, as long as kernel itself survives that... In this case I can see
the point in "give them enough rope" approach.

