Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbRCWDAy>; Thu, 22 Mar 2001 22:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRCWDAp>; Thu, 22 Mar 2001 22:00:45 -0500
Received: from dentin.eaze.net ([216.228.128.151]:59666 "EHLO xirr.com")
	by vger.kernel.org with ESMTP id <S129408AbRCWDAg>;
	Thu, 22 Mar 2001 22:00:36 -0500
Date: Thu, 22 Mar 2001 20:59:43 -0600 (CST)
From: SodaPop <soda@xirr.com>
To: <egger@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Only 10 MB/sec with via 82c686b - FIXED
In-Reply-To: <20010321143956.917977A94@Nicole.muc.suse.de>
Message-ID: <Pine.LNX.4.30.0103222056120.25793-100000@xirr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Further note - kernels built with K6-2 support seem to be just fine.  But
all athlon/K7 kernels die horribly, with greatly varying death messages.
Most commonly I get bogus pointer/dereference errors and eventually init
gets killed, other times it just locks up, sometimes I get things like
'cannot exec syslogd: Out of memory'.  It looks like the memory registers
are horked up somehow.

I could try to copy some of this out by hand if anyone thought it
worthwhile.  Either way, I think IWill has some work to do yet on their
system bios.

-dennis T




On Wed, 21 Mar 2001 egger@suse.de wrote:

> On 20 Mar, SodaPop wrote:
>
> > I have an IWill KK-266R motherboard with an athlon-c 1200
> > processor in it, and for the life of me I can't get more than
> > 10 MB/sec through the on-board ide controller.  Yes, all the
> > appropriate support is turned on in the kernel to enable dma
> > and specific chipset support, and yes, I think I have all
> > relevant patches and a reasonable kernel.
>
>  Yes, actually I'm seeing the same on a KT133 board from Elitegroup.
>  Although here I get a bit more: 15 MB/s
>
> > I noted a number of other interesting things;  one, that -X33,
> > -X34, and -X64 through -X69 all have the same 10 MB/sec transfer
> > rate, and two, that the 10 MB/sec transfer rate can be linearly
> > increased to 12 MB/sec by raising the system bus from 100 mhz to
> > 120 mhz (all components are safely rated at 133, no overclocking
> > involved.)
>
>  Duh, before making such a claim you should consider the fact that
>  this is overclocking your PCI/AGP bus and I have yet to see any
>  graphic cards/IDE controllers/other devices which are rated for
>  37MHz PCI bus speed.
>
> --
>
> Servus,
>        Daniel
>

