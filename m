Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbTA2Q6C>; Wed, 29 Jan 2003 11:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266438AbTA2Q6C>; Wed, 29 Jan 2003 11:58:02 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:49917 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266514AbTA2Q6A>; Wed, 29 Jan 2003 11:58:00 -0500
Message-Id: <200301291425.h0TEPQ9o001322@eeyore.valparaiso.cl>
To: Steven Dake <sdake@mvista.com>
cc: LKML <linux-kernel@vger.kernel.org>, brand@eeyore.valparaiso.cl
Subject: Re: New model for managing dev_t's for partitionable block devices 
In-Reply-To: Your message of "Tue, 28 Jan 2003 10:20:31 MST."
             <3E36BBDF.4090104@mvista.com> 
Date: Wed, 29 Jan 2003 15:25:26 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Dake <sdake@mvista.com> said:
> I was thinking of an entirely new model for partitionable block devices. 
> Here is how it would work:
> 
> Each physical disk would be assigned a minor number in a group of 
> majors.  So assume a major was chosen of 150, 151, 152, 153, there would 
> be a total of 1024 physical disks that could be mapped.  Then the device 
> mapper code could be used to provide partition devices in another 
> major/group of majors.
> 
> The advantage of this technique is that instead of wasting tons of 
> minors on partitions that are never used, partitions could be 
> dynamically allocated out of the minor list, allowing for thousands of 
> disks with varying numbers of partitions each.  Further instead of each 
> block device (such as i2o, scsi, etc) having their own set of majors for 
> each partitionable disk (which wastes dev_t address space) everything 
> would be compressed into the same set of majors.

Great idea! Add another partition, and the minors for everything else on
the system change. Not!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
