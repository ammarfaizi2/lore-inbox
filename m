Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTKXVeP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 16:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTKXVeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 16:34:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11136 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261769AbTKXVeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 16:34:14 -0500
Date: Mon, 24 Nov 2003 16:34:43 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Larry McVoy <lm@bitmover.com>, Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: data from kernel.bkbits.net
In-Reply-To: <20031124203321.GA9036@thunk.org>
Message-ID: <Pine.LNX.4.53.0311241628230.3173@chaos>
References: <20031124155034.GA13896@work.bitmover.com>
 <Pine.GSO.4.33.0311241405070.13188-100000@sweetums.bluetronic.net>
 <20031124192432.GA20839@work.bitmover.com> <Pine.LNX.4.53.0311241459320.2333@chaos>
 <20031124203321.GA9036@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Theodore Ts'o wrote:

> On Mon, Nov 24, 2003 at 03:05:24PM -0500, Richard B. Johnson wrote:
> > Attempt to copy the raw drive to /dev/null.  If that works, the
> > drive is likely okay, but the fs got fsucked up by software. You
> > might be able to mount the drive on a 2.4.22 machine if you have a
> > spare. Then you might be able to selectively copy important stuff
> > to another drive, after which you can make a new file-system as
> > a "repair".
>
> The error messages Larry reported were obviously reported by the
> hardware, and were **not** filesystem errors.
>
> 						- Ted

Yes but an attempt to read beyond the limits of the physical
drive will provide you with a lot of **interesting** hardware
errors. This happens if the file-system gets corrupt.

And I'm not implying that the software screwed up either. The
software doesn't know if an "extra" bit was set during a write
to the drive. These things happen asd a result of bad RAM, bad
DMA, and other hardware-corrupting things....

So, the first check is to see if the drive can be read without
any reference to its contents. Since Read/Write is usually the
software implimentation detail of a direction bit, if you can
read, you can usually write.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


