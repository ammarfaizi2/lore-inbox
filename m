Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265371AbSJRVZi>; Fri, 18 Oct 2002 17:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265379AbSJRVZi>; Fri, 18 Oct 2002 17:25:38 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:26796 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S265371AbSJRVZf>; Fri, 18 Oct 2002 17:25:35 -0400
Date: Fri, 18 Oct 2002 14:24:48 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Russell King <rmk@arm.linux.org.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [BK PATCHS] fbdev updates.
In-Reply-To: <20021018193245.A15827@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0210181421110.3591-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Yes the drivers should always have priority. The other stuff is there
> > only if the drivers have no power management of any kind. I leave it up to
> > the driver write to implement a fb_blank function that handles different
> > cases.
>
> The drivers don't have priority though.  You call set_par, and then
> wander off into the internals of fbgen.c to set can_soft_blank youself,
> without giving the drivers any look-in to set that correctly.

Your right. That is a bug from the old fbgen code. Since few driver used
the old fbgen code it never appeared. I suggest we remove can_soft_blank
and just test to see if the function pointer exist for fb_blank. If it
doesn't then we can resort to other tricks in suggested in the ther email.


