Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135994AbRD0LpW>; Fri, 27 Apr 2001 07:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135998AbRD0LpN>; Fri, 27 Apr 2001 07:45:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:25473 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135994AbRD0LpE>; Fri, 27 Apr 2001 07:45:04 -0400
Date: Fri, 27 Apr 2001 07:43:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alexander Viro <viro@math.psu.edu>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.GSO.4.21.0104261651110.15385-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.3.95.1010427073924.29572A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Alexander Viro wrote:

> 
> 
> On Thu, 26 Apr 2001, Richard B. Johnson wrote:
> 
> > The disk image, raw.bin, does NOT contain the image of the floppy.
> > Most of boot stuff added by lilo is missing. It will eventually
> > get there, but it's not there now, even though the floppy was
> > un-mounted!
> 
> I doubt that you can reproduce that on anything remotely recent.
> All buffers are flushed when last user closes device.
> 
    2.4.3

Buffers are not flushed (actually written) to disk. The floppy continues
to be written for 20 to 30 seconds after  `umount` returns to
the shell. A program like `cp` , accessing the raw device during this time
does not get what will eventually be written.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


