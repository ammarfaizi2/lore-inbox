Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVCRNqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVCRNqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 08:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVCRNqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 08:46:07 -0500
Received: from mailgate1.mysql.com ([213.115.162.47]:30880 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S261603AbVCRNot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 08:44:49 -0500
Message-ID: <423AE958.3090801@mysql.com>
Date: Fri, 18 Mar 2005 15:44:40 +0100
From: Jonas Oreland <jonas.oreland@mysql.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: yenta_socket "nobody cared - Disabling IRQ #4"
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a IBM thinkpad G40 and have just upgraded from 2.4.28 to 2.6.11.2
And I fail to get my netgear wg511t wireless pccard to function.
(worked fine with 2.4.28)

I've tried (wo really knowing what i'm doing) using
*) pci=routeirq
*) compiling kernel wo/ acpi
*) modprobe yenta_socket disable_clkrun=1

NOTE: It works sometimes!
When I insert the card (or modprobe yenta_socket), it will either work 
and then I can use the wlan card wo/ problem, or it will fail directly.

The failures are unfortunatly is majority :-(

NOTE2: I have also tried wo/ the madwifi driver, and it can still lock up.

Please let me know I you need more/less info

/Jonas

-- output from uname -a
Linux eel 2.6.11.2 #2 Fri Mar 18 14:47:09 CET 2005 i686 Intel(R)
Pentium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux

-- output from dump_cis
eel ~ # dump_cis 
Socket 0:
  manfid 0x0271, 0x0012
  config_cb base 0x0000 last_index 0x01
  cftable_entry_cb 0x01 [default]
    [master] [parity] [serr] [fast back]
    Vcc Vnom 3300mV Istatic 25mA Iavg 450mA Ipeak 500mA
    irq mask 0xffff [level]
    mem_base 1
  BAR 1 size 64kb [mem]
  vers_1 7.1, "Atheros Communications, Inc.", "AR5001-0000-0000",
    "Wireless LAN Reference Card", "00"
  funcid network_adapter [post]
  lan_speed 6 mb/sec
  lan_speed 9 mb/sec
  lan_speed 12 mb/sec
  lan_speed 18 mb/sec
  lan_speed 24 mb/sec
  lan_speed 36 mb/sec
  lan_speed 48 mb/sec
  lan_speed 54 mb/sec
  lan_speed 72 mb/sec
  lan_media 5.4_GHz
  lan_node_id 00 09 5b ec 43 cd
  lan_connector Closed connector standard

-- output from dmesg
Linux version 2.6.11.2 (root@eel) (gcc version 3.3.5 (Gentoo Linux 3.3.5-r1, ssp-3.3.2-3, pie-8.7.7.1)) #2 Fri Mar 18 14:47:09 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
 BIOS-e820: 000000000f6f0000 - 000000000f700000 (reserved)
 BIOS-e820: 000000000f700000 - 000000003f6f0000 (usable)
 BIOS-e820: 000000003f6f0000 - 000000003f6f8000 (ACPI data)
 BIOS-e820: 000000003f6f8000 - 000000003f6fa000 (ACPI NVS)
 BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f7330
ACPI: XSDT (v001 IBM    TP-1T    0x00001081  LTP 0x00000000) @ 0x3f6f2435
ACPI: FADT (v002 IBM    TP-1T    0x00001081 IBM  0x00000001) @ 0x3f6f2479
ACPI: SSDT (v001 IBM    TP-1T    0x00001081 MSFT 0x0100000d) @ 0x3f6f252d
ACPI: ECDT (v001 IBM    TP-1T    0x00001081 IBM  0x00000001) @ 0x3f6f7f87
ACPI: BOOT (v001 IBM    TP-1T    0x00001081  LTP 0x00000001) @ 0x3f6f7fd8
ACPI: DSDT (v001 IBM    TP-1T    0x00001081 MSFT 0x0100000d) @ 0x00000000
Allocating PCI resources starting at 40000000 (gap: 40000000:bf800000)
Built 1 zonelists
Kernel command line: root=/dev/hda4 resume=/dev/hda3
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2988.029 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 904280k/917504k available (3129k kernel code, 12640k reserved, 1103k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5898.24 BogoMIPS (lpj=2949120)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebf9ff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebf9ff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0298)
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd966, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Found ECDT
ACPI: Could not use ECDT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 9 10 11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x35 set to 0x1
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
audit: initializing netlink socket (disabled)
audit(1111156449.775:0): initialized
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.22 [Flags: R/O].
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 4 throttling states)
ACPI: Thermal Zone [THRM] (51 C)
ibm_acpi: IBM ThinkPad ACPI Extras v0.8
ibm_acpi: http://ibm-acpi.sf.net/
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 4 (level, low) -> IRQ 4
parport: PnPBIOS parport detected.
parport0: PC-style at 0x3bc, irq 5 [PCSPP(,...)]
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 7 (level, low) -> IRQ 7
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N060ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: DW-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: Host Protected Area detected.
        current capacity is 111668597 sectors (57174 MB)
        native  capacity is 117210240 sectors (60011 MB)
hda: Host Protected Area disabled.
hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 1658kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 7
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 7 (level, low) -> IRQ 7
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 7, pci mem 0xd0100000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 3 (level, low) -> IRQ 3
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 3, io base 0x1820
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 9, io base 0x1840
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 7 (level, low) -> IRQ 7
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 7, io base 0x1860
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-2: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
I2O subsystem v$Rev$
i2o: max drivers = 8
I2O Configuration OSM v$Rev$
I2O ProcFS OSM v$Rev$
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 4 (level, low) -> IRQ 4
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49335 usecs
intel8x0: clocking to 48000
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 4 (level, low) -> IRQ 4
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ALSA device list:
  #0: Intel 82801DB-ICH4 with AD1981B at 0xd0100c00, irq 4
  #1: Intel 82801DB-ICH4 Modem at 0x2400, irq 4
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
 LID SLPB PCI0 BLAN CBS0 USB0 USB1 USB2 AC97 
