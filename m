Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267494AbUGNSF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267494AbUGNSF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 14:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267495AbUGNSF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 14:05:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:55486 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267494AbUGNSFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 14:05:54 -0400
Date: Wed, 14 Jul 2004 11:03:44 -0700
From: Greg KH <greg@kroah.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040714180344.GA22593@kroah.com>
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714082621.GA4291@in.ibm.com> <20040714142614.GA15742@kroah.com> <20040714152235.GA5956@in.ibm.com> <20040714170336.GB4636@kroah.com> <20040714174948.GA3935@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714174948.GA3935@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 11:19:49PM +0530, Dipankar Sarma wrote:
> On Wed, Jul 14, 2004 at 10:03:37AM -0700, Greg KH wrote:
> > On Wed, Jul 14, 2004 at 08:52:35PM +0530, Dipankar Sarma wrote:
> > > He is just adding lock-free support from an existing refcounting
> > > mechanism that is used in VFS.
> > 
> > If this is true, then I strongly object to the naming of this file, and
> > the name of the typedef (which shouldn't be a typedef at all) and this
> > should be made a private data structure to the vfs so no one else tries
> > to use it.  Otherwise it will be used.
> 
> I am reasonably sure that when that patch was done (months ago) kref wasn't
> there. Now that kref.[ch] is around, everything can be put there.

I agree.

> Now, if struct kref is shrinked (want patch ? ;-), all this 
> can possibly be nicely collapsed into one set of APIs for refcounting.

Sounds good to me.

> There aren't many users of kref yet, so this seems like a good
> time to do it. Was there any objection to shrinking it ?

None that I know of.  In fact, it's on my list of things to do, so a
patch from someone else to fix this would be greatly appreciated.

thanks,

greg k-h
