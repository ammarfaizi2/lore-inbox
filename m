Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVLFSCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVLFSCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbVLFSCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:02:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:4589 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964990AbVLFSCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:02:32 -0500
Date: Tue, 6 Dec 2005 09:44:24 -0800
From: Greg KH <greg@kroah.com>
To: Jakob Oestergaard <jakob@unthought.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206174424.GC3084@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <20051204170049.GA4179@unthought.net> <20051204223931.GA8914@kroah.com> <20051205151753.GB4179@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205151753.GB4179@unthought.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 04:17:53PM +0100, Jakob Oestergaard wrote:
> On Sun, Dec 04, 2005 at 02:39:31PM -0800, Greg KH wrote:
> > On Sun, Dec 04, 2005 at 06:00:49PM +0100, Jakob Oestergaard wrote:
> > > In the real world, however, admins currently need to pick out specific
> > > versions of the kernel for specific workloads (try running a large
> > > fileserver on anything but 2.6.11.11 for example - any earlier or later
> > > kernel will barf reliably.
> > 
> > Have you filed a but at bugzilla.kernel.org about this?  If not, how do
> > you expect it to get fixed?
> 
> I don't expect to get it fixed. It's futile. It can get fixed in one
> version and broken two days later, and it seems the attitude is that
> that is just fine.

Huh?  That is just not true at all.  Please give us a bit more credit
than that.

> After a long long back-and-forth, 2.6.11 was fixed to the point where it
> could reliably serve files (at least on uniprocessor configurations -
> and in my setup I don't see problems on NUMA either, but as far as I
> know that's just me being lucky).
> 
> Right after that, someone thought it was a great idea to pry out the PCI
> subsystem and shovel in something else.  Find, that's great for a
> development kernel, but for a kernel that's supposed to be stable it's
> just not something you can realistically do and expect things to work
> afterwards.  And things broke - try mounting 10-20 XFS filesystems
> simultaneously on 2.6.14.  Boom - PCI errors.

What PCI errors are you speaking of?  We did that PCI work to fix a lot
of other machines that were having problems.  And yes, this did break
some working machines, and we are very sorry about this.  But in the
future, changes to this area will not cause this to happen due to the
changes made.

Please file a bug in bugzilla.kernel.org and let us know you are having
problems.  Otherwise we have no idea.

> Now what? Do I as a user upgrade my production environment to the latest
> and greatest kernel experiment, hope that the problems can be fixed
> quickly, and hope that I don't lose too much data in the process?

No, if you rely on a production environment for your stuff, stick with a
disto kernel which has been tested and is backed up by a company that
will maintain it over time.

> (remember I will have people unable to do their jobs whenever the file
> server is down).   Or do I stay on 2.6.11.11 which works on this
> particular server?
> 
> I think I stay.

As you wish.

> > > There are very very good reasons for offering a 'stable series' in plain
> > > source-tree form - lots of admins of real-world systems need this.
> > 
> > But it sounds like you will want different stable series depending on
> > what kind of server you are running.  And that will be even more work...
> 
> The idea would be to fix the actual bugs. After a while, one could have
> a kernel of higher quality with fewer bugs, making it a lot more likely
> that the *same* kernel tree could be used for both workloads A and B.
> 
> It's really very simple :)

If you can point out the "actual bugs" yes.  It sounds so simple from a
theoritical view, but we all know how well theory works in real life
sometimes...

We don't try to create new bugs they are the side affect of fixing other
bugs, or adding new features that other people need.  And again, if
those bugs aren't reported, we have no idea they are present.

thanks,

greg k-h
