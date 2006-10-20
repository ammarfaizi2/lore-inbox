Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992600AbWJTMJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992600AbWJTMJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992598AbWJTMJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:09:33 -0400
Received: from cicero1.cybercity.dk ([212.242.40.4]:37062 "EHLO
	cicero1.cybercity.dk") by vger.kernel.org with ESMTP
	id S2992597AbWJTMJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:09:31 -0400
Message-ID: <4538BC60.8000603@molgaard.org>
Date: Fri, 20 Oct 2006 14:09:04 +0200
From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060717 Debian/1.7.13-0.2ubuntu1
X-Accept-Language: en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: speedstep-centrino: ENODEV
References: <EB12A50964762B4D8111D55B764A8454C1A971@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C1A971@scsmsx413.amr.corp.intel.com>
Content-Type: multipart/mixed;
 boundary="------------020908000604070205040208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020908000604070205040208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pallipadi, Venkatesh wrote:
> 
> Hmm... You must have CPU_FREQ_DENUG enabled in CONFIG already. Can you pass cpufreq.debug=3 in boot option and send me the output of dmesg after that.
> 
> Thanks,
> Venki

I am currently on 2.6.17.13 ubuntu version, that includes a lot of 
2.6.18 code.

It seems it tries to load acpi-cpufreq which complains about 
cpu_online_map, bu I also tried explicitly to load speedstep-centrino, 
which resulted in

sune@tommelise:~$ sudo modprobe speedstep-centrino
Password:
FATAL: Error inserting speedstep_centrino 
(/lib/modules/2.6.17.13-ubuntu1-pentium4m-1/kernel/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.ko): 
No such device
sune@tommelise:~$

But nothing in dmesg, which is attached.

And it is me who should be and am thanking :-)

/sunem

--------------020908000604070205040208
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

