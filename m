Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbRARHoP>; Thu, 18 Jan 2001 02:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRARHoF>; Thu, 18 Jan 2001 02:44:05 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:47240 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S129759AbRARHn5>; Thu, 18 Jan 2001 02:43:57 -0500
Date: Thu, 18 Jan 2001 08:43:40 +0100
From: Petr Matula <pem@informatics.muni.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Petr Matula <pem@informatics.muni.cz>,
        "Dunlap, Randy" <randy.dunlap@intel.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: int. assignment on SMP + ServerWorks chipset
Message-ID: <20010118084340.A12255709@aisa.fi.muni.cz>
In-Reply-To: <20010117185047.A13171968@aisa.fi.muni.cz> <Pine.LNX.4.10.10101171332420.10151-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10101171332420.10151-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 17, 2001 at 01:33:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 01:33:42PM -0800, Linus Torvalds wrote:
> Did you also remove the two lines that disabled pirq routing if an IO-APIC
> was enabled?
Yesterday not, today yes. But it's the same.

> > Kernel with these changes can't detect my SCSI drive. It prints these messages 
> > in cycle:
> 
> Which SCSI adapter is this? It may be that you have one of the drivers
> that does not do "pci_enable_dev()" at initialization time..
SCSI storage controller: Adaptec 7899P (rev 0).
  IRQ 16.
  Master Capable.  Latency=72.  Min Gnt=40.Max Lat=25.
  I/O at 0x5800 [0x58ff].
  Non-prefetchable 64 bit memory at 0xfd000000 [0xfd000fff].

Used kernel options:
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY=10

Petr

---------------------------------------------------------------
 Petr Matula                                    pem@fi.muni.cz
                                    http://www.fi.muni.cz/~pem
---------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
