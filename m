Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbRESJUe>; Sat, 19 May 2001 05:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261737AbRESJUY>; Sat, 19 May 2001 05:20:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:19626 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261724AbRESJUO>;
	Sat, 19 May 2001 05:20:14 -0400
Date: Sat, 19 May 2001 05:20:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
 inuserspace
In-Reply-To: <3B0638D1.9AF50C79@uow.edu.au>
Message-ID: <Pine.GSO.4.21.0105190518220.5339-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Andrew Morton wrote:

> Alexander Viro wrote:
> > 
> > > (2) what about bootstrapping?  how do you find the root device?
> > > Do you do "root=/dev/hda/offset=63,limit=1235823"?  Bit nasty.
> > 
> > Ben's patch makes initrd mandatory.
> > 
> 
> Can this be fixed?  I've *never* had to futz with initrd.
> Probably most systems are the same.  It seems a step
> backward to make it necessary.

Well, if you remove partition table parsing from the kernel - you've
got to boot with root on unpartitioned device (e.g. /dev/ram0) and
either stay that way or bring the userland code that understands
partitioning on that device...

