Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274654AbRITVS2>; Thu, 20 Sep 2001 17:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274655AbRITVSX>; Thu, 20 Sep 2001 17:18:23 -0400
Received: from [195.223.140.107] ([195.223.140.107]:33525 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274654AbRITVRi>;
	Thu, 20 Sep 2001 17:17:38 -0400
Date: Thu, 20 Sep 2001 23:18:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010920231804.C729@athlon.random>
In-Reply-To: <20010920205942.V729@athlon.random> <Pine.GSO.4.21.0109201530190.5141-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109201530190.5141-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Sep 20, 2001 at 04:41:54PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 04:41:54PM -0400, Alexander Viro wrote:
> 
> 
> On Thu, 20 Sep 2001, Andrea Arcangeli wrote:
> 
> > The second call will do the work if there's something to do. If somebody
> > did an open/read/writes/close in the middle, it should do the work as
> > usual. I actually can see a problem if you use the different inodes, but
> > that will be sorted out too automatically as soon as we stop pinning the
> > inodes.
> 
> 
> Sigh... Try BLKFLSBUF + write() + BLKFLSBUF.

write will return -EIO and second BLKFLSBUF will do nothing.

Andrea
