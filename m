Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269372AbRGaREA>; Tue, 31 Jul 2001 13:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269375AbRGaRDu>; Tue, 31 Jul 2001 13:03:50 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:14838 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269371AbRGaRDi>; Tue, 31 Jul 2001 13:03:38 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107311639.f6VGdciQ020335@webber.adilger.int>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <000701c119cd$ebf0c720$294b82ce@connecttech.com>
 "from Stuart MacDonald at Jul 31, 2001 10:34:35 am"
To: Stuart MacDonald <stuartm@connecttech.com>
Date: Tue, 31 Jul 2001 10:39:38 -0600 (MDT)
CC: Khalid Aziz <khalid@fc.hp.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Stuart MacDonald writes:
> From: "Khalid Aziz" <khalid@fc.hp.com>
> > AFAIK, you can not have console on a PCI serial port at this time. I
> > looked at it few months back and found out that PCI initialization
> > happens much too late for a serial console. It would take quite a bit of
> 
> That's very odd. That implies that serial consoles don't use the serial
> driver at all then, as the pci serial port setup is done at the same
> time as the regular serial port setups.
> 
> A) Serial console support is mutually exclusive with the serial driver
> being a module.

Yes, because you want console support long before you get the root fs
mounted and have access to modules.

> C) serial.c contains a completely separate serial console driver,
> complete with its own init routine. Which meshes with the current
> suggestion that the "serial driver" isn't used, and pci init happens
> too late.

It _may_ be that Keith Owens (I think) will change this in 2.5.  He has
talked about a big reorg of the serial layer to separate out the tty
handling from the serial I/O handling.  Maybe at that point my idea of
having a console on a parallel port will work.  I guess that it is just
not that easy right now.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

