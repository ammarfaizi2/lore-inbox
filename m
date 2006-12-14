Return-Path: <linux-kernel-owner+w=401wt.eu-S1751977AbWLNXeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbWLNXeL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbWLNXeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:34:10 -0500
Received: from webserve.ca ([69.90.47.180]:60410 "EHLO computersmith.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751973AbWLNXeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:34:06 -0500
Message-ID: <4581DF1B.9040002@wintersgift.com>
Date: Thu, 14 Dec 2006 15:32:43 -0800
From: Teunis Peters <teunis@wintersgift.com>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-git19, Intel 945 + ICH7 SATA - long delay in boot (30 seconds
 to a minute timeout).
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/mixed;
 boundary="------------000109090502090406060902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000109090502090406060902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

still has 30+ second (up to a minute or more) delay in SATA init.

It's a laptop - so such delays are costly.

Okay - working from "single":
no real change in configuration from past.

ipw3945 still broken - I'm not surprised... (I know - patience!)

Still testing out synaptics driver... it's looking good!
actually - the kernel seems to be working quite well otherwise.

attached: dmesg and lspci

If anyone has any debugging suggestions for this (SATA/Flash drive) - please let me know.   (note: NO serial or parallel port on unit)

- - Teunis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgd8abFT/SAfwLKMRAnE/AKCyRwMu6L/8Y8snOo4QHtoXAFMF8gCZAYWh
9io2aatGgG78SYcZUq+TB2U=
=YcPK
-----END PGP SIGNATURE-----

--------------000109090502090406060902
Content-Type: text/plain;
 name="log-nx6310"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log-nx6310"

: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed9b000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
759MB LOWMEM available.
Entering add_active_range(0, 0, 194512) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   194512
  HighMem    194512 ->   194512
early_node_map[1] active PFN ranges
    0:        0 ->   194512
On node 0 totalpages: 194512
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1487 pages used for memmap
  Normal zone: 188929 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI 2.4 present.
Using APIC driver default
ACPI: RSDP (v000 HP                                    ) @ 0x000f7d70
ACPI: RSDT (v001 HP     30AA     0x28040620 HP   0x00000001) @ 0x2f7e5684
ACPI: FADT (v002 HP     30AA     0x00000002 HP   0x00000001) @ 0x2f7e5600
ACPI: MADT (v001 HP     30AA     0x00000001 HP   0x00000001) @ 0x2f7e56c4
ACPI: MCFG (v001 HP     30AA     0x00000001 HP   0x00000001) @ 0x2f7e572c
ACPI: TCPA (v002 HP     30AA     0x00000001 HP   0x00000001) @ 0x2f7e5768
ACPI: SSDT (v001 HP       HPQSAT 0x00000001 MSFT 0x0100000e) @ 0x2f7f4afc
ACPI: SSDT (v001 HP      Cpu0Cst 0x00003001 INTL 0x20050624) @ 0x2f7f4e58
ACPI: SSDT (v001 HP        CpuPm 0x00003000 INTL 0x20050624) @ 0x2f7f5033
ACPI: DSDT (v001 HP       nc6340 0x00010000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 2f800000:cf400000)
Detected 1463.105 MHz processor.
Built 1 zonelists.  Total pages: 192993
Kernel command line: root=/dev/mapper/crypt0 cryptopts=target=crypt0,source=/dev/mapper/Komodo-KMDOFS ro vga=791 single
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 758672k/778048k available (1952k kernel code, 18688k reserved, 812k data, 228k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffe16000 - 0xfffff000   (1956 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf0000000 - 0xff7fe000   ( 247 MB)
    lowmem  : 0xc0000000 - 0xef7d0000   ( 759 MB)
      .init : 0xc03ba000 - 0xc03f3000   ( 228 kB)
      .data : 0xc02e8269 - 0xc03b32f4   ( 812 kB)
      .text : 0xc0100000 - 0xc02e8269   (1952 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2928.22 BogoMIPS (lpj=1464112)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 0000c109 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00002940 0000c109 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 13k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Celeron(R) M CPU        410  @ 1.46GHz stepping 08
Total of 1 processors activated (2928.22 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
PM: Adding info for No Bus:platform
HP Compaq Laptop series board detected. Selecting BIOS-method for reboots.
NET: Registered protocol family 16
PM: Adding info for No Bus:vtcon0
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at f8000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 2.10 entry at 0xf0322, last bus=8
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [C002] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C002] bus is 0
PM: Adding info for No Bus:pci0000:00
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1100-113f claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#03) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.C002._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:02.1
PM: Adding info for pci:0000:00:1b.0
PM: Adding info for pci:0000:00:1c.0
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.3
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.2
PM: Adding info for pci:0000:08:00.0
PM: Adding info for pci:0000:02:06.0
PM: Adding info for pci:0000:02:06.1
PM: Adding info for pci:0000:02:0e.0
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C092._PRT]
ACPI: Power Resource [C20B] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C0FB._PRT]
ACPI: Power Resource [C213] (off)
ACPI: PCI Interrupt Link [C107] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C108] (IRQs *10 11)
ACPI: PCI Interrupt Link [C109] (IRQs *10 11)
ACPI: PCI Interrupt Link [C10A] (IRQs *10 11)
ACPI: PCI Interrupt Link [C123] (IRQs *10 11)
ACPI: PCI Interrupt Link [C124] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C125] (IRQs 10 11) *0, disabled.
ACPI Exception (pci_link-0180): AE_NOT_FOUND, Evaluating _PRS [20060707]
ACPI: Power Resource [C308] (off)
ACPI: Power Resource [C309] (off)
ACPI: Power Resource [C30A] (off)
ACPI: Power Resource [C30B] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
intel_rng: FWH not detected
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:09: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:09: ioport range 0x1000-0x107f could not be reserved
pnp: 00:09: ioport range 0x1100-0x113f has been reserved
pnp: 00:09: ioport range 0x1200-0x121f has been reserved
PM: Adding info for No Bus:mem
PM: Adding info for No Bus:kmem
PM: Adding info for No Bus:null
PM: Adding info for No Bus:port
PM: Adding info for No Bus:zero
PM: Adding info for No Bus:full
PM: Adding info for No Bus:random
PM: Adding info for No Bus:urandom
PM: Adding info for No Bus:kmsg
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: e8000000-e80fffff
  PREFETCH window: disabled.
