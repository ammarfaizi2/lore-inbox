Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWEYPDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWEYPDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 11:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbWEYPDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 11:03:17 -0400
Received: from cantor2.suse.de ([195.135.220.15]:63164 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965194AbWEYPDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 11:03:17 -0400
Date: Thu, 25 May 2006 08:01:01 -0700
From: Greg KH <greg@kroah.com>
To: Theodore Tso <tytso@mit.edu>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add user taint flag
Message-ID: <20060525150101.GA1428@kroah.com>
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org> <20060523184506.GA29044@kroah.com> <20060524133916.GC16705@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524133916.GC16705@thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 09:39:16AM -0400, Theodore Tso wrote:
> On Tue, May 23, 2006 at 11:45:06AM -0700, Greg KH wrote:
> > On Sun, May 21, 2006 at 07:04:32PM -0400, Theodore Ts'o wrote:
> > > --- linux-2.6.orig/kernel/panic.c	2006-04-28 21:16:55.000000000 -0400
> > > +++ linux-2.6/kernel/panic.c	2006-05-21 19:00:15.000000000 -0400
> > > @@ -150,6 +150,7 @@
> > >   *  'R' - User forced a module unload.
> > >   *  'M' - Machine had a machine check experience.
> > >   *  'B' - System has hit bad_page.
> > > + *  'U' - Userspace-defined naughtiness.
> > 
> > Just a note, some other distros already use the 'U' flag in taint
> > messages to show an "unsupported" module has been loaded.  I know it's
> > out-of-the-tree and will never go into mainline, just FYI if you happen
> > to see some 'U' flags in the wild today...
> > 
> > Oh, and I like this feature, makes sense to me to have this.
> 
> Should we worry about collisions with what distributions are using?

I wouldn't.  It's their responsibility to handle things like this when
merging to new kernel versions.  They can just change the character,
like they handle new sysrq values.

thanks,

greg k-h
