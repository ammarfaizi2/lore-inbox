Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261706AbREOXlC>; Tue, 15 May 2001 19:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbREOXkw>; Tue, 15 May 2001 19:40:52 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:27641 "EHLO tytlal")
	by vger.kernel.org with ESMTP id <S261706AbREOXkj>;
	Tue, 15 May 2001 19:40:39 -0400
Date: Tue, 15 May 2001 16:39:23 -0700
From: Chip Salzenberg <chip@valinux.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515163923.P3098@valinux.com>
In-Reply-To: <20010515144020.H3098@valinux.com> <E14zn3V-0003CJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14zn3V-0003CJ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 15, 2001 at 11:12:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Alan Cox:
> Chip:
> > Wouldn't it be better just to *try* ioctls and see which ones work and
> > which ones don't?
> 
> 1. We have overlaps

We all agree that overlaps need to be eliminated over time.  In the
meantime, as a coping strategy: I'll bet you that for any two given
device classes, there is at least one ioctl that works on only one of
them.  (I'm only talking about an interim workaround!  Calm down!  Put
down those bats!)

> 2. I've seen code where people play clever ioctl tricks to deduce a
> device type and it ends up looking like one of those chemistry
> identification charts (hopefully minus do you see smoke ?)

I don't mean to suggest that ioctls be used to deduce device types
(except in the case of overlapping ioctl numbers, which shouldn't be
all *that* common (I hope)).  I mean to suggest that the question
"What device type are you?" usually shouldn't even be asked!

If you want to do X to the device on fd, just call ioctl(fd, X, ...).
Either it works or it doesn't.

I realize that overlapping ioctls throw a monkey wrench into this
world view.  Is it a bigger wrench than the wrenching pain that we'll
have to live through to make device identification reliable?  Depends
on how many ioctls overlap, and how easily we could make them stop
overlapping.
-- 
Chip Salzenberg              - a.k.a. -             <chip@valinux.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
