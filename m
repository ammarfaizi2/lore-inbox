Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVI0Oan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVI0Oan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVI0Oan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:30:43 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:23400 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964932AbVI0Oam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:30:42 -0400
Date: Tue, 27 Sep 2005 08:31:15 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: USB on nForce4 board only working with pci=routeirq
In-reply-to: <4RiHo-6iG-19@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <433957B3.1050402@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4RaTs-3kL-7@gated-at.bofh.it> <4RaTs-3kL-5@gated-at.bofh.it>
 <4RiHo-6iG-19@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Engelhardt wrote:
> Sep 25 10:12:54 discovery ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller
> (OHCI) Driver (PCI)
> Sep 25 10:12:54 discovery acpi_bus-0212 [02] acpi_bus_set_power    : Device is
> not power manageable
> Sep 25 10:12:54 discovery ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
> Sep 25 10:12:54 discovery ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] ->
> GSI 20 (level, low) -> IRQ 66
> Sep 25 10:12:54 discovery PCI: Setting latency timer of device 0000:00:02.0 to
> 64
> Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: OHCI Host Controller
> Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: USB HC takeover failed! 
> (BIOS/SMM bug)
> Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: can't reset
> Sep 25 10:12:54 discovery ACPI: PCI interrupt for device 0000:00:02.0 disabled
> Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: init 0000:00:02.0 fail, -16
> Sep 25 10:12:54 discovery ohci_hcd: probe of 0000:00:02.0 failed with error -16

You might try disabling USB Legacy support in the BIOS and see if that 
helps. It would seem the BIOS likely has some bugs in the code that is 
supposed to handle handoff of the OHCI controller from the BIOS SMM code 
(that does USB legacy) to the OS. I haven't heard of such problems on 
other NF4 boards (I have one) so I'm assuming it's something in the ECS 
BIOS.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

