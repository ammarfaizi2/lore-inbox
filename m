Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268939AbTCDBJy>; Mon, 3 Mar 2003 20:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268940AbTCDBJy>; Mon, 3 Mar 2003 20:09:54 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:48291 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S268939AbTCDBJx>; Mon, 3 Mar 2003 20:09:53 -0500
Date: Mon, 3 Mar 2003 20:20:20 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Errors in i810 DRM driver, 2.4.21-pre5-ac1
In-Reply-To: <1046737847.7949.9.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.50.0303032007240.21087-100000@marabou.research.att.com>
References: <Pine.LNX.4.50.0303031730410.20127-100000@marabou.research.att.com>
 <1046737847.7949.9.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alan!

> > When I boot 2.4.21-pre5-ac1 on a system with an i810 card and i810 DRM
> > supported in the kernel, following lines are printed continuously to the
> > kernel log:
>
> The DRM in -ac is for XFree86 4.2.99/4.3. It ought to be working in 4.2 as
> well but apparently not.

You are right!  Upgrading to XFree86-4.2.99.902-20030220.1 from RawHide
has fixed the problem.  The only relevant messages in the kernel log are:

[drm] AGP 0.99 on Intel i810 @ 0xd0000000 64MB
[drm] Initialized i810 1.2.1 20020211 on minor 0
mtrr: base(0xd0000000) is not aligned on a size(0x180000) boundary
PCI: Found IRQ 12 for device 00:01.0

and they are printed only once.  The last two are repeated when X
restarts.

I forgot to write in the previous message that CONFIG_DRM_I810_XFREE_41
makes no difference.

-- 
Regards,
Pavel Roskin
