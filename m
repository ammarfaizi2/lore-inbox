Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131211AbRAHRcD>; Mon, 8 Jan 2001 12:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130869AbRAHRbn>; Mon, 8 Jan 2001 12:31:43 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:32500 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130511AbRAHRbe>; Mon, 8 Jan 2001 12:31:34 -0500
Date: Mon, 8 Jan 2001 12:31:29 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>, Alexander Viro <viro@math.psu.edu>
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <20010108180857.A26776@athlon.random>
Message-ID: <Pine.LNX.4.30.0101081230160.15703-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I fail to see why this is useful. you can't do anything in the directory
afterwards.

bash# mkdir foobar
bash# cd foobar/
bash# ls
bash# rmdir .
bash# touch foooooo
touch: foooooo: Operation not permitted
bash# ls

Whats the point of it?

On Mon, 8 Jan 2001, Andrea Arcangeli wrote:

> Hello Al,
>
> why `rmdir .` is been deprecated in 2.4.x?  I wrote software that depends on
> `rmdir .` to work (it's local software only for myself so I don't care that it
> may not work on unix) and I'm getting flooded by failing cronjobs since I put
> 2.4.0 on such machine.  `rmdir .` makes perfect sense, the cwd dentry remains
> pinned by me until I `cd ..`, when it gets finally deleted from disk.  I'd like
> if we could resurrect such fine feature (adapting userspace is just a few liner
> but that isn't the point). Comments?
>
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