ACPI: (supports S0 S3 S4 S5)
ReiserFS: hda4: found reiserfs format "3.6" with standard journal
ReiserFS: hda4: using ordered data mode
ReiserFS: hda4: journal params: device hda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda4: checking transaction log (hda4)
ReiserFS: hda4: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 160k freed
Adding 1005472k swap on /dev/hda3.  Priority:-1 extents:1
tg3.c:v3.23 (February 15, 2005)
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 3 (level, low) -> IRQ 3
eth0: Tigon3 [partno(BCM95901A50) rev 3001 PHY(5705)] (PCI:33MHz:32-bit) 10/100BaseT Ethernet 00:06:1b:c4:30:dd
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
NTFS volume version 3.1.
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 4 (level, low) -> IRQ 4
Yenta: CardBus bridge found at 0000:02:01.0 [1014:054e]
Yenta: adjusting diagnostic: 40 -> 60
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:01.0, mfunc 0x011c1112, devctl 0x64
Yenta: ISA IRQ mask 0x0c00, PCI irq 4
Socket status: 30000020
irq 4: nobody cared!
 [<c01036ce>] dump_stack+0x1e/0x30
 [<c0136d4b>] __report_bad_irq+0x2b/0xa0
 [<c0136e56>] note_interrupt+0x66/0xa0
 [<c0136817>] __do_IRQ+0x147/0x150
 [<c0104c66>] do_IRQ+0x26/0x40
 [<c01032ae>] common_interrupt+0x1a/0x20
 [<c011c84a>] do_softirq+0x2a/0x30
 [<c011c916>] irq_exit+0x36/0x40
 [<c0104c6b>] do_IRQ+0x2b/0x40
 [<c01032ae>] common_interrupt+0x1a/0x20
 [<c0101110>] cpu_idle+0x50/0x60
 [<c052681f>] start_kernel+0x14f/0x170
 [<c010019f>] 0xc010019f
handlers:
[<c0389eb0>] (snd_intel8x0_interrupt+0x0/0x260)
[<c038d1b0>] (snd_intel8x0_interrupt+0x0/0x260)
[<f8a4a8a0>] (yenta_interrupt+0x0/0x40 [yenta_socket])
Disabling IRQ #4
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.14.9 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413)
wlan: 0.8.4.5 (EXPERIMENTAL)
ath_rate_onoe: 1.0
ath_pci: 0.9.4.12 (EXPERIMENTAL)
PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 4 (level, low) -> IRQ 4
ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
ath0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: mac 5.9 phy 4.3 radio 4.6
ath0: 802.11 address: 00:09:5b:ec:43:cd
ath0: Use hw queue 0 for WME_AC_BE traffic
ath0: Use hw queue 1 for WME_AC_BK traffic
ath0: Use hw queue 2 for WME_AC_VI traffic
ath0: Use hw queue 3 for WME_AC_VO traffic
ath0: Atheros 5212: mem=0x40800000, irq=4

-- output from lspci -vv
0000:00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 01)
        Subsystem: IBM: Unknown device 054a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at <unassigned> (32-bit, prefetchable)
        Capabilities: [40] #09 [e105]

0000:00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 01)
        Subsystem: IBM: Unknown device 054b
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 01)
        Subsystem: IBM: Unknown device 054c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:02.0 VGA compatible controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 01) (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 0543
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Region 1: Memory at d0000000 (32-bit, non-prefetchable) [size=512K]
        Region 2: I/O ports at 1800 [size=8]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 Display controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 01)
        Subsystem: IBM: Unknown device 0543
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at e8000000 (32-bit, prefetchable)
        Region 1: Memory at d0080000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 0547
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 3
        Region 4: I/O ports at 1820 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 0547
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1840 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 0547
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 7
        Region 4: I/O ports at 1860 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: IBM: Unknown device 0548
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 7
        Region 0: Memory at d0100000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=64
        I/O behind bridge: 00003000-00006fff
        Memory behind bridge: d0200000-dfffffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: IBM: Unknown device 0547
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 1810 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
        Subsystem: IBM: Unknown device 0547
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 4
        Region 4: I/O ports at 1880 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
        Subsystem: IBM: Unknown device 0542
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 4
        Region 0: I/O ports at 1c00
        Region 1: I/O ports at 18c0 [size=64]
        Region 2: Memory at d0100c00 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at d0100800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 01) (prog-if 00 [Generic])
        Subsystem: IBM: Unknown device 0544
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 4
        Region 0: I/O ports at 2400
        Region 1: I/O ports at 2000 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5901 100Base-TX (rev 01)
        Subsystem: IBM ThinkPad R40e (2684-HVG) builtin ethernet controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at d0200000 (64-bit, non-prefetchable)
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: ffbafffffffefffc  Data: dfff

0000:02:01.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
        Subsystem: IBM: Unknown device 054e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 20
        Interrupt: pin A routed to IRQ 4
        Region 0: Memory at 40001000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 40400000-407ff000 (prefetchable)
        Memory window 1: 40800000-40bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
        16-bit legacy interface ports at 0001

0000:03:00.0 Ethernet controller: Atheros Communications, Inc. AR5212 802.11abg NIC (rev 01)
        Subsystem: Netgear: Unknown device 4b00
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168 (2500ns min, 7000ns max), cache line size 20
        Interrupt: pin A routed to IRQ 4
        Region 0: Memory at 40800000 (32-bit, non-prefetchable)
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

-- 
Jonas Oreland, Software Engineer
MySQL AB, www.mysql.com

