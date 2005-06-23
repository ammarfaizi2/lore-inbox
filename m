Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVFWBCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVFWBCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVFWBCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:02:33 -0400
Received: from nome.ca ([65.61.200.81]:60599 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S261945AbVFWBAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:00:24 -0400
Date: Wed, 22 Jun 2005 18:00:32 -0700
From: Mike Bell <kernel@mikebell.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623010031.GB17453@mikebell.org>
Mail-Followup-To: Mike Bell <kernel@mikebell.org>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621151019.GA19666@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 08:10:19AM -0700, Greg KH wrote:
> There might be some complaints.  But I doubt they would be from anyone
> running a -mm tree as those people kind of know the current status of
> things in the kernel.  There have been numerous warnings as to the fact
> that this was going away, and I waited a _year_ to do this.

I use -mm and I'm complaining.

Knowing it's coming isn't the same as agreeing with it. :)

Once devfs is out, it's out for good. It is for all intents and purposes
impossible to maintain such a thing outside of mainline. You should know
that, udev's kernel infrastructure was developed pretty much entirely
within mainline and look how long it took to get even the present number
of drivers working with it.

It's pretty hard to put effort into devfs when said patches won't get
merged because it has already been decided by certain people that devfs
is not the way to go. For example the quick death without comment of the
earlier devfs-on-top-of-tmpfs patches.

Or, look at how hard of a time udev had gaining mindshare, how long it
was around for until now. Only shock tactics like marking devfs OBSOLETE
(at a time when udev was completely unready to replace devfs, making
it far from obsolete) got people switching.

> Also, no disto uses devfs only (gentoo is close, but offers users udev
> and a static /dev also.)

It breaks a lot of my embedded setups which have read-only storage only
and thus need /dev on devfs or tmpfs. With early-userspace-udev-on-tmpfs
being - in my experience - still unready. Not to mention the general
bother of having to change dozens of desktop/server systems to work with
udev, but I doubt you care about that.
