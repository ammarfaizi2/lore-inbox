Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132117AbRC1SV4>; Wed, 28 Mar 2001 13:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132118AbRC1SVq>; Wed, 28 Mar 2001 13:21:46 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:60686 "EHLO mailout01.sul.t-online.com") by vger.kernel.org with ESMTP id <S132117AbRC1SV2>; Wed, 28 Mar 2001 13:21:28 -0500
Message-ID: <3AC22BAB.6C500DAC@t-online.de>
Date: Wed, 28 Mar 2001 20:21:31 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@linux-fbdev.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mouse problems in 2.4.2 -> lost byte
References: <Pine.LNX.4.31.0103280722310.948-100000@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> >Where can I get your driver?
> 
> I attach it to the other posting to this thread. I also have it in CVS at
> http://linuxconsole.sourceforge.net with a bunch of other input drivers.
> 
> >> Section "Pointer"
> >>             Protocol    "ImPS/2"
> >>             Device      "/dev/input/mice"
> >
> >What is better in using /dev/input/mice than /dev/psaux
> >on this problem exactly?
> 
> The reason to use /dev/input/mice is the PS/2 mouse driver itself has not
                    ^^^^^^^^^^^^^^^

So you recommend to connect the mouse to USB (instead of psaux) because
psaux+Xfree86 are losing bytes under circumstances (e.g. some load pattern).

This is a fine solution for users with dual protocol mice, but doesn't
resolve the problem for other poor ps/2 mouse owners !

> been ported over to the input suite for 2.4.X. You can use the above for
> the USB mouse now. Now if you have a USB mouse plus a PS/2 mouse then
> having both use /dev/psaux would require a reworking of the PS/2 driver.
> I rather port over the PS/2 mouse to use /dev/input/mice. I have done this
> for my CVS but since the PS/2 mouse shares the same chipset as the PS/2
> keyboard you have to use both input drivers. It would be better if XFree86
> would have a /dev/eventX driver but we would wait a long time for that to
> happen :-(

Even with PS/2 mouse support in the "new input" driver I wouldn't expect the 
psaux-byte-lost bug to disappear magically.
-

Gunther
