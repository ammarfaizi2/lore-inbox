Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278604AbRKFHWr>; Tue, 6 Nov 2001 02:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278579AbRKFHWh>; Tue, 6 Nov 2001 02:22:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:9165 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278604AbRKFHWc>;
	Tue, 6 Nov 2001 02:22:32 -0500
Date: Tue, 6 Nov 2001 02:22:30 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: alain@linux.lu, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: <200111060719.fA67J1j21018@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0111060220250.27713-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Nov 2001, Richard Gooch wrote:

> IIRC that I've told you this already. Here it is again: devfs=only
> serves as a way of enforcing that the devfs entry->driver ops
> connection is the only way of accessing a driver. It deliberately
> breaks the fallback to major-table-lookup.
> 
> And it actually works now. It doesn't require massive 2.5 changes.
> When I boot with devfs=only (which is always), my system still works.

Try rmmod while blkdev_get() (from mount(2) or swapon(2)) sleeps on ->bd_sem.
And think what happens with value of ->bd_op.

