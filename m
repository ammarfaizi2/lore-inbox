Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272404AbRIYSpi>; Tue, 25 Sep 2001 14:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272465AbRIYSp2>; Tue, 25 Sep 2001 14:45:28 -0400
Received: from waste.org ([209.173.204.2]:32817 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S272404AbRIYSpR>;
	Tue, 25 Sep 2001 14:45:17 -0400
Date: Tue, 25 Sep 2001 13:47:17 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: William Scott Lockwood III <thatlinuxguy@hotmail.com>,
        Padraig Brady <padraig@antefacto.com>,
        Nerijus Baliunas <nerijus@users.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: all files are executable in vfat
In-Reply-To: <Pine.GSO.4.21.0109251430330.24321-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0109251343050.17451-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Alexander Viro wrote:

> On Tue, 25 Sep 2001, Oliver Xymoron wrote:
>
> > Don't know if you already did this with umask, but {umask dmask uid gid}
> > probably make sense as per-mountpoint options rather than VFAT-specific
> > ones.
>
> OK, let me put it that way: we need to turn stat() into method call
> rather than blind access to inode fields.  Then all these problems
> will be very easy to deal with.  Variants of such patch exist and
> there is no reasons preventing them that stuff in 2.4 (i.e. no
> changes are required in filesystems), but it still needs more local
> testing.

Mmm.. all of the above are orthogonal options and yet still part of
stat(), so it's not obvious to me how abstracting stat helps here. It
seems you'd need something like stackable filters over a generic (or
fs-specific) stat().

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

