Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264112AbUCPROG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264111AbUCPROC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:14:02 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:44941 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263966AbUCPRLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:11:00 -0500
Date: Tue, 16 Mar 2004 18:10:38 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs
Message-ID: <20040316171038.GA27046@wohnheim.fh-wedel.de>
References: <20040315235243.GA21416@wohnheim.fh-wedel.de> <200403161618.i2GGITKK004831@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200403161618.i2GGITKK004831@eeyore.valparaiso.cl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 March 2004 12:18:29 -0400, Horst von Brand wrote:
> =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> said:
> > Horst von Brand <vonbrand@inf.utfsm.cl> said:
> 
> > What looks like a promising idea for this problem and others is to
> > have visible and invisible inodes.  All current filesystems know only
> > visible inodes.  Invisible ones have no dentry linking to them
> > directly, only indirectly through files/links with cow semantics.
> 
> But this is then _one_ filesystem, not a stack of them added/deleted in
> random order while running. _So_ it is easy... and mostly useless.

Maybe.  I personally don't care much about links between filesystems,
but some people seem to, so there should be some use.

BTW: Why would you want to mount/umount filesystems in a stack in
random order?

> > Yeah, maybe.  My personal consensus right now is that this actually
> > looks very simple.  Not sure how much time I will find, but it should
> > definitely be finished for 2.8.
> 
> As I said: Not too hard, doable. But not sensibly. And needs to mess with
> _all_ filesystems (on disk and kernel guts) if they want to someday perhaps
> somewhere participate...  Besides, the people asking for this mostly really
> want version control, or get what they want from symlink farms.

So what?  Yes, I have to tweak vfs, but mainly to save tons of memory.
Cannot imagine too many complaints against that.  All filesystems that
want stacking capability have to be changed, the rest can set a couple
of pointers to NULL.  Effectively it will come down to ext[23], maybe
reiser and xfs plus those fifty special purpose filesystems that never
make it into linus' tree anyway.

And version control is something I actually want to be done inside the
kernel, at least to some degree.  People already use kernel support,
although it sucks (cp -lr anyone?).  Looks like the alternatives suck
even more, so your point is void.

Jörn

-- 
/* Keep these two variables together */
int bar;
