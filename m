Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWGRSgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWGRSgD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 14:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWGRSgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 14:36:03 -0400
Received: from lx1.dinonet.it ([213.145.29.133]:61826 "EHLO mail.dinonet.it")
	by vger.kernel.org with ESMTP id S932345AbWGRSgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 14:36:01 -0400
From: <febo@delenda.net>
To: <linux-kernel@vger.kernel.org>
Subject: 'vintage' via dma bug
Date: Tue, 18 Jul 2006 20:36:00 +0200
Message-ID: <001001c6aa99$0476a380$fc01a8c0@EFFEPUNTO>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaqmQPl3ahpw3zsQlu9utLcEnSalw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the misfortune to run a rather old PIII machine with a VIA chipset, 
a Fedora Core 1 distro with 2.4.22 kernel and two PATA hard mirrored hard 
disk, on two separate channels, both set to primary. I've experienced some 
data corruption lately and after much googling I've found that 4-5 years 
ago some via chipset experienced a similar problem with dma transfers, 
especially with hard disk configured the very same way as my setup. The bug 
was fixed, I gather, in 2.4.4. I've upgrade the kernel to 2.6.10 (the 
latest Fedora legacy core *TWO* kernel, with fingers crossed) but the 
corruption problems usually start to pop up only after a few weeks of 
uptime, especially under relatively heavy load.
I couldn't find more precise pointers after all these years so I'd like to 
know if that bug really affected my chipset, and if 2.6.10 is a valid 
solution.. 

the kernel identifies the chipset at boot:


# dmesg | fgrep -i via
ACPI: DSDT (v001    VIA APOLLO-P 0x00001000 MSFT 0x0100000b) @ 0x00000000
PCI: Via IRQ fixup
agpgart: Detected VIA Apollo Pro 133 chipset
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
parport_pc: VIA 686A/8231 detected
parport_pc: VIA parallel port: io=0x378, irq=7

# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev
 c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AG
P]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 22
)
00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/
C/VT8235 PIPC Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] 
(rev
10)
00:07.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] 
(rev
10)
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 
08)
00:0f.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 
08)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP 2X (rev 
27)

