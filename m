Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVCSJPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVCSJPO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 04:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVCSJPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 04:15:14 -0500
Received: from v1n54.linking.ee ([212.27.244.54]:22730 "EHLO linking.ee")
	by vger.kernel.org with ESMTP id S262435AbVCSJPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 04:15:02 -0500
Message-ID: <423BEDCE.30900@ylenurme.ee>
Date: Sat, 19 Mar 2005 11:15:58 +0200
From: Elmer Joandi <elmer@ylenurme.ee>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI suspend lockup 2.6.10, works with 2.6.11
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on 15 Feb I complained about 2.6.10, now it works now, with 2.6.11.
However, there are two warnings still, below.

PM: Preparing system for suspend
Stopping tasks: 
============================================================|
PM: Entering state.
Back to C!
Debug: sleeping function called from invalid context at mm/slab.c:2082
in_atomic():0, irqs_disabled():1
 [<c012102c>] __might_sleep+0xac/0xc0
 [<c016047b>] kmem_cache_alloc+0x5b/0x60
 [<c026c5aa>] acpi_pci_link_set+0x43/0x193
 [<c026ca09>] irqrouter_resume+0x1c/0x30
 [<c02a8e47>] sysdev_resume+0xf7/0xfc
 [<c02ad8e5>] device_power_up+0x5/0xa
 [<c014b995>] suspend_enter+0x35/0x50
 [<c014ba35>] enter_state+0x55/0x90
 [<c02697b6>] acpi_suspend+0x25/0x33
 [<c0238088>] copy_from_user+0x58/0x90
 [<c0269895>] acpi_system_write_sleep+0x69/0x7a
 [<c0181b83>] vfs_write+0xc3/0x130
 [<c0181cb7>] sys_write+0x47/0x80
 [<c0103b49>] sysenter_past_esp+0x52/0x75
PM: Finishing up.
----> point of previous lockup here
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 restarted, EHCI 1.00, driver 10 Dec 2004
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
PCI: Enabling device 0000:02:02.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
Restarting tasks... done
ALPS Touchpad (Glidepoint) detected
  Disabling hardware tapping
input: AlpsPS/2 ALPS TouchPad on isa0060/serio4


lspci:
00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller 
(rev 03)
00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 03)
00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller 
(rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage 
Controller (rev 03)
00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 03)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 
Audio Controller (rev 03)
00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf 
[Radeon Mobility 9000 M9] (rev 01)
02:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
02:02.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini 
PCI Adapter (rev 04)
02:03.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller



