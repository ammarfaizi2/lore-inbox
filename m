Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUJDIsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUJDIsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 04:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267852AbUJDIsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 04:48:13 -0400
Received: from CPE-144-131-119-86.nsw.bigpond.net.au ([144.131.119.86]:55536
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S267851AbUJDIsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 04:48:08 -0400
Message-ID: <41610E47.2040906@eyal.emu.id.au>
Date: Mon, 04 Oct 2004 18:48:07 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc3-mm1: Badness in remove_proc_entry at fs/proc/generic.c:688
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this [<<<<<<<<<<<<<<<] in every boot. I see it already mentioned
on the lists (in different contexts) - should I ignore it? It is 100%
reproducible and I can supply details and test patches is there is
a need.

usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
uhci_hcd 0000:00:1d.0: irq 16, io base 0xbc00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb1: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
usb usb1: Manufacturer: Linux 2.6.9-rc3-mm1 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
uhci_hcd 0000:00:1d.1: irq 19, io base 0xb000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb2: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
usb usb2: Manufacturer: Linux 2.6.9-rc3-mm1 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
uhci_hcd 0000:00:1d.2: irq 18, io base 0xb400
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb3: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
usb usb3: Manufacturer: Linux 2.6.9-rc3-mm1 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
uhci_hcd 0000:00:1d.3: irq 16, io base 0xb800
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: detected 2 ports
usb usb4: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
usb usb4: Manufacturer: Linux 2.6.9-rc3-mm1 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.3
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Badness in remove_proc_entry at fs/proc/generic.c:688 <<<<<<<<<<<<<<<
  [remove_proc_entry+250/309] remove_proc_entry+0xfa/0x135
  [pg0+943583476/1069347840] uhci_hcd_init+0xf4/0x121 [uhci_hcd]
  [sys_init_module+395/575] sys_init_module+0x18b/0x23f
  [syscall_call+7/11] syscall_call+0x7/0xb
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xde100000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
usb usb5: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
usb usb5: Manufacturer: Linux 2.6.9-rc3-mm1 ehci_hcd
usb usb5: SerialNumber: 0000:00:1d.7
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected

-- 
Eyal Lebedinsky	 (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
