Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTE1Fnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTE1Fnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:43:47 -0400
Received: from opus.cs.columbia.edu ([128.59.20.100]:39391 "EHLO
	opus.cs.columbia.edu") by vger.kernel.org with ESMTP
	id S264535AbTE1Fnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:43:46 -0400
Subject: Re: permission() operating on inode instead of dentry?
From: Shaya Potter <spotter@cs.columbia.edu>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030528054804.GF27916@parcelfarce.linux.theplanet.co.uk>
References: <1054099180.6942.71.camel@zaphod>
	 <20030528054804.GF27916@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1054101380.7005.113.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 May 2003 01:56:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to assume this mean "it's a reasonable idea, all that matters
is the execution"

On Wed, 2003-05-28 at 01:48, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Wed, May 28, 2003 at 01:19:40AM -0400, Shaya Potter wrote:
> > [please cc: responses to me, have 10k message backlog in l-k folder)
> > 
> > Is there a good reason why the fs permission function operates on the
> > inode instead of the dentry? It would seem if the dentry was passed into
> > the function instead of the inode, one would have a better structure to
> > play with, such as being able to use d_put() to get the real path name. 
> > The inode is still readily accessible from the dentry.
> 
> man grep.
> 
> Then use the resulting knowledge to find the callers of said function in
> the tree.
> 
> Then think where you would get dentry (and vfsmount, since you want path)
> for each of these.  Exclude ones that have them available.  See which
> functions contain the rest of calls.

Why would the calling process not be the right place?  Everything should
have a calling process, or am I missing something?

<snipped how to get it done>

thanks,

shaya

