Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132249AbQKWMhU>; Thu, 23 Nov 2000 07:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132240AbQKWMhK>; Thu, 23 Nov 2000 07:37:10 -0500
Received: from zeus.kernel.org ([209.10.41.242]:46084 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S129507AbQKWMg6>;
        Thu, 23 Nov 2000 07:36:58 -0500
Date: Thu, 23 Nov 2000 12:01:35 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Ben LaHaise <bcrl@redhat.com>
Subject: Re: [patch] O_SYNC patch 3/3, add inode dirty buffer list support to ext2
Message-ID: <20001123120135.D8368@redhat.com>
In-Reply-To: <20001122112646.D6516@redhat.com> <20001122115424.A18592@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001122115424.A18592@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Wed, Nov 22, 2000 at 11:54:24AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 22, 2000 at 11:54:24AM -0700, Jeff V. Merkey wrote:
> 
> I have not implemented O_SYNC in NWFS, but it looks like I need to add it 
> before posting the final patches.  This patch appears to force write-through 
> of only dirty inodes, and allow reads to continue from cache.  Is this
> assumption correct

Yes: O_SYNC is not required to force reads to be made from disk.
SingleUnix has an "O_RSYNC" option which does that, but O_SYNC and
O_DSYNC don't imply that.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
