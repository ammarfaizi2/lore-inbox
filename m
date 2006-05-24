Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932744AbWEXNjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbWEXNjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 09:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWEXNjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 09:39:23 -0400
Received: from thunk.org ([69.25.196.29]:46489 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932307AbWEXNjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 09:39:23 -0400
Date: Wed, 24 May 2006 09:39:16 -0400
From: Theodore Tso <tytso@mit.edu>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add user taint flag
Message-ID: <20060524133916.GC16705@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Greg KH <greg@kroah.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org> <20060523184506.GA29044@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060523184506.GA29044@kroah.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2006 at 11:45:06AM -0700, Greg KH wrote:
> On Sun, May 21, 2006 at 07:04:32PM -0400, Theodore Ts'o wrote:
> > --- linux-2.6.orig/kernel/panic.c	2006-04-28 21:16:55.000000000 -0400
> > +++ linux-2.6/kernel/panic.c	2006-05-21 19:00:15.000000000 -0400
> > @@ -150,6 +150,7 @@
> >   *  'R' - User forced a module unload.
> >   *  'M' - Machine had a machine check experience.
> >   *  'B' - System has hit bad_page.
> > + *  'U' - Userspace-defined naughtiness.
> 
> Just a note, some other distros already use the 'U' flag in taint
> messages to show an "unsupported" module has been loaded.  I know it's
> out-of-the-tree and will never go into mainline, just FYI if you happen
> to see some 'U' flags in the wild today...
> 
> Oh, and I like this feature, makes sense to me to have this.

Should we worry about collisions with what distributions are using?
That could cause confusion in the future....

						- Ted
