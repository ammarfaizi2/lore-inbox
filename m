Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282357AbRK2Gua>; Thu, 29 Nov 2001 01:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282378AbRK2GuW>; Thu, 29 Nov 2001 01:50:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:2178 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S282393AbRK2GuM>;
	Thu, 29 Nov 2001 01:50:12 -0500
Date: Thu, 29 Nov 2001 00:18:59 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org,
        ltp-list@lists.sourceforge.net
Subject: Re: fsync02 test hangs 2.5.1-pre3 + patch
Message-ID: <20011129001859.B17852@earthlink.net>
In-Reply-To: <20011128220329.A2718@earthlink.net> <Pine.GSO.4.21.0111282303190.9271-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0111282303190.9271-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Nov 28, 2001 at 11:12:22PM -0500
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 11:12:22PM -0500, Alexander Viro wrote:
> > This was on a reiserfs system, btw.
> 
> Obvious tests:
> 	a) 2.5.1-pre2

2.5.1-pre2 was fine.

> 	b) 2.5.1-pre2 + fs/super.c from 2.5.1-pre3
> 	c) 2.5.1-pre3 + fs/super.c from 2.5.1-pre2
> (fs/super.c changes are independent from everything else).

I'll try option c and let you know what happens.

> Another possibility is silent fs corruption from 2.5.0/2.4.15 - if you
> ran these kernels you really ought to do fsck -f (or whatever is used
> to force recovery of reiserfs).

I did have some nasty errors while running dbench around those kernel versions.
To be safe, I did a cpio backup and re-mkreiserfs'd three filesystems with 2.4.16.
The filesystem that fsync02 hung on was one of the recently rebuilt filesystems.

-- 
Randy Hron

