Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132707AbRDNBok>; Fri, 13 Apr 2001 21:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132708AbRDNBoa>; Fri, 13 Apr 2001 21:44:30 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:1801 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132707AbRDNBoW>; Fri, 13 Apr 2001 21:44:22 -0400
Date: Fri, 13 Apr 2001 19:36:57 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org,
        Linus Torvalds <torvalds@transmeta.com>, Linux390@de.ibm.com
Subject: Re: EXPORT_SYMBOL for chrdev_open 2.4.3
Message-ID: <20010413193657.B15009@vger.timpanogas.org>
In-Reply-To: <20010413183810.A14604@vger.timpanogas.org> <Pine.GSO.4.21.0104132125180.24992-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0104132125180.24992-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Apr 13, 2001 at 09:29:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 09:29:43PM -0400, Alexander Viro wrote:
> 
> On Fri, 13 Apr 2001, Jeff V. Merkey wrote:
> 
> > How are folks supposed to open disk and tape devices from kernel modules
> > without these?  Not everything should be done in user space Al.  If you 
> 
> Normally - filp_open(). If all you want is ioctl on block device -
> blkdev_get() + ioctl_by_bdev() + blkdev_put(). If you want it by
> device _number_ - use bdget().
> 
> > remove blkdev_open I will not be able to properly increment the use 
> > count an a disk device I may be reading or writing to.  
> 


> 	Yes, you will. And I would _really_ advice you to do that by
> name instead of device number - that way you will avoid a lot of pain
> couple of years down the road.


This is **VERY** good to know, and also shows that you in fact have
looked through my code.  

:-)

Jeff


