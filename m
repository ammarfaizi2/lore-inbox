Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131997AbRC1PcW>; Wed, 28 Mar 2001 10:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132042AbRC1PcN>; Wed, 28 Mar 2001 10:32:13 -0500
Received: from gull.prod.itd.earthlink.net ([207.217.121.85]:24539 "EHLO gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP id <S132033AbRC1PcF>; Wed, 28 Mar 2001 10:32:05 -0500
Date: Wed, 28 Mar 2001 07:32:29 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mouse problems in 2.4.2 -> lost byte
Message-ID: <Pine.LNX.4.31.0103280722310.948-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Where can I get your driver?

I attach it to the other posting to this thread. I also have it in CVS at
http://linuxconsole.sourceforge.net with a bunch of other input drivers.

>> Section "Pointer"
>>             Protocol    "ImPS/2"
>>             Device      "/dev/input/mice"
>
>What is better in using /dev/input/mice than /dev/psaux
>on this problem exactly?

The reason to use /dev/input/mice is the PS/2 mouse driver itself has not
been ported over to the input suite for 2.4.X. You can use the above for
the USB mouse now. Now if you have a USB mouse plus a PS/2 mouse then
having both use /dev/psaux would require a reworking of the PS/2 driver.
I rather port over the PS/2 mouse to use /dev/input/mice. I have done this
for my CVS but since the PS/2 mouse shares the same chipset as the PS/2
keyboard you have to use both input drivers. It would be better if XFree86
would have a /dev/eventX driver but we would wait a long time for that to
happen :-(

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

