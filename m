Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263058AbTCLGEa>; Wed, 12 Mar 2003 01:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263061AbTCLGEa>; Wed, 12 Mar 2003 01:04:30 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:37674 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S263058AbTCLGE0>; Wed, 12 Mar 2003 01:04:26 -0500
Date: Wed, 12 Mar 2003 07:07:26 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <b4lvk2$vcd$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.30.0303120622290.15538-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Mar 2003, Linus Torvalds wrote:
>
> If there is a well-known list of compilers, we should put a BIG warning
> in some core kernel file to guide people to upgrade (or maybe work

Not enough, nobody would notice and today most end user doesn't
compile the kernel himself, they are just shipped by a broken kernels.

We *also* need a mechanism to know the kernel was compiled with a
broken compiler (from kernel point of view of course, not the latest
C++ features). Like the 'tainted' approach but this would be marked as
broken/miscompiled/etc. To be able to tell the user *immediately* to
complain to his vendor instead hunting/finding the bug again and
again, as happening now.

I know all compiler is broken but the severities are different.

> around it by forcing -fno-frame-pointer if that fixes it for the
> affected compilers).

I also doubt this. There are things suppose the code was compiled
otherwise.

> Do we have a list?

Impossible. Vendors have their own versioning when they patch the
compiler.

Only way I see is to detect it at build time, BIG warning to the user
of compiler, print a well visible "kernel was built by broken tools"
message at boot time to end users and marking the kernel 'broken' in
case it oopses for developers.

And the badly broken compilers' case is closed. Once ..... well, at
least for a given compiler bug, but the infrastructure would be there
to deal with them in the future, if kernel can't workaround them.

BTW, if possible having the Code both before and after when a fault
happens could also help a lot in the future.

And in general, an oops counter would be also useful, not spending too
much time decoding potentialy bogus oopses.

	Szaka

