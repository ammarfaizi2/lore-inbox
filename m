Return-Path: <linux-kernel-owner+w=401wt.eu-S1030254AbXAHWHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbXAHWHy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbXAHWHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:07:54 -0500
Received: from smtp.osdl.org ([65.172.181.24]:47248 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030254AbXAHWHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:07:52 -0500
Date: Mon, 8 Jan 2007 14:02:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-Id: <20070108140224.3a814b7d.akpm@osdl.org>
In-Reply-To: <1168291848.9853.1.camel@localhost.localdomain>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	<1168229596875-git-send-email-jsipek@cs.sunysb.edu>
	<20070108111852.ee156a90.akpm@osdl.org>
	<Pine.LNX.4.63.0701081442230.19059@razor.cs.columbia.edu>
	<20070108131957.cbaf6736.akpm@osdl.org>
	<1168291848.9853.1.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jan 2007 16:30:48 -0500
Shaya Potter <spotter@cs.columbia.edu> wrote:

> On Mon, 2007-01-08 at 13:19 -0800, Andrew Morton wrote:
> > On Mon, 8 Jan 2007 14:43:39 -0500 (EST) Shaya Potter <spotter@cs.columbia.edu> wrote:
> > >  It's the same thing as modifying a block 
> > > device while a file system is using it.  Now, when unionfs gets confused, 
> > > it shouldn't oops, but would one expect ext3 to allow one to modify its 
> > > backing store while its using it?
> > 
> > There's no such problem with bind mounts.  It's surprising to see such a
> > restriction with union mounts.
> 
> the difference is bind mounts are a vfs construct, while unionfs is a
> file system.

Well yes.  So the top-level question is "is this the correct way of doing
unionisation?".

I suspect not, in which case unionfs is at best a stopgap until someone
comes along and implements unionisation at the VFS level, at which time
unionfs goes away.

That could take a long time.  The questions we're left to ponder over are
things like

a) is unionfs a sufficiently useful stopgap to justify a merge and

b) would an interim merge of unionfs increase or decrease the motivation
   for someone to do a VFS implementation?

I suspect the answer to b) is "increase": if unionfs proves to be useful
then people will be motivated to produce more robust implementations of the
same functionality.  If it proves to not be very useful then nobody will
bother doing anything, which in a way would be a useful service.


Is there vendor interest in unionfs?
