Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274299AbRJ0SNY>; Sat, 27 Oct 2001 14:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274305AbRJ0SNO>; Sat, 27 Oct 2001 14:13:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49090 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274299AbRJ0SNL>;
	Sat, 27 Oct 2001 14:13:11 -0400
Date: Sat, 27 Oct 2001 14:13:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: alain@linux.lu
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: <200110271800.f9RI0M803440@hitchhiker.org.lu>
Message-ID: <Pine.GSO.4.21.0110271407570.21545-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Oct 2001, Alain Knaff wrote:

> Register_disk seems to be related to partitions... and is yet another
> place where floppy_fops is handed out. And it doesn't seem to have a
> corresponding unregister_disk function, so this worries me
> somewhat. Who did that, and why didn't he contact me?

In most of the cases (and that includes floppy.c) unregister_disk() would
be invoked by unregister_blkdev().  The only exception (back then, now
we probably have more) would be SCSI.  That stuff got frozen in the middle
of a merge by devfs inclusion (2.3.46 or so).  Right now register_disk()
is no-op for partitionless devices.
 
> Good. But then, what's the point of devfs=only ? I assumed this was

Ask Richard.  Maybe you will be able to get a straight answer.  I hadn't...

