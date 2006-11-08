Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754580AbWKHMog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbWKHMog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754582AbWKHMog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:44:36 -0500
Received: from outmx020.isp.belgacom.be ([195.238.4.201]:25513 "EHLO
	outmx020.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1754580AbWKHMof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:44:35 -0500
Message-ID: <4551D12D.4010304@trollprod.org>
Date: Wed, 08 Nov 2006 13:44:29 +0100
From: Olivier Nicolas <olivn@trollprod.org>
User-Agent: Thunderbird 2.0b1pre (X11/20061106)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc5 x86_64  irq 22: nobody cared
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.19-rc5 does not boot properly, I have tried pci=routeirq, irpoll 
without success.

Full details (.config, dmesg, /proc/interrupts) are in 
http://olivn.trollprod.org/2.6.19-rc5-irq.tar.gz

Olivier




System: ASUS M2N32-SLI, AMD64 X2 Dual Core 4600


kernel 2.6.9-rc5

irq 22: nobody cared (try booting with the "irqpoll" option)

Call Trace:
  <IRQ>  [<ffffffff80259055>] __report_bad_irq+0x35/0x90
  [<ffffffff802592d3>] note_interrupt+0x223/0x280
  [<ffffffff80259d41>] handle_fasteoi_irq+0xb1/0xf0
  [<ffffffff8020b17c>] call_softirq+0x1c/0x30
  [<ffffffff8020d1ba>] do_IRQ+0x8a/0xe0
  [<ffffffff8020a571>] ret_from_intr+0x0/0xa
  <EOI>
handlers:
[<ffffffff8807f150>] (nv_generic_interrupt+0x0/0xc0 [sata_nv])
Disabling IRQ #22


            CPU0       CPU1
   0:        223      45540   IO-APIC-edge      timer
   1:          1        402   IO-APIC-edge      i8042
   6:          1          4   IO-APIC-edge      floppy
   8:          0          0   IO-APIC-edge      rtc
   9:          0          0   IO-APIC-fasteoi   acpi
  12:          0        103   IO-APIC-edge      i8042
  14:          7        140   IO-APIC-edge      ide0
  16:          0          0   IO-APIC-fasteoi   libata
  17:          0         10   IO-APIC-fasteoi   bttv0
  20:          0         20   IO-APIC-fasteoi   ehci_hcd:usb1
  21:          0          0   IO-APIC-fasteoi   libata
  22:        214      99786   IO-APIC-fasteoi   libata, HDA Intel
  23:         76       6230   IO-APIC-fasteoi   libata, ohci_hcd:usb2
308:          5       3169   PCI-MSI-edge      eth1
309:          0         10   PCI-MSI-edge      eth1
310:          0         44   PCI-MSI-edge      eth1
311:          1       3193   PCI-MSI-edge      eth0
312:          0          0   PCI-MSI-edge      eth0
313:          0          1   PCI-MSI-edge      eth0
NMI:         64         68
LOC:      45716      45691
ERR:          0



kernel 2.6.19-rc5 with pci=routeirq

irq 21: nobody cared (try booting with the "irqpoll" option)

Call Trace:
  <IRQ>  [<ffffffff80259055>] __report_bad_irq+0x35/0x90
  [<ffffffff802592d3>] note_interrupt+0x223/0x280
  [<ffffffff80259d41>] handle_fasteoi_irq+0xb1/0xf0
  [<ffffffff8020b17c>] call_softirq+0x1c/0x30
  [<ffffffff8020d1ba>] do_IRQ+0x8a/0xe0
  [<ffffffff802092f0>] default_idle+0x0/0x50
  [<ffffffff8020a571>] ret_from_intr+0x0/0xa
  <EOI>  [<ffffffff80209319>] default_idle+0x29/0x50
  [<ffffffff8020939b>] cpu_idle+0x5b/0x80
  [<ffffffff8050039c>] start_secondary+0x50c/0x520

handlers:
[<ffffffff880e6fd0>] (usb_hcd_irq+0x0/0x60 [usbcore])
Disabling IRQ #21

            CPU0       CPU1
   0:        214      24856   IO-APIC-edge      timer
   1:          0        359   IO-APIC-edge      i8042
   6:          0          5   IO-APIC-edge      floppy
   8:          0          0   IO-APIC-edge      rtc
   9:          0          0   IO-APIC-fasteoi   acpi
  12:          0        103   IO-APIC-edge      i8042
  14:          0        128   IO-APIC-edge      ide0
  16:          0          0   IO-APIC-fasteoi   libata
  17:          1          2   IO-APIC-fasteoi   bttv0
  20:         22       6469   IO-APIC-fasteoi   libata
  21:         11      99989   IO-APIC-fasteoi   ehci_hcd:usb2, HDA Intel
  22:          0          1   IO-APIC-fasteoi   libata, ohci_hcd:usb1
  23:          0          0   IO-APIC-fasteoi   libata
308:          8       2378   PCI-MSI-edge      eth1
309:          0          9   PCI-MSI-edge      eth1
310:          0          9   PCI-MSI-edge      eth1
311:          4       2401   PCI-MSI-edge      eth0
312:          0          0   PCI-MSI-edge      eth0
313:          0          1   PCI-MSI-edge      eth0
NMI:         74         47
LOC:      25024      24991
ERR:          0



kernel 2.6.19-rc5 with irqpoll

Hang during boot
(See screenshot in http://olivn.trollprod.org/2.6.19-rc5-irq.tar.gz)



kernel 2.6.18 (works without any problem)

            CPU0       CPU1
   0:       1590     998089    IO-APIC-edge  timer
   1:          2        657    IO-APIC-edge  i8042
   6:          0          5    IO-APIC-edge  floppy
   8:          0          0    IO-APIC-edge  rtc
   9:          0          0   IO-APIC-level  acpi
  12:        194      59353    IO-APIC-edge  i8042
  14:         13       6381    IO-APIC-edge  ide0
  50:          0          0   IO-APIC-level  libata
  58:          0          0   IO-APIC-level  libata
  66:        109     181425   IO-APIC-level  libata, nvidia
  74:         41        963   IO-APIC-level  ehci_hcd:usb1, HDA Intel
  82:          4          6   IO-APIC-level  bttv0
  90:          0          0       PCI-MSI-X  eth0
  98:          3          0       PCI-MSI-X  eth0
106:     212234          0       PCI-MSI-X  eth0
114:        532          0       PCI-MSI-X  eth1
122:        445          0       PCI-MSI-X  eth1
130:     212217          0       PCI-MSI-X  eth1
233:         73      23009   IO-APIC-level  libata, ohci_hcd:usb2
NMI:         99        104
LOC:     999684     999664
ERR:          0
MIS:          0



