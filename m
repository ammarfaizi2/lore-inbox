Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129996AbQKXE4K>; Thu, 23 Nov 2000 23:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131156AbQKXE4A>; Thu, 23 Nov 2000 23:56:00 -0500
Received: from [209.249.10.20] ([209.249.10.20]:37854 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S129996AbQKXEzp>; Thu, 23 Nov 2000 23:55:45 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 23 Nov 2000 20:25:01 -0800
Message-Id: <200011240425.UAA07555@baldur.yggdrasil.com>
To: ad@mpifr-bonn.mpg.de, daniel.kobras@student.uni-tuebingen.de,
        emilie.chung@axis.com, GordPeters@smarttech.com, jamesg@Filanet.com,
        leonvs@iae.nl, pascal.drolet@nurun.com, rficklin@westengineering.com,
        sebastien.rougeaux@anu.edu.au
Subject: ohci1394 PCI device ID's
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Sorry for the rather lengthy email list.  I am not sure exactly
which of you it would be appropriate to put this question to.

	I am writing a pci_device_id table for ohci1394.c.  This will
allow a userland program to automatically load the module when an
ohci1394 card is present.  There is a PCI device class for ohci1394
controllers (pci_dev->class == 0x0c0310).  So, is there some reason
why linux-2.4.0-test11/drivers/ieee1394/ohci1934.c contains a list
of vendor_id/device_id pairs?

	If ohci1394.c really needs to match based on vendor_id and
device_id, then I will generate a pci_device_id table accordingly.
On the other hand, if ohci1394.c really does not need to care about
vendor_id/device_id pairs, I will add the generic pci_device_id table
for an ohci1394 controller, and I would also be happy to generate
a patch for you folks that eliminates the use of the vendor_id / device_id
pairs, and, if you want, ports the driver to the new hotplug PCI
interface, which might be useful, considering that I see ieee1394
CardBus cards everywhere.

	Any feedback would be appreciated.  Thanks in advance.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
