Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130090AbRACKAl>; Wed, 3 Jan 2001 05:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130247AbRACKAV>; Wed, 3 Jan 2001 05:00:21 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:52618 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130090AbRACKAR>;
	Wed, 3 Jan 2001 05:00:17 -0500
Date: Wed, 3 Jan 2001 04:29:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dan Aloni <karrde@callisto.yi.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in prune_dcache (2.4.0-prerelease)
In-Reply-To: <Pine.LNX.4.21.0101031022200.6614-100000@callisto.yi.org>
Message-ID: <Pine.GSO.4.21.0101030424240.15658-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2001, Dan Aloni wrote:

> After a bit of few code reviewing, it looks like the only code that
> assigns stuff to ->d_op in a nonstandard way is in fs/vfat/namei.c. 
> 
> Udo, are you using vfat?

	If it was assigned by something that was supposed to set ->d_op
it would not get such value. Whatever had done that had no idea of the
->d_op or struct dentry in the first place.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
