Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265906AbRFYTx6>; Mon, 25 Jun 2001 15:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265888AbRFYTxr>; Mon, 25 Jun 2001 15:53:47 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:63217 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262856AbRFYTxd>; Mon, 25 Jun 2001 15:53:33 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106251951.f5PJpOYN025503@webber.adilger.int>
Subject: Re: [Ext2-devel] Re: [UPDATE] Directory index for ext2
In-Reply-To: <01062518105001.01008@starship> "from Daniel Phillips at Jun 25,
 2001 06:10:50 pm"
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Mon, 25 Jun 2001 13:51:24 -0600 (MDT)
CC: Tony Gale <gale@syntax.dera.gov.uk>, Heusden@mail.bonn-fries.net,
        Folkert van <f.v.heusden@ftr.nl>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes:
> > > On Wednesday 20 June 2001 16:59, Tony Gale wrote:
> > > > The main problem I have with this is that e2fsck doesn't know how to
> > > > deal with it - at least I haven't found a version that will. This makes
> > > > it rather difficult to use, especially for your root fs.
> 
> Sure, if your root partition is expendable, by all means go ahead.  Ted has 
> already offered to start the required changes to e2fsck, which reminds me, I 
> have to send the promised docs.  For now, just use normal fsck and it will 
> (in theory) turn the directory indexes back into normal file blocks, and have 
> no effect on inodes.

This is only true without the COMPAT_DIR_INDEX flag.  Since e2fsck _needs_
to know about every filesystem feature, it will (correctly) refuse to touch
such a system for now.  You could "tune2fs -O ^FEATURE_C4 /dev/hdX" to
turn of the COMPAT_DIR_INDEX flag and let e2fsck go to town.  That will
break all of the directory indexes, I believe.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
