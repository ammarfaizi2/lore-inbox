Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADFGp>; Thu, 4 Jan 2001 00:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRADFG0>; Thu, 4 Jan 2001 00:06:26 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:38860 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129324AbRADFGS>;
	Thu, 4 Jan 2001 00:06:18 -0500
Date: Thu, 4 Jan 2001 00:06:00 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Oliver Xymoron <oxymoron@waste.org>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Dilger <adilger@enel.ucalgary.ca>,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: [RFC] ext2_new_block() behaviour
In-Reply-To: <Pine.LNX.4.30.0101032234450.1971-100000@waste.org>
Message-ID: <Pine.GSO.4.21.0101032355040.19195-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2001, Oliver Xymoron wrote:

> On Wed, 3 Jan 2001, Alexander Viro wrote:
> 
> > On Wed, 3 Jan 2001, Stephen C. Tweedie wrote:
> >
> > > Having preallocated blocks allocated immediately is deliberate:
> > > directories grow slowly and remain closed most of the time, so the
> > > normal preallocation regime of only preallocating open files and
> > > discarding preallocation on close just doesn't work.
> >
> > Erm. For directories we would not have the call of discard_prealloc()
> > on close(2) - they have NULL ->release() anyway and for them it would
> > happen only on ext2_put_inode(), i.e. upon the final dput(). Which would
> > not happen while some descendent would stay in dcache.
> 
> I bet it long predates dcache though..

Not too likely. <checking CVS> It went in in 2.1.93. Apr 2 1998...
Dcache was there ~50 versions before that.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
