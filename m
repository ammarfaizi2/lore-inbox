Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264831AbTE1TBY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264832AbTE1TBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:01:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46983 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264831AbTE1TBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:01:23 -0400
Date: Wed, 28 May 2003 15:17:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 bug: fifo-write causes diskwrites to read-only fs ! 
In-Reply-To: <200305281852.h4SIqWHJ015026@verdi.et.tudelft.nl>
Message-ID: <Pine.LNX.4.53.0305281508140.13318@chaos>
References: <200305281852.h4SIqWHJ015026@verdi.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, Rob van Nieuwkerk wrote:

>
> I wrote:
> > It turns out that Linux is updating inode timestamps of fifos (named
> > pipes) that are written to while residing on a read-only filesystem.
> > It is not only updating in-ram info, but it will issue *physical*
> > writes to the read-only fs on the disk !
> 	.
> 	.
> 	.
> > Sysinfo:
> > --------
> > - various 2.4 kernels including RH-2.4.20-13.9,
> >   but also straight 2.4(ac) ones.
> > - CompactFlash (= IDE disk)
> > - Geode GX1 CPU (i586 compatible)
>
> Forgot to mention: I use an ext2 fs, but maybe it's a generic,
> fs-independant problem.
>
> 	greetings,
> 	Rob van Nieuwkerk

How does it 'know' it's a R/O file-system? Have you mounted it
R/O, mounted it noatime, or just taken whatever you get when
you boot from a ramdisk?

FYI, I created a FIFO with mkfifo, remounted the file-system
R/O, executed `cat` with it's input coming from the FIFO, and
then waited for a few minutes. I then wrote to the FIFO.
The atime did not change with 2.4.20.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

