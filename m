Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSEJUJl>; Fri, 10 May 2002 16:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316107AbSEJUJk>; Fri, 10 May 2002 16:09:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35289 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316106AbSEJUJk>;
	Fri, 10 May 2002 16:09:40 -0400
Date: Fri, 10 May 2002 16:09:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com
Subject: Re: [PATCH] iget_locked [5/6]
In-Reply-To: <20020510160817.GF18065@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.GSO.4.21.0205101604450.19226-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 May 2002, Jan Harkes wrote:

> 
> This patch starts taking i_ino dependencies out of the VFS. The FS
> provided test and set callbacks become responsible for testing and
> setting inode->i_ino.
> 
> Because most filesystems are based on 32-bit unique inode numbers
> several functions are duplicated to keep iget_locked a fast path. We
> can avoid unnecessary pointer dereferences and function calls for this
> specific case.

I'd suggest putting the comment above + who's which counterpart
into inode.c.  Otherwise - fine with me.


