Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbTBFPX6>; Thu, 6 Feb 2003 10:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267338AbTBFPX5>; Thu, 6 Feb 2003 10:23:57 -0500
Received: from postal.sdsc.edu ([132.249.20.114]:62865 "EHLO postal.sdsc.edu")
	by vger.kernel.org with ESMTP id <S267330AbTBFPXz>;
	Thu, 6 Feb 2003 10:23:55 -0500
Date: Thu, 6 Feb 2003 07:33:29 -0800 (PST)
From: "Peter L. Ashford" <ashford@sdsc.edu>
To: Stephan van Hienen <raid@a2000.nu>
cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Promise FastTrak TX4 losing interrupts (with apic mode)
In-Reply-To: <Pine.LNX.4.53.0302060313490.9702@ddx.a2000.nu>
Message-ID: <Pine.GSO.4.30.0302060728320.15885-100000@multivac.sdsc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan,

> hde: lost interrupt
> hde: lost interrupt
> ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> hde: lost interrupt
> unknown partition table
> hdg: lost interrupt
> hdg: lost interrupt
> ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> hdg: lost interrupt
> unknown partition table
> hdi: lost interrupt
> hdi: lost interrupt
> ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> hdi: lost interrupt
> unknown partition table

I just saw, and fixed, a very similar problem last night (lost interrupts,
but partition table was eventually read).  The system was a dual Xeon on a
P4DP6.  The Promise card was an Ultra100TX2.  The OS was RedHat 7.3.

The fix was to increase the bus master time for the PCI slot in the BIOS.
This was also tried under SuSE 8.1, where it did NOT work.

YMMV.
				Peter Ashford

