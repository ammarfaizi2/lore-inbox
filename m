Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290497AbSAQWZ0>; Thu, 17 Jan 2002 17:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290499AbSAQWYp>; Thu, 17 Jan 2002 17:24:45 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28392 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290497AbSAQWYk>;
	Thu, 17 Jan 2002 17:24:40 -0500
Date: Thu, 17 Jan 2002 17:24:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.3-pre1] Fix NFS dentry lookup behaviour
In-Reply-To: <Pine.LNX.4.33.0201171414220.3114-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0201171720390.11155-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Jan 2002, Linus Torvalds wrote:

> 
> On Thu, 17 Jan 2002, Trond Myklebust wrote:
> >
> >  - Close 'cto hole' when doing open(".").
> 
> What's wrong with using the existing "revalidate" approach? I hate the
> notion of adding a special VFS layer call for something like this.

Nothing, especially since it will happen automatically when we switch
to slightly different handling of cwd/root (no user-visible changes,
will allow union-mounts - basically, cleanup of first and last steps
of path_walk()).

