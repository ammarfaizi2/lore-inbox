Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWABLKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWABLKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 06:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWABLKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 06:10:05 -0500
Received: from vvv.conterra.de ([212.124.44.162]:13535 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S932251AbWABLKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 06:10:04 -0500
Message-ID: <43B90A04.2090403@conterra.de>
Date: Mon, 02 Jan 2006 12:09:56 +0100
From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: X86_64 + VIA + 4g problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just gave 2.6.15-rc7 a try, but still fail when plugging 4g into the board :-(
Its an Asus sk8v (VIA chipset), thus I get:

  Linux version 2.6.15-rc7 (root@linux2) (gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)) #9 Sun Jan 1 19:54:26 CET 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000bff30000 (usable)
  BIOS-e820: 00000000bff30000 - 00000000bff40000 (ACPI data)
  BIOS-e820: 00000000bff40000 - 00000000bfff0000 (ACPI NVS)
  BIOS-e820: 00000000bfff0000 - 00000000c0000000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fa850
ACPI: XSDT (v001 A M I  OEMXSDT  0x06000517 MSFT 0x00000097) @ 0x00000000bff30100
ACPI: FADT (v003 A M I  OEMFACP  0x06000517 MSFT 0x00000097) @ 0x00000000bff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x06000517 MSFT 0x00000097) @ 0x00000000bff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000517 MSFT 0x00000097) @ 0x00000000bff40040
ACPI: DSDT (v001  SK8V_ SK8V_033 0x00000033 MSFT 0x0100000d) @ 0x0000000000000000
On node 0 totalpages: 1029568
   DMA zone: 3160 pages, LIFO batch:0
   DMA32 zone: 767848 pages, LIFO batch:31
   Normal zone: 258560 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:0
Looks like a VIA chipset. Disabling IOMMU. Overwrite with "iommu=allowed"
.....
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 19
eth0: 3Com Gigabit LOM (3C940)
       PrefPort:A  RlmtMode:Check Link State

don't know, if it's related to that, but with 2G it runs stable since about a year.

The problem arises as soon as my network (3C940) gets enabled, the following
message is continuously repeated and nothing else works any more, not even
console switching.

eth0: -- ERROR --
Class: Hardware failure
Nr: 0x264
Msg: unexpected IRQ Status error
eth0: Adapter failed.

Any suggestion? Try different boot options acpi= pci= iommu= ... ?

Dieter.
-- 
Dieter Stüken, con terra GmbH, Münster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
