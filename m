Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVIJV4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVIJV4T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVIJV4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:56:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:16775 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932252AbVIJV4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:56:18 -0400
Date: Sat, 10 Sep 2005 14:55:40 -0700
From: Greg KH <gregkh@suse.de>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Message-ID: <20050910215540.GB15645@suse.de>
References: <20050909214542.GA29200@kroah.com> <4322A160.1060809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4322A160.1060809@gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 11:03:28AM +0200, Michael Thonke wrote:
> Hello Greg,
> 
> just for understanding the problem right. Some questions.
> Greg KH schrieb:
> 
> >Here are the same "delete devfs" patches that I submitted for 2.6.12.
> >It rips out all of devfs from the kernel and ends up saving a lot of
> >space.  Since 2.6.13 came out, I have seen no complaints about the fact
> >that devfs was not able to be enabled anymore, and in fact, a lot of
> >different subsystems have already been deleting devfs support for a
> >while now, with apparently no complaints (due to the lack of users.)
> > 
> >
> How could users really say/complain what brakage they have, in fact they
> don't even know the relationship between all that
> ( e.g drivers -> devfs -> sysfs or other programs that rely on devfs)?

Their machines would not boot.  :)

> They aren't all developers to encrypt the "magic" bug reports/debug messages
> spreading over the screen.

What do you mean?

> >I mean, how can you go wrong with deleting over 8000 lines of kernel
> >code :)
> > 
> >
> Right, it's a good/right work to remove dispensable code from kernel.
> Even it makes it easier to maintain the code but what happen if
> there is an "for now" an unresolved/unknown problem which no one notice 
> so far?
> 
> Devfs is in for many years, why removing it in just some weeks?

It's been told and widly known that it was going to be removed last
July.  In July 2004 this happened, so people have known for over a year.
How much longer do you expect me to give people?

> I think this is a bad solution because on the one hand you "force" to 
> remove devfs due it's crappy naming sheme and on the other hand
> offering to add such thing again which brakes ALSA and other.
> *confused* Even if it has only 300 lines of code.
> 
> This is not consistent with the intention to remove devfs forever.
> Either say "live with it or die" or leave it as it is.

"die."  :)

I never said that ndevfs was to be a solution for anyone, just for
people who really complained about Linux not having an in-kernel
devfs-like solution.  And if they worry about this, then they can keep
that patch outside of the main kernel tree for their distros quite
easily.

thanks,

greg k-h
