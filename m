Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAXXoJ>; Wed, 24 Jan 2001 18:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRAXXoA>; Wed, 24 Jan 2001 18:44:00 -0500
Received: from ruddock-157.caltech.edu ([131.215.90.157]:64267 "EHLO
	alex.caltech.edu") by vger.kernel.org with ESMTP id <S129406AbRAXXnt>;
	Wed, 24 Jan 2001 18:43:49 -0500
Date: Wed, 24 Jan 2001 15:44:57 -0800
From: David Bustos <bustos@its.caltech.edu>
To: sailer@ife.ee.ethz.ch, mj@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: es1371 freezes 2.4.0 hard
Message-ID: <20010124154457.A491@alex.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading to 2.4.0, insertion of the es1371 modules causes my
machine to freeze right after printing

	es1371: version v0.26 time 14:24:35 Jan 24 2001
	es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x02
	PCI: Assigned IRQ11 for device 00:0a.0

The box becomes unresponsive to the keyboard, the mouse, and the
network.  The same thing happens when the driver is compiled directly
into the kernel.

Since the module worked ok in 2.4.0-test10, I tried reverting
drivers/sound/es1371.c to that version, but the same thing happened, so
I suspect it's a PCI problem.

I've got a K6-2/350 with the VIA MVP3 chipset.  I used Debian's 2.95.3
to compile 2.4.0.


lspci -v output for the card:

00:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Flags: bus master, slow devsel, latency 64, IRQ 11
        I/O ports at e800 [size=64]
        Capabilities: [dc] Power Management version 1


Any ideas as to what is going on here?


Thanks,
David Bustos
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
