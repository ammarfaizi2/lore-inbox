Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUBSTrX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUBSTrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:47:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:5791 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267509AbUBSTqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:46:51 -0500
Date: Thu, 19 Feb 2004 11:43:57 -0800
From: Greg KH <greg@kroah.com>
To: Mike Bell <kernel@mikebell.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040219194357.GA13934@kroah.com>
References: <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <20040210172552.GB27779@kroah.com> <20040210174603.GL4421@tinyvaio.nome.ca> <20040210181242.GH28111@kroah.com> <20040210182943.GO4421@tinyvaio.nome.ca> <20040213211920.GH14048@kroah.com> <20040214085110.GG5649@tinyvaio.nome.ca> <20040214165444.GA26602@kroah.com> <20040219094720.GD432@tinyvaio.nome.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219094720.GD432@tinyvaio.nome.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 01:47:21AM -0800, Mike Bell wrote:
> 
> And I already do use the devfs we already have, and have done so for a
> long time. But it could use a lot of improvement (the same way udev
> could).

What could be improved in udev?  What is it lacking that you need?
Seriously, I'm interested in this.  I'm not interested in devfs vs udev
arguments, as that argument has been played out zillions of times before
and devfs has consistently lost.

<big snip...>

> I wasn't trying to tell you how to do udev (though again, I may have
> come off that way accidentally, and if so I'm sorry). The only issue I
> ever had with you was that I didn't agree with a lot of your "devfs
> versus udev" document. Which is why I started the thread with a sort of
> counter to that.

Well, if you want to either send me a patch for the udev-vs-devfs
document that contains your suggested changes, or post your own
devfs_is_so_superior_to_udev_that_no_one_should_ever_argue_with_me
document, feel free to do so :)

> > > How do you figure that's free? hotplug's a great feature, nothing
> > > against it, but as far as I know the vast majority of installations
> > > aren't making use of it right now.
> > 
> > Hint, I don't know of ANY distro that does not enable CONFIG_HOTPLUG
> > that is not a embedded distro.  That's why I call it "free".  It has
> > so many other benefits that people can no longer turn it off and
> > expect their systems to work "nicely".
> 
> It may be enabled in a lot of kernels, but I don't know any distros that
> actually break if you turn it off (though I may be wrong here). So I
> don't think you're right when you say "It has so many other benefits
> that people can no longer turn it off and expect their systems to work
> "nicely"".

As you have proved that you do not understand what CONFIG_HOTPLUG is and
does for a system, I do not see how you can back up your argument about
this topic.  Please become more well-informed of the situation before
trying to discuss this.

> I wasn't trying to get somewhere with you. The main purpose of this
> thread was to guage the level of interest in keeping devfs alive (which
> I suppose I've done, though I'm disappointed more people don't seem to
> agree with me on the advantages of a devfs solution over udev).

If you look at your first post on this topic, it falls far short of this
goal.  It seemed like another "why is everyone picking on devfs as it's
so great!" complaint to me by someone who does not fully understand how
the devfs or udev code works.

> The most I ever wanted from you personally was for you to make your udev
> versus devfs document a little fairer to devfs. I wish you the best of
> luck in developing udev, and since it looks like it's the preferred
> solution, I genuinely hope it matures quickly so that static /dev on
> linux can go away.

udev is mature enough to do this today.  I'm typing this on a box that
runs it's /dev solely by using udev on a ramfs partition.  See my
recently posted HOWTO for how to do this if you are interested.

Also, please remember the main goal of udev, the ability to create
persistent names for devices.  This is something that devfs can not do
for you at all.  The fact that udev can fully replace devfs with a tiny
userspace program is further proof that udev is the proper way to manage
a /dev tree.

thanks,

greg k-h
