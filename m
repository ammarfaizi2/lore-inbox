Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136480AbREDSf7>; Fri, 4 May 2001 14:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136482AbREDSft>; Fri, 4 May 2001 14:35:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47607 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136480AbREDSff>;
	Fri, 4 May 2001 14:35:35 -0400
Date: Fri, 4 May 2001 14:35:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <200105041820.f44IKec11204@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0105041430380.21896-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 May 2001, Richard Gooch wrote:

> However, doing an ioctl(2) on the block device won't help. So the
> question is, where to add the hook? One possibility is the FS, and
> record inum,bnum pairs. But of course we don't have a way of accessing
> via inum in user-space. So that's no good. Besides, we want to get
> block numbers on the block device, because that's the only meaningful
> number to resort.
> 
> So, what, then? Some kind of hook on the page cache? Ideas?

Two of them: use less bloated shell (and link it statically) and clean
your rc scripts.

