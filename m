Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSHOT7D>; Thu, 15 Aug 2002 15:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSHOT7D>; Thu, 15 Aug 2002 15:59:03 -0400
Received: from richardson.uni2.net ([130.227.52.104]:14028 "EHLO
	richardson.uni2.net") by vger.kernel.org with ESMTP
	id <S317373AbSHOT7B>; Thu, 15 Aug 2002 15:59:01 -0400
Subject: Re: promise ultra 133 tx2 lets system standby during use...?
From: Thomas Munck Steenholdt <tmus@get2net.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1029418059.29816.30.camel@irongate.swansea.linux.org.uk>
References: <200208151227.g7FCR8P03099@eday-fe9.tele2.ee> 
	<1029418059.29816.30.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Aug 2002 22:02:52 +0200
Message-Id: <1029441779.1637.8.camel@frasier>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-15 at 15:27, Alan Cox wrote:
> On Thu, 2002-08-15 at 13:27, Thomas Munck Steenholdt wrote:
> > OK, I'll try the apm=off first to see if that resolves my problem...
> > are there any examples/places to look if i decided to update the
> > APM monitor list from linux? Anywhere I could get an idea of how that
> > could be done?
> > I don't know the chipset atm.
> 
> lspci will tell you the chipset identifiers. Generally the first few
> listed devices are the chipset itself (00:00.0 is the north bridge, then
> the other stuff follows).
> 
lspci:--8<-------------
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03)
00:02.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:02.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:02.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:02.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 05)
00:10.0 Unknown mass storage controller: Promise Technology, Inc. 20269
(rev 02)
00:14.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX]
(rev a1)
01:01.0 VGA compatible controller: S3 Inc. Trio 64 3D (rev 01)
-->8---------------

This is what I have - but anyway, the apm=off option seems to work for
the 2.4.19 kernel, so I guess i'll leave it at that for the time being.
I suspect that the option will work with the distribution kernel as
well.
If the task of poke'ing an additional IRQ into the APM monitor list is
simply just doing a pokeb or pokew at the right port somewhere, then I
just might have a look at it... I really don't know where to start
tough.

Anyway, thanks alot :-) at least now i'm pretty sure what's causing my
problems, and happy that i did NOT go out after another ATA133
controller, just to try that out - the result would likely have been the
same and a lot of money would have been wasted.

Thanks again

Thomas

