Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267844AbRHAR5c>; Wed, 1 Aug 2001 13:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267843AbRHAR5X>; Wed, 1 Aug 2001 13:57:23 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:45816 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267844AbRHAR5I>; Wed, 1 Aug 2001 13:57:08 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108011756.f71HuuL2006872@webber.adilger.int>
Subject: Re: resizing of raid5?
In-Reply-To: <15207.63232.611617.37794@notabene.cse.unsw.edu.au>
 "from Neil Brown at Aug 1, 2001 10:33:04 pm"
To: Neil Brown <neilb@cse.unsw.edu.au>
Date: Wed, 1 Aug 2001 11:56:56 -0600 (MDT)
CC: Roger Abrahamsson <hyperion@gnyrf.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
> On Wednesday August 1, hyperion@gnyrf.net wrote:
> > Just figured if anyone could give some information about resizing of
> > software raid5 systems (2.4.x kernels)? I've been looking all over for
> > information about if this is possible or not currently, and if not, how
> > this system of raid cluster blocks work in conjunction with ext2.
> 
> The only way to resize a raid5 array is to back up, rebuild, and
> re-load.  Any attempt to re-organise the data, or the linkage, to
> avoid this would be more trouble that it is worth.

Hmm, this surprises me.  I would have thought it possible to do
"resizing" at least by adding new stripes to the end of the current
RAID 5 volume, using N+1 new "disks" to make up a new stripe group.

Adding a new disk into the stripe set and re-striping the whole thing
is definitely a lot harder.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

