Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135386AbREDSuJ>; Fri, 4 May 2001 14:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132580AbREDSuA>; Fri, 4 May 2001 14:50:00 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:53123 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S136487AbREDStm>; Fri, 4 May 2001 14:49:42 -0400
Date: Fri, 4 May 2001 12:49:35 -0600
Message-Id: <200105041849.f44InZa11520@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.GSO.4.21.0105041430380.21896-100000@weyl.math.psu.edu>
In-Reply-To: <200105041820.f44IKec11204@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0105041430380.21896-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Fri, 4 May 2001, Richard Gooch wrote:
> 
> > However, doing an ioctl(2) on the block device won't help. So the
> > question is, where to add the hook? One possibility is the FS, and
> > record inum,bnum pairs. But of course we don't have a way of accessing
> > via inum in user-space. So that's no good. Besides, we want to get
> > block numbers on the block device, because that's the only meaningful
> > number to resort.
> > 
> > So, what, then? Some kind of hook on the page cache? Ideas?
> 
> Two of them: use less bloated shell (and link it statically) and
> clean your rc scripts.

No, because I'm not using the latest bloated version of bash, and I'm
not using the slow and bloated RedHat boot scripts. My boot scripts
are lean and mean. Oh. And I already have init(8) warming the cache
with these scripts.

The problem is all the various daemons and system utilities (mount,
hwclock, ifconfig and so on) that turn a kernel into a useful system.
And then of course there's X...

Sorry. A "don't do that then" answer isn't appropriate for this
problem space.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
