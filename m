Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268300AbTBSCBx>; Tue, 18 Feb 2003 21:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268301AbTBSCBx>; Tue, 18 Feb 2003 21:01:53 -0500
Received: from tomts9.bellnexxia.net ([209.226.175.53]:27592 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268300AbTBSCBw>; Tue, 18 Feb 2003 21:01:52 -0500
Date: Tue, 18 Feb 2003 21:09:10 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: a really annoying feature of the config menu structure
In-Reply-To: <3E52DCE6.5090403@verizon.net>
Message-ID: <Pine.LNX.4.44.0302182059250.25284-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, Stephen Wille Padnos wrote:

> Robert P. J. Day wrote:

> >  what has to be avoided is for any of these directories to
> >give itself a menu label that implies that it's fairly high
> >up in the food chain, and subsequently leave no way to 
> >incorporate submenus beneath it.  (see, eg., "Multimedia")
> >
> The only change to "drivers/media/Kconfig" was the removal of the menu 
> and endmenu lines, for exactly the purpose of removing the title.

that's still not good enough.  think about it this way:  every
directory with related source that makes up a subcomponent of the
kernel -- I2C, USB, kernel hacking, whatever -- should theoretically
be under the control of a maintainer.

that maintainer should not only look after patches to the
code, but should keep the Kconfig file in that directory up
to date.  ideally, that maintainer should be the ultimate
authority for *everything* that happens in that directory.

at the top level, whoever organizes the main config menu
should not have to do any more than source other Kconfig
files to pull them into the top-level menu.  this gives the
main config person total freedom to shift around menu entries
and submenus without *ever* going into one of those lower
directories and making *any* changes to their contents.

from my perspective, it's not good enough that you only
had to remove the two menu definition lines -- you shouldn't
have had to do *anything* in what you can consider someone
else's directory.  now, assuming that you appreciate that,
yes, this is a problem, what are the possible solutions?

i can think of a couple solutions, but they require making
sure everyone agrees on some kind of standard for how maintainers
are going to manage their Kconfig files so that they're 
movable at will.

i'll hold off going any further until i'm sure i'm making
sense here.

rday

