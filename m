Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316097AbSEJT5I>; Fri, 10 May 2002 15:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316098AbSEJT5H>; Fri, 10 May 2002 15:57:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7872 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316097AbSEJT5G>;
	Fri, 10 May 2002 15:57:06 -0400
Date: Fri, 10 May 2002 15:57:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com
Subject: Re: [PATCH] iget-locked [2/6]
In-Reply-To: <20020510160730.GC18065@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.GSO.4.21.0205101554540.19226-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 May 2002, Jan Harkes wrote:

> 
> Now we introduce iget_locked and iget5_locked. These are similar to
> iget, but return a locked inode and read_inode has not been called. So
> the FS has to call read_inode to initialize the inode and then unlock
> it with unlock_new_inode().
> 
> This patch is based on the icreate patch from the XFS group, i.e.
> it is still pretty much identical except for function naming.

No problems, except for putting exports in inode.c.  ISTR Linus saying that
additional files with exports seriously increase the build time...  Linus?

