Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315411AbSFAHnW>; Sat, 1 Jun 2002 03:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315412AbSFAHnW>; Sat, 1 Jun 2002 03:43:22 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:658 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315411AbSFAHnV>; Sat, 1 Jun 2002 03:43:21 -0400
Date: Sat, 1 Jun 2002 02:43:14 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Dan Aloni <da-x@gmx.net>
cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Link order madness :-(
In-Reply-To: <20020601065520.GA11951@callisto.yi.org>
Message-ID: <Pine.LNX.4.44.0206010235340.21152-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jun 2002, Dan Aloni wrote:

> > 	So, I was trying to fix that, and I found a problem with
> > kernel link order.
> 
> It is possible that recent kbuild changes caused that.

I don't think so, I took extra care to leave it all the same. (Well, 
except for sound/, which is outside drivers/) It'd however surely be a 
good idea to go through it and document which dependencies there are.

There's surely stuff which could be cleaned up (Jeff, as you're CC'ed 
anyway, look where tulip/ is linked in drivers/net/Makefile, I think that 
could be straightened up a bit)

W.r.t to the original problem I have to say I didn't really look into yet, 
but I think it makes e.g. a lot of sense to initialize networking earlier 
(subsys_initcall). We have initcall levels, using them right will help a 
lot. (The block subsystem is only __initcall a.k.a. driver_initcall as 
well, that's asking for problems at some point)

--Kai


