Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUBXIg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 03:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUBXIgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 03:36:49 -0500
Received: from witte.sonytel.be ([80.88.33.193]:52157 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261628AbUBXIgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 03:36:42 -0500
Date: Tue, 24 Feb 2004 09:36:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Stuart Young <sgy-lkml@amc.com.au>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbdv/fbcon pending problems
In-Reply-To: <200402241657.37382.sgy-lkml@amc.com.au>
Message-ID: <Pine.GSO.4.58.0402240935390.3187@waterleaf.sonytel.be>
References: <1077497593.5960.28.camel@gaston> <200402241657.37382.sgy-lkml@amc.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Stuart Young wrote:
> On Mon, 23 Feb 2004 11:53 am, Benjamin Herrenschmidt wrote:
> >  - Logo problems. When booting with a logo, then going to getty, the
> > logo doesn't get erased until we actually switch to another console (or
> > reset the console). At this point, using things like vi & scrolling up
> > doesn't work properly. Actually, last time I tried, I had to switch
> > back & forth twice before my console that had the logo got fully working
> > with vi.
>
> Been around forever and a day. RedHat getty's clear the screen, which tends to
> remove the unscrollable region that the logo sits in. Debian doesn't, so it's
> much more noticable (and always has been).
>
> This might be best done thru userspace, as having the logo and other graphics
> sitting at the top of the screen through the boot process (eg: sysv init
> scripts, etc) within an unscrollable region can be useful. I know that the
> boot-icons package in Debian actually relies on this behaviour. Perhaps you
> could provide an option in the kernel config to change this default
> behaviour, for those that want it?
>
> If it's possible to unlock this region so that it scrolls again from userspace
> (ie: not resetting/clearing it, just unlocking it), then it's just a simple
> matter of checking wether the current console is an fb device, and if it is,
> making it unlock the scrolling region. In Debian, this could be done
> in /etc/init.d/rmnologin, or even in /etc/profile if someone would rather it
> done after login.

There should be an ANSI escape sequence for resetting the scroll region. Just
send that to the console.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
