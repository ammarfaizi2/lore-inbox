Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132657AbRC2Drf>; Wed, 28 Mar 2001 22:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132658AbRC2DrZ>; Wed, 28 Mar 2001 22:47:25 -0500
Received: from falcon.prod.itd.earthlink.net ([207.217.120.74]:56264 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132657AbRC2DrG>; Wed, 28 Mar 2001 22:47:06 -0500
Date: Wed, 28 Mar 2001 19:47:30 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mouse problems in 2.4.2 -> lost byte
Message-ID: <Pine.LNX.4.31.0103281941040.1748-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>So you recommend to connect the mouse to USB (instead of psaux) because
>psaux+Xfree86 are losing bytes under circumstances (e.g. some load
>pattern).
>
>This is a fine solution for users with dual protocol mice, but doesn't
>resolve the problem for other poor ps/2 mouse owners !

You misunderstood me. For 2.4.X it is:

Real PS/2 mouse -> /dev/psaux -> PS/2 protocol -> X server

All mice using /dev/input/mice -> PS/2 protocol -> X server

Yes mice. I have had 5 mice attached and going to the X server. It was no
problem. Multiple keyboards, well that is another story :-( It doesn't
matter to the X server if two different devices are sending the same
protocol. Since the protocol is coming in from two different devices theri
is no conflict. I believe we was having problems with another type of
mouse.

>Even with PS/2 mouse support in the "new input" driver I wouldn't expect
>the psaux-byte-lost bug to disappear magically.

I see Vojtech has answered this already.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

