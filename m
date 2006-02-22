Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWBVX5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWBVX5o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWBVX5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:57:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32922 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030319AbWBVX5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:57:43 -0500
Date: Thu, 23 Feb 2006 00:56:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060222235639.GK13621@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602220038.18054.rjw@sisk.pl> <20060222222445.GA13796@elf.ucw.cz> <200602230031.41217.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602230031.41217.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > It is doable - I'm doing it now, but am thinking about reverting part of the 
> > > > code to use pbes again. If you're going to look at using bitmaps in place of 
> > > > pbes, me changing would be a waste of time. Do you want me to hold off for a 
> > > > while? (I'll happily do that, as I have far more than enough to keep me 
> > > > occupied at the moment anyway).
> > > 
> > > Well, I'd say so. :-)
> > > 
> > > Frankly, I didn't think of dropping PBEs right now, but in the long run
> > > that's worth considering, IMO.  The advantage of PBEs is that they are easy to
> > > handle in the assembly parts, but apart from this they are a bit wasteful
> > > (not very much, though).
> > 
> > Of course it will depend on what patch looks like, but changing
> > assembly parts is hard -- you have to change all the architectures,
> > and better not make any mistake.
> 
> Yes, that would be a lot of work, so it's rather a long term
> "vision".

Ok, I have no problems with visions.

> I think we should try to get the pagecache stuff right first anyway.

Are you sure it is worth doing? I mean... it only helps on small
machines, no?

OTOH having it for benchmarks will be nice, and perhaps we could use
that kind it to speed up boot and similar things... 

> > > The fact that we use page flags to store some suspend/resume-related
> > > information is a big disadvantage in my view, and I'd like to get rid of that
> > > in the future.  In principle we could use a bitmap, or rather two of them,
> > > to store the same information independently of the page flags, and
> > > if we use bitmaps for this purpose, we can use them also instead of
> > > PBEs.
> > 
> > Well, we "only" use 2 bits... :-).
> 
> In my view the problem is this adds constraints that other people have to take
> into account.  Not a good thing if avoidable IMHO.

Well, I hope that swsusp development will move to userland in future
:-).
									Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
