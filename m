Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVCULjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVCULjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 06:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVCULjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 06:39:37 -0500
Received: from mailgw1.technion.ac.il ([132.68.238.34]:33421 "EHLO
	mailgw1.technion.ac.il") by vger.kernel.org with ESMTP
	id S261756AbVCULjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 06:39:32 -0500
Date: Mon, 21 Mar 2005 13:39:30 +0200 (IST)
From: Jacques Goldberg <goldberg@phep2.technion.ac.il>
X-X-Sender: goldberg@localhost.localdomain
Reply-To: Jacques Goldberg <Jacques.Goldberg@cern.ch>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Need break driver<-->pci-device automatic association
In-Reply-To: <20050321082228.A22099@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58_heb2.09.0503211336090.6491@localhost.localdomain>
References: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain>
 <20050318165124.GC14952@kroah.com> <Pine.LNX.4.58_heb2.09.0503192021431.11358@localhost.localdomain>
 <20050321081638.GC2703@pazke> <20050321082228.A22099@flint.arm.linux.org.uk>
X-MailKey: 829.36.63
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Here is a modem which cannot be used because it is grabbed by the
serial driver:

00:0f.0 Modem: ALi Corporation SmartLink SmartPCI561 56K Modem (prog-if 00
[Gene
ric])
        Subsystem: ARCHTEK TELECOM Corp: Unknown device 9100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f4101000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 1000 [size=256]
        Capabilities: <available only to root>

and here is the corresponding  /proc/pci

  Bus  0, device  15, function  0:
    Class 0703: PCI device 10b9:5459 (rev 0).
      IRQ 10.
      Master Capable.  Latency=64.
      Non-prefetchable 32 bit memory at 0xf4101000 [0xf4101fff].
      I/O at 0x1000 [0x10ff].

There are more such devices.


On Mon, 21 Mar 2005, Russell King wrote:

> On Mon, Mar 21, 2005 at 11:16:38AM +0300, Andrey Panin wrote:
> > On 078, 03 19, 2005 at 08:33:14PM +0200, Jacques Goldberg wrote:
> > >  That's really what is needed (mainline).
> > >  I attach the file which Sasha, author or the lmodem driver, has
> > > modified and then it works for the chips hard-wired in the routine.
> > >  To locate the patched area, look for 5457
> >
> > We can use PCI quirk here. Patch attached.
>
> I haven't seen any mail in this thread which provides the complete
> PCI ID information for these cards.Can someone oblige please, with:
>
> lspci -vv
>
> for the relevant card.
>
> --
> Russell King
>  Linux kernel  2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:2.6 Serial core
>

                                Jacques.Goldberg@cern.ch
                                >>>> Currently at TECHNION <<<<
                                PHONE: Technion=+(972)(0)(4)829.36.63
                                           CERN=+(41)(22)767.73.85
                                FAX:   Technion=+(972)(0)(4)829.39.01
                                           CERN=+(41)(22)767.31.00
                                HOME: Haifa=+(972)(4)825.29.04
                                GSM portable: +(972)(0)544.29.36.63
