Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263966AbSJOWDw>; Tue, 15 Oct 2002 18:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264812AbSJOWDw>; Tue, 15 Oct 2002 18:03:52 -0400
Received: from ns.suse.de ([213.95.15.193]:2322 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263966AbSJOWDn> convert rfc822-to-8bit;
	Tue, 15 Oct 2002 18:03:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Add extended attributes to ext2/3
Date: Wed, 16 Oct 2002 00:09:38 +0200
User-Agent: KMail/1.4.3
Cc: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
References: <200210151640.15581.agruen@suse.de> <200210152300.32190.agruen@suse.de> <20021015220144.GK15552@clusterfs.com>
In-Reply-To: <20021015220144.GK15552@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210160009.38099.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 October 2002 00:01, Andreas Dilger wrote:
> On Oct 15, 2002  23:00 +0200, Andreas Gruenbacher wrote:
> > The original ext2_new_inode with no xattr/acl patches calls
> > mark_inode_dirty before unlock_super. This call is not removed in 0.8.50
> > or 0.8.51, but a second call is added below ext2_init_acl. Since
> > ext2_init_acl takes care of dirtying the inode itself this second call is
> > no longer needed (I hope!)
>
> Just as an FYI - marking ext3 inodes dirty is an expensive operation,
> and should be done only once if at all possible (not sure if the same
> code applies to ext3 as you are discussing ext2, but I thought I should
> mention it).

Then I should really think out something to improve that. Thanks.

--Andreas.
