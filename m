Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131115AbQK2QSs>; Wed, 29 Nov 2000 11:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131607AbQK2QSi>; Wed, 29 Nov 2000 11:18:38 -0500
Received: from [62.172.234.2] ([62.172.234.2]:61760 "EHLO
        localhost.localdomain") by vger.kernel.org with ESMTP
        id <S131115AbQK2QS2>; Wed, 29 Nov 2000 11:18:28 -0500
Date: Wed, 29 Nov 2000 15:46:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andries Brouwer <aeb@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <Pine.GSO.4.21.0011290711430.14112-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011291533340.4535-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Alexander Viro wrote:
> 
> On Wed, 29 Nov 2000, Hugh Dickins wrote:
> 
> > Yes, and I think you'll have difficulty, Andries, finding
> > any other Unices which interpret the standard as you and
> > Linux do: Solaris, HP-UX, UnixWare and OpenServer all allow
> > writing to a device node (or FIFO) on read-only filesystem.
> 
> 	has r/o filesystems	access()	open()
> What you are saying is that recent SysV variants have
> 		yes		?		ok
> Nice, but what do they do on access()? If they do not return EROFS for
> devices - that's it, standard needs to be fixed and 2.2 should drop the
> special-casing in sys_access().

Sorry, I missed the point at issue here, and what changed when.
Assuming (perhaps wrongly) it's independent of filesystem type,

Solaris         yes             ok              ok
HP-UX           yes             EROFS           ok

I don't have UnixWare or OpenServer at hand to test,
guess UnixWare as Solaris, can report OpenServer tomorrow.
But it looks like a Floridan answer.

Hugh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
