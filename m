Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130582AbRCEBnI>; Sun, 4 Mar 2001 20:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130583AbRCEBm6>; Sun, 4 Mar 2001 20:42:58 -0500
Received: from ausxc10.us.dell.com ([143.166.98.229]:51462 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S130582AbRCEBmv>; Sun, 4 Mar 2001 20:42:51 -0500
Message-ID: <CDF99E351003D311A8B0009027457F1403BF9E09@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
Cc: R.E.Wolff@BitWizard.nl, fluffy@snurgle.org
Subject: RE: 2.4 and 2GB swap partition limit
Date: Sun, 4 Mar 2001 16:04:52 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Linus has spoken, and 2.4.x now requires swap = 2x RAM.
> > 
> > I think I missed this.  What possible value does this have? 

A good write-up of the discussion can be found at:
http://kt.zork.net/kernel-traffic/kt20010126_104.html#2


My concern is that if there continues to be a 2GB swap partition/file size
limitation, and you can have (as currently #defined) 8 swap partitions,
you're limited to 16GB swap, which then follows a max of 8GB RAM.  We'd like
to sell servers with 32GB or 64GB RAM to customers who request such for
their applications.  Such customers generally have no problem purchasing
additional disks to be used for swap, likely on a hardware RAID controller.

We've also seen (anecdotal evidence here) cases where a kernel panics, which
we believe may have to do with having 0 < swap < 2x RAM.  We're
investigating further.

> Actually the deal is: either use enough swap (about 2x RAM) or use
> none at all. 

If swap space isn't required in all cases, great!  We'll encourage the use
of swap files as needed, rather than swap partitions.  But, if instead you
*require* swap = 2x RAM, then the 2GB swap size limitation must go.

Thanks,
Matt
	

-- 
Matt Domsch
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux
