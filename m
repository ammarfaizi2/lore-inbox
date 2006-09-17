Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWIQQcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWIQQcn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 12:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWIQQcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 12:32:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45235 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964996AbWIQQcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 12:32:42 -0400
Date: Sun, 17 Sep 2006 16:09:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: bluetooth oops during resume from ram
Message-ID: <20060917140952.GA3349@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If I suspend-to-RAM with usb active on thinkpad x60, I get an
oops. Machine works okay after that, but...

it seems bluetooth is scribbling over more memory than was allocated
(?)

							Pavel

EXT2-fs warning (device sda2): ext2_fill_super: mounting ext3 filesystem as ext2
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
PM: Preparing system for mem sleep
Freezing cpus ...
Breaking affinity for irq 0
Breaking affinity for irq 12
Breaking affinity for irq 20
CPU 1 is now offline
SMP alternatives: switching to UP code
CPU1 is down
Stopping tasks: ====================================================================|
mmcblk mmc0:cc53: suspend
i8042 i8042: suspend
 usbdev5.2_ep83: PM: suspend 0->2, parent 5-2:1.0 already 1
 usbdev5.2_ep02: PM: suspend 0->2, parent 5-2:1.0 already 1
 usbdev5.2_ep81: PM: suspend 0->2, parent 5-2:1.0 already 1
usb 5-2:1.0: PM: suspend 1-->2
usb 5-2: suspend, may wakeup
hub 5-0:1.0: suspend
usb usb5: suspend, may wakeup
hub 4-0:1.0: suspend
usb usb4: suspend, may wakeup
hub 3-0:1.0: suspend
usb usb3: suspend, may wakeup
hub 2-0:1.0: suspend
usb usb2: suspend, may wakeup
hub 1-0:1.0: suspend
usb usb1: suspend, may wakeup
sd 0:0:0:0: suspend
serial8250 serial8250: suspend
vesafb vesafb.0: suspend
pcspkr pcspkr: suspend
platform bluetooth: suspend
pnp 00:0b: suspend
pnp 00:0a: suspend
i8042 aux 00:09: suspend
i8042 kbd 00:08: suspend
pnp 00:07: suspend
pnp 00:06: suspend
pnp 00:05: suspend
pnp 00:04: suspend
pnp 00:03: suspend
system 00:02: suspend
pnp 00:01: suspend
system 00:00: suspend
sdhci 0000:15:00.2: suspend
ACPI: PCI interrupt for device 0000:15:00.2 disabled
ohci1394 0000:15:00.1: suspend
yenta_cardbus 0000:15:00.0: suspend
ACPI: PCI interrupt for device 0000:15:00.0 disabled
pci 0000:03:00.0: suspend
e1000 0000:02:00.0: suspend
ACPI: PCI interrupt for device 0000:02:00.0 disabled
pci 0000:00:1f.3: suspend
ahci 0000:00:1f.2: suspend
ACPI: PCI interrupt for device 0000:00:1f.2 disabled
ata1: exception Emask 0x52 SAct 0x0 SErr 0xffffffff action 0x6 frozen
ata1: (irq_stat 0x00400000, PHY RDY changed)
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
PIIX_IDE 0000:00:1f.1: suspend
pci 0000:00:1f.0: suspend
pci 0000:00:1e.0: suspend
ehci_hcd 0000:00:1d.7: suspend, may wakeup
ACPI: PCI interrupt for device 0000:00:1d.7 disabled
uhci_hcd 0000:00:1d.3: suspend
ACPI: PCI interrupt for device 0000:00:1d.3 disabled
uhci_hcd 0000:00:1d.2: suspend
ACPI: PCI interrupt for device 0000:00:1d.2 disabled
uhci_hcd 0000:00:1d.1: suspend
ACPI: PCI interrupt for device 0000:00:1d.1 disabled
uhci_hcd 0000:00:1d.0: suspend
ACPI: PCI interrupt for device 0000:00:1d.0 disabled
pci 0000:00:1c.3: suspend
pci 0000:00:1c.2: suspend
pci 0000:00:1c.1: suspend
pci 0000:00:1c.0: suspend
HDA Intel 0000:00:1b.0: suspend
BUG: soft lockup detected on CPU#0!
 [<c0104353>] show_trace_log_lvl+0x173/0x190
 [<c01057af>] show_trace+0xf/0x20
 [<c01057d5>] dump_stack+0x15/0x20
 [<c014bdec>] softlockup_tick+0xac/0xe0
 [<c01305c1>] update_process_times+0x31/0x80
 [<c01199a2>] smp_apic_timer_interrupt+0x52/0x60
 [<c0103a57>] apic_timer_interrupt+0x1f/0x24
 [<c02828b4>] delay_tsc+0x14/0x20
 [<c02828f6>] __delay+0x6/0x10
 [<c053926a>] azx_send_cmd+0xfa/0x110
 [<c053a4b4>] snd_hda_codec_read+0x44/0x80
 [<c053b14c>] hda_set_power_state+0x5c/0xe0
 [<c053c118>] snd_hda_suspend+0x48/0x60
 [<c0539fde>] azx_suspend+0x5e/0xc0
 [<c028f14d>] pci_device_suspend+0x1d/0x60
 [<c034cdc7>] suspend_device+0xe7/0x1d0
 [<c034cfcd>] device_suspend+0x9d/0x196
 [<c0147db8>] enter_state+0x178/0x200
 [<c0147ee9>] state_store+0xa9/0xc0
 [<c01aa469>] subsys_attr_store+0x29/0x40
 [<c01aabcf>] sysfs_write_file+0x8f/0xe0
 [<c016df96>] vfs_write+0xa6/0x160
 [<c016e951>] sys_write+0x41/0x70
 [<c010303f>] syscall_call+0x7/0xb
 [<b7e6ad2e>] 0xb7e6ad2e
ACPI: PCI interrupt for device 0000:00:1b.0 disabled
pci 0000:00:02.1: suspend
pci 0000:00:02.0: suspend
agpgart-intel 0000:00:00.0: suspend
acpi acpi: suspend
PM: Entering mem sleep
 hwsleep-0285 [-5566] enter_sleep_state     : Entering sleep state [S3]
Back to C!
PM: Finishing wakeup.
acpi acpi: resuming
agpgart-intel 0000:00:00.0: resuming
e1000: eth0: e1000_watchdog: NIC Link is Down
pci 0000:00:02.0: resuming
pci 0000:00:02.1: resuming
PM: Writing back config space on device 0000:00:02.1 at offset 1 (was 900000, writing 900003)
HDA Intel 0000:00:1b.0: resuming
PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was 100106, writing 100100)
PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
PCI: Setting latency timer of device 0000:00:1b.0 to 64
pci 0000:00:1c.0: resuming
PM: Writing back config space on device 0000:00:1c.0 at offset 7 (was 2020, writing 20002020)
PCI: Setting latency timer of device 0000:00:1c.0 to 64
pci 0000:00:1c.1: resuming
PCI: Setting latency timer of device 0000:00:1c.1 to 64
pci 0000:00:1c.2: resuming
PM: Writing back config space on device 0000:00:1c.2 at offset 7 (was 20006050, writing 6050)
PCI: Setting latency timer of device 0000:00:1c.2 to 64
pci 0000:00:1c.3: resuming
PM: Writing back config space on device 0000:00:1c.3 at offset f (was 40400, writing 4040b)
PM: Writing back config space on device 0000:00:1c.3 at offset 9 (was 10001, writing e421e421)
PM: Writing back config space on device 0000:00:1c.3 at offset 8 (was 0, writing ebf0ea00)
PM: Writing back config space on device 0000:00:1c.3 at offset 7 (was 20000000, writing 8070)
PM: Writing back config space on device 0000:00:1c.3 at offset 3 (was 810000, writing 810010)
PM: Writing back config space on device 0000:00:1c.3 at offset 1 (was 100000, writing 100107)
PCI: Setting latency timer of device 0000:00:1c.3 to 64
uhci_hcd 0000:00:1d.0: resuming
PCI: Setting latency timer of device 0000:00:1d.0 to 64
usb usb2: root hub lost power or was reset
uhci_hcd 0000:00:1d.1: resuming
PCI: Setting latency timer of device 0000:00:1d.1 to 64
usb usb3: root hub lost power or was reset
uhci_hcd 0000:00:1d.2: resuming
PCI: Setting latency timer of device 0000:00:1d.2 to 64
usb usb4: root hub lost power or was reset
uhci_hcd 0000:00:1d.3: resuming
PCI: Setting latency timer of device 0000:00:1d.3 to 64
usb usb5: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: resuming
PCI: Setting latency timer of device 0000:00:1d.7 to 64
pci 0000:00:1e.0: resuming
PM: Writing back config space on device 0000:00:1e.0 at offset 1 (was 100005, writing 100007)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
pci 0000:00:1f.0: resuming
PIIX_IDE 0000:00:1f.1: resuming
ahci 0000:00:1f.2: resuming
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata2: Can't start DMA engine (-1)
ata3: Can't start DMA engine (-1)
ata4: Can't start DMA engine (-1)
pci 0000:00:1f.3: resuming
e1000 0000:02:00.0: resuming
PCI: Setting latency timer of device 0000:02:00.0 to 64
pci 0000:03:00.0: resuming
yenta_cardbus 0000:15:00.0: resuming
PM: Writing back config space on device 0000:15:00.0 at offset 1 (was 2100000, writing 2100007)
ohci1394 0000:15:00.1: resuming
sdhci 0000:15:00.2: resuming
PM: Writing back config space on device 0000:15:00.2 at offset 4 (was 0, writing e4301800)
PM: Writing back config space on device 0000:15:00.2 at offset 3 (was 800000, writing 804000)
PM: Writing back config space on device 0000:15:00.2 at offset 1 (was 2100000, writing 2100006)
system 00:00: resuming
pnp 00:01: resuming
system 00:02: resuming
pnp 00:03: resuming
pnp 00:04: resuming
pnp 00:05: resuming
pnp 00:06: resuming
pnp 00:07: resuming
i8042 kbd 00:08: resuming
pnp: Device 00:08 does not support activation.
i8042 aux 00:09: resuming
pnp: Device 00:09 does not support activation.
pnp 00:0a: resuming
pnp 00:0b: resuming
platform bluetooth: resuming
pcspkr pcspkr: resuming
vesafb vesafb.0: resuming
serial8250 serial8250: resuming
sd 0:0:0:0: resuming
usb usb1: resuming
hub 1-0:1.0: resuming
usb usb2: resuming
hub 2-0:1.0: resuming
usb usb3: resuming
hub 3-0:1.0: resuming
usb usb4: resuming
hub 4-0:1.0: resuming
usb usb5: resuming
hub 5-0:1.0: resuming
usb 5-2: resuming
 usbdev5.2_ep81: PM: resume from 0, parent 5-2:1.0 still 1
 usbdev5.2_ep02: PM: resume from 0, parent 5-2:1.0 still 1
 usbdev5.2_ep83: PM: resume from 0, parent 5-2:1.0 still 1
