Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbTJNOyc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 10:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTJNOyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 10:54:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15232 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262669AbTJNOy3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 10:54:29 -0400
Date: Tue, 14 Oct 2003 10:54:22 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: jlnance@unity.ncsu.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
In-Reply-To: <20031014143047.GA6332@ncsu.edu>
Message-ID: <Pine.LNX.4.53.0310141043570.892@chaos>
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it>
 <Pine.LNX.4.44.0310140917540.3754-100000@chimarrao.boston.redhat.com>
 <20031014143047.GA6332@ncsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003 jlnance@unity.ncsu.edu wrote:

> On Tue, Oct 14, 2003 at 09:24:17AM -0400, Rik van Riel wrote:
> > On Tue, 14 Oct 2003, Marco Fioretti wrote:
> >
> > > There are literally thousands of schools, all over the world, which
> > > simply cannot afford any money on computers. The "HW is cheap" slogan is
> > > very cruel when recited in places where 64 MB of RAM are one month's
> > > salary. I am not kidding.
>
> Let me concur with the sentiments on this thread.
>
> When I started using Linux, it was on a 40 MHz 386 with 8Megs of ram and
> a 200 Meg HD.  This was a reasonably typical machine for the time (1993).
> I ran X on this machine, and it was fine running several Xterms and you
> could play the X version of Tetris or gnuchess.  I used this machine to
> write the program I was working on for my Masters degree.

Information:

Booting Linux-2.4.22 with mem=16M, I can still compile the
kernel as `make -j 16 bzImage` with the following resources:


        total:    used:    free:  shared: buffers:  cached:
Mem:  14544896 14118912   425984        0   274432  6713344
Swap: 1069268992 16510976 1052758016
MemTotal:        14204 kB
MemFree:           416 kB
MemShared:           0 kB
Buffers:           268 kB
Cached:           3264 kB
SwapCached:       3320 kB
Active:           5980 kB
Inactive:         2944 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        14204 kB
LowFree:           388 kB
SwapTotal:     1044208 kB
SwapFree:      1028084 kB

After a `make clean`, this configuration normally takes
about 3 minutes to compile. With mem=16M, it takes about
12 minutes. Not too bad.

The kernel is as 'modular' as one can make it. I don't have
any built-in stuff that I don't use. This helps keep it
small. But...it is growing in size for no obvious gain.
-rwxr-xr-x   1 root     root      1532520 Mar 13  2003 vmlinux
                                  ^^^^^^^___ linux-2.4.20
-rwxr-xr-x   1 root     root      1567340 Oct 14 09:39 vmlinux
                                  ^^^^^^^___ linux-2.4.22
Both of these kernels have the exact configuration and are
built with the exact same tools.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


