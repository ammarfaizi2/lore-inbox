Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbRDEHST>; Thu, 5 Apr 2001 03:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132568AbRDEHSJ>; Thu, 5 Apr 2001 03:18:09 -0400
Received: from mx.mips.com ([206.31.31.226]:23727 "EHLO mx.mips.com")
	by vger.kernel.org with ESMTP id <S132567AbRDEHSC>;
	Thu, 5 Apr 2001 03:18:02 -0400
Message-ID: <3ACC1B85.9EDEDD3A@mips.com>
Date: Thu, 05 Apr 2001 09:15:17 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, Wade Hampton <whampton@staffnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pcnet32 (maybe more) hosed in 2.4.3
In-Reply-To: <20010330190137.A426@indiana.edu> <Pine.LNX.4.30.0103311541300.406-100000@fs131-224.f-secure.com> <20010403202127.A316@bacchus.dhis.org> <3ACB2323.C1653236@mips.com> <3ACB3CA5.D978EF41@staffnet.com> <3ACB8098.DFEC12D7@vc.cvut.cz> <20010404235124.B3102@alpha.franken.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Bogendoerfer wrote:

> On Wed, Apr 04, 2001 at 01:14:16PM -0700, Petr Vandrovec wrote:
> > VMware is working on implementation PCnet 32bit mode in emulation (there
> > is no such thing now because of no OS except FreeBSD needs it). But
> > my question is - is there some real benefit in running chip in
> > 32bit mode?
>
> probably not.

In some 32bit bigendian systems you need to do address-swapping before doing any
16 bit (or 8 bit) PCI accesses, whereas 32 bit (full bus width) doesn't need any
swapping, and therefor it would be more efficient.

>
> > so is 32bit mode needed for bigendian ports, or what's reasoning
> > behind it?
>
> I've added 32bit mode for some IBM PowerPC machines. The firmware
> on this machines setup the chip to DWIO and I haven't found a way
> to switch it back to WIO.

I got the same issue on one of my platforms, the firmware setup the chip to DWIO
and the only thing that will bring it back to WIO is a hardware reset.

>
>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessary a
> good idea.                                 [ Alexander Viro on linux-kernel ]

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