i8042 i8042: resuming
psmouse serio0: resuming
atkbd serio1: resuming
mmcblk mmc0:cc53: resuming
Restarting tasks...<6>usb 5-2: USB disconnect, address 2
PM: Removing info for No Bus:usbdev5.2_ep81
PM: Removing info for No Bus:usbdev5.2_ep02
PM: Removing info for No Bus:usbdev5.2_ep83
PM: Removing info for usb:5-2:1.0
PM: Removing info for No Bus:usbdev5.2_ep00
PM: Removing info for usb:5-2
ata1: waiting for device to spin up (8 secs)
 done
Thawing cpus ...
usb 5-2: new full speed USB device using uhci_hcd and address 3
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3657.67 BogoMIPS (lpj=18288366)
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
CPU1: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
CPU1 is up
PM: Adding info for usb:5-2
PM: Adding info for No Bus:usbdev5.3_ep00
usb 5-2: configuration #1 chosen from 1 choice
PM: Adding info for usb:5-2:1.0
PM: Adding info for No Bus:usbdev5.3_ep81
PM: Adding info for No Bus:usbdev5.3_ep02
PM: Adding info for No Bus:usbdev5.3_ep83
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/100
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
usb 5-1: new full speed USB device using uhci_hcd and address 4
PM: Adding info for usb:5-1
PM: Adding info for No Bus:usbdev5.4_ep00
usb 5-1: configuration #1 chosen from 1 choice
PM: Adding info for usb:5-1:1.0
PM: Adding info for No Bus:hci0
PM: Adding info for No Bus:usbdev5.4_ep81
PM: Adding info for No Bus:usbdev5.4_ep82
PM: Adding info for No Bus:usbdev5.4_ep02
PM: Adding info for usb:5-1:1.1
PM: Adding info for No Bus:usbdev5.4_ep83
PM: Adding info for No Bus:usbdev5.4_ep03
PM: Adding info for usb:5-1:1.2
PM: Adding info for No Bus:usbdev5.4_ep84
PM: Adding info for No Bus:usbdev5.4_ep04
PM: Adding info for usb:5-1:1.3
acpiphp_glue: cannot get bridge info
acpiphp_glue: cannot get bridge info
PM: Preparing system for mem sleep
Freezing cpus ...
Breaking affinity for irq 12
Breaking affinity for irq 22
CPU 1 is now offline
SMP alternatives: switching to UP code
CPU1 is down
Stopping tasks: =========================================================================================|
usb 5-1:1.3: PM: suspend 1-->2
 usbdev5.4_ep04: PM: suspend 0->2, parent 5-1:1.2 already 1
 usbdev5.4_ep84: PM: suspend 0->2, parent 5-1:1.2 already 1
