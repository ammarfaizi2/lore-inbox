Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130607AbRCISsa>; Fri, 9 Mar 2001 13:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130615AbRCISsV>; Fri, 9 Mar 2001 13:48:21 -0500
Received: from www.wen-online.de ([212.223.88.39]:24585 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130607AbRCISsH>;
	Fri, 9 Mar 2001 13:48:07 -0500
Date: Fri, 9 Mar 2001 19:47:14 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Alexander Viro <viro@math.psu.edu>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
In-Reply-To: <Pine.GSO.4.21.0103091334020.14558-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0103091944240.586-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Alexander Viro wrote:

> On Fri, 9 Mar 2001, Mike Galbraith wrote:
>
> > I was generally exercising with 'what can I do wrong' scenarios when I
> > noticed some strangness.  If you boot a ramdisk root with init=/bin/sh,
> > mount a drive, cd to it and exec chroot . /bin/sh and then mount proc,
> > proc/mounts shows /dev/root and the freshly mounted drive as both being
> > root.  /dev/root must still be the ramdisk, as no pivot (or playing
> > with remount) had been done at that time.
> >
> > I don't know if it would show the same using two partitions or not,
> > nor if it's a problem.. certainly looks odd though.
>
> Why would it be a problem? /proc/mounts shows names in the context of
> process reading it. We could filter out stuff that happens to be
> outside of visible subtree, but that won't change anything.

Ok.

> Could somebody post the exact way to reproduce the problem? -o remount
> scenario is obvious, but that's a case of you get what you ask for.
> Anything else?

I only managed to kill two devices with one write once.. and I had to
work at it, so nope.

	-Mike

