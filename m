Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbTLIIfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbTLIIfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:35:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:6614 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266140AbTLIIfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:35:37 -0500
Date: Tue, 9 Dec 2003 00:32:28 -0800
From: Greg KH <greg@kroah.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031209083228.GC1698@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <1070953338.7668.6.camel@simulacron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070953338.7668.6.camel@simulacron>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 08:02:19AM +0100, Andreas Jellinghaus wrote:
> On Tue, 2003-12-09 at 00:34, Greg KH wrote:
> > You have 15 floppy devices connected to your box?  All floppy devices
> > should show up in /sys/block.
> 
> No, 16 devices are normal, sysfs has only one:
> aj@simulacron:~/torrent/j-tv/download$ ls /dev/floppy/
> 0       0u1120  0u1600  0u1722  0u1760  0u1920  0u720  0u820
> 0u1040  0u1440  0u1680  0u1743  0u1840  0u360   0u800  0u830
> aj@simulacron:~/torrent/j-tv/download$ find /sys/block/fd* -name dev
> /sys/block/fd0/dev
> 
> Are those floppy devices obsolete? fdformat was the only app to use
> them anyway, I guess. (Not that I use my floppy, I simply noticed
> the change.)

I don't know if they are obsolete or not.  I've never used them, and
trying to figure out the floppy driver just makes my head hurt.  I'm
sure that if anyone really does use them, and udev doesn't work for
them, I'll hear about it :)

> > Regardless of the state of udev, devfs has insolvable problems and you
> > should not use it.  End of story.
> 
> how many bug reports did you see in the last three months of people
> having problems with devfs?

I don't think that all 4 users of devfs on 2.6 are all that vocal :)
Either way, I haven't been paying attention, as I really don't care.

> I don't doubt the problems in theory, but but I simply haven't seen
> them happening. Most users seem quite happy.

There's no accounting for taste, is there.  Anyway, sure some users
might be happy, but when the kernel vfs maintainer shows that it's
pretty simple to deadlock your kernel, and when the devfs maintainer
disappears from view for over a year, that might be a good indication
that you might want to stop using it.

Besides, there's only one "major" distro still using devfs, and that's
just because they don't know any better.

thanks,

greg k-h

/me prepares for another onslaught of complaints from Gentoo users 
