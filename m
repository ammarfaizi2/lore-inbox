Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129765AbQKXSiE>; Fri, 24 Nov 2000 13:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129601AbQKXShz>; Fri, 24 Nov 2000 13:37:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35866 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129231AbQKXShn>; Fri, 24 Nov 2000 13:37:43 -0500
Date: Fri, 24 Nov 2000 19:07:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Ben LaHaise <bcrl@redhat.com>
Subject: Re: [patch] O_SYNC patch 3/3, add inode dirty buffer list support to ext2
Message-ID: <20001124190708.B30911@athlon.random>
In-Reply-To: <20001122112646.D6516@redhat.com> <20001122115424.A18592@vger.timpanogas.org> <20001123120135.D8368@redhat.com> <20001123130125.B23067@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001123130125.B23067@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Thu, Nov 23, 2000 at 01:01:25PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 01:01:25PM -0700, Jeff V. Merkey wrote:
> On Thu, Nov 23, 2000 at 12:01:35PM +0000, Stephen C. Tweedie wrote:
> > Hi,
> > 
> > On Wed, Nov 22, 2000 at 11:54:24AM -0700, Jeff V. Merkey wrote:
> > > 
> > > I have not implemented O_SYNC in NWFS, but it looks like I need to add it 
> > > before posting the final patches.  This patch appears to force write-through 
> > > of only dirty inodes, and allow reads to continue from cache.  Is this
> > > assumption correct
> > 
> > Yes: O_SYNC is not required to force reads to be made from disk.
> > SingleUnix has an "O_RSYNC" option which does that, but O_SYNC and
> > O_DSYNC don't imply that.
> 
> Cool.  ORACLE is going to **SMOKE** on EXT2 with this change.

Note that this is nothing new, linux (say 2.2.18pre23) always used the O_SYNC
semantics Stephen implemented in the 2.4.x O_SYNC showstopper bugfix.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
