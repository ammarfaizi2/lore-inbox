Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131240AbRAHTgq>; Mon, 8 Jan 2001 14:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131547AbRAHTgg>; Mon, 8 Jan 2001 14:36:36 -0500
Received: from big-relay-1.ftel.co.uk ([192.65.220.123]:37552 "EHLO
	old-callisto.ftel.co.uk") by vger.kernel.org with ESMTP
	id <S131240AbRAHTgZ>; Mon, 8 Jan 2001 14:36:25 -0500
Date: Mon, 8 Jan 2001 19:36:20 GMT
Message-Id: <200101081936.f08JaJj24581@old-callisto.ftel.co.uk>
From: Paul Flinders <P.Flinders@ftel.co.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.2/2.4 on MSI 694D Pro-AIR (MS-6321)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone got either 2.2.x or 2.4.0 booted on the above motherboard?

This board has an integrated Promise Fasttrack ATA/100 controller - I
know that to support the hardware RAID I need the binary only drivers
from Promise but I'd rather not use these if software RAID works as
there's no source, however I'm not getting that far.

All the kernels that I've tried hang either after identifying the
on-board IDE controllers if they don't have support for the promise
chipset or after identifying the first channel on the Promise if they
do

The last boot messages printed are:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: Chipset Revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: Via vt82c686a IDE Controller on PCI 0:7.1
    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:DMA, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 60
PDC20265: Chipset Revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio

Then it hangs requiring power cycling.

I'm not sure whether the I/O address reported by the promise driver is
correct - the promise BIOS shows the I/O address for the first channel
as 0xCC00.

There are two Maxtor 33073H3 30G drives connected as master & slave on
channel 1 (yes, I know that they should be master on channel 1 and
master on channel 2 - we're getting hold of some more cables but I
assume that is not the cause of the kernel hang). The Promise BIOS
utility shows them being in UDMA mode 5

The board has 2x 866 Mhz PIIIs (kernel compiled for SMP but using a UP
kernel gives the same result), it's BIOS is version 3.0. There doesn't
seem to be an option to disable the Promise controller otherwise I
would.  There also doesn't seem to be the option of not using controller
as a "normal" ATA/100 IDE controller either unless the act of _not_
configuring any RAID arrays is sufficient.

Is this a configuration with known problems?

TIA

Paul

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