PCI: Bus 3, cardbus bridge: 0000:02:06.0
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: e8100000-e83fffff
  PREFETCH window: 30000000-31ffffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 17
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 8454k freed
PM: Adding info for platform:pcspkr
apm: BIOS not found.
PM: Adding info for No Bus:snapshot
audit: initializing netlink socket (disabled)
audit(1166107882.493:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
PM: Adding info for pci_express:0000:00:1c.0:pcie00
Allocate Port Service[0000:00:1c.0:pcie02]
PM: Adding info for pci_express:0000:00:1c.0:pcie02
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
vesafb: framebuffer at 0xd0000000, mapped to 0xf0080000, using 6144k, total 7872k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
PM: Adding info for No Bus:fb0
bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size 213047 bytes,<6>...found (1024x768, 212951 bytes, v3).
PM: Adding info for No Bus:vtcon1
Console: switching to colour frame buffer device 122x40
fb0: VESA VGA frame buffer device
ACPI: Transitioning device [C30C] to D3
ACPI: Transitioning device [C30C] to D3
ACPI: Fan [C30C] (off)
ACPI: Transitioning device [C30D] to D3
ACPI: Transitioning device [C30D] to D3
ACPI: Fan [C30D] (off)
ACPI: Transitioning device [C30E] to D3
ACPI: Transitioning device [C30E] to D3
ACPI: Fan [C30E] (off)
ACPI: Transitioning device [C30F] to D3
ACPI: Transitioning device [C30F] to D3
ACPI: Fan [C30F] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x2
ACPI: Thermal Zone [TZ0] (49 C)
ACPI: Thermal Zone [TZ1] (46 C)
ACPI: Thermal Zone [TZ2] (41 C)
ACPI: Thermal Zone [TZ3] (29 C)
ACPI: Thermal Zone [TZ4] (71 C)
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PM: Adding info for No Bus:tty
PM: Adding info for No Bus:console
PM: Adding info for No Bus:ptmx
PM: Adding info for No Bus:tty0
PM: Adding info for No Bus:vcs
PM: Adding info for No Bus:vcsa
PM: Adding info for No Bus:tty1
PM: Adding info for No Bus:tty2
PM: Adding info for No Bus:tty3
PM: Adding info for No Bus:tty4
PM: Adding info for No Bus:tty5
PM: Adding info for No Bus:tty6
PM: Adding info for No Bus:tty7
PM: Adding info for No Bus:tty8
PM: Adding info for No Bus:tty9
PM: Adding info for No Bus:tty10
PM: Adding info for No Bus:tty11
PM: Adding info for No Bus:tty12
PM: Adding info for No Bus:tty13
PM: Adding info for No Bus:tty14
PM: Adding info for No Bus:tty15
PM: Adding info for No Bus:tty16
PM: Adding info for No Bus:tty17
PM: Adding info for No Bus:tty18
PM: Adding info for No Bus:tty19
PM: Adding info for No Bus:tty20
PM: Adding info for No Bus:tty21
PM: Adding info for No Bus:tty22
PM: Adding info for No Bus:tty23
PM: Adding info for No Bus:tty24
PM: Adding info for No Bus:tty25
PM: Adding info for No Bus:tty26
PM: Adding info for No Bus:tty27
PM: Adding info for No Bus:tty28
PM: Adding info for No Bus:tty29
PM: Adding info for No Bus:tty30
PM: Adding info for No Bus:tty31
PM: Adding info for No Bus:tty32
PM: Adding info for No Bus:tty33
PM: Adding info for No Bus:tty34
PM: Adding info for No Bus:tty35
PM: Adding info for No Bus:tty36
PM: Adding info for No Bus:tty37
PM: Adding info for No Bus:tty38
PM: Adding info for No Bus:tty39
PM: Adding info for No Bus:tty40
PM: Adding info for No Bus:tty41
PM: Adding info for No Bus:tty42
PM: Adding info for No Bus:tty43
PM: Adding info for No Bus:tty44
PM: Adding info for No Bus:tty45
PM: Adding info for No Bus:tty46
PM: Adding info for No Bus:tty47
PM: Adding info for No Bus:tty48
PM: Adding info for No Bus:tty49
PM: Adding info for No Bus:tty50
PM: Adding info for No Bus:tty51
PM: Adding info for No Bus:tty52
PM: Adding info for No Bus:tty53
PM: Adding info for No Bus:tty54
PM: Adding info for No Bus:tty55
PM: Adding info for No Bus:tty56
PM: Adding info for No Bus:tty57
PM: Adding info for No Bus:tty58
PM: Adding info for No Bus:tty59
PM: Adding info for No Bus:tty60
PM: Adding info for No Bus:tty61
PM: Adding info for No Bus:tty62
PM: Adding info for No Bus:tty63
PM: Adding info for No Bus:rtc
Real Time Clock Driver v1.12ac
PM: Adding info for No Bus:hpet
PM: Adding info for No Bus:nvram
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945GM Chipset.
agpgart: Detected 7932K stolen memory.
PM: Adding info for No Bus:agpgart
agpgart: AGP aperture is 256M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
PM: Adding info for No Bus:ttyS0
PM: Adding info for No Bus:ttyS1
PM: Adding info for No Bus:ttyS2
PM: Adding info for No Bus:ttyS3
PM: Adding info for No Bus:isa
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Yenta: CardBus bridge found at 0000:02:06.0 [103c:30aa]
Yenta: Enabling burst memory read transactions
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:06.0, mfunc 0x01a61b22, devctl 0x64
Yenta: ISA IRQ mask 0x0cf8, PCI irq 17
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#02) from #03 to #06
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
cs: IO port probe 0x2000-0x2fff: clean.
pcmcia: parent PCI bridge Memory window: 0xe8100000 - 0xe83fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x31ffffff
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:C208,PNP0f13:C209] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
PM: Adding info for serio:serio0
mice: PS/2 mouse device common for all mice
PM: Adding info for serio:serio1
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Time: tsc clocksource has been installed.
Freeing unused kernel memory: 228k freed
Time: acpi_pm clocksource has been installed.
PM: Adding info for serio:serio2
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Adding info for serio:serio3
PM: Adding info for serio:serio4
synaptics reset failed
synaptics reset failed
synaptics reset failed
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04793/0x300000
serio: Synaptics pass-through port at isa0060/serio4/input0
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 18, io base 0x00006020
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
input: SynPS/2 Synaptics TouchPad as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
PM: Adding info for serio:serio5
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PM: Adding info for No Bus:usbdev1.1_ep81
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00006040
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
SCSI subsystem initialized
libata version 2.00 loaded.
ieee1394: Initialized config rom entry `ip1394'
PM: Adding info for No Bus:usbdev2.1_ep81
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 17, io base 0x00006060
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev3.1_ep81
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 20, io base 0x00006080
PM: Adding info for usb:usb4
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev4.1_ep81
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 18, io mem 0xe8584000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PM: Adding info for usb:usb5
PM: Adding info for No Bus:usbdev5.1_ep00
usb usb5: configuration #1 chosen from 1 choice
PM: Adding info for usb:5-0:1.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
PM: Adding info for No Bus:usbdev5.1_ep81
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo pmp pio slum part 
ata1: SATA max UDMA/133 cmd 0xF080C100 ctl 0x0 bmdma 0x0 irq 222
ata2: SATA max UDMA/133 cmd 0xF080C180 ctl 0x0 bmdma 0x0 irq 222
ata3: SATA max UDMA/133 cmd 0xF080C200 ctl 0x0 bmdma 0x0 irq 222
ata4: SATA max UDMA/133 cmd 0xF080C280 ctl 0x0 bmdma 0x0 irq 222
scsi0 : ahci
PM: Adding info for No Bus:host0
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1: port is slow to respond, please be patient (Status 0x80)
ata1: port failed to respond (30 secs, Status 0x80)
ata1: COMRESET failed (device not ready)
ata1: hardreset failed, retrying in 5 secs
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6, max UDMA/33, 32503808 sectors: LBA 
ata1.00: ata1: dev 0 multi count 1
ata1.00: applying bridge limits
ata1.00: configured for UDMA/33
scsi1 : ahci
PM: Adding info for No Bus:host1
ata2: SATA link down (SStatus 0 SControl 0)
scsi2 : ahci
PM: Adding info for No Bus:host2
ata3: SATA link down (SStatus 0 SControl 0)
scsi3 : ahci
PM: Adding info for No Bus:host3
ata4: SATA link down (SStatus 0 SControl 0)
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      PQI SATA DiskOnM YUAN PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x60a0-0x60a7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
SCSI device sda: 32503808 512-byte hdwr sectors (16642 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 32503808 512-byte hdwr sectors (16642 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
hda: HL-DT-STCD-RW/DVD DRIVE GCC-4244N, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
ACPI: PCI Interrupt 0000:02:06.1[B] -> GSI 19 (level, low) -> IRQ 20
PM: Adding info for ieee1394:fw-host0
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=[e8101000-e81017ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
b44.c:v1.01 (Jun 16, 2006)
ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 16 (level, low) -> IRQ 16
eth0: Broadcom 4400 10/100BaseT Ethernet 00:15:60:ca:47:d4
hda: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
PM: Adding info for No Bus:device-mapper
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
Probing IDE interface ide1...
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 1560 types, 166 bools, 1 sens, 1024 cats
security:  58 classes, 48173 rules
security:  class context not defined in policy
security:  class dccp_socket not defined in policy
security:  permission dccp_recv in class node not defined in policy
security:  permission dccp_send in class node not defined in policy
security:  permission dccp_recv in class netif not defined in policy
security:  permission dccp_send in class netif not defined in policy
security:  permission setsockcreate in class process not defined in policy
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-3, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1166107938.720:2): policy loaded auid=4294967295
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
PM: Adding info for No Bus:timer
input: PC Speaker as /class/input/input2
iTCO_vendor_support: vendor-support=0
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (11-Nov-2006)
PM: Adding info for platform:iTCO_wdt
iTCO_wdt: Found a ICH7-M TCO device (Version=2, TCOBASE=0x1060)
PM: Adding info for No Bus:watchdog
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux, 1.1.3d
ipw3945: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:08:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:08:00.0 to 64
ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
PM: Adding info for No Bus:0000:08:00.0
sd 0:0:0:0: Attached scsi generic sg0 type 0
PM: Adding info for No Bus:seq
PM: Adding info for No Bus:sequencer
PM: Adding info for No Bus:sequencer2
PM: Removing info for No Bus:0000:08:00.0
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1b.0 to 64
PM: Adding info for No Bus:card0
PM: Adding info for No Bus:pcmC0D6p
PM: Adding info for No Bus:pcmC0D6c
PM: Adding info for No Bus:pcmC0D0p
PM: Adding info for No Bus:pcmC0D0c
PM: Adding info for No Bus:dsp
PM: Adding info for No Bus:audio
PM: Adding info for No Bus:controlC0
PM: Adding info for No Bus:mixer
Floppy drive(s): fd0 is 1.44M
audit(1166136745.539:3): avc:  denied  { getattr } for  pid=2354 comm="pam_console_app" name="hda" dev=tmpfs ino=3522 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:device_t:s0 tclass=blk_file
audit(1166136745.831:4): avc:  denied  { setattr } for  pid=2338 comm="pam_console_app" name="hda" dev=tmpfs ino=3522 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:device_t:s0 tclass=blk_file
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
floppy0: no floppy controllers found
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
lp: driver loaded but no devices found
ACPI: AC Adapter [C1B2] (on-line)
ACPI: Battery Slot [C1B4] (battery present)
ACPI: Battery Slot [C1B3] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C231]
ACPI: Lid Switch [C22A]
Using specific hotkey driver
ibm_acpi: ec object not found
ACPI: Video Device [C07F] (multi-head: yes  rom: no  post: no)
EXT3 FS on dm-3, internal journal
audit(1166136754.227:5): avc:  denied  { read } for  pid=2689 comm="mount" name="sda1" dev=tmpfs ino=3354 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:device_t:s0 tclass=blk_file
audit(1166136754.227:6): avc:  denied  { getattr } for  pid=2689 comm="mount" name="sda1" dev=tmpfs ino=3354 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:device_t:s0 tclass=blk_file
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda1, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-5, type ext3), uses xattr
audit(1166136754.403:7): avc:  denied  { getattr } for  pid=2739 comm="pam_console_app" name="hda" dev=tmpfs ino=3522 scontext=system_u:system_r:pam_console_t:s0 tcontext=system_u:object_r:device_t:s0 tclass=blk_file
audit(1166136754.403:8): avc:  denied  { setattr } for  pid=2739 comm="pam_console_app" name="hda" dev=tmpfs ino=3522 scontext=system_u:system_r:pam_console_t:s0 tcontext=system_u:object_r:device_t:s0 tclass=blk_file
Adding 978420k swap on /dev/mapper/crypt2.  Priority:-1 extents:1 across:978420k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.

--------------000109090502090406060902
Content-Type: text/plain;
 name="log-nx6310.pci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log-nx6310.pci"

00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express Memory Controller Hub (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile 945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
00:1f.2 SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controller AHCI (rev 01)
02:06.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
02:06.1 FireWire (IEEE 1394): Texas Instruments PCIxx12 OHCI Compliant IEEE 1394 Host Controller
02:0e.0 Ethernet controller: Broadcom Corporation BCM4401-B0 100Base-TX (rev 02)
08:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Network Connection (rev 02)

--------------000109090502090406060902--
