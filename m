Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbRALV4X>; Fri, 12 Jan 2001 16:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129886AbRALV4N>; Fri, 12 Jan 2001 16:56:13 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4612 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129595AbRALV4H>;
	Fri, 12 Jan 2001 16:56:07 -0500
Message-ID: <20010112192706.A618@bug.ucw.cz>
Date: Fri, 12 Jan 2001 19:27:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <20010108180857.A26776@athlon.random> <Pine.GSO.4.21.0101081236440.4061-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.GSO.4.21.0101081236440.4061-100000@weyl.math.psu.edu>; from Alexander Viro on Mon, Jan 08, 2001 at 12:58:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The bottom line: rmdir(".") is gone. Replace it with portable equivalent,
> namely
> 	p = getcwd(pwd, sizeof(pwd));
> 	if (!p)
> 		/* handle error - ERANGE or ENOENT */
> 	rmdir(p);
> Shell equivalent is rmdir `pwd`. Also portable.

...when you are lucky and all directories up to your path are
readable... Which is not always so. With old glibc, it will fail.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
