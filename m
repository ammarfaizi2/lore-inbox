Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVFVMV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVFVMV3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 08:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFVMV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 08:21:29 -0400
Received: from magic.adaptec.com ([216.52.22.17]:47556 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261196AbVFVMVR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 08:21:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Fwd: 2.4 and aacraid dmesg]
Date: Wed, 22 Jun 2005 08:20:28 -0400
Message-ID: <60807403EABEB443939A5A7AA8A7458B0152136F@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Fwd: 2.4 and aacraid dmesg]
Thread-Index: AcV2jcFQ3F8cZgpFSMu6sb24iiNVnQAlS+AA
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Mark Haverkamp" <markh@osdl.org>
Cc: "Gabor Z. Papp" <gzp@papp.hu>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The message is coming from the PCI subsystem. Yes it is triggered by the
pending driver load and requesting card pci resources, but such messages
are usually a result of issues with the Motherboard BIOS or Hardware.
They are not generally a result of the driver or the associated
hardware.

My take (which can be incorrect) on this message is that someone put
just a bit too much debugging into the PCI subsystem :-) and the net
result is that you are firmly knowledgeable about the fact that device
on PCI address 03:0d.0 and 03:09.0 are sharing IRQ 4. The 'info' message
is printed every time the pcibios_enable_device() call is made. The
interrupt sharing is assigned by the Motherboard BIOS and if you have
subsequent problems with the operation of the card(s) or the system, you
should investigate updating the Motherboard BIOS or go into the
motherboard BIOS setup and see if you can reassign the PCI (IRQ)
resources.

The spurious 8259A interrupt message *may* be viewed as a problem.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Mark Haverkamp [mailto:markh@osdl.org] 
Sent: Tuesday, June 21, 2005 2:20 PM
To: Salyzyn, Mark
Subject: [Fwd: 2.4 and aacraid dmesg]

I noticed this in the lk list.

-------- Forwarded Message --------
From: Gabor Z. Papp <gzp@papp.hu>
To: linux-kernel@vger.kernel.org, linux-aacraid-devel@dell.com
Subject: 2.4 and aacraid dmesg
Date: Tue, 21 Jun 2005 19:45:04 +0200
Is this

PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0

repeated kernel message okay for so many times?

Linux version 2.4.31 (root@gzp) (gcc version 3.4.3) #1 Tue Jun 7
18:53:06 CEST 2005
[...]
SCSI subsystem driver Revision: 1.00
Red Hat/Adaptec aacraid driver (1.1-3 Jun  7 2005 18:53:28)
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
AAC0: kernel 4.2.4 build 7349
AAC0: monitor 4.2.4 build 7349
AAC0: bios 4.2.0 build 7349
AAC0: serial bad0fafaf001
AAC0: Non-DASD support enabled
spurious 8259A interrupt: IRQ7.
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
scsi0 : aacraid
  Vendor: ADAPTEC   Model: Adaptec Mirror    Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02

lspci not very informative about the card:

03:0d.0 RAID bus controller: Adaptec AAC-RAID (rev 01)

Its an Adaptec 2120S pci raid controller.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
-- 
Mark Haverkamp <markh@osdl.org>

