Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVDEP1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVDEP1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVDEP1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:27:08 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:10888 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S261780AbVDEPZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:25:27 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12-rc2
Date: Tue, 05 Apr 2005 14:56:57 GMT
Message-ID: <054V86X12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.12-rc2 still does not boot properly on my box.

Hubert Tonneau wrote:
>
> When switching from 2.6.11 to 2.6.12-rc1,
> I get a 'cannot open root device' fatal error at end of kernel boot process.
> Root device is 'hda1'.
> 
> Hardware content of the box:
> 
> 8086 	Intel Corporation 	3340 	82855PM 	0 		Host-Hub Interface Bridge
> 8086 	Intel Corporation 	3341 	82855PM 	0 		AGP Bridge
> 8086 	Intel Corporation 	24C2 	82801DB/DBL/DBM 	B 		USB UHCI Controller #1
> 8086 	Intel Corporation 	24C4 	82801DB/DBL/DBM 	B 		USB UHCI Controller #2
> 8086 	Intel Corporation 	24C7 	82801DB/DBL/DBM 	B 		USB UHCI Controller #3
> 8086 	Intel Corporation 	24CD 	82801DB/DBL/DBM 	B 		USB EHCI Controller
> 8086 	Intel Corporation 	2448 	82801BAM/CAM/DBM 	0 		Hub Interface to PCI Bridge
> 8086 	Intel Corporation 	24CC 	82801DBM 	0 		LPC Interface Bridge
> 8086 	Intel Corporation 	24CA 	82801DBM 	B 		IDE Controller (UltraATA/100)
> 8086 	Intel Corporation 	24C5 	82801DB/DBL/DBM 	B 		AC97 Audio Controller
> 8086 	Intel Corporation 	24C6 	82801DB/DBM 	B 		AC97 Modem Controller
> 10DE 	NVIDIA Corporation 	0324 	NV31 	B 		NVIDIA NV31GL
> 14E4 	Broadcom Corporation 	165D 	BCM5705M 	B 		Broadcom NetXtreme Gigabit Ethernet
> 104C 	Texas Instruments 	AC47 	7510/4510 	B 		Cardbus
> 104C 	Texas Instruments 	AC4A 		B 		
> 104C 	Texas Instruments 	802B 		B 		
> 104C 	Texas Instruments 	8204 	4610, 4515, 4610FM 	0 		TI UltraMedia Firmware Loader Device
> 8086 	Intel Corporation 	4220 	MPCI3B 	B 		Intel 2200 mPCI 3B - RoW
> 
> 2.6.11 kernel report:
> 
> <4>Linux version 2.6.11 (root@hubert) (gcc version 3.3 (Debian)) #1 Sun Mar 6 12:00:57 CET 2005
> <6>BIOS-provided physical RAM map:
> <4> BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
> <4> BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
> <4> BIOS-e820: 0000000000100000 - 000000003ffae000 (usable)
> <4> BIOS-e820: 000000003ffae000 - 0000000040000000 (reserved)
> <4> BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
> <4> BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
> <4>Warning only 896MB will be used.
> <4>Use a HIGHMEM enabled kernel.
> <5>896MB LOWMEM available.
> <7>On node 0 totalpages: 229376
> <7>  DMA zone: 4096 pages, LIFO batch:1
> <7>  Normal zone: 225280 pages, LIFO batch:16
> <7>  HighMem zone: 0 pages, LIFO batch:1
> <6>DMI 2.3 present.
> <7>ACPI: RSDP (v000 DELL                                  ) @ 0x000fdf00
> <7>ACPI: RSDT (v001 DELL    CPi R   0x27d40903 ASL  0x00000061) @ 0x3fff0000
> <7>ACPI: FADT (v001 DELL    CPi R   0x27d40903 ASL  0x00000061) @ 0x3fff0400
> <7>ACPI: ASF! (v016 DELL    CPi R   0x27d40903 ASL  0x00000061) @ 0x3fff0800
> <7>ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
> <4>Allocating PCI resources starting at 40000000 (gap: 40000000:beda0000)
> <4>Built 1 zonelists
> <4>Kernel command line: BOOT_IMAGE=recover ro root=301
> <4>Local APIC disabled by BIOS -- you can enable it with "lapic"
> <7>mapped APIC to ffffd000 (01703000)
> <6>Initializing CPU#0
> <4>PID hash table entries: 4096 (order: 12, 65536 bytes)
> <4>Detected 1998.546 MHz processor.
> <6>Using tsc for high-res timesource
> <4>Console: colour VGA+ 80x25
> <4>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> <4>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> <6>Memory: 906620k/917504k available (1598k kernel code, 10432k reserved, 518k data, 140k init, 0k highmem)
> <4>Checking if this processor honours the WP bit even in supervisor mode... Ok.
> <7>Calibrating delay loop... 3956.73 BogoMIPS (lpj=1978368)
> <4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> <7>CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
> <7>CPU: After vendor identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
> <6>CPU: L1 I cache: 32K, L1 D cache: 32K
> <6>CPU: L2 cache: 2048K
> <7>CPU: After all inits, caps: afe9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
> <6>Intel machine check architecture supported.
> <6>Intel machine check reporting enabled on CPU#0.
> <4>CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 06
> <6>Enabling fast FPU save and restore... done.
> <6>Enabling unmasked SIMD FPU exception support... done.
> <6>Checking 'hlt' instruction... OK.
> <4>ACPI: setting ELCR to 0200 (from 0800)
> <6>NET: Registered protocol family 16
> <6>PCI: PCI BIOS revision 2.10 entry at 0xfc96e, last bus=2
> <6>PCI: Using configuration type 1
> <6>mtrr: v2.0 (20020519)
> <6>ACPI: Subsystem revision 20050211
> <6>ACPI: Interpreter enabled
> <6>ACPI: Using PIC for interrupt routing
> <6>ACPI: PCI Root Bridge [PCI0] (00:00)
> <4>PCI: Probing PCI hardware (bus 00)
> <6>PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> <6>PCI: Transparent bridge - 0000:00:1e.0
> <7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> <4>ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
> <4>ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
> <4>ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
> <4>ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
> <4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
> <4>ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> <7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
> <7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
> <6>Linux Kernel Card Services
> <6>  options:  [pci] [cardbus] [pm]
> <6>PCI: Using ACPI for IRQ routing
> <6>** PCI interrupts are no longer routed automatically.  If this
> <6>** causes a device to stop working, it is probably because the
> <6>** driver failed to call pci_enable_device().  As a temporary
> <6>** workaround, the "pci=routeirq" argument restores the old
> <6>** behavior.  If this argument makes the device work again,
> <6>** please email the output of "lspci" to bjorn.helgaas@hp.com
> <6>** so I can fix the driver.
> <6>ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
> <6>ACPI: Processor [CPU0] (supports 8 throttling states)
> <6>ACPI: Thermal Zone [THM] (79 C)
> <6>Real Time Clock Driver v1.12
> <6>serio: i8042 AUX port at 0x60,0x64 irq 12
> <6>serio: i8042 KBD port at 0x60,0x64 irq 1
> <6>io scheduler noop registered
> <6>io scheduler anticipatory registered
> <6>io scheduler deadline registered
> <6>io scheduler cfq registered
> <6>tg3.c:v3.23 (February 15, 2005)
> <4>ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> <4>PCI: setting IRQ 11 as level-triggered
> <6>ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
> <6>eth0: Tigon3 [partno(BCM95705A50) rev 3001 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:11:43:64:67:27
> <6>eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
> <6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> <6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> <6>ICH4: IDE controller at PCI slot 0000:00:1f.1
> <4>PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
> <4>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
> <6>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
> <6>ICH4: chipset revision 1
> <6>ICH4: not 100% native mode: will probe irqs later
> <6>    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
> <6>    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
> <7>Probing IDE interface ide0...
> <4>hda: FUJITSU MHT2060AH, ATA DISK drive
> <4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> <7>Probing IDE interface ide1...
> <4>hdc: HL-DT-STCD-RW/DVD-ROM GCC-4243N, ATAPI CD/DVD-ROM drive
> <4>ide1 at 0x170-0x177,0x376 on irq 15
> <7>Probing IDE interface ide2...
> <7>Probing IDE interface ide3...
> <7>Probing IDE interface ide4...
> <7>Probing IDE interface ide5...
> <6>hda: max request size: 128KiB
> <6>hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
> <7>hda: cache flushes supported
> <6> hda: hda1
> <4>PCI: Enabling device 0000:02:01.0 (0000 -> 0002)
> <4>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> <6>ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
> <6>Yenta: CardBus bridge found at 0000:02:01.0 [1028:014e]
> <6>Yenta: ISA IRQ mask 0x04f8, PCI irq 11
> <6>Socket status: 30000410
> <6>ACPI: PCI interrupt 0000:02:01.1[A] -> GSI 11 (level, low) -> IRQ 11
> <6>Yenta: CardBus bridge found at 0000:02:01.1 [1028:014e]
> <6>Yenta: ISA IRQ mask 0x04f8, PCI irq 11
> <6>Socket status: 30000047
> <6>mice: PS/2 mouse device common for all mice
> <6>input: AT Translated Set 2 keyboard on isa0060/serio0
> <6>ALPS Touchpad (Dualpoint) detected
> <6>input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> <6>NET: Registered protocol family 2
> <6>IP: routing cache hash table of 8192 buckets, 64Kbytes
> <4>TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
> <4>TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
> <6>TCP: Hash tables configured (established 131072 bind 65536)
> <6>NET: Registered protocol family 1
> <6>NET: Registered protocol family 17
> <4>ACPI wakeup devices: 
> <4> LID PBTN PCI0 USB0 USB1 USB2 USB3 MODM PCIE 
> <6>ACPI: (supports S0 S1 S3 S4 S4bios S5)
> <6>EXT3-fs: mounted filesystem with ordered data mode.
> <4>VFS: Mounted root (ext3 filesystem) readonly.
> <6>Freeing unused kernel memory: 140k freed
> <6>kjournald starting.  Commit interval 5 seconds
> <6>EXT3 FS on hda1, internal journal
> <6>cs: IO port probe 0xc00-0xcff: clean.
> <6>cs: IO port probe 0xc00-0xcff: clean.
> <6>cs: IO port probe 0x800-0x8ff: excluding 0x8c0-0x8e7
> <6>cs: IO port probe 0x800-0x8ff: excluding 0x8c0-0x8e7
> <6>cs: IO port probe 0x100-0x4ff: excluding 0x280-0x287 0x2f8-0x2ff 0x378-0x37f 0x3f8-0x3ff 0x4d0-0x4d7
> <6>cs: IO port probe 0x100-0x4ff: excluding 0x280-0x287 0x2f8-0x2ff 0x378-0x37f 0x3f8-0x3ff 0x4d0-0x4d7
> <6>cs: IO port probe 0xa00-0xaff: clean.
> <6>cs: IO port probe 0xa00-0xaff: clean.
> <6>cs: memory probe 0xa0000000-0xa0ffffff: clean.
> <6>tg3: eth0: Link is up at 100 Mbps, full duplex.
> <6>tg3: eth0: Flow control is off for TX and off for RX.
> <6>usbcore: registered new driver usbfs
> <6>usbcore: registered new driver hub
> <6>USB Universal Host Controller Interface driver v2.2
> <6>ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
> <6>uhci_hcd 0000:00:1d.0: UHCI Host Controller
> <7>PCI: Setting latency timer of device 0000:00:1d.0 to 64
> <6>uhci_hcd 0000:00:1d.0: irq 11, io base 0xbf80
> <6>uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
> <6>hub 1-0:1.0: USB hub found
> <6>hub 1-0:1.0: 2 ports detected
> <6>ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
> <6>uhci_hcd 0000:00:1d.1: UHCI Host Controller
> <7>PCI: Setting latency timer of device 0000:00:1d.1 to 64
> <6>uhci_hcd 0000:00:1d.1: irq 11, io base 0xbf40
> <6>uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
> <6>hub 2-0:1.0: USB hub found
> <6>hub 2-0:1.0: 2 ports detected
> <6>ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
> <6>uhci_hcd 0000:00:1d.2: UHCI Host Controller
> <7>PCI: Setting latency timer of device 0000:00:1d.2 to 64
> <6>uhci_hcd 0000:00:1d.2: irq 11, io base 0xbf20
> <6>uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
> <6>hub 3-0:1.0: USB hub found
> <6>hub 3-0:1.0: 2 ports detected
> <6>usb 2-1: new low speed USB device using uhci_hcd and address 2
> <6>usbcore: registered new driver usbkbd
> <6>drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
> <6>input: USB HIDBP Mouse 413c:3010 on usb-0000:00:1d.1-1
> <6>usbcore: registered new driver usbmouse
> <6>drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
> <4>Warning: CPU frequency is 2000000, cpufreq assumed 1800000 kHz.
> <4>Warning: CPU frequency is 2000000, cpufreq assumed 1800000 kHz.
> <4>Warning: CPU frequency is 2000000, cpufreq assumed 1800000 kHz.
> <4>Warning: CPU frequency is 2000000, cpufreq assumed 1800000 kHz.
> <4>Warning: CPU frequency is 2000000, cpufreq assumed 1800000 kHz.
> <4>Warning: CPU frequency is 2000000, cpufreq assumed 1800000 kHz.
> <4>Warning: CPU frequency is 2000000, cpufreq assumed 1600000 kHz.
> 
> Kernel settings:
> 
> CONFIG_1GB:  y
> CONFIG_ACPI:  y
> CONFIG_ACPI_AC:  m
> CONFIG_ACPI_BATTERY:  m
> CONFIG_ACPI_BUTTON:  m
> CONFIG_ACPI_FAN:  m
> CONFIG_ACPI_PROCESSOR:  y
> CONFIG_ACPI_SLEEP:  y
> CONFIG_ACPI_THERMAL:  y
> CONFIG_ACPI_VIDEO:  m
> CONFIG_ACT200L_DONGLE:  m
> CONFIG_ACTISYS_DONGLE:  m
> CONFIG_APM_RTC_IS_GMT:  y
> CONFIG_ATALK:  m
> CONFIG_AUTOFS_FS:  m
> CONFIG_BINFMT_ELF:  y
> CONFIG_BINFMT_MISC:  y
> CONFIG_BLK_DEV_CMD640:  y
> CONFIG_BLK_DEV_FD:  m
> CONFIG_BLK_DEV_GENERIC:  y
> CONFIG_BLK_DEV_IDE:  y
> CONFIG_BLK_DEV_IDECD:  m
> CONFIG_BLK_DEV_IDECS:  m
> CONFIG_BLK_DEV_IDEDISK:  y
> CONFIG_BLK_DEV_IDEDMA:  y
> CONFIG_BLK_DEV_IDEDMA_PCI:  y
> CONFIG_BLK_DEV_IDEPCI:  y
> CONFIG_BLK_DEV_IDESCSI:  m
> CONFIG_BLK_DEV_LOOP:  m
> CONFIG_BLK_DEV_NBD:  m
> CONFIG_BLK_DEV_PIIX:  y
> CONFIG_BLK_DEV_RAM:  m
> CONFIG_BLK_DEV_RZ1000:  y
> CONFIG_BLK_DEV_SD:  m
> CONFIG_BLK_DEV_SR:  m
> CONFIG_BLK_DEV_TRIRON:  y
> CONFIG_BSD_PROCESS_ACCT:  y
> CONFIG_CARDBUS:  y
> CONFIG_CHR_DEV_SG:  m
> CONFIG_CODA_FS:  m
> CONFIG_CPU_FREQ:  y
> CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE:  y
> CONFIG_CPU_FREQ_GOV_ONDEMAND:  m
> CONFIG_CPU_FREQ_GOV_PERFORMANCE:  m
> CONFIG_CPU_FREQ_GOV_POWERSAVE:  m
> CONFIG_CPU_FREQ_GOV_USERSPACE:  y
> CONFIG_CPU_FREQ_TABLE:  y
> CONFIG_DONGLE:  m
> CONFIG_DUMMY_CONSOLE:  y
> CONFIG_ESI_DONGLE:  m
> CONFIG_EXPERIMENTAL:  y
> CONFIG_EXT2_FS:  y
> CONFIG_EXT3_FS:  y
> CONFIG_EXT3_FS_XATTR:  y
> CONFIG_FAT_FS:  m
> CONFIG_FB:  y
> CONFIG_FB_ATY:  m
> CONFIG_FB_ATY128:  m
> CONFIG_FB_I810:  m
> CONFIG_FB_INTEL:  m
> CONFIG_FB_MATROX:  m
> CONFIG_FB_MODE_HELPER:  y
> CONFIG_FB_RADEON:  m
> CONFIG_FB_RIVA:  m
> CONFIG_FB_RIVA_I2C:  y
> CONFIG_FB_VESA:  y
> CONFIG_FILTER:  y
> CONFIG_FRAMEBUFFER_CONSOLE:  y
> CONFIG_GIRBIL_DONGLE:  m
> CONFIG_HFSPLUS_FS:  m
> CONFIG_HFS_FS:  m
> CONFIG_HOTPLUG:  y
> CONFIG_HPET_TIMER:  y
> CONFIG_HPFS_FS:  m
> CONFIG_IDE:  y
> CONFIG_IDEDMA_AUTO:  y
> CONFIG_IDEDMA_ONLYDISK:  y
> CONFIG_IDEDMA_PCI_AUTO:  y
> CONFIG_IDEPCI_SHARE_IRQ:  y
> CONFIG_IDE_GENERIC:  y
> CONFIG_INET:  y
> CONFIG_INPUT:  y
> CONFIG_INPUT_KEYBDEV:  m
> CONFIG_INPUT_KEYBOARD:  y
> CONFIG_INPUT_MOUSE:  y
> CONFIG_INPUT_MOUSEDEV:  m
> CONFIG_IP_ALIAS:  y
> CONFIG_IP_ROUTE_VERBOSE:  y
> CONFIG_IRCOMM:  m
> CONFIG_IRDA:  m
> CONFIG_IRDA_CACHE_LAST_LSAP:  y
> CONFIG_IRDA_DEBUG:  y
> CONFIG_IRDA_FAST_RR:  y
> CONFIG_IRLAN:  m
> CONFIG_IRPORT_SIR:  m
> CONFIG_IRQBALANCE:  y
> CONFIG_IRTTY_SIR:  m
> CONFIG_ISA:  y
> CONFIG_ISO9660_FS:  m
> CONFIG_KCORE_ELF:  y
> CONFIG_KEYBOARD_ATKBD:  y
> CONFIG_LEGACY_PTYS:  y
> CONFIG_LITELINK_DONGLE:  m
> CONFIG_LOCKD:  m
> CONFIG_M386:  n
> CONFIG_M486:  n
> CONFIG_M586:  n
> CONFIG_M686:  n
> CONFIG_MA600_DONGLE:  m
> CONFIG_MAC_PARTITION:  y
> CONFIG_MCP2120_DONGLE:  m
> CONFIG_MODULES:  y
> CONFIG_MODULE_UNLOAD:  y
> CONFIG_MOUSE:  m
> CONFIG_MOUSE_PS2:  y
> CONFIG_MPENTIUMM:  y
> CONFIG_MSDOS_FS:  m
> CONFIG_MTRR:  y
> CONFIG_NET:  y
> CONFIG_NETDEVICES:  y
> CONFIG_NET_ETHERNET:  y
> CONFIG_NFSD:  m
> CONFIG_NFS_FS:  m
> CONFIG_NLS:  y
> CONFIG_NLS_CODEPAGE_437:  m
> CONFIG_NLS_CODEPAGE_850:  m
> CONFIG_NLS_ISO8859_1:  m
> CONFIG_NLS_UTF8:  m
> CONFIG_NOHIGHMEM:  y
> CONFIG_NTFS_FS:  m
> CONFIG_OLD_BELKIN_DONGLE:  m
> CONFIG_OOM_KILLER:  y
> CONFIG_PACKET:  y
> CONFIG_PARPORT:  m
> CONFIG_PARPORT_PC:  m
> CONFIG_PCCARD:  y
> CONFIG_PCI:  y
> CONFIG_PCI_BIOS:  y
> CONFIG_PCI_GOANY:  y
> CONFIG_PCI_OLD_PROC:  y
> CONFIG_PCI_QUIRKS:  y
> CONFIG_PCMCIA:  y
> CONFIG_PIIX_TUNING:  y
> CONFIG_PM:  y
> CONFIG_PPP:  m
> CONFIG_PPPOE:  m
> CONFIG_PPP_ASYNC:  m
> CONFIG_PPP_BSDCOMP:  m
> CONFIG_PPP_DEFLATE:  m
> CONFIG_PPP_FILTER:  y
> CONFIG_PPP_SYNC_TTY:  m
> CONFIG_PREEMPT:  y
> CONFIG_PRINTER:  m
> CONFIG_PRINTER_READBACK:  y
> CONFIG_PROC_FS:  y
> CONFIG_PSMOUSE:  y
> CONFIG_QNX4FS_FS:  m
> CONFIG_REGPARM:  y
> CONFIG_RTC:  y
> CONFIG_SCSI:  m
> CONFIG_SCSI_PROC_FS:  y
> CONFIG_SERIAL:  m
> CONFIG_SERIAL_8250:  m
> CONFIG_SERIAL_8250_CS:  m
> CONFIG_SHAPER:  m
> CONFIG_SLIP:  m
> CONFIG_SMB_FS:  m
> CONFIG_SMC_IRCC_FIR:  m
> CONFIG_SND:  m
> CONFIG_SND_INTEL8X0:  m
> CONFIG_SND_MIXER_OSS:  m
> CONFIG_SND_PCM_OSS:  m
> CONFIG_SND_RTCTIMER:  m
> CONFIG_SND_SEQUENCER:  m
> CONFIG_SND_SEQUENCER_OSS:  y
> CONFIG_SND_SEQ_DUMMY:  m
> CONFIG_SND_USB_AUDIO:  m
> CONFIG_SOUND:  m
> CONFIG_SOUND_ICH:  m
> CONFIG_SUNRPC:  m
> CONFIG_SYSCTL:  y
> CONFIG_SYSVIPC:  y
> CONFIG_TEKRAM_DONGLE:  m
> CONFIG_TIGON3:  y
> CONFIG_UFS_FS:  m
> CONFIG_UMSDOS_FS:  m
> CONFIG_UNIX:  y
> CONFIG_USB:  m
> CONFIG_USB_ACM:  m
> CONFIG_USB_AUDIO:  m
> CONFIG_USB_CDCETHER:  m
> CONFIG_USB_DEVICEFS:  y
> CONFIG_USB_EHCI_HCD:  m
> CONFIG_USB_HID:  y
> CONFIG_USB_HIDINPUT:  y
> CONFIG_USB_KBD:  m
> CONFIG_USB_MOUSE:  m
> CONFIG_USB_OHCI:  m
> CONFIG_USB_OHCI_HCD:  m
> CONFIG_USB_PRINTER:  m
> CONFIG_USB_SERIAL:  m
> CONFIG_USB_STORAGE:  m
> CONFIG_USB_UHCI:  m
> CONFIG_USB_UHCI_ALT:  m
> CONFIG_USB_UHCI_HCD:  m
> CONFIG_VFAT_FS:  m
> CONFIG_VGA_CONSOLE:  y
> CONFIG_VIDEO_SELECT:  y
> CONFIG_VT:  y
> CONFIG_VT_CONSOLE:  y
> CONFIG_X86_MCE:  y
> CONFIG_X86_SPEEDSTEP_CENTRINO:  y
> CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI:  y
> CONFIG_X86_UP_APIC:  y
> CONFIG_X86_UP_IOAPIC:  y
> CONFIG_YENTA:  y
> CONGIG_KMOD:  y
> 

