Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbRFTWyl>; Wed, 20 Jun 2001 18:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262922AbRFTWyb>; Wed, 20 Jun 2001 18:54:31 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:6639 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262655AbRFTWy1>; Wed, 20 Jun 2001 18:54:27 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106202253.f5KMrX2X029668@webber.adilger.int>
Subject: Re: Unknown PCI Net Device
In-Reply-To: <Pine.LNX.4.21.0106201401060.1874-100000@maestro.symsys.com>
 "from Greg Ingram at Jun 20, 2001 02:19:00 pm"
To: Greg Ingram <ingram@symsys.com>
Date: Wed, 20 Jun 2001 16:53:33 -0600 (MDT)
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg writes:
> I picked up a network card that claims to use the "most reliable Realtek
> LAN chip".  The big chip is labelled "LAN-8139" so naturally I tried the
> 8139too driver.  It doesn't find the device.  I'm wondering if maybe it's
> just something in the device ID tables.  Here's some info:
> 
> 00:0b.0 Ethernet controller: MYSON Technology Inc: Unknown device 0803
> 	Subsystem: MYSON Technology Inc: Unknown device 0803
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-

Add the PCI vendor ID and device ID (0803) to drivers/net/8139too.c, in
the rtl8139_pci_tbl[] and board_info[] and if it works, send a patch to
Jeff (CC'd).

Jeff, is there a reason why you have numeric vendor and device IDs instead
of using the definitions in <linux/pci_ids.h>?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
