Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUIDRRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUIDRRS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUIDRRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:17:17 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:5317 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264639AbUIDRRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:17:04 -0400
Date: Sat, 4 Sep 2004 19:16:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] copyfile: sendfile
Message-ID: <20040904171647.GB9765@wohnheim.fh-wedel.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de> <20040904165938.GD8579@wohnheim.fh-wedel.de> <20040904181143.A16644@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040904181143.A16644@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 September 2004 18:11:43 +0100, Christoph Hellwig wrote:
> On Sat, Sep 04, 2004 at 06:59:38PM +0200, Jörn Engel wrote:
> > Creates vfs_sendfile(), which can be called from other places within
> > the kernel.  Such other places include copyfile() and cowlinks.
> > 
> > In principle, this just removes code from do_sendfile() to
> > vfs_sendfile().  On top of that, it adds a check to out_inode,
> > identical to the one on in_inode.  True, the check for out_inode was
> > never needed, maybe that tells you something about the check to
> > in_inode as well. ;)
> 
> Both checks aren't nessecary. 

Ok, will remove them before resending.

> > +++ linux-2.6.9-rc1-mm3/include/linux/syscalls.h	2004-09-04 18:17:15.000000000 +0200
> > @@ -285,6 +285,8 @@
> >  asmlinkage long sys_unlink(const char __user *pathname);
> >  asmlinkage long sys_rename(const char __user *oldname,
> >  				const char __user *newname);
> > +asmlinkage long sys_copyfile(const char __user *from, const char __user *to,
> > +				umode_t mode);
> 
> oesn't seem to belong into this patch.

True, should have been in 3/3.  Thanks.

Jörn

-- 
Anything that can go wrong, will.
-- Finagle's Law
