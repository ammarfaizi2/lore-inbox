Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbRGNM3H>; Sat, 14 Jul 2001 08:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbRGNM25>; Sat, 14 Jul 2001 08:28:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:56559 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267640AbRGNM2t>;
	Sat, 14 Jul 2001 08:28:49 -0400
Date: Sat, 14 Jul 2001 08:28:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Abramo Bagnara <abramo@alsa-project.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        nfs-devel@linux.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] [PATCH] Bug in NFS - should init be allowed to set umask???
In-Reply-To: <15184.9379.88029.737764@notabene.cse.unsw.edu.au>
Message-ID: <Pine.GSO.4.21.0107140823430.21170-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Jul 2001, Neil Brown wrote:

> > It is. Ability to connect == write permissions on AF_UNIX socket. So
> > umask matters.
> 
> I certainly appreciate that permissions on an AF_UNIX socket matter,
> but wondered why they were set to "sock->inode->i_mode" rather than
> simply 0666.  Maybe - I thought - sock->inode->i_mode already has the
> umask applied in some way, and so re-appling it was not necessary.
> Where-from comes the mode that is in sock->inode->i_mode ?

net/socket.c::sock_alloc().

