Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbVIPEiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbVIPEiA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 00:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030583AbVIPEiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 00:38:00 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:49235 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030582AbVIPEh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 00:37:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=P4I+2lLwQ6gKkdhT8FrZ57fQ+hPbixuX6xSVPFsDkMYSC+5ThSwGRdXR2tIs2Q9vN47bs7kTk+5ZJ/uXjyypdvazQ2V1fqQzuNFzwRabmxKESsOmxOsBiRVG42OqYF4ugpj5qKcBVHhxDm/IvdnVNDi4p+Xk+3f/LvlTWQwvW6k=
Message-ID: <432A4A1F.3040308@gmail.com>
Date: Thu, 15 Sep 2005 23:29:19 -0500
From: Tim Rupp <caphrim007@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Lost keyboard on Inspiron 8200 at 2.6.13
Content-Type: multipart/mixed;
 boundary="------------010500010005040809050307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010500010005040809050307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I just recently went to upgrade to 2.6.13 from 2.6.12.3 and after
re-compiling with a clean .config, I've hit a snag.

I'm pretty sure I've got the config script down right, but upon reboot,
I no longer have a keyboard.

I checked to see if this had crept up between 2.6.12.3 and 2.6.13.1. It
seems that >2.6.13 are the versions that do this.

Attached are dmesgs from my 2.6.13.1 and 2.6.12.3 kernels. In the
2.6.13.1 kernel I noticed this line.

	i8042.c: Can't read CTR while initializing i8042

I dont know if that is hinting at the problem, but it comes right around
the point where in the 2.6.12.3 kernel, I get this

	serio: i8042 AUX port at 0x60,0x64 irq 12
	serio: i8042 KBD port at 0x60,0x64 irq 1

If anyone has any words of wisdom or can suggest various ways to
troubleshoot this, I'd really appreciate it. I'm dieing to try out kexec
and use inotify without having to patch.

Thanks in advance!
Tim Rupp

--------------010500010005040809050307
Content-Type: text/plain;
 name="dmesg-2.6.12.3-08-05-2005"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.12.3-08-05-2005"