errupt for device 0000:00:1e.3 disabled
[4294668.392000] input: PC Speaker as /class/input/input0
[4294668.392000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[4294668.393000] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[4294668.397000] serio: i8042 AUX port at 0x60,0x64 irq 12
[4294668.403000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294668.403000] TCP bic registered
[4294668.403000] NET: Registered protocol family 8
[4294668.404000] NET: Registered protocol family 20
[4294668.404000] Using IPI Shortcut mode
[4294668.404000] ACPI: (supports S0 S3 S4 S5)
[4294668.404000] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[4294668.404000] Freeing unused kernel memory: 168k freed
[4294668.418000] input: AT Translated Set 2 keyboard as /class/input/input1
[4294668.438000] NET: Registered protocol family 1
[4294668.454000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[4294668.455000] ACPI: Processor [CPU0] (supports 8 throttling states)
[4294668.455000] ACPI: Getting cpuindex for acpiid 0x1
[4294668.464000] ACPI: Thermal Zone [THM] (53 C)
[4294668.796000] libata version 1.20 loaded.
[4294668.797000] ahci 0000:00:1f.2: version 1.2
[4294668.797000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
[4294668.797000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
[4294668.797000] ahci: probe of 0000:00:1f.2 failed with error -12
[4294668.798000] ata_piix 0000:00:1f.2: version 1.05
[4294668.798000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
[4294668.798000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[4294668.798000] ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
[4294668.953000] ata1: dev 0 cfg 49:2f00 82:7c6b 83:5b08 84:4003 85:7c69 86:1a08 87:4003 88:203f
[4294668.953000] ata1: dev 0 ATA-6, max UDMA/100, 78140160 sectors: LBA
[4294668.953000] ata1(0): applying bridge limits
[4294668.956000] ata1: dev 0 configured for UDMA/100
[4294668.956000] scsi0 : ata_piix
[4294668.956000]   Vendor: ATA       Model: TOSHIBA MK4026GA  Rev: PA10
[4294668.957000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294668.958000] ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
[4294669.263000] ata2: dev 0 cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000 87:0000 88:0407
[4294669.263000] ata2: dev 0 ATAPI, max UDMA/33
[4294669.417000] ata2: dev 0 configured for UDMA/33
[4294669.417000] scsi1 : ata_piix
[4294669.721000]   Vendor: SONY      Model: DVD+-RW DW-Q58A   Rev: UDS1
[4294669.722000]   Type:   CD-ROM                             ANSI SCSI revision: 05
[4294669.736000] SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
[4294669.736000] sda: Write Protect is off
[4294669.736000] sda: Mode Sense: 00 3a 00 00
[4294669.736000] SCSI device sda: drive cache: write back
[4294669.737000] SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
[4294669.737000] sda: Write Protect is off
[4294669.737000] sda: Mode Sense: 00 3a 00 00
[4294669.737000] SCSI device sda: drive cache: write back
[4294669.737000]  sda: sda1 sda2 sda3
[4294669.797000] sd 0:0:0:0: Attached scsi disk sda
[4294669.989000] usbcore: registered new driver usbfs
[4294669.990000] usbcore: registered new driver hub
[4294669.990000] USB Universal Host Controller Interface driver v3.0
[4294669.991000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 18
[4294669.991000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[4294669.991000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[4294669.991000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[4294669.991000] uhci_hcd 0000:00:1d.0: irq 18, io base 0x0000bf80
[4294669.991000] usb usb1: configuration #1 chosen from 1 choice
[4294669.991000] hub 1-0:1.0: USB hub found
[4294669.991000] hub 1-0:1.0: 2 ports detected
[4294670.028000] ieee1394: Initialized config rom entry `ip1394'
[4294670.049000] Attempting manual resume
[4294670.059000] SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
[4294670.060000] XFS mounting filesystem sda3
[4294670.092000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
[4294670.092000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[4294670.092000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[4294670.092000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[4294670.092000] uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000bf60
[4294670.092000] usb usb2: configuration #1 chosen from 1 choice
[4294670.092000] hub 2-0:1.0: USB hub found
[4294670.092000] hub 2-0:1.0: 2 ports detected
[4294670.158000] Ending clean XFS mount for filesystem: sda3
[4294670.193000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 19
[4294670.193000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[4294670.193000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[4294670.193000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[4294670.193000] uhci_hcd 0000:00:1d.2: irq 19, io base 0x0000bf40
[4294670.193000] usb usb3: configuration #1 chosen from 1 choice
[4294670.193000] hub 3-0:1.0: USB hub found
[4294670.193000] hub 3-0:1.0: 2 ports detected
[4294670.294000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 16
[4294670.294000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[4294670.294000] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[4294670.294000] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[4294670.294000] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000bf20
[4294670.294000] usb usb4: configuration #1 chosen from 1 choice
[4294670.294000] hub 4-0:1.0: USB hub found
[4294670.294000] hub 4-0:1.0: 2 ports detected
[4294670.395000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 16 (level, low) -> IRQ 18
[4294670.395000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[4294670.395000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[4294670.395000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[4294670.395000] ehci_hcd 0000:00:1d.7: debug port 1
[4294670.396000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[4294670.396000] ehci_hcd 0000:00:1d.7: irq 18, io mem 0xffa80800
[4294670.399000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[4294670.400000] usb usb5: configuration #1 chosen from 1 choice
[4294670.400000] hub 5-0:1.0: USB hub found
[4294670.400000] hub 5-0:1.0: 8 ports detected
[4294670.501000] ACPI: PCI Interrupt 0000:03:01.1[B] -> GSI 18 (level, low) -> IRQ 19
[4294670.554000] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[dfdfc800-dfdfcfff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[4294670.886000] usb 4-2: new low speed USB device using uhci_hcd and address 2
[4294671.047000] usb 4-2: configuration #1 chosen from 1 choice
[4294671.819000] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[344fc00032486830]
[4294688.106000] usbcore: registered new driver hiddev
[4294688.127000] input: Logitech USB Receiver as /class/input/input2
[4294688.127000] input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.3-2
[4294688.127000] usbcore: registered new driver usbhid
[4294688.127000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[4294688.198000] Linux agpgart interface v0.101 (c) Dave Jones
[4294688.215000] agpgart: Detected an Intel 915GM Chipset.
[4294688.215000] agpgart: Detected 7932K stolen memory.
[4294688.237000] agpgart: AGP aperture is 256M @ 0xc0000000
[4294688.333000] hw_random: cannot enable RNG, aborting
[4294688.346000] Real Time Clock Driver v1.12ac
[4294688.495000] input: PS/2 Mouse as /class/input/input3
[4294688.516000] input: AlpsPS/2 ALPS GlidePoint as /class/input/input4
[4294689.016000] mice: PS/2 mouse device common for all mice
[4294689.672000] ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 16 (level, low) -> IRQ 18
[4294689.672000] PCI: Setting latency timer of device 0000:00:1e.2 to 64
[4294689.820000] sdhci: Secure Digital Host Controller Interface driver, 0.12
[4294689.820000] sdhci: Copyright(c) Pierre Ossman
[4294689.849000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[4294689.849000]  1:0:0:0: Attached scsi generic sg1 type 5
[4294689.907000] ieee80211_crypt: registered algorithm 'NULL'
[4294689.943000] ieee80211: 802.11 data/management/control stack, 1.1.14
[4294689.943000] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[4294689.971000] sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[4294689.971000] Uniform CD-ROM driver Revision: 3.20
[4294689.971000] sr 1:0:0:0: Attached scsi CD-ROM sr0
[4294690.017000] ipw2200: no version for "ieee80211_wx_get_encodeext" found: kernel tainted.
[4294690.019000] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.8
[4294690.019000] ipw2200: Copyright(c) 2003-2005 Intel Corporation
[4294690.483000] intel8x0_measure_ac97_clock: measured 50465 usecs
[4294690.483000] intel8x0: clocking to 48000
[4294690.483000] ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 19 (level, low) -> IRQ 16
[4294690.483000] Yenta: CardBus bridge found at 0000:03:01.0 [1028:0188]
[4294690.606000] Yenta: ISA IRQ mask 0x04b8, PCI irq 16
[4294690.606000] Socket status: 30000006
[4294690.606000] Yenta: Raising subordinate bus# of parent bus (#03) from #04 to #07
[4294690.607000] pcmcia: parent PCI bridge Memory window: 0xdfd00000 - 0xdfdfffff
[4294690.607000] pcmcia: parent PCI bridge Memory window: 0x60000000 - 0x61ffffff
[4294690.611000] sdhci: SDHCI controller found at 0000:03:01.2 [1180:0822] (rev 17)
[4294690.612000] ACPI: PCI Interrupt 0000:03:01.2[C] -> GSI 17 (level, low) -> IRQ 17
[4294690.615000] mmc0: SDHCI at 0xdfdfc700 irq 17 DMA
[4294690.619000] b44.c:v1.00 (Apr 7, 2006)
[4294690.619000] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level, low) -> IRQ 19
[4294690.624000] eth0: Broadcom 4400 10/100BaseT Ethernet 00:12:3f:e7:d1:a7
[4294690.625000] ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 17 (level, low) -> IRQ 17
[4294690.625000] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[4294691.170000] lp: driver loaded but no devices found
[4294691.214000] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[4294691.215000] ieee1394: sbp2: Try serialize_io=0 for better performance
[4294691.280000] fuse init (API version 7.6)
[4294691.306000] i8k: unable to get SMM BIOS version
[4294691.306000] Dell laptop SMM driver v1.14 21/02/2005 Massimo Dal Zotto (dz@debian.org)
[4294691.386000] Adding 1004052k swap on /dev/disk/by-uuid/83fa86c0-5214-4328-8fab-12a59d32ae08.  Priority:-1 extents:1 across:1004052k
[4294691.699000] device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
[4294692.142000] NET: Registered protocol family 17
[4294693.188000] kjournald starting.  Commit interval 5 seconds
[4294693.188000] EXT3 FS on sda1, internal journal
[4294693.188000] EXT3-fs: mounted filesystem with ordered data mode.
[4294694.767000] ACPI: AC Adapter [AC] (on-line)
[4294695.086000] ACPI: Battery Slot [BAT0] (battery present)
[4294695.097000] ACPI: Lid Switch [LID]
[4294695.097000] ACPI: Power Button (CM) [PBTN]
[4294695.097000] ACPI: Sleep Button (CM) [SBTN]
[4294695.185000] ibm_acpi: ec object not found
[4294695.231000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[4294695.232000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[4294695.232000] ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
[4294695.490000] acpi_cpufreq: Unknown symbol cpu_online_map
[4294702.201000] [drm] Initialized drm 1.0.1 20051102
[4294702.204000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 18
[4294702.206000] [drm] Initialized i915 1.5.0 20060119 on minor 0
[4294703.841000] NET: Registered protocol family 10
[4294703.842000] lo: Disabled Privacy Extensions
[4294703.842000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[4294703.842000] IPv6 over IPv4 tunneling driver
[4294709.074000] Bluetooth: Core ver 2.8
[4294709.074000] NET: Registered protocol family 31
[4294709.074000] Bluetooth: HCI device and connection manager initialized
[4294709.074000] Bluetooth: HCI socket layer initialized
[4294709.146000] Bluetooth: L2CAP ver 2.8
[4294709.146000] Bluetooth: L2CAP socket layer initialized
[4294709.161000] Bluetooth: RFCOMM socket layer initialized
[4294709.161000] Bluetooth: RFCOMM TTY layer initialized
[4294709.161000] Bluetooth: RFCOMM ver 1.7
[4294724.009000] eth1: no IPv6 routers present
[4294727.530000] ieee80211_crypt: registered algorithm 'TKIP'

--------------020908000604070205040208--
