Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUDGNEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 09:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUDGNEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 09:04:15 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:50347 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263295AbUDGNEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 09:04:10 -0400
Subject: Re: [PATCH] reiserfs v3 fixes and features
From: Yury Umanets <yury@clusterfs.com>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1081274618.30828.30.camel@watt.suse.com>
References: <1081274618.30828.30.camel@watt.suse.com>
Content-Type: text/plain
Organization: Cluster File Systems Inc.
Message-Id: <1081343178.3042.2.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Apr 2004 16:06:18 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 21:03, Chris Mason wrote:
> Hello everyone,
> 
> You can download the set of experimental reiserfs v3 patches from:
> 
> ftp://ftp.suse.com/pub/people/mason/patches/reiserfs/2.6.5
> 
> Since some of these are in -mm and some are not, there are two series
> files.  series.linus gives you the patches needed for mainline 2.6.5,
> and series.mm gives you the patches needed for 2.6.5-mm1
> 
> Most of these are from Jeff Mahoney and I, they include:
> 
> bug fixes
> logging optimizations
> data=ordered support
> xattrs
> acls
> quotas
> error messages with device names (based on Oleg's 2.4 patch)
> block allocator improvements
> 
> Jeff Mahoney's acls and xattrs for reiserfs v3 have been in use in the
> suse 2.4 kernels and now 2.6 kernels for a while.  I've posted for
> review to namesys many times, but Hans refuses to consider or read the
> code.   I renewed my efforts over the last month to talk with him about
> the code, but he has ignored it entirely.
> 
> His past objections seem to be that he doesn't want new features in v3. 
> The implementation does not change the disk format in any way (xattrs
> are stored as regular files in a hidden directory) and is stable.  I
> believe reiserfs needs these features in order to stay current in the
> kernel, so I'm posting for inclusion in -mm.  I'm sending Andrew the
> following patches from series.mm:
> 
> reiserfs-end-trans-bkl 
> reiserfs-acl-mknod.diff 
> reiserfs-xattrs-04 
> reiserfs-acl-02 
> reiserfs-trusted-02 
> reiserfs-selinux-02 
> reiserfs-xattr-locking-02 
> reiserfs-quota 
> permission-reiserfs 
> reiserfs-warning 
> 
> (which is everything except the new block allocator code)
> 
> The block allocator improvements is our attempt to reduce
> fragmentation.  The patch defaults to the regular 2.6.5 block allocator,
> but has options documented at the top of the patch that allow grouping
> of blocks by packing locality or object id.  It also has an option to
> inherit lightly used packing localities across multiple subdirs, which
> keeps things closer together in the tree if you have a bunch of subdirs
> without much in them.
> 
> If anyone is interested in experimenting with the block allocator stuff,
> please let me know.
> 
> -chris
> 
Hello Chris,

That would be nice to have also improved locking in this
features-improvements-fixes patch set. Ask Oleg, he had intention to
work on and probably has something done already.

Thanks.

-- 
umka