Linux version 2.6.12.3-08-05-2005 (root@tadakichi) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-47.fc4)) #3 Fri Aug 5 16:18:30 UTC 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffe2800 (usable)
 BIOS-e820: 000000003ffe2800 - 0000000040000000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262114
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32738 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fde50
ACPI: RSDT (v001 DELL    CPi R   0x27d20404 ASL  0x00000061) @ 0x000fde64
ACPI: FADT (v001 DELL    CPi R   0x27d20404 ASL  0x00000061) @ 0x000fde90
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Allocating PCI resources starting at 40000000 (gap: 40000000:beda0000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/ acpi=force single
Initializing CPU#0
CPU 0 irqstacks, hard=c059a000 soft=c0599000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1595.382 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032388k/1048456k available (3476k kernel code, 15144k reserved, 1020k data, 184k init, 130952k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3153.92 BogoMIPS (lpj=1576960)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 3febf9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 3febf9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: 3febf9ff 00000000 00000000 00000080 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0800)
checking if image is initramfs... it is
Freeing initrd memory: 984k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
ACPI: Power Resource [PADA] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 16 devices
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz@debian.org)
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NET: Registered protocol family 23
pnp: 00:01: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:01: ioport range 0x800-0x805 could not be reserved
pnp: 00:01: ioport range 0x808-0x80f could not be reserved
pnp: 00:02: ioport range 0x806-0x807 has been reserved
pnp: 00:02: ioport range 0x810-0x85f could not be reserved
pnp: 00:02: ioport range 0x860-0x87f has been reserved
pnp: 00:02: ioport range 0x880-0x8bf has been reserved
pnp: 00:02: ioport range 0x8c0-0x8ff has been reserved
pnp: 00:03: ioport range 0xf000-0xf0fe has been reserved
pnp: 00:03: ioport range 0xf100-0xf1fe has been reserved
pnp: 00:03: ioport range 0xf200-0xf2fe has been reserved
pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
pnp: 00:03: ioport range 0xf500-0xf5fe has been reserved
pnp: 00:03: ioport range 0xf600-0xf6fe has been reserved
pnp: 00:03: ioport range 0xf800-0xf8fe has been reserved
pnp: 00:03: ioport range 0xf900-0xf9fe has been reserved
pnp: 00:08: ioport range 0x900-0x91f has been reserved
pnp: 00:08: ioport range 0x3f0-0x3f1 has been reserved
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1126816869.082:0): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NTFS driver 2.1.22 [Flags: R/O].
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THM] (63 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized drm 1.0.0 20040925
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: HTS548040M9AT00, ATA DISK drive
hdb: TEAC CD-RW CD-W224E, ATAPI CD/DVD-ROM drive
Probing IDE interface ide1...
hdc: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/7877KiB Cache, CHS=16383/255/63
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdb: ATAPI 24X CD-ROM CD-R/RW drive, 1280kB Cache
Uniform CD-ROM driver Revision: 3.20
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache
ide-floppy driver 0.99.newide
ieee1394: Initialized config rom entry `ip1394'
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
Disabled Privacy Extensions on device c050f860(lo)
IPv6 over IPv4 tunneling driver
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 17
Software Suspend Core.
Software Suspend Compression Driver loading.
Software Suspend Encryption Driver loading.
Software Suspend userspace UI support loading.
Software Suspend Swap Writer loading.
ACPI wakeup devices: 
 LID PBTN PCI0 UAR1 USB0 USB1 USB2 MODM PCIE MPCI 
ACPI: (supports S0 S1 S3 S4 S4bios S5)
Freeing unused kernel memory: 184k freed
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
alps.c: Enabling hardware tapping
input: DualPoint Stick on isa0060/serio1
input: AlpsPS/2 ALPS DualPoint TouchPad on isa0060/serio1
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.14.9 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413)
wlan: 0.8.6.0 (EXPERIMENTAL)
ath_rate_sample: 1.2
ath_pci: 0.9.6.0 (EXPERIMENTAL)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:00.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.19
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49392 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.6 to 64
MC'97 1 converters and GPIO not ready (0xff00)
codec_semaphore: semaphore is not ready [0x1][0x300300]
codec_write 1: semaphore is not ready for register 0x54
hw_random hardware driver 1.0.0 loaded
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Enabling device 0000:02:01.0 (0000 -> 0002)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:01.0 [1028:00d4]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:01.0, mfunc 0x05033002, devctl 0x64
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000020
PCI: Enabling device 0000:02:01.1 (0000 -> 0002)
ACPI: PCI Interrupt 0000:02:01.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:01.1 [1028:00d4]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:01.1, mfunc 0x05033002, devctl 0x64
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000061
PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Build date: Aug  7 2005
Debugging version (IEEE80211)
ath0: 11a rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
ath0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: turboA rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: H/W encryption support: WEP AES AES_CCM TKIP
ath0: mac 5.6 phy 4.1 5ghz radio 1.7 2ghz radio 2.3
ath0: Use hw queue 1 for WME_AC_BE traffic
ath0: Use hw queue 0 for WME_AC_BK traffic
ath0: Use hw queue 2 for WME_AC_VI traffic
ath0: Use hw queue 3 for WME_AC_VO traffic
ath0: Use hw queue 8 for CAB traffic
ath0: Use hw queue 9 for beacons
Debugging version (ATH)
ath0: Atheros 5212: mem=0x40800000, irq=11
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:02:01.2[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[f8fff000-f8fff7ff]  Max Packet=[2048]
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:07:00.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:07:00.0 to 64
ohci_hcd 0000:07:00.0: OHCI Host Controller
ohci_hcd 0000:07:00.0: new USB bus registered, assigned bus number 3
ohci_hcd 0000:07:00.0: irq 11, io mem 0x41000000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[464fc000270ec421]
PCI: Enabling device 0000:07:00.1 (0000 -> 0002)
ACPI: PCI Interrupt 0000:07:00.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:07:00.1 to 64
ohci_hcd 0000:07:00.1: OHCI Host Controller
ohci_hcd 0000:07:00.1: new USB bus registered, assigned bus number 4
ohci_hcd 0000:07:00.1: irq 11, io mem 0x41001000
audit(1126816894.999:0): user pid=1469 uid=0 length=52 loginuid=4294967295 msg='hwclock: op=changing system time id=0 res=success'
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Enabling device 0000:07:00.2 (0000 -> 0002)
ACPI: PCI Interrupt 0000:07:00.2[C] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:07:00.2: EHCI Host Controller
ehci_hcd 0000:07:00.2: new USB bus registered, assigned bus number 5
ehci_hcd 0000:07:00.2: irq 11, io mem 0x41002000
ehci_hcd 0000:07:00.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 5 ports detected
spurious 8259A interrupt: IRQ7.
EXT3 FS on hda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 610460k swap on /dev/hda3.  Priority:-1 extents:1
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
eth0: no IPv6 routers present

--------------010500010005040809050307
Content-Type: text/plain;
 name="dmesg-2.6.13.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.13.1"

112k kernel code, 14668k reserved, 1093k data, 176k init, 130952k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3195.41 BogoMIPS (lpj=6390820)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 3febf9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 3febf9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: 3febf9ff 00000000 00000000 00000080 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0800)
checking if image is initramfs... it is
Freeing initrd memory: 984k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
ACPI: Power Resource [PADA] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 16 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:01: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:01: ioport range 0x800-0x805 could not be reserved
pnp: 00:01: ioport range 0x808-0x80f could not be reserved
pnp: 00:02: ioport range 0x806-0x807 has been reserved
pnp: 00:02: ioport range 0x810-0x85f could not be reserved
pnp: 00:02: ioport range 0x860-0x87f has been reserved
pnp: 00:02: ioport range 0x880-0x8bf has been reserved
pnp: 00:02: ioport range 0x8c0-0x8ff has been reserved
pnp: 00:03: ioport range 0xf000-0xf0fe has been reserved
pnp: 00:03: ioport range 0xf100-0xf1fe has been reserved
pnp: 00:03: ioport range 0xf200-0xf2fe has been reserved
pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
pnp: 00:03: ioport range 0xf500-0xf5fe has been reserved
pnp: 00:03: ioport range 0xf600-0xf6fe has been reserved
pnp: 00:03: ioport range 0xf800-0xf8fe has been reserved
pnp: 00:03: ioport range 0xf900-0xf9fe has been reserved
pnp: 00:08: ioport range 0x900-0x91f has been reserved
pnp: 00:08: ioport range 0x3f0-0x3f1 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: fc000000-fdffffff
  PREFETCH window: d8000000-e7ffffff
PCI: Bus 3, cardbus bridge: 0000:02:01.0
  IO window: 00001000-00001fff
  IO window: 00002000-00002fff
  PREFETCH window: 40000000-41ffffff
  MEM window: f4000000-f5ffffff
PCI: Bus 7, cardbus bridge: 0000:02:01.1
  IO window: 00003000-00003fff
  IO window: 00004000-00004fff
  PREFETCH window: 42000000-43ffffff
  MEM window: f6000000-f7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: e000-ffff
  MEM window: f4000000-fbffffff
  PREFETCH window: 40000000-44ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Enabling device 0000:02:01.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:02:01.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1126817221.052:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THM] (60 C)
lp: driver loaded but no devices found
Dell laptop SMM driver v1.14 21/02/2005 Massimo Dal Zotto (dz@debian.org)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized drm 1.0.0 20040925
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Can't read CTR while initializing i8042.
pnp: Device 00:05 does not supported disabling.
pnp: Device 00:04 does not supported disabling.
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HTS548040M9AT00, ATA DISK drive
hdb: TEAC CD-RW CD-W224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdb: ATAPI 24X CD-ROM CD-R/RW drive, 1280kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:02:01.2[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[f8fff000-f8fff7ff]  Max Packet=[2048]
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugfs is not available
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801CA/CAM USB (Hub #1)
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801CA/CAM USB (Hub #3)
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28 12:20:13 2005 UTC).
ALSA device list:
  No soundcards found.
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
 LID PBTN PCI0 UAR1 USB0 USB1 USB2 MODM PCIE MPCI 
ACPI: (supports S0 S1 S3 S4 S4bios S5)
Freeing unused kernel memory: 176k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[464fc000270ec421]
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:00.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.19
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 55413 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.6 to 64
MC'97 1 converters and GPIO not ready (0xff00)
hw_random hardware driver 1.0.0 loaded
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:01.0 [1028:00d4]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:01.0, mfunc 0x05033002, devctl 0x64
Yenta: ISA IRQ mask 0x0418, PCI irq 11
Socket status: 30000020
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xffff
pcmcia: parent PCI bridge Memory window: 0xf4000000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x44ffffff
ACPI: PCI Interrupt 0000:02:01.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:01.1 [1028:00d4]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:01.1, mfunc 0x05033002, devctl 0x64
Yenta: ISA IRQ mask 0x0418, PCI irq 11
Socket status: 30000061
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xffff
pcmcia: parent PCI bridge Memory window: 0xf4000000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x44ffffff
PCI: Enabling device 0000:07:00.2 (0000 -> 0002)
ACPI: PCI Interrupt 0000:07:00.2[C] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:07:00.2: NEC Corporation USB 2.0
ehci_hcd 0000:07:00.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:07:00.2: irq 11, io mem 0xf6002000
ehci_hcd 0000:07:00.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 5 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:07:00.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:07:00.0 to 64
ohci_hcd 0000:07:00.0: NEC Corporation USB
ohci_hcd 0000:07:00.0: new USB bus registered, assigned bus number 4
ohci_hcd 0000:07:00.0: irq 11, io mem 0xf6000000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
PCI: Enabling device 0000:07:00.1 (0000 -> 0002)
ACPI: PCI Interrupt 0000:07:00.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:07:00.1 to 64
ohci_hcd 0000:07:00.1: NEC Corporation USB (#2)
ohci_hcd 0000:07:00.1: new USB bus registered, assigned bus number 5
ohci_hcd 0000:07:00.1: irq 11, io mem 0xf6001000
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
audit(1126817240.999:2): user pid=2110 uid=0 auid=4294967295 msg='hwclock: op=changing system time id=0 res=success'
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
EXT3 FS on hda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 610460k swap on /dev/hda3.  Priority:-1 extents:1
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
dazuko: version magic '2.6.12.3 preempt PENTIUM4 REGPARM 4KSTACKS gcc-4.0' should be '2.6.13.1 preempt PENTIUM4 gcc-4.0'
audit(1126817293.782:3): user pid=2922 uid=0 auid=4294967295 msg='PAM authentication: user=tim exe="/usr/sbin/sshd" (hostname=10.21.6.21, addr=10.21.6.21, terminal=ssh result=Success)'
audit(1126817293.782:4): user pid=2922 uid=0 auid=4294967295 msg='PAM accounting: user=tim exe="/usr/sbin/sshd" (hostname=10.21.6.21, addr=10.21.6.21, terminal=ssh result=Success)'
audit(1126817293.886:5): user pid=2926 uid=0 auid=4294967295 msg='PAM session open: user=tim exe="/usr/sbin/sshd" (hostname=10.21.6.21, addr=10.21.6.21, terminal=ssh result=Success)'
audit(1126817293.886:6): user pid=2926 uid=0 auid=4294967295 msg='PAM setcred: user=tim exe="/usr/sbin/sshd" (hostname=10.21.6.21, addr=10.21.6.21, terminal=ssh result=Success)'
audit(1126817300.399:7): user pid=2957 uid=500 auid=4294967295 msg='PAM authentication: user=root exe="/bin/su" (hostname=?, addr=?, terminal=pts/0 result=Success)'
audit(1126817300.399:8): user pid=2957 uid=500 auid=4294967295 msg='PAM accounting: user=root exe="/bin/su" (hostname=?, addr=?, terminal=pts/0 result=Success)'
audit(1126817300.491:9): user pid=2957 uid=500 auid=4294967295 msg='PAM session open: user=root exe="/bin/su" (hostname=?, addr=?, terminal=pts/0 result=Success)'
audit(1126817300.491:10): user pid=2957 uid=500 auid=4294967295 msg='PAM setcred: user=root exe="/bin/su" (hostname=?, addr=?, terminal=pts/0 result=Success)'

--------------010500010005040809050307--
