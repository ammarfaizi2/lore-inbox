Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUAJPg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbUAJPg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:36:29 -0500
Received: from fmr06.intel.com ([134.134.136.7]:63433 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265181AbUAJPg0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:36:26 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: problems with CONFIG_PCI_USE_VECTOR in 2.6.1
Date: Sat, 10 Jan 2004 07:36:23 -0800
Message-ID: <7F740D512C7C1046AB53446D3720017361881E@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problems with CONFIG_PCI_USE_VECTOR in 2.6.1
Thread-Index: AcPXMXP9b3rkpyx5Sterxiysx6GhwAAXSusA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Eric C. Cooper" <ecc@cmu.edu>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Jan 2004 15:36:23.0829 (UTC) FILETIME=[80D5B450:01C3D78F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Can please you check what happens if you boot the kernel with ACPI
disabled, i.e. use the boot parameter "acpi=off" or "pci=noacpi"? 

2. Do you see the same ACPI complaints when you boot the kernel without
CONFIG_PCI_USE_VECTOR configured?

Jun

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Eric C. Cooper
> Sent: Friday, January 09, 2004 8:21 PM
> To: linux-kernel@vger.kernel.org
> Subject: problems with CONFIG_PCI_USE_VECTOR in 2.6.1
> 
> When I tried a 2.6.1 kernel with CONFIG_PCI_USE_VECTOR, my onboard
> Ethernet (sis900) produced nothing but watchdog timeouts.  It worked
> fine with the old IRQ routing.
> 
> When I looked in /var/log/syslog, I noticed that the Ethernet driver
> was using a different IRQ, so I suspected the vector routing.  I found
> the following suspicious entries:
> 
> Jan  9 20:09:08 jaguar kernel: PCI: PCI BIOS revision 2.10 entry at
> 0xf11b0, last bus=1
> Jan  9 20:09:08 jaguar kernel: PCI: Using configuration type 1
> Jan  9 20:09:08 jaguar kernel: mtrr: v2.0 (20020519)
> Jan  9 20:09:08 jaguar kernel: ACPI: Subsystem revision 20031002
> Jan  9 20:09:08 jaguar kernel: IOAPIC[0]: Set PCI routing entry (2-20
->
> 0xa9 -> IRQ 20 Mode:1 Active:1)
> Jan  9 20:09:08 jaguar kernel: ACPI: SCI (IRQ20) allocation failed
> Jan  9 20:09:08 jaguar kernel:     ACPI-0133: *** Error: Unable to
install
> System Control Interrupt Handler, AE_NOT_ACQUIRED
> Jan  9 20:09:08 jaguar kernel: ACPI: Unable to start the ACPI
Interpreter
> Jan  9 20:09:08 jaguar kernel: Trying to free free IRQ20
> Jan  9 20:09:08 jaguar kernel: ACPI: ACPI tables contain no PCI IRQ
> routing entries
> Jan  9 20:09:08 jaguar kernel: PCI: Invalid ACPI-PCI IRQ routing table
> Jan  9 20:09:08 jaguar kernel: PCI: Probing PCI hardware
> Jan  9 20:09:08 jaguar kernel: PCI: Probing PCI hardware (bus 00)
> Jan  9 20:09:08 jaguar kernel: Enabling SiS 96x SMBus.
> Jan  9 20:09:08 jaguar kernel: PCI: Using IRQ router default
[1039/0963]
> at 0000:00:02.0
> Jan  9 20:09:08 jaguar kernel: PCI BIOS passed nonexistent PCI bus 0!
> Jan  9 20:09:08 jaguar last message repeated 9 times
> Jan  9 20:09:08 jaguar kernel: PCI BIOS passed nonexistent PCI bus 1!
> Jan  9 20:09:08 jaguar kernel: PCI BIOS passed nonexistent PCI bus 0!
> 
> 
> If anyone needs more information (kernel configs, syslog from the
> non-USE_VECTOR kernel, etc) or if I can help in any way by trying
> something out, please let me know.
> 
> --
> Eric C. Cooper          e c c @ c m u . e d u
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