usb 5-1:1.2: PM: suspend 1-->2
hci_usb 5-1:1.1: suspend
hci_usb 5-1:1.0: suspend
usb 5-1: suspend, may wakeup
 usbdev5.3_ep83: PM: suspend 0->2, parent 5-2:1.0 already 1
 usbdev5.3_ep02: PM: suspend 0->2, parent 5-2:1.0 already 1
 usbdev5.3_ep81: PM: suspend 0->2, parent 5-2:1.0 already 1
usb 5-2:1.0: PM: suspend 1-->2
usb 5-2: suspend, may wakeup
mmcblk mmc0:cc53: suspend
i8042 i8042: suspend
hub 5-0:1.0: suspend
usb usb5: suspend, may wakeup
hub 4-0:1.0: suspend
usb usb4: suspend, may wakeup
hub 3-0:1.0: suspend
usb usb3: suspend, may wakeup
hub 2-0:1.0: suspend
usb usb2: suspend, may wakeup
hub 1-0:1.0: suspend
usb usb1: suspend, may wakeup
sd 0:0:0:0: suspend
serial8250 serial8250: suspend
vesafb vesafb.0: suspend
pcspkr pcspkr: suspend
platform bluetooth: suspend
pnp 00:0b: suspend
pnp 00:0a: suspend
i8042 aux 00:09: suspend
i8042 kbd 00:08: suspend
pnp 00:07: suspend
pnp 00:06: suspend
pnp 00:05: suspend
pnp 00:04: suspend
pnp 00:03: suspend
system 00:02: suspend
pnp 00:01: suspend
system 00:00: suspend
sdhci 0000:15:00.2: suspend
ACPI: PCI interrupt for device 0000:15:00.2 disabled
ohci1394 0000:15:00.1: suspend
yenta_cardbus 0000:15:00.0: suspend
ACPI: PCI interrupt for device 0000:15:00.0 disabled
pci 0000:03:00.0: suspend
e1000 0000:02:00.0: suspend
ACPI: PCI interrupt for device 0000:02:00.0 disabled
pci 0000:00:1f.3: suspend
ahci 0000:00:1f.2: suspend
ACPI: PCI interrupt for device 0000:00:1f.2 disabled
ata1: exception Emask 0x52 SAct 0x0 SErr 0xffffffff action 0x6 frozen
ata1: (irq_stat 0x00400000, PHY RDY changed)
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
PIIX_IDE 0000:00:1f.1: suspend
pci 0000:00:1f.0: suspend
pci 0000:00:1e.0: suspend
ehci_hcd 0000:00:1d.7: suspend, may wakeup
ACPI: PCI interrupt for device 0000:00:1d.7 disabled
uhci_hcd 0000:00:1d.3: suspend
ACPI: PCI interrupt for device 0000:00:1d.3 disabled
uhci_hcd 0000:00:1d.2: suspend
ACPI: PCI interrupt for device 0000:00:1d.2 disabled
uhci_hcd 0000:00:1d.1: suspend
ACPI: PCI interrupt for device 0000:00:1d.1 disabled
uhci_hcd 0000:00:1d.0: suspend
ACPI: PCI interrupt for device 0000:00:1d.0 disabled
pci 0000:00:1c.3: suspend
pci 0000:00:1c.2: suspend
pci 0000:00:1c.1: suspend
pci 0000:00:1c.0: suspend
HDA Intel 0000:00:1b.0: suspend
ACPI: PCI interrupt for device 0000:00:1b.0 disabled
pci 0000:00:02.1: suspend
pci 0000:00:02.0: suspend
agpgart-intel 0000:00:00.0: suspend
acpi acpi: suspend
PM: Entering mem sleep
 hwsleep-0285 [-12467] enter_sleep_state     : Entering sleep state [S3]
