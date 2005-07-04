Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVGDVOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVGDVOz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 17:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVGDVOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 17:14:54 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:55305 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S261677AbVGDVOl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 17:14:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: IRQ routing problem
Date: Mon, 4 Jul 2005 16:14:37 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C2A@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IRQ routing problem
Thread-Index: AcV/wTmwIUtO1TP0RoOoukAFYsJqUgBG9OIA
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Marko Kohtala" <marko.kohtala@gmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Jul 2005 21:14:38.0232 (UTC) FILETIME=[62B89980:01C580DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been having interrupt problems. 2.6.12 worked fine, but 
> soon after it got broken and was still broken just now that I 
> checked git version.
> 
> Interrupts get somehow misrouted.
> 
> Here is a part from the syslog showing the problem:
> 
> Jul  3 13:17:09 kohtala kernel: USB Universal Host Controller 
> Interface driver v2.3 Jul  3 13:17:09 kohtala kernel: <7>Pin 
> 2-12 already programmed Jul  3 13:17:09 kohtala kernel: ACPI: 
> PCI Interrupt 0000:00:11.2[D] -> GSI 12 (level, low) -> IRQ 
> 20 Jul  3 13:17:09 kohtala kernel: PCI: Via IRQ fixup for 
> 0000:00:11.2, from 12 to 4 Jul  3 13:17:09 kohtala kernel: 
> uhci_hcd 0000:00:11.2: VIA Technologies, Inc. VT82xxxxx UHCI 
> USB 1.1 Controller Jul  3 13:17:09 kohtala kernel: uhci_hcd 
> 0000:00:11.2: new USB bus registered, assigned bus number 4 
> Jul  3 13:17:09 kohtala kernel: uhci_hcd 0000:00:11.2: irq 
> 20, io base 0x0000cc00 Jul  3 13:17:09 kohtala kernel: hub 
> 4-0:1.0: USB hub found Jul  3 13:17:09 kohtala kernel: hub 
> 4-0:1.0: 2 ports detected Jul  3 13:17:09 kohtala kernel: usb 
> 3-1: new low speed USB device using ohci_hcd and address 2 
> Jul  3 13:17:09 kohtala kernel: irq 20: nobody cared (try 
> booting with the "irqpoll" option)
> 
> Working kernel uses IRQ 12.
> 
Hi Marko,
Have you tried booting with "pci=noacpi" boot option?

Thanks,
--Natalie
