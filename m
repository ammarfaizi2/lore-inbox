Return-Path: <linux-kernel-owner+w=401wt.eu-S1750822AbXAHXiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbXAHXiU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbXAHXiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:38:20 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:52531 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbXAHXiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:38:19 -0500
Date: Mon, 8 Jan 2007 18:37:37 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: Shaya Potter <spotter@cs.columbia.edu>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070108233737.GC1269@filer.fsl.cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu> <1168229596875-git-send-email-jsipek@cs.sunysb.edu> <20070108111852.ee156a90.akpm@osdl.org> <Pine.LNX.4.63.0701081442230.19059@razor.cs.columbia.edu> <20070108131957.cbaf6736.akpm@osdl.org> <1168291848.9853.1.camel@localhost.localdomain> <20070108140224.3a814b7d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108140224.3a814b7d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 02:02:24PM -0800, Andrew Morton wrote:
> On Mon, 08 Jan 2007 16:30:48 -0500
> Shaya Potter <spotter@cs.columbia.edu> wrote:
> 
> > On Mon, 2007-01-08 at 13:19 -0800, Andrew Morton wrote:
> > > On Mon, 8 Jan 2007 14:43:39 -0500 (EST) Shaya Potter <spotter@cs.columbia.edu> wrote:
> > > >  It's the same thing as modifying a block 
> > > > device while a file system is using it.  Now, when unionfs gets confused, 
> > > > it shouldn't oops, but would one expect ext3 to allow one to modify its 
> > > > backing store while its using it?
> > > 
> > > There's no such problem with bind mounts.  It's surprising to see such a
> > > restriction with union mounts.
> > 
> > the difference is bind mounts are a vfs construct, while unionfs is a
> > file system.
> 
> Well yes.  So the top-level question is "is this the correct way of doing
> unionisation?".
 
Namespace unification doesn't seem to fit into neither vfs-only nor fs-only
category. My guess is that some of the code that's currently in unionfs
could be replaced by some vfs-level magic.
 
> I suspect not, in which case unionfs is at best a stopgap until someone
> comes along and implements unionisation at the VFS level, at which time
> unionfs goes away.
> 
> That could take a long time.  The questions we're left to ponder over are
> things like
> 
> a) is unionfs a sufficiently useful stopgap to justify a merge and

We (unionfs team) think so :)

> b) would an interim merge of unionfs increase or decrease the motivation
>    for someone to do a VFS implementation?

And is a VFS implementation the right way to do it?

> I suspect the answer to b) is "increase": if unionfs proves to be useful
> then people will be motivated to produce more robust implementations of the
> same functionality.

I think it would "increase" the chance of people doing the right thing -
whatever it may be.

> Is there vendor interest in unionfs?

Many people are currently using the full - lkml-unsafe :) version of the
code which has a considerable amount of bells and whistles - at least
compared to the minimal version submitted. I want to take the good things
"port" them over and make sure everything is good.

Josef "Jeff" Sipek.

-- 
The box said "Windows XP or better required". So I installed Linux.
