Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTKFO0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 09:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTKFO0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 09:26:14 -0500
Received: from apate.telenet-ops.be ([195.130.132.57]:2224 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263598AbTKFO0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 09:26:11 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test9] ACPI-0094: *** Error: Could not acquire interpreter mutex
Date: Thu, 6 Nov 2003 15:26:12 +0100
User-Agent: KMail/1.5.4
Cc: acpi-support@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311061526.20302.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Today I got round to installing 2.6.0-test9. All seems to work great, except for this strange message in my dmesg:

ACPI-0094: *** Error: Could not acquire interpreter mutex

which comes back now and again. Is this something I should worry about? I couldn't find anything about it on the net...

System is an ACER TravelMate 803LCi.

ACPI Related bootmessages:

Nov  6 14:55:52 precious kernel:  BIOS-e820: 000000001ff70000 - 000000001ff7b000 (ACPI data)
Nov  6 14:55:52 precious kernel:  BIOS-e820: 000000001ff7b000 - 000000001ff80000 (ACPI NVS)
Nov  6 14:55:52 precious kernel: ACPI: RSDP (v000 ACER                                      ) @ 0x000f60c0
Nov  6 14:55:52 precious kernel: ACPI: RSDT (v001 ACER   Cardinal 0x20020730  LTP 0x00000000) @ 0x1ff74c61
Nov  6 14:55:52 precious kernel: ACPI: FADT (v001 ACER   Cardinal 0x20020730 PTL  0x0000001e) @ 0x1ff7af64
Nov  6 14:55:52 precious kernel: ACPI: BOOT (v001 ACER   Cardinal 0x20020730  LTP 0x00000001) @ 0x1ff7afd8
Nov  6 14:55:52 precious kernel: ACPI: DSDT (v001 ACER   Cardinal 0x20020730 MSFT 0x0100000d) @ 0x00000000
Nov  6 14:55:53 precious kernel: ACPI: Subsystem revision 20031002
Nov  6 14:55:53 precious kernel: ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
Nov  6 14:55:53 precious kernel: ACPI: Interpreter enabled
Nov  6 14:55:53 precious kernel: ACPI: Using PIC for interrupt routing
Nov  6 14:55:53 precious kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 11 12)
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 11 12)
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 10)
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
Nov  6 14:55:53 precious kernel: ACPI: Embedded Controller [EC0] (gpe 29)
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
Nov  6 14:55:53 precious kernel: ACPI: Power Resource [PFN0] (off)
Nov  6 14:55:53 precious kernel: ACPI: Power Resource [PFN1] (off)
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Nov  6 14:55:53 precious kernel: ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
Nov  6 14:55:53 precious kernel: PCI: Using ACPI for IRQ routing
Nov  6 14:55:53 precious kernel: ACPI: AC Adapter [ACAD] (off-line)
Nov  6 14:55:53 precious kernel: ACPI: Battery Slot [BAT1] (battery present)
Nov  6 14:55:53 precious kernel: ACPI: Battery Slot [BAT2] (battery absent)
Nov  6 14:55:53 precious kernel: ACPI: Power Button (FF) [PWRF]
Nov  6 14:55:53 precious kernel: ACPI: Lid Switch [LID]
Nov  6 14:55:53 precious kernel: ACPI: Sleep Button (CM) [SLPB]
Nov  6 14:55:53 precious kernel: ACPI: Fan [FAN0] (off)
Nov  6 14:55:53 precious kernel: ACPI: Fan [FAN1] (off)
Nov  6 14:55:53 precious kernel: ACPI: Processor [CPU0] (supports C1 C2 C3)
Nov  6 14:55:53 precious kernel: ACPI: Thermal Zone [THRM] (55 C)
Nov  6 14:55:53 precious kernel: ACPI: (supports S0 S3 S4 S5)
Nov  6 14:56:32 precious kernel:     ACPI-0094: *** Error: Could not acquire interpreter mutex
Nov  6 14:58:28 precious kernel:     ACPI-0094: *** Error: Could not acquire interpreter mutex
Nov  6 15:00:15 precious kernel:     ACPI-0094: *** Error: Could not acquire interpreter mutex


Thanks.

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/qloKUQQOfidJUwQRAs35AJ41E/MiHshYyzMXe4eY4CJxmikR7QCfaGgl
DlgWtq4TV9cbw3BNsxXJMVc=
=DASy
-----END PGP SIGNATURE-----

