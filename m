Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281286AbRKTTkg>; Tue, 20 Nov 2001 14:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281284AbRKTTk1>; Tue, 20 Nov 2001 14:40:27 -0500
Received: from zeus.kernel.org ([204.152.189.113]:63467 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S281244AbRKTTkR> convert rfc822-to-8bit;
	Tue, 20 Nov 2001 14:40:17 -0500
Date: Tue, 20 Nov 2001 17:49:32 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "Paul G. Allen" <pgallen@randomlogic.com>
Cc: Chris Wedgwood <cw@f00f.org>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: What Athlon chipset is most stable in Linux?
In-Reply-To: <3BFA09B3.20F31B78@randomlogic.com>
Message-ID: <20011120173825.G1836-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Nov 2001, Paul G. Allen wrote:

> Chris Wedgwood wrote:
> >
> > On Wed, Nov 14, 2001 at 05:03:21PM -0800, Paul G. Allen wrote:
> >
> >     I am running 2.4.9ac10 with a few minor tweaks, agpgart slightly
> >     tweaked compiled in, and a tweaked Detonator 3 nVidia driver. I
> >     plan to upgrade all these soon and see what happens.
> >
> > Is this different from 1541? If so, where might I find this
> >
>
> I just D/L, modified and compiled 1541. A cat of /proc/nv/card0 shows:
>
> [root@keroon /root]# cat /proc/nv/card0
> ----- Driver Info -----
> NVRM Version: 1.0-1541
> ------ Card Info ------
> Model:        GeForce3
> IRQ:          17
> Video BIOS:   03.20.00.10
> ------ AGP Info -------
> AGP status:   Enabled
> AGP Driver:   NVIDIA
> Bridge:       AMD Irongate MP
> SBA:          Supported [enabled]
> FW:           Supported [disabled]
> Rates:        4x 2x 1x  [4x]
> Registers:    0x0f000217:0x00000304
> [root@keroon /root]#
>
> So, AGP 4x and Side Band Addressing is enabled, but for some reason Fast
> Writes are not. I am still using the 2.06 Tyan BIOS (as shipped) and
> need to upgrade to the latest (I've had trouble getting the BIOS file
> from the Tyan web site). agpgart is not compiled into this kernel, so as
> you can see it's using the NVIDIA driver instead. I e-mailed developer
> support at nVidia to ask why FW is disabled even though it's supported
> (it could very well be the BIOS).

May-be, FW works quite well here, but they just want to enable it in some
future driver version and then claim 50% speed improvement. :-) :o)

To be serious, FW needs special handling in AGP, notably flow-control by
the target using WBF for example. As a result, it could well be broken for
your board forever due to some errata in signalling.

> I also installed thier GLX libraries.

You seem to like bloat. :)

  Gérard.

