Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWFEE6b (ORCPT <rfc822;ralf@linux-mips.org>);
	Mon, 5 Jun 2006 00:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWFEE6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 00:58:31 -0400
Received: from wx-out-0102.google.com ([66.249.82.205]:2961 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932412AbWFEE6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 00:58:30 -0400
Message-ID: <a44ae5cd0606042158t4448a6f5od12a032eeb215c15@mail.gmail.com>
Date: Sun, 4 Jun 2006 21:58:29 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc5-mm3 -- BUG: sleeping function called from invalid context at include/asm/semaphore.h:9 9 in_atomic():0, irqs_disabled():1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: <linux-kernel-owner+ralf=40linux-mips.org-S932412AbWFEE6b@vger.kernel.org>

BUG: sleeping function called from invalid context at
include/asm/semaphore.h:9 9
in_atomic():0, irqs_disabled():1
 [<c0104851>] show_trace+0xd/0x10
 [<c010486b>] dump_stack+0x17/0x1c
 [<c011448c>] __might_sleep+0x93/0x9d
 [<c020077c>] acpi_os_wait_semaphore+0x68/0xba
 [<c0215ef1>] acpi_ut_acquire_mutex+0x2a/0x69
 [<c020c9d1>] acpi_set_register+0x5a/0x173
 [<c0204eab>] acpi_clear_event+0x25/0x2b
 [<c021652d>] acpi_pm_enter+0x91/0xb8
 [<c0131607>] suspend_enter+0x33/0x46
 [<c0131795>] enter_state+0x140/0x18c
 [<c0131862>] state_store+0x81/0x97
 [<c018d558>] subsys_attr_store+0x20/0x25
 [<c018db8a>] sysfs_write_file+0xb5/0xda
 [<c0158a11>] vfs_write+0xac/0x158
 [<c015928d>] sys_write+0x3b/0x60
 [<c03078a5>] sysenter_past_esp+0x56/0x79
Back to C!
PM: Finishing wakeup.
 acpi: resuming
agpgart-intel 0000:00:00.0: resuming
 0000:00:00.1: resuming
 0000:00:00.3: resuming
 0000:00:02.0: resuming
PM: Writing back config space on device 0000:00:02.0 at offset f (was
100, writ ing 10a)
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 17
 0000:00:02.1: resuming
PM: Writing back config space on device 0000:00:02.1 at offset 5 (was
0, writing e0080000)
PM: Writing back config space on device 0000:00:02.1 at offset 4 (was
8, writing f0000008)
PM: Writing back config space on device 0000:00:02.1 at offset 1 (was
900000, writing 900007)
uhci_hcd 0000:00:1d.0: resuming
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.0 to 64
usb usb1: root hub lost power or was reset
uhci_hcd 0000:00:1d.1: resuming
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.1 to 64
usb usb2: root hub lost power or was reset
uhci_hcd 0000:00:1d.2: resuming
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.2 to 64
usb usb3: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: resuming
ACPI (acpi_bus-0192): Device `USB7]is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to 64
PM: Writing back config space on device 0000:00:1d.7 at offset 1 (was
2900006, writing 2900106)
usb usb4: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
 0000:00:1e.0: resuming
PM: Writing back config space on device 0000:00:1e.0 at offset 9 (was
fff0, writing 51f05000)
PM: Writing back config space on device 0000:00:1e.0 at offset 8 (was
fff0, writing e020e020)
PM: Writing back config space on device 0000:00:1e.0 at offset 7 (was
228000f0,  writing 2803030)
PM: Writing back config space on device 0000:00:1e.0 at offset 6 (was
40020200,  writing 40060200)
PM: Writing back config space on device 0000:00:1e.0 at offset 1 (was
80800005,  writing 80800107)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
 0000:00:1f.0: resuming
PIIX_IDE 0000:00:1f.1: resuming
PM: Writing back config space on device 0000:00:1f.1 at offset f (was
100, writing 1ff)
PM: Writing back config space on device 0000:00:1f.1 at offset 9 (was
0, writing 52000000)
PM: Writing back config space on device 0000:00:1f.1 at offset 1 (was
2800005, writing 2800007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 19
 0000:00:1f.3: resuming
Intel ICH 0000:00:1f.5: resuming
PM: Writing back config space on device 0000:00:1f.5 at offset f (was
200, writing 205)
PM: Writing back config space on device 0000:00:1f.5 at offset 7 (was
0, writing e0100800)
PM: Writing back config space on device 0000:00:1f.5 at offset 6 (was
0, writing e0100c00)
PM: Writing back config space on device 0000:00:1f.5 at offset 5 (was
1301, writing 18c1)
PM: Writing back config space on device 0000:00:1f.5 at offset 4 (was
1201, writing 1c01)
PM: Writing back config space on device 0000:00:1f.5 at offset 1 (was
2900005, writing 2900000)
PCI: Enabling device 0000:00:1f.5 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.5 to 64
 0000:00:1f.6: resuming
PM: Writing back config space on device 0000:00:1f.6 at offset f (was
200, writing 205)
PM: Writing back config space on device 0000:00:1f.6 at offset 5 (was
1501, writing 2001)
PM: Writing back config space on device 0000:00:1f.6 at offset 4 (was
1401, writing 2401)
PM: Writing back config space on device 0000:00:1f.6 at offset 1 (was
2900005, writing 2900000)
8139too 0000:02:00.0: resuming
PM: Writing back config space on device 0000:02:00.0 at offset 5 (was
0, writing e0207800)
PM: Writing back config space on device 0000:02:00.0 at offset 4 (was
1, writing 3001)
PM: Writing back config space on device 0000:02:00.0 at offset 3 (was
0, writing 4000)
PM: Writing back config space on device 0000:02:00.0 at offset 1 (was
2900000, writing 2900107)
 0000:02:06.0: resuming
PM: Writing back config space on device 0000:02:06.0 at offset f (was
18030100,  writing 18030104)
PM: Writing back config space on device 0000:02:06.0 at offset 4 (was
0, writing e0206000)
PM: Writing back config space on device 0000:02:06.0 at offset 3 (was
0, writing 4008)
PM: Writing back config space on device 0000:02:06.0 at offset 1 (was
2900000, writing 2900100)
yenta_cardbus 0000:02:09.0: resuming
PM: Writing back config space on device 0000:02:09.0 at offset f (was
34001ff, writing 5c001ff)
PM: Writing back config space on device 0000:02:09.0 at offset e (was
0, writing 38fc)
PM: Writing back config space on device 0000:02:09.0 at offset d (was
0, writing 3800)
PM: Writing back config space on device 0000:02:09.0 at offset c (was
0, writing 34fc)
PM: Writing back config space on device 0000:02:09.0 at offset b (was
0, writing 3400)
PM: Writing back config space on device 0000:02:09.0 at offset a (was
0, writing 55fff000)
PM: Writing back config space on device 0000:02:09.0 at offset 9 (was
0, writing 54000000)
PM: Writing back config space on device 0000:02:09.0 at offset 8 (was
0, writing 51fff000)
PM: Writing back config space on device 0000:02:09.0 at offset 7 (was
0, writing 50000000)
PM: Writing back config space on device 0000:02:09.0 at offset 6 (was
0, writing b0060302)
PM: Writing back config space on device 0000:02:09.0 at offset 4 (was
0, writing e0209000)
PM: Writing back config space on device 0000:02:09.0 at offset 3 (was
820000, writing 82a820)
PM: Writing back config space on device 0000:02:09.0 at offset 1 (was
2100040, writing 2100007)
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 20 (level, low) -> IRQ 16
ohci1394 0000:02:09.2: resuming
PM: Writing back config space on device 0000:02:09.2 at offset f (was
4030300, writing 4030304)
PM: Writing back config space on device 0000:02:09.2 at offset 5 (was
0, writing e0200000)
PM: Writing back config space on device 0000:02:09.2 at offset 4 (was
0, writing e0207000)
PM: Writing back config space on device 0000:02:09.2 at offset 3 (was
800000, writing 804008)
PM: Writing back config space on device 0000:02:09.2 at offset 1 (was
2100000, writing 2100116)
 0000:02:09.3: resuming
PM: Writing back config space on device 0000:02:09.3 at offset f (was
40701ff, writing 407010b)
PM: Writing back config space on device 0000:02:09.3 at offset 4 (was
0, writing e0204000)
PM: Writing back config space on device 0000:02:09.3 at offset 3 (was
800000, writing 804008)
PM: Writing back config space on device 0000:02:09.3 at offset 1 (was
2100000, writing 2100106)
 0000:02:09.4: resuming
PM: Writing back config space on device 0000:02:09.4 at offset f (was
40701ff, writing 407010b)
PM: Writing back config space on device 0000:02:09.4 at offset 6 (was
0, writing e0207c00)
PM: Writing back config space on device 0000:02:09.4 at offset 5 (was
0, writing e0208000)
PM: Writing back config space on device 0000:02:09.4 at offset 4 (was
0, writing e0208400)
PM: Writing back config space on device 0000:02:09.4 at offset 3 (was
800000, writing 804008)
PM: Writing back config space on device 0000:02:09.4 at offset 1 (was
2100000, writing 2100106)
