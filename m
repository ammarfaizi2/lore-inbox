Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319352AbSIFT2N>; Fri, 6 Sep 2002 15:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319354AbSIFT2M>; Fri, 6 Sep 2002 15:28:12 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:8426 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S319352AbSIFT2L>; Fri, 6 Sep 2002 15:28:11 -0400
Message-Id: <5.1.0.14.2.20020906203045.03eb8980@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 06 Sep 2002 20:32:50 +0100
To: Daniel Phillips <phillips@arcor.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E17nMzU-0006I3-00@starship>
References: <Pine.SOL.3.96.1020906164920.7282A-100000@virgo.cus.cam.ac.uk>
 <Pine.SOL.3.96.1020906164920.7282A-100000@virgo.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:33 06/09/02, Daniel Phillips wrote:
>On Friday 06 September 2002 19:20, Anton Altaparmakov wrote:
> > As of very recently, Andrew Morton introduced an optimization to this with
> > the get_blocks() interface in 2.5 kernels. Now the file system, when doing
> > direct_IO at least, returns to the VFS the requested block position _and_
> > the size of the block. So the VFS now gains in power in that it only needs
> > to ask for each block once as it is now aware of the size of the block.
> >
> > But still, even with this optimization, the VFS still asks the FS for each
> > block, and then the FS has to lookup each block.
>
>Well, it takes no great imagination to see the progression: get_blocks
>acts on extents instead of arrays of blocks.  Expect to see that around
>the 2.7 timeframe.

Isn't that just a matter of terminology? Whether you are calling the 
things  "variable sized blocks" or "extents" they are still the same thing, 
no? So I would say, get_blocks() acts on extents right now. (-: [I may be 
missing your point in which case a small explanation would be appreciated...]

Cheers,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

