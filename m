Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130539AbRCISjk>; Fri, 9 Mar 2001 13:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130585AbRCISjc>; Fri, 9 Mar 2001 13:39:32 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:56996 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130539AbRCISjZ>;
	Fri, 9 Mar 2001 13:39:25 -0500
Date: Fri, 9 Mar 2001 13:38:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Galbraith <mikeg@wen-online.de>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103091843130.416-100000@mikeg.weiden.de>
Message-ID: <Pine.GSO.4.21.0103091334020.14558-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Mar 2001, Mike Galbraith wrote:

> I was generally exercising with 'what can I do wrong' scenarios when I
> noticed some strangness.  If you boot a ramdisk root with init=/bin/sh,
> mount a drive, cd to it and exec chroot . /bin/sh and then mount proc,
> proc/mounts shows /dev/root and the freshly mounted drive as both being
> root.  /dev/root must still be the ramdisk, as no pivot (or playing
> with remount) had been done at that time.
> 
> I don't know if it would show the same using two partitions or not,
> nor if it's a problem.. certainly looks odd though.

Why would it be a problem? /proc/mounts shows names in the context of
process reading it. We could filter out stuff that happens to be
outside of visible subtree, but that won't change anything.

Could somebody post the exact way to reproduce the problem? -o remount
scenario is obvious, but that's a case of you get what you ask for.
Anything else?
							Cheers,
								Al

