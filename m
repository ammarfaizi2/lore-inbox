Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTLJINX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 03:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTLJINX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 03:13:23 -0500
Received: from unthought.net ([212.97.129.88]:59877 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263008AbTLJINW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 03:13:22 -0500
Date: Wed, 10 Dec 2003 09:13:20 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Greg KH <greg@kroah.com>
Cc: Witukind <witukind@nsbm.kicks-ass.org>, recbo@nishanet.com,
       linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-ID: <20031210081320.GA994@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Greg KH <greg@kroah.com>, Witukind <witukind@nsbm.kicks-ass.org>,
	recbo@nishanet.com, linux-kernel@vger.kernel.org
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org> <20031209075619.GA1698@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209075619.GA1698@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 11:56:20PM -0800, Greg KH wrote:
> On Tue, Dec 09, 2003 at 06:17:28AM +0100, Witukind wrote:
> > From the udev FAQ:
> > 
> > Q: But udev will not automatically load a driver if a /dev node is opened
> >    when it is not present like devfs will do.
> > A: If you really require this functionality, then use devfs.  It is still
> >    present in the kernel.
> > 
> > Will it have this 'equivalent functionality' some day?
> 
> Heh, no.  I really don't believe all of the people who keep asking me
> this.  I think I need to reword this answer to something like:
>   A:  That is correct.  If you really require this functionality, then
>       use devfs.  There is no way that udev can support this, and it
>       never will.
> 
> That better?  :)

No Greg.  People keep asking, because you continue to give an answer
that is 'correct' but does not answer the question people 'meant' to
ask.

Andreas Jellinghaus <aj@dungeon.inka.de> gave an excellent answer -
which I shall blatantly quote:

-------------------------
Q: devfs did load drivers when someone tried to open() a non existing
device. will sysfs/hotplug/udev do this?

A: there is no need to. hotplug/sysfs/udev will create devices for all
hardware supported by the kernel and the available modules. it will do
that during boot up, and whenever new hardware is added. so you can
expect all devices be already present, no need for a devfs like
mechanism.
-------------------------

And there you have it  :)

 / jakob

