Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266390AbSLOLsC>; Sun, 15 Dec 2002 06:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266387AbSLOLsC>; Sun, 15 Dec 2002 06:48:02 -0500
Received: from quark.amimatica.com ([213.139.24.154]:54148 "EHLO
	quark.amimatica.com") by vger.kernel.org with ESMTP
	id <S266386AbSLOLsB> convert rfc822-to-8bit; Sun, 15 Dec 2002 06:48:01 -0500
Message-Id: <5.1.1.6.0.20021215123609.00b979e8@mail.adv-solutions.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sun, 15 Dec 2002 12:55:06 +0100
To: Adrian Bunk <bunk@fs.tum.de>
From: =?iso-8859-1?Q?Jos=E9?= Luis =?iso-8859-1?Q?Tall=F3n?= 
	<jltallon@adv-solutions.net>
Subject: Re: Linux-2.4.20: bug with radeonfb - solved
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021215005654.GE27658@fs.tum.de>
References: <5.1.1.6.0.20021203004621.00b5a770@mail.adv-solutions.net>
 <5.1.1.6.0.20021203004621.00b5a770@mail.adv-solutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:56 15/12/2002 +0100, you wrote:
>On Tue, Dec 03, 2002 at 01:52:09AM +0100, José Luis Tallón wrote:
>
> > Environment:  gcc-2.95.4, latest dev tools from Debian "Sarge"( testing )
> > Kernel:       2.4.20 + patch-2.4.20-ac1 from ftp.kernel.org
> >...
> > "No Go's":
> >       Radeon M7 AGP:
> >       - Framebuffer:  unreadable output ( did work _perfectly_ with
> >       Linux-2.4.19 ).
> >       Looks like there's a bug somewhere in the rendering code( kernel
> > autodetects and configures a 175x65 framebuffer, as previously):
> > output seems to be "misplaced" -- might be a little assumption when
> > calculating line offsets.
> > Text lines, although bent to the right( 60º angle or so ), look _extremely
> > long_ (might be a wrong appreciation)
> > "Tux" logo is unrecogniceable too :(
> >
> >       - DRM 4.1( v20020828 ) works nicely with XFree 4.2.1
> >       - Xvid extension works
> >
> > dmesg gives this ( double-checked with 2.4.19 ): relevant sections are
> > identical to 2.4.19
> > ---
> > Pentium 4 Mobility - stepping 04
> > [...]
> > ref_clk=2700, ref_div=12, xclk=16600 from BIOS
> > Samsung LTN-1050P1-L02 flatpanel
> > DFP 1400x1050 from BIOS
> > Radeon M7 LW DDR SGRAM 64MB
> > colour framebuffer 175x65
> >...
>
>Does it work if you revert the patch against drivers/video/radeonfb.c
>that is in -ac?
>
>Does it work in plain 2.4.20 (without the -ac patch)?

<sweating and blushing>
Works perfect with 2.4.20 vanilla :-|
         ( I had previously trusted Alan's patches quite blindly )
- Chipset and DMA working


Will test with -ac2 and 21-pre1 and report back, so that we can isolate the 
bug ( quite a nasty one, I can assure you )

Thanks again.

         J.L.

