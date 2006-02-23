Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWBWAd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWBWAd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWBWAd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:33:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58565 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932248AbWBWAd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:33:26 -0500
Date: Thu, 23 Feb 2006 01:33:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060223003300.GL13621@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602230031.41217.rjw@sisk.pl> <20060222235639.GK13621@elf.ucw.cz> <200602231011.44889.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602231011.44889.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > The fact that we use page flags to store some suspend/resume-related
> > > > > information is a big disadvantage in my view, and I'd like to get rid
> > > > > of that in the future.  In principle we could use a bitmap, or rather
> > > > > two of them, to store the same information independently of the page
> > > > > flags, and if we use bitmaps for this purpose, we can use them also
> > > > > instead of PBEs.
> > > >
> > > > Well, we "only" use 2 bits... :-).
> > >
> > > In my view the problem is this adds constraints that other people have to
> > > take into account.  Not a good thing if avoidable IMHO.
> >
> > Well, I hope that swsusp development will move to userland in future
> >
> > :-).
> 
> I don't get your point. I mean, we're talking about flags that record what 
> pages are going to be in the image, be atomically copied and so on. Are you 
> planning on trying to export the free page information and the like to 
> userspace too, along with atomic copy code?

No, certainly not.

Rafael said something like "being limited is bad, because it makes it
hard to change in-kernel snapshoting code". My reply was something
like "I hope people will stop changing in-kernel swsusp code, and hack
userland instead".

Atomic copy code has to stay with kernel: it needs disabled
interrupts, access to all the RAM, etc. It screams "kernel code".

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
