Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbTH2RBt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbTH2RBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:01:49 -0400
Received: from windsormachine.com ([206.48.122.28]:24196 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S261403AbTH2RB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:01:27 -0400
Date: Fri, 29 Aug 2003 13:01:23 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: linux-kernel@vger.kernel.org
Subject: Bug report with ACPI under 2.4.22, on ASUS P4B533 motherboards.
Message-ID: <Pine.LNX.4.56.0308291251430.18200@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a bunch of servers here with ASUS P4B533 motherboards.

Under 2.4.21, things work fine.

I've upgraded two machines so far that had an ethernet card in pci slot
2(two below the AGP), and upon reboot, slot2 ends up with either IRQ
255(none assigned), or doesn't work.

Before moving the card from slot2:

kernel: PCI: No IRQ known for interrupt pin A of device 02:0a.0
kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xd0806000, 00:40:f4:64:c9:2c, IRQ 7

I've seen the no irq known problem before, but it hasn't bitten me like
this one did.

(after a few lines after the network card is setup)

kernel: NETDEV WATCHDOG: eth0: transmit timed out

After moving the network card to the bottom slot:

kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xd0806000, 00:40:f4:64:c9:2c, IRQ 18

Which worked fine.

As well, the USR pci modem in the one machine changed it's address and irq
after reboot, requiring me to go onsite to update /etc/serial.conf to
reflect the new addresses.

I'll have to check /proc/pci before updating servers to make sure the
ethernet card isn't in slot 2.  As for what to do about the PCI modem's
changing addresses on me, I have no idea.  Onsite upgrades for all, I
guess.

Any other information needed?

Mike
