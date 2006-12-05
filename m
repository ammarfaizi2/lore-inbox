Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936851AbWLEWiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936851AbWLEWiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936829AbWLEWiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:38:15 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:60782 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936851AbWLEWiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:38:13 -0500
Date: Tue, 5 Dec 2006 17:38:07 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fsstack: Fix up ecryptfs's fsstack usage
Message-ID: <20061205223807.GA7300@filer.fsl.cs.sunysb.edu>
References: <20061204204024.2401148d.akpm@osdl.org> <20061205191824.GB2240@filer.fsl.cs.sunysb.edu> <20061205192231.GD2240@filer.fsl.cs.sunysb.edu> <20061205142831.9cb3e91c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205142831.9cb3e91c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 02:28:31PM -0800, Andrew Morton wrote:
> On Tue, 5 Dec 2006 14:22:32 -0500
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> 
> > Fix up a stray ecryptfs_copy_attr_all call and remove prototypes for
> > ecryptfs_copy_* as they no longer exist.
> > 
> > Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> > ---
> >  fs/ecryptfs/dentry.c          |    2 +-
> >  fs/ecryptfs/ecryptfs_kernel.h |    4 +---
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
> > index 52d1e36..b0352d8 100644
> > --- a/fs/ecryptfs/dentry.c
> > +++ b/fs/ecryptfs/dentry.c
> > @@ -61,7 +61,7 @@ static int ecryptfs_d_revalidate(struct
> >  		struct inode *lower_inode =
> >  			ecryptfs_inode_to_lower(dentry->d_inode);
> >  
> > -		ecryptfs_copy_attr_all(dentry->d_inode, lower_inode);
> > +		fsstack_copy_attr_all(dentry->d_inode, lower_inode, NULL);
> 
> I fixed that two weeks ago.
> 
> When your patches are queued in -mm please do test them there, and review
> others' changes to them, and raise patches against them.  Raising patches
> against one's private tree and not testing the code which is planned to be
> merged can introduce errors.

Sorry about that. I noticed your fix, and the one by Adrian. And I did add
them to my fsstack queue.

I must have dropped it accidentally.

Josef "Jeff" Sipek.

-- 
If I have trouble installing Linux, something is wrong. Very wrong.
		- Linus Torvalds
