Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbUDLNyh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 09:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbUDLNyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 09:54:37 -0400
Received: from web41211.mail.yahoo.com ([66.218.93.44]:22712 "HELO
	web41211.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262904AbUDLNyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 09:54:35 -0400
Message-ID: <20040412135430.45066.qmail@web41211.mail.yahoo.com>
Date: Mon, 12 Apr 2004 06:54:30 -0700 (PDT)
From: Jin Suh <jinssuh@yahoo.com>
Subject: [2.4.25] PCMCIA PCI: No IRQ for interrupt pin A and failed to allocate shared interrupt
To: linux-kernel@vger.kernel.org, linux1394-user@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using a Gateway 600YG2 laptop (Intel P4-M, PCMCIA TI PCI1520 controller)
on 2.4.25. I have 3 different pcmcia firewire cards. When I insert module
yenta_socket with any of those cards, I get "Yenta ISA IRQ mask 0x0a98, PCI irq
0" and "PCI: No IRQ for interrupt pin A of device 03:00.0 please try using
pci=biosirq". After this error, when I run the modprobe ieee1394 and ohci1394,
I get "ohci1394: failed to allocate shared interrupt 10". The same pcmcia
firewire cards work on old Gateway 9300, 9500 laptop and IBM T22 laptop. 
BTW, my Netgear pcmcia 10/100mb ethernet card works on the Gateway 600YG2
laptop. Also my USB pen drives are not working too. The bootparameter
pci=biosirq doesn't seem to work. 
It worked fine with 2.4.20 without any problems. Could someone help me to fix
this problem on 2.4.25? I have buillt both of 2.4.20 and 2.4.25 without ACPI.

Thanks,
Jin

DMESG output
-------------------------------------------------------------------------
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6620
ACPI: RSDT (v001 GATEWA 602      0x20021104  LTP 0x00000000) @ 0x1fef8313
ACPI: FADT (v001 GATEWA 602      0x20021104 PTL  0x0000001e) @ 0x1fefef64
ACPI: BOOT (v001 GATEWA 602      0x20021104  LTP 0x00000001) @ 0x1fefefd8
ACPI: DSDT (v001 GATEWA 602      0x20021104 MSFT 0x0100000e) @ 0x00000000
Kernel command line: initrd=ramdisk.img root=/dev/ram0 bickrootfs=tmpfs vga=791
BOOT_IMAGE=linux 
No local APIC present or hardware disabled
.........
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 10 for device 02:02.0
PCI: Sharing IRQ 10 with 00:1f.1
PCI: Sharing IRQ 10 with 02:02.1
PCI: Found IRQ 10 for device 02:02.1
PCI: Sharing IRQ 10 with 00:1f.1
PCI: Sharing IRQ 10 with 02:02.0
Yenta ISA IRQ mask 0x0a98, PCI irq 0
Socket status: 30000011
Yenta ISA IRQ mask 0x0a98, PCI irq 0
Socket status: 30000020
cs: cb_alloc(bus 7): vendor 0x104c, device 0x8024
PCI: Enabling device 07:00.0 (0000 -> 0002)
PCI: No IRQ known for interrupt pin A of device 07:00.0. Please try using
pci=biosirq.
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 02:05.0
PCI: Sharing IRQ 10 with 00:1f.3
PCI: Sharing IRQ 10 with 00:1f.6
ohci1394: Failed to allocate shared interrupt 10
PCI: No IRQ known for interrupt pin A of device 07:00.0. Please try using
pci=biosirq.
ohci1394: Failed to allocate shared interrupt 0
sbp2: $Rev: 1074 $ Ben Collins <bcollins@debian.org>


__________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online by April 15th
http://taxes.yahoo.com/filing.html
