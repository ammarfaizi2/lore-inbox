Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268765AbRG0DPp>; Thu, 26 Jul 2001 23:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268764AbRG0DPe>; Thu, 26 Jul 2001 23:15:34 -0400
Received: from [216.21.153.1] ([216.21.153.1]:15371 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S268765AbRG0DPW>;
	Thu, 26 Jul 2001 23:15:22 -0400
Date: Thu, 26 Jul 2001 20:17:43 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Christopher Allen Wing <wingc@engin.umich.edu>, sentry21@cdslash.net,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Weird ext2fs immortal directory bug (all-in-one)
In-Reply-To: <200107261821.f6QIL4017990@lynx.adilger.int>
Message-ID: <Pine.LNX.4.10.10107262011400.14197-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

It should probably not allow things to be both a directory and a symlink
as well.  I asked the original poster and he indicated the permissions
were "all on" when he first discovered the file. Clearly that's not
a combination fsck should let pass.

 
	Gerhard
 

On Thu, 26 Jul 2001, Andreas Dilger wrote:

> Chris Wing writes:
> > I am assuming that the problem here was that fsck restored a lost inode to
> > lost+found, but the inode had been corrupted and had the immutable bit
> > set.
> > 
> > At the very least, ext2 fsck should complain about ext2 attributes set for
> > symlinks or device files... I have had this same problem myself many times
> > on machines with bad SCSI termination- I end up with unremovable device
> > files thanks to a bogus immutable bit and have to use debugfs to get rid
> > of them.
> 
> It should actually assume that such inodes are corrupt, and either just
> delete them at e2fsck time, or at least clear the "bad" parts of the inode
> before sticking it in lost+found.
> 
> Cheers, Andreas
> 
> PS - I CC'd Ted on this, as he can probably fix this a lot faster than I
>      (I may be able to fix it during another OLS presentation today or
>      tomorrow).
> -- 
> Andreas Dilger                               Turbolinux filesystem development
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

