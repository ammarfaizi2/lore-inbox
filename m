Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273542AbRIUOTb>; Fri, 21 Sep 2001 10:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273544AbRIUOTV>; Fri, 21 Sep 2001 10:19:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42119 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273542AbRIUOTK>;
	Fri, 21 Sep 2001 10:19:10 -0400
Date: Fri, 21 Sep 2001 10:19:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Steve Lord <lord@sgi.com>
cc: hch@sgi.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Gonyou, Austin" <austin@coremetrics.com>,
        narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: XFS to main kernel source 
In-Reply-To: <200109202131.f8KLVbB19795@jen.americas.sgi.com>
Message-ID: <Pine.GSO.4.21.0109210956150.8014-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Steve Lord wrote:

> Two answers here - economics and code stability. This is a filesystem
> which has been worked on by people being payed to do so by a corporation,
> therefore there is a budget (long since blown). It was simpler and hence
> cheaper to wrap XFS in a conversion layer than to rework the code down
> into the bowels of the filesystem. Then the stability part of it, we
> started with a working filesystem, from an engineering standpoint it 
> made more sense to keep as much of the existing code base intact as
> possible - the less surgery performed the better in terms of keeping
> things running, and making it easy to take enhancements and fixes made
> in the Irix base into the Linux code (we don't do it the other way around).

True, but there's a cost of maintaining the source and reducing the
size of said source by order of magnitude will help to reduce _that_.

The argument would make sense if you were treating everything under
your compatibility layer as a black box, but I sincerely hope that
it's not the case.
 
> >  o checks already peformed by the VFS all over the place
> >    (just take a look at xfs_rename.c!)
> 
> I think I will answer this one more slowly and in response to Al Viro's
> email. But that economics/stability thing comes into it again.

Looking forward to that...  Just documenting the exclusion requirements
of CXFS would help.  Big way.  As it is, you are bordering on the "adding
undocumented API for proprietory module" and while I've got no problems
with the last part (I don't suffer from stallmanellosis), I really don't
like the first one.  Nobody's asking to give up the guts of CXFS, but
having its exclusion requirements documented is a different story.

