Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315530AbSESW7k>; Sun, 19 May 2002 18:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315544AbSESW7j>; Sun, 19 May 2002 18:59:39 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:51169 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315530AbSESW7i>; Sun, 19 May 2002 18:59:38 -0400
Date: Sun, 19 May 2002 23:59:35 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: Andrew Morton <akpm@zip.com.au>
cc: Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/15] larger b_size, and misc fixlets
In-Reply-To: <3CE82CDD.21A125DA@zip.com.au>
Message-ID: <Pine.SOL.3.96.1020519235351.19301A-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 May 2002, Andrew Morton wrote:
> Andreas Dilger wrote:
> > On May 19, 2002  12:39 -0700, Andrew Morton wrote:
> > > -     printk(KERN_ERR "Buffer I/O error on device %s, logical block %ld\n",
> > > -                     bdevname(bh->b_bdev), bh->b_blocknr);
> > > +     printk(KERN_ERR "Buffer I/O error on device %s, logical block %Ld\n",
> > > +                     bdevname(bh->b_bdev), (u64)bh->b_blocknr);
> > 
> > Not that I'm a 64-bit system user/developer, but it is my understanding
> > that u64 == long on a 64-bit platform, so your cast to u64 does not
> > actually change the type of b_blocknr as far as printk is concerned.
> > You would need to cast it to unsigned long long instead.
> 
> Yes, I suppose so.  That more closely matches what "%L" does.

/me can't help it: Didn't I say earlier on that one has to use (unsigned)
long long and not u64? (-; But noone would listen...

But to be fully correct, if you want unsigned long long you really ought
to write %Lu not %Ld... (-8

Cheers,
	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

