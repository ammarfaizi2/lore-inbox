Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264427AbRFYWWj>; Mon, 25 Jun 2001 18:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264497AbRFYWW3>; Mon, 25 Jun 2001 18:22:29 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:49937 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264427AbRFYWWY>; Mon, 25 Jun 2001 18:22:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [Ext2-devel] Re: [UPDATE] Directory index for ext2
Date: Tue, 26 Jun 2001 00:25:32 +0200
X-Mailer: KMail [version 1.2]
Cc: Tony Gale <gale@syntax.dera.gov.uk>, Heusden@mail.bonn-fries.net,
        Folkert van <f.v.heusden@ftr.nl>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>
In-Reply-To: <200106251951.f5PJpOYN025503@webber.adilger.int>
In-Reply-To: <200106251951.f5PJpOYN025503@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <01062600253207.01008@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 June 2001 21:51, Andreas Dilger wrote:
> Daniel writes:
> > > > On Wednesday 20 June 2001 16:59, Tony Gale wrote:
> > > > > The main problem I have with this is that e2fsck doesn't know how
> > > > > to deal with it - at least I haven't found a version that will.
> > > > > This makes it rather difficult to use, especially for your root fs.
> >
> > Sure, if your root partition is expendable, by all means go ahead.  Ted
> > has already offered to start the required changes to e2fsck, which
> > reminds me, I have to send the promised docs.  For now, just use normal
> > fsck and it will (in theory) turn the directory indexes back into normal
> > file blocks, and have no effect on inodes.
>
> This is only true without the COMPAT_DIR_INDEX flag.  Since e2fsck _needs_
> to know about every filesystem feature, it will (correctly) refuse to touch
> such a system for now.  You could "tune2fs -O ^FEATURE_C4 /dev/hdX" to
> turn of the COMPAT_DIR_INDEX flag and let e2fsck go to town.  That will
> break all of the directory indexes, I believe.

This is what he wants, a workaround so he can fsck.  However, the above 
command (on version 1.2-WIP) just gives me:

   Invalid filesystem option set: ^FEATURE_C4

Maybe he should just edit the source so it doesn't set the superblock flag 
for now.

BTW, there doesn't seem to be a --version command in tune2fs.

--
Daniel
