Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751657AbWBWIsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWBWIsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 03:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWBWIsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 03:48:36 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:17556 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751657AbWBWIsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 03:48:35 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 23 Feb 2006 09:33:35 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602231011.44889.ncunningham@cyclades.com> <20060223003300.GL13621@elf.ucw.cz>
In-Reply-To: <20060223003300.GL13621@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602230933.36391.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 23 February 2006 01:33, Pavel Machek wrote:
> > > > > > The fact that we use page flags to store some suspend/resume-related
> > > > > > information is a big disadvantage in my view, and I'd like to get rid
> > > > > > of that in the future.  In principle we could use a bitmap, or rather
> > > > > > two of them, to store the same information independently of the page
> > > > > > flags, and if we use bitmaps for this purpose, we can use them also
> > > > > > instead of PBEs.
> > > > >
> > > > > Well, we "only" use 2 bits... :-).
> > > >
> > > > In my view the problem is this adds constraints that other people have to
> > > > take into account.  Not a good thing if avoidable IMHO.
> > >
> > > Well, I hope that swsusp development will move to userland in future
> > >
> > > :-).
> > 
> > I don't get your point. I mean, we're talking about flags that record what 
> > pages are going to be in the image, be atomically copied and so on. Are you 
> > planning on trying to export the free page information and the like to 
> > userspace too, along with atomic copy code?
> 
> No, certainly not.
> 
> Rafael said something like "being limited is bad, because it makes it
> hard to change in-kernel snapshoting code". My reply was something
> like "I hope people will stop changing in-kernel swsusp code, and hack
> userland instead".

Actually I meant all of the other users of page flags.  If we didn't use page
flags, they would be less constrained in what they're doing.

Greetings,
Rafael

