Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277873AbRJNVu0>; Sun, 14 Oct 2001 17:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277878AbRJNVuG>; Sun, 14 Oct 2001 17:50:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38650 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277873AbRJNVuF>;
	Sun, 14 Oct 2001 17:50:05 -0400
Date: Sun, 14 Oct 2001 17:50:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Gietl <a.gietl@e-admin.de>
cc: linux-kernel@vger.kernel.org, =?iso-8859-1?q?Kr=E4mer?= <kraemer@crasu.de>,
        =?iso-8859-1?q?K=FChne?= <kuehne@power-netz.de>
Subject: Re: fs mounted twice, writing to wrong partition with 3ware escalade
 ide-raid
In-Reply-To: <E15sqSI-0008P9-00@d101.x-mailer.de>
Message-ID: <Pine.GSO.4.21.0110141743320.7054-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Oct 2001, Andreas Gietl wrote:

> a strace on the mount command shows that the syscall mount is executed w/o 
> error.
> 
> mount("/dev/sda5", "/mnt/", "ext2", 0xc0ed0000, 0) = 0  
> 
> As far as i know it should return EBUSY on a fs that is already mounted.

No, it shouldn't.  HOWEVER, trees should be in sync (actually, there's
only one tree and only one superblock).

> Second mystery:
> 
> the mounted /dev/hda3 contains the same data as /dev/sda5 and changes to one 
> of them affect both partitions.

Please, post your /proc/mounts.  Results of ls -l /dev/hda3 /dev/sda5
would also be very interesting.

