Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130151AbQKWTfQ>; Thu, 23 Nov 2000 14:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130147AbQKWTfH>; Thu, 23 Nov 2000 14:35:07 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:14604 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S129097AbQKWTex>; Thu, 23 Nov 2000 14:34:53 -0500
Date: Thu, 23 Nov 2000 13:01:25 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Ben LaHaise <bcrl@redhat.com>
Subject: Re: [patch] O_SYNC patch 3/3, add inode dirty buffer list support to ext2
Message-ID: <20001123130125.B23067@vger.timpanogas.org>
In-Reply-To: <20001122112646.D6516@redhat.com> <20001122115424.A18592@vger.timpanogas.org> <20001123120135.D8368@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001123120135.D8368@redhat.com>; from sct@redhat.com on Thu, Nov 23, 2000 at 12:01:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 12:01:35PM +0000, Stephen C. Tweedie wrote:
> Hi,
> 
> On Wed, Nov 22, 2000 at 11:54:24AM -0700, Jeff V. Merkey wrote:
> > 
> > I have not implemented O_SYNC in NWFS, but it looks like I need to add it 
> > before posting the final patches.  This patch appears to force write-through 
> > of only dirty inodes, and allow reads to continue from cache.  Is this
> > assumption correct
> 
> Yes: O_SYNC is not required to force reads to be made from disk.
> SingleUnix has an "O_RSYNC" option which does that, but O_SYNC and
> O_DSYNC don't imply that.

Cool.  ORACLE is going to **SMOKE** on EXT2 with this change.

Jeff

> 
> Cheers,
>  Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
