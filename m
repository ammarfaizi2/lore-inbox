Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVAPRX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVAPRX6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 12:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVAPRX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 12:23:58 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:1974 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262547AbVAPRXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 12:23:55 -0500
Date: Sun, 16 Jan 2005 19:24:13 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: changing local version requires full rebuild
Message-ID: <20050116172413.GA5029@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050116152242.GA4537@mellanox.co.il> <20050116161622.GC3090@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116161622.GC3090@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Sam Ravnborg (sam@ravnborg.org) "Re: changing local version requires full rebuild":
> On Sun, Jan 16, 2005 at 05:22:42PM +0200, Michael S. Tsirkin wrote:
> > Hi!
> > Is it just me, or does changing the local version always require
> > a full kernel rebuild?
> > 
> > If so, I'd like to fix it, since I like copying
> > my kernel source with --preserve and changing the
> > local version, then going back to the old version in case of
> > a crash.
> > Its important to change the local version to force 
> > make install and make modules_install to put things in a separate
> > directory.
> 
> Just tried it out here.
> After cp -Ra only a limited part of the kernel rebuilds.
> o oiu.c in ieee directory - because it dependson the shell script
> o A number of drivers that include version.h
> 	- This should be changed so local version does not affect
> 	  the reast of version.h.
> o Other stuff that is always build if kernel has changed
> 
> Do you use "echo -mylocalver > localversion" to change the local version?
> 
> 	Sam

Just tried this with the same effect.

Could it be your version was already -mylocalver?

Please note that you have to actually *change* the local
version, otherwise almost nothing is recompiled.
Just a touch does nothing.

Actually, the directory kernel/ is not recompiled (so the subject is a
bit misleading) , but a huge number of files in drivers, filesystems, sound,
lib and net directory - are.

MST
