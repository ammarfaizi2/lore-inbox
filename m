Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131600AbRC3Rx7>; Fri, 30 Mar 2001 12:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131603AbRC3Rxt>; Fri, 30 Mar 2001 12:53:49 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:3832 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131600AbRC3Rxh>; Fri, 30 Mar 2001 12:53:37 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103301752.f2UHqmV27328@webber.adilger.int>
Subject: Re: Cool Road Runner
In-Reply-To: <20010330175900.I1396@dss19> from Steffen Grunewald at "Mar 30,
 2001 05:59:00 pm"
To: Steffen Grunewald <steffen@gfz-potsdam.de>
Date: Fri, 30 Mar 2001 10:52:48 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Gruenwald writes:
> The CompactFlash disk (a 32 MB SanDisk) is recognized as /dev/hda,
> but the system fails to see the /dev/hdb disk (an IBM DARA-206000
> jumpered as slave). When the IDE driver loads, it displays 
> hda:pio, hdb:DMA - and yes, the BIOS assigns UDMA33 to the slave drive
> while the master is detected as Mode1.
> The IDE controller is a CS5530.

This was just discussed this week by Andre Hedrick.  You need to add a
mount option like "hdb=flash" (I wasn't paying much attention).  This
is because CF disks do not properly handle detection of slaves.  See:

http://marc.theaimsgroup.com/?l=linux-kernel&m=98580536318380&w=4

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