Back to C!
PM: Finishing wakeup.
acpi acpi: resuming
agpgart-intel 0000:00:00.0: resuming
e1000: eth0: e1000_watchdog: NIC Link is Down
pci 0000:00:02.0: resuming
pci 0000:00:02.1: resuming
PM: Writing back config space on device 0000:00:02.1 at offset 1 (was 900000, writing 900003)
HDA Intel 0000:00:1b.0: resuming
PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was 100106, writing 100100)
PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
PCI: Setting latency timer of device 0000:00:1b.0 to 64
__tx_submit: hci0 tx submit failed urb f2f94360 type 2 err -113
__tx_submit: hci0 tx submit failed urb f2f5e590 type 2 err -113
__tx_submit: hci0 tx submit failed urb c20efc20 type 2 err -113
pci 0000:00:1c.0: resuming
PM: Writing back config space on device 0000:00:1c.0 at offset 7 (was 2020, writing 20002020)
PCI: Setting latency timer of device 0000:00:1c.0 to 64
pci 0000:00:1c.1: resuming
PCI: Setting latency timer of device 0000:00:1c.1 to 64
pci 0000:00:1c.2: resuming
PCI: Setting latency timer of device 0000:00:1c.2 to 64
pci 0000:00:1c.3: resuming
PM: Writing back config space on device 0000:00:1c.3 at offset f (was 40400, writing 4040b)
PM: Writing back config space on device 0000:00:1c.3 at offset 9 (was 10001, writing e421e421)
PM: Writing back config space on device 0000:00:1c.3 at offset 8 (was 0, writing ebf0ea00)
PM: Writing back config space on device 0000:00:1c.3 at offset 7 (was 20000000, writing 20008070)
PM: Writing back config space on device 0000:00:1c.3 at offset 3 (was 810000, writing 810010)
PM: Writing back config space on device 0000:00:1c.3 at offset 1 (was 100000, writing 100107)
PCI: Setting latency timer of device 0000:00:1c.3 to 64
uhci_hcd 0000:00:1d.0: resuming
PCI: Setting latency timer of device 0000:00:1d.0 to 64
usb usb2: root hub lost power or was reset
uhci_hcd 0000:00:1d.1: resuming
PCI: Setting latency timer of device 0000:00:1d.1 to 64
usb usb3: root hub lost power or was reset
uhci_hcd 0000:00:1d.2: resuming
PCI: Setting latency timer of device 0000:00:1d.2 to 64
usb usb4: root hub lost power or was reset
uhci_hcd 0000:00:1d.3: resuming
PCI: Setting latency timer of device 0000:00:1d.3 to 64
usb usb5: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: resuming
PCI: Setting latency timer of device 0000:00:1d.7 to 64
pci 0000:00:1e.0: resuming
PM: Writing back config space on device 0000:00:1e.0 at offset 1 (was 100005, writing 100007)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
pci 0000:00:1f.0: resuming
PIIX_IDE 0000:00:1f.1: resuming
ahci 0000:00:1f.2: resuming
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata2: Can't start DMA engine (-1)
ata3: Can't start DMA engine (-1)
ata4: Can't start DMA engine (-1)
pci 0000:00:1f.3: resuming
e1000 0000:02:00.0: resuming
PCI: Setting latency timer of device 0000:02:00.0 to 64
pci 0000:03:00.0: resuming
yenta_cardbus 0000:15:00.0: resuming
PM: Writing back config space on device 0000:15:00.0 at offset 1 (was 2100000, writing 2100007)
ohci1394 0000:15:00.1: resuming
sdhci 0000:15:00.2: resuming
PM: Writing back config space on device 0000:15:00.2 at offset 4 (was 0, writing e4301800)
PM: Writing back config space on device 0000:15:00.2 at offset 3 (was 800000, writing 804000)
PM: Writing back config space on device 0000:15:00.2 at offset 1 (was 2100000, writing 2100006)
system 00:00: resuming
pnp 00:01: resuming
system 00:02: resuming
pnp 00:03: resuming
pnp 00:04: resuming
pnp 00:05: resuming
pnp 00:06: resuming
pnp 00:07: resuming
i8042 kbd 00:08: resuming
pnp: Device 00:08 does not support activation.
i8042 aux 00:09: resuming
pnp: Device 00:09 does not support activation.
pnp 00:0a: resuming
pnp 00:0b: resuming
platform bluetooth: resuming
pcspkr pcspkr: resuming
vesafb vesafb.0: resuming
serial8250 serial8250: resuming
sd 0:0:0:0: resuming
usb usb1: resuming
hub 1-0:1.0: resuming
usb usb2: resuming
hub 2-0:1.0: resuming
usb usb3: resuming
hub 3-0:1.0: resuming
usb usb4: resuming
hub 4-0:1.0: resuming
usb usb5: resuming
hub 5-0:1.0: resuming
i8042 i8042: resuming
psmouse serio0: resuming
atkbd serio1: resuming
mmcblk mmc0:cc53: resuming
usb 5-2: resuming
 usbdev5.3_ep81: PM: resume from 0, parent 5-2:1.0 still 1
 usbdev5.3_ep02: PM: resume from 0, parent 5-2:1.0 still 1
 usbdev5.3_ep83: PM: resume from 0, parent 5-2:1.0 still 1
