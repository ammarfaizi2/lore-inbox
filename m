Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135851AbRDTKRQ>; Fri, 20 Apr 2001 06:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135852AbRDTKRC>; Fri, 20 Apr 2001 06:17:02 -0400
Received: from www.topmail.de ([212.255.16.226]:20432 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S135851AbRDTKQj>;
	Fri, 20 Apr 2001 06:16:39 -0400
Message-ID: <00ca01c0c982$fbcb25a0$de00a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "James Simmons" <jsimmons@linux-fbdev.org>,
        "Scott Prader" <gnea@rochester.rr.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10104191007240.23576-100000@www.transvirtual.com>
Subject: [RFC and 1/2 OT] Re: ANNOUNCE New Open Source X server
Date: Fri, 20 Apr 2001 10:16:35 -0000
Organization: eccesys.net Linux development
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "James Simmons" <jsimmons@linux-fbdev.org>
To: "Scott Prader" <gnea@rochester.rr.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Thursday, April 19, 2001 5:16 PM
Subject: Re: ANNOUNCE New Open Source X server


>
> Thank you. It is true all I want to do is help the community. I feel
as
> alot of people do XFree86 can not meet the needs of the community. It
is
> very sad that people feel that no amount of people in the open source
> community can make code of the same or better quality as XFree86 in a
> shorter period of time. I don't feel this way. Now I'm off to work on
code
> and documentation for the project. Thank you.

My idea were: why not integrate kind of Nano-X (yes I know what that is)
into the kernel, just the X server, configured by make menuconfig (or
which you like more), and just use XF86 or something different (or even
X clients running under a different machine on the net) on it.

It should then implement enough of, if not the full, X11R6 API, and have
either direct access to the gfx board or at least to the fb (might this
be speeded up?).

It doesn't need to be fullstly (?) integrated to the kernel, it may also
be a "server" (as in microkernel systems), loaded as module but on CPL3.
So a crash doesn't hang the full system: if it crashes, we have a SysRq
which kicks out the module and does either a videomode-switch to a sane
80x25 (BIOS 03), VGA (BIOS 12) or - if framebuffer-based - nothing
because
the X server and the fb are separated.
We might as well support EGA, HGC or CGA(??) cards for it; switching to
a sane mode isn't that difficult (as discussed earlier, and for HGC I
have some NASM sources), and IIRC there is a HGC framebuffer somewhere.

-mirabilos
--
)))                  LICENSE FOR ABOVE MESSAGE BODY:              (((
YOU _MUST NOT_ READ  ABOVE MESSAGE BODY  IF YOU DO NOT AGREE TO THESE
TERMS.  BY READING ABOVE MESSAGE BODY  YOU _AUTOMATICALLY_ _DO AGREE_
TO THE FOLLOWING TERMS:
This mail/work is protected  by copyright law.  It _MUST NOT_ be used
otherwise than specified by the terms and conditions at:
      http://members.tripod.de/mirabilos/license.mip
The mail is, if not _explicitly_ specified differently, ONLY licensed
by these terms. THIS _CANNOT_ BE OVERRIDDEN BY ANY "TERMS OF SERVICE"
OF ANY S.PROVIDER THE MAIL GOES THROUGH, EVEN _NOT_ IF I SIGNED THEM!
--
(Sorry for the bandwidth, but some ToS force me to.)
EA F0 FF 00 F0 #$@%CARRIER LOST

