Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSGLOS6>; Fri, 12 Jul 2002 10:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSGLOS5>; Fri, 12 Jul 2002 10:18:57 -0400
Received: from conn6m.toms.net ([64.32.246.219]:30421 "EHLO conn6m.toms.net")
	by vger.kernel.org with ESMTP id <S316532AbSGLOS4>;
	Fri, 12 Jul 2002 10:18:56 -0400
Date: Fri, 12 Jul 2002 10:21:36 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: Christian Ludwig <cl81@gmx.net>
cc: Daniel Phillips <phillips@arcor.de>, Ville Herva <vherva@niksula.hut.fi>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: bzip2 support against 2.4.18
In-Reply-To: <000901c2296e$7cab2ed0$1c6fa8c0@hyper>
Message-ID: <Pine.LNX.4.44.0207121011260.23208-100000@conn6m.toms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > How about bz2Image, or, more natural in my mind, bz2linux.

> Sure "bz2bzImage" is a bit ugly. I personally would prefer bzImage.bz2,

I chose the name bz2bzImage and have been using it on tomsrtbt since 2.0.0,
the reason I chose it was to make as clear as possible that it is still a
big/compressed image and that the bz2 is additional/different.  I get a lot
of confusion from users who assume that bzImage *already* has something to do
with bzip2.  I tried to convey that it was a "Bzip2-Big-Compressed-image"
rather than a "normal" "Big-Compressed-image".  I still prefer it to either
bz2Image or bzImage.? or bzip2Image.  But I don't really care.

Note, I have gotten it to work fine with a 4MB machine on 2.2.x, so 2.4.x
will probably work on 4MB also in some smaller kernel configurations.  Also,
the speed penalty was not problematic even on 486 machines.  See my post a
few months ago for details.  But, overall, it is fine on an 8MB 486, and I
think it is useful enough in embedded and floppy and flash environments that
it would be worthwhile.

Does your mod of my patch support configuring the normal vs. "small" option?
Also, does it support choosing the compression-level-number?  Does it support
using gzip/bzip2 one for the kernel and the other for the ramdisk in either
combination?  My original patch was only "small", disabled gzip, and I think
used "-9" compression for both the kernel and the ramdisk.

-Tom