usb 5-1: resuming
hci_usb 5-1:1.0: resuming
hci_usb 5-1:1.1: resuming
 usbdev5.4_ep84: PM: resume from 0, parent 5-1:1.2 still 1
 usbdev5.4_ep04: PM: resume from 0, parent 5-1:1.2 still 1
Restarting tasks...<6>usb 5-1: USB disconnect, address 4
PM: Removing info for No Bus:usbdev5.4_ep81
PM: Removing info for No Bus:usbdev5.4_ep82
PM: Removing info for No Bus:usbdev5.4_ep02
slab error in verify_redzone_free(): cache `size-1024': memory outside object was overwritten
 [<c0104353>] show_trace_log_lvl+0x173/0x190
 [<c01057af>] show_trace+0xf/0x20
 [<c01057d5>] dump_stack+0x15/0x20
 [<c0168c8e>] cache_free_debugcheck+0x14e/0x1f0
 [<c016a203>] kfree+0x63/0xc0
 [<c04ce653>] hci_usb_close+0xf3/0x160
 [<c04ce72e>] hci_usb_disconnect+0x2e/0x90
 [<c046d3d4>] usb_unbind_interface+0x34/0x70
 [<c034916f>] __device_release_driver+0x5f/0xc0
 [<c0349407>] device_release_driver+0x17/0x30
 [<c03489e7>] bus_remove_device+0x87/0xa0
 [<c034769b>] device_del+0xfb/0x150
 [<c046c293>] usb_disable_device+0xb3/0x100
 [<c0466194>] usb_disconnect+0x84/0xe0
 [<c04689e2>] hub_thread+0x362/0xbde
 [<c013b757>] kthread+0xf7/0x100
 [<c0101005>] kernel_thread_helper+0x5/0x10
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0x10
Leftover inexact backtrace:
f28b7944: redzone 1:0x5a5a5a5a, redzone 2:0xc055de7c.
------------[ cut here ]------------
kernel BUG at mm/slab.c:2748!
invalid opcode: 0000 [#1]
SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c0168cf2>]    Not tainted VLI
EFLAGS: 00010002   (2.6.18-rc6 #333) 
EIP is at cache_free_debugcheck+0x1b2/0x1f0
eax: f28b7940   ebx: 00052c00   ecx: 0000040c   edx: 00000004
esi: f28b7944   edi: c20df800   ebp: f28b60f8   esp: c229de34
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 134, ti=c229c000 task=c2241550 task.ti=c229c000)
Stack: c06777ec f28b7944 5a5a5a5a c055de7c c04ce653 f28b60c0 c20df800 c20db34c 
       f28b7948 00000286 c016a203 f2f94360 f2f9434c f7f46380 0000000c c04ce653 
       f7f4633c f7f4636c f2fd2448 f7f462b0 00000001 f7f462b0 f2fd2448 c07a3910 
Call Trace:
 [<c016a203>] kfree+0x63/0xc0
 [<c04ce653>] hci_usb_close+0xf3/0x160
 [<c04ce72e>] hci_usb_disconnect+0x2e/0x90
 [<c046d3d4>] usb_unbind_interface+0x34/0x70
 [<c034916f>] __device_release_driver+0x5f/0xc0
 [<c0349407>] device_release_driver+0x17/0x30
 [<c03489e7>] bus_remove_device+0x87/0xa0
 [<c034769b>] device_del+0xfb/0x150
 [<c046c293>] usb_disable_device+0xb3/0x100
 [<c0466194>] usb_disconnect+0x84/0xe0
 [<c04689e2>] hub_thread+0x362/0xbde
 [<c013b757>] kthread+0xf7/0x100
 [<c0101005>] kernel_thread_helper+0x5/0x10
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0x10
Leftover inexact backtrace:
Code: e9 cc fe ff ff 81 fd 71 f0 2c 5a 75 a9 b9 52 6b 67 c0 89 fa b8 b8 9e 63 c0 e8 3b f4 ff ff eb a7 81 fd a5 c2 0f 17 75 8e 90 eb b4 <0f> 0b bc 0a 6a 6a 67 c0 e9 cf fe ff ff 0f 0b bb 0a 6a 6a 67 c0 
EIP: [<c0168cf2>] cache_free_debugcheck+0x1b2/0x1f0 SS:ESP 0068:c229de34
 <6>ata1: waiting for device to spin up (8 secs)
 done
Thawing cpus ...
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3657.54 BogoMIPS (lpj=18287720)
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
CPU1: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
CPU1 is up
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/100
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
