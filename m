Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWHIWi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWHIWi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWHIWi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:38:28 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:9952 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751408AbWHIWi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:38:28 -0400
Date: Wed, 9 Aug 2006 18:37:55 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       ezk@cs.sunysb.edu, dquigley@ic.sunysb.edu, dpquigl@tycho.nsa.gov
Subject: Re: [RFC] Privilege escalation in filesystems
Message-ID: <20060809223755.GD1882@filer.fsl.cs.sunysb.edu>
References: <20060809215200.GB1882@filer.fsl.cs.sunysb.edu> <1155161852.15624.50.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155161852.15624.50.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 06:17:32PM -0400, Trond Myklebust wrote:
> On Wed, 2006-08-09 at 17:52 -0400, Josef Sipek wrote:
...
> > (fs/nfs/nfs4recover.c:nfs4_save_user)
> > current->fsuid = 0;
> > current->fsgid = 0;
> 
> This sort of thing can be defeated by selinux.

I was affraid of that.

> The right way to perform privileged operations is normally to give the
> task to a kernel thread that has the required privileges (for instance a
> work_queue like keventd).

This makes sense. So, I suppose it would make sense to have a per-mount or
per-superblock pdflush-like thread that gets instantiated on mount.

> Ugh. Having the kernel interpret magic directory entries is just evil.
> Having the kernel magically create and remove said entries on behalf of
> the user ought to be punishable by death.

I'd like to hear about anything that is as portable, but not as "evil" :)

> Why can't you use something like an xattr to label opaqueness (or
> visibility!) instead?

The goal is to have as few restrictions as possible - not every file system
supports xattr.

Josef "Jeff" Sipek.

-- 
Bus Error: passangers dumped.
