Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131304AbRCNFu4>; Wed, 14 Mar 2001 00:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131310AbRCNFur>; Wed, 14 Mar 2001 00:50:47 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:34758 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131304AbRCNFub>;
	Wed, 14 Mar 2001 00:50:31 -0500
Date: Wed, 14 Mar 2001 00:49:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <200103140519.f2E5JD606622@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0103140041140.2506-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Mar 2001, Andreas Dilger wrote:

> Yes, I know you _can_ do all sorts of tricks like this, but most people
> don't really do it.  In any case, I would be happy if I could even get

Ugh. That sounds like a work for mount(8), not mount(2), then. BTW, userland
(mount(8)) looks like the only potential user for that.

> "/mnt" from the first mount.  If it comes to the point where I can get
> that, then I will start to worry about "mount --bind".
> 
> This is to store in the ext2 on-disk superblock, which is currently always
> (from dumpe2fs -h /dev/hdX):
> 
> Last mounted on:          <not available>
> 
> To be able to put _something_ there will suit my needs.

OK... I don't like the idea of passing a vfsmount to read_super (for obvious
reasons - ->mnt_count, for one thing), but there may be other ways to do that.
What kind of use (aside of getting rid of <not available> in dumpe2fs
output) do you have in mind?
							Cheers,
								Al

