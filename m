Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262922AbRFTW5b>; Wed, 20 Jun 2001 18:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263079AbRFTW5V>; Wed, 20 Jun 2001 18:57:21 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23466 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262922AbRFTW5G>;
	Wed, 20 Jun 2001 18:57:06 -0400
Message-ID: <3B312A32.86BDE58B@mandrakesoft.com>
Date: Wed, 20 Jun 2001 18:56:50 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Greg Ingram <ingram@symsys.com>, linux-kernel@vger.kernel.org
Subject: Re: Unknown PCI Net Device
In-Reply-To: <200106202253.f5KMrX2X029668@webber.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> Greg writes:
> > I picked up a network card that claims to use the "most reliable Realtek
> > LAN chip".  The big chip is labelled "LAN-8139" so naturally I tried the
> > 8139too driver.  It doesn't find the device.  I'm wondering if maybe it's
> > just something in the device ID tables.  Here's some info:
> >
> > 00:0b.0 Ethernet controller: MYSON Technology Inc: Unknown device 0803
> >       Subsystem: MYSON Technology Inc: Unknown device 0803
> >       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> 
> Add the PCI vendor ID and device ID (0803) to drivers/net/8139too.c, in
> the rtl8139_pci_tbl[] and board_info[] and if it works, send a patch to
> Jeff (CC'd).

See my other reply, it uses the fealnx driver, adding 2.4.4 or 2.4.5 or
so :)

> Jeff, is there a reason why you have numeric vendor and device IDs instead
> of using the definitions in <linux/pci_ids.h>?

Not a good one :)   Not using those constants makes the table nice and
uniform, with one entry per line.  Using those constants tends to bloat
up [in the src] the pci_device_id table quite a bit.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
