Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264476AbRFKNLC>; Mon, 11 Jun 2001 09:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264514AbRFKNKv>; Mon, 11 Jun 2001 09:10:51 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28429 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264488AbRFKNKs>; Mon, 11 Jun 2001 09:10:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <andrewm@uow.edu.au>
Subject: Re: [patch] truncate_inode_pages
Date: Mon, 11 Jun 2001 15:13:13 +0200
X-Mailer: KMail [version 1.2]
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0106091331120.19361-100000@weyl.math.psu.edu> <01061018402300.05248@starship> <3B24BD57.E1D6D1D0@uow.edu.au>
In-Reply-To: <3B24BD57.E1D6D1D0@uow.edu.au>
MIME-Version: 1.0
Message-Id: <01061115131301.05248@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 June 2001 14:45, Andrew Morton wrote:
> Daniel Phillips wrote:
> > On Sunday 10 June 2001 03:31, Andrew Morton wrote:
> > > Daniel Phillips wrote:
> > > > This is easy, just set the list head to the page about to be
> > > > truncated.
> > >
> > > Works for me.
> >
> > It looks good, but it's black magic
>
> No, it's wrong.  I'm getting BUG()s in clear_inode():
> [...]
> The lists are mangled.

curr is being advanced in the wrong place.

/me makes note to self: never resist the temptation to clean things up the 
rest of the way

I'll actually apply the patch and try it this time ;-)

--
Daniel
