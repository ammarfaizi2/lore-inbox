Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274586AbRIYSd5>; Tue, 25 Sep 2001 14:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275141AbRIYSdr>; Tue, 25 Sep 2001 14:33:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30338 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274586AbRIYSdn>;
	Tue, 25 Sep 2001 14:33:43 -0400
Date: Tue, 25 Sep 2001 14:34:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Oliver Xymoron <oxymoron@waste.org>
cc: William Scott Lockwood III <thatlinuxguy@hotmail.com>,
        Padraig Brady <padraig@antefacto.com>,
        Nerijus Baliunas <nerijus@users.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: all files are executable in vfat
In-Reply-To: <Pine.LNX.4.30.0109251323510.17451-100000@waste.org>
Message-ID: <Pine.GSO.4.21.0109251430330.24321-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Sep 2001, Oliver Xymoron wrote:

> On Tue, 25 Sep 2001, Alexander Viro wrote:
> 
> > On Tue, 25 Sep 2001, William Scott Lockwood III wrote:
> >
> > > dmask?
> >
> > Umm... That makes sense.
> 
> Don't know if you already did this with umask, but {umask dmask uid gid}
> probably make sense as per-mountpoint options rather than VFAT-specific
> ones.

OK, let me put it that way: we need to turn stat() into method call
rather than blind access to inode fields.  Then all these problems
will be very easy to deal with.  Variants of such patch exist and
there is no reasons preventing them that stuff in 2.4 (i.e. no
changes are required in filesystems), but it still needs more local
testing.

