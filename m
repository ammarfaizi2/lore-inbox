Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbVI1Hcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVI1Hcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbVI1Hcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:32:39 -0400
Received: from main.gmane.org ([80.91.229.2]:34784 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030208AbVI1Hcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:32:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: bogus VIA IRQ fixup in drivers/pci/quirks.c
Date: Wed, 28 Sep 2005 09:28:56 +0200
Message-ID: <pan.2005.09.28.07.28.55.23717@free.fr>
References: <20050926184451.GB11752@suse.de> <Pine.LNX.4.58.0509261446590.3308@g5.osdl.org> <1127831274.433956ea35992@webmail.jordet.nu> <Pine.LNX.4.58.0509270734340.3308@g5.osdl.org> <1127855989.4339b77537987@webmail.jordet.nu> <Pine.LNX.4.58.0509271432490.3308@g5.osdl.org> <1127857716.4339be34f239f@webmail.jordet.nu> <Pine.LNX.4.58.0509271556211.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Le Tue, 27 Sep 2005 15:58:33 -0700, Linus Torvalds a écrit :

> 
> 

> so my patch didn't change anything at all for you (which is correct - it 
> was designed not to ;)
> 

It will for me as I have [1].

But since the irq for ide are probe after, I think it won't change
anything.
I will try your patch when I'll have some free time.

Matthieu

PS : The Via fix are quite strange, as if I understand the message it try
to map usb to irq 1...

[1]
$dmesg | grep -B2 -A2 "Via IRQ"
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 15
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SAMSUNG SP0802N, ATA DISK drive
hdb: IC35L040AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
hdd: CD-RW CDR-6S48, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
--
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 1
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
--
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 1
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
--
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 1
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
--
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 1
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
--
         For more details, read ALSA-Configuration.txt.
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:11.5, from 10 to 5
PCI: Setting latency timer of device 0000:00:11.5 to 64
Floppy drive(s): fd0 is 1.44M

