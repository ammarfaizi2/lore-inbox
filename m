Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268379AbUHYGH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268379AbUHYGH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 02:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268397AbUHYGH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 02:07:56 -0400
Received: from smtp5.pop.com.br ([200.175.8.39]:3200 "EHLO smtp5.pop.com.br")
	by vger.kernel.org with ESMTP id S268379AbUHYGH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 02:07:27 -0400
Message-ID: <1065.200.225.247.187.1093414043.squirrel@popmail4.pop.com.br>
Date: Wed, 25 Aug 2004 03:07:23 -0300 (BRT)
Subject: PCI: Unable to reserve I/O region
From: "Rodrigo F Baroni" <rodrigobaroni@pop.com.br>
To: linux-kernel@vger.kernel.org
User-Agent: POPMail/1.4.2
X-POPMail-client-ip: 200.225.247.187
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello,

    I'm getting the following error when trying to load a module for a Smart
Link PCI 56Kps Modem. The manufacturer says to be for the 2.6 kernel. I
compiled it with no errors. When I try to load it, I got below  error.
Also, I tryed to compile the AC97 ALSA modem support build in as suggest
in the docs and load it with alsa support (other error, saying about hw:1
could not be found .. I have set the default device to 2 in the
/etc/asound too, but since this is a PCI Modem card, I conclude that with
alsa support it wasn't the case) but did'n work..

    #modprobe slamr
    slamr: SmartLink AMRMO modem.
    slamr: probe 10b9:5459 SL1800 card...
    PCI: Unable to reserve I/O region #2:100@d000 for device 0000:01:09.0
    slamr: failed request regions.
    slamr: probe of 0000:01:09.0 failed with error -16


    The machine configuration, running a 2.6.7 kernel :
      -ASUS A7N8X-X (nvidia2 chipset)
      -LG Modem (Smart Link chipset)
      -Athlon 2.6+ Barton

    Does anybody can points me some suggests/docs about the error?
    I have spend a lot of time trying this work..


Rodrigo F Baroni

  Below more information .. :
-----------------------------------------------------
#cat /proc/ioports

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
5000-5007 : nForce2 SMBus
5500-5507 : nForce2 SMBus
d000-dfff : PCI Bus #01
  d000-d0ff : 0000:01:09.0
    d028-d02f : serial
    d040-d047 : serial
    d050-d057 : serial
    d060-d067 : serial
    d070-d077 : serial
e000-e007 : 0000:00:04.0
  e000-e007 : eth0
e400-e4ff : 0000:00:06.0
e800-e87f : 0000:00:06.0
  e800-e83f : NVidia nForce2 - Controller
ec00-ec1f : 0000:00:01.1
f000-f00f : 0000:00:09.0
  f000-f007 : ide0
  f008-f00f : ide1
------------------------------------------
#dmesg

pass
testing michael_mic across pages
Console: switching to colour frame buffer device 128x48
lp: driver loaded but no devices found

DoubleTalk PC - not found
Real Time Clock Driver v1.12
ppdev: user-space parallel port driver
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 128M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS47 at I/O 0xd028 (irq = 5) is a 8250
ttyS2 at I/O 0xd040 (irq = 5) is a 8250
ttyS3 at I/O 0xd050 (irq = 5) is a 8250
ttyS4 at I/O 0xd060 (irq = 5) is a 8250
ttyS5 at I/O 0xd070 (irq = 5) is a 8250
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
nbd: registered device at major 43
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit
encapsulation enabled).
CSLIP: code copyright 1989 Regents of the University of California.
SLIP linefill/keepalive option.
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
netconsole: not configured, aborting
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST3120022A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 32X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
ehci_hcd 0000:00:02.2: reset hcs_params 0x102486 dbg=1 cc=2 pcc=4 !ppc ports=6
ehci_hcd 0000:00:02.2: reset portroute 0 0 1 1 1 0
ehci_hcd 0000:00:02.2: reset hcc_params a086 caching frame 256/512/1024 park
ehci_hcd 0000:00:02.2: capability 0001 at a0
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 11, pci mem d0ea5000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: reset command 080b02 park=3 ithresh=8 period=1024 Reset
HALT
irq 11: nobody cared!
 [<c0105d54>] __report_bad_irq+0x24/0x80
 [<c0105e31>] note_interrupt+0x61/0x90
 [<c0105d00>] handle_IRQ_event+0x30/0x60
 [<c01060ea>] do_IRQ+0x11a/0x130
 [<c01045a4>] common_interrupt+0x18/0x20
 [<c0119870>] __do_softirq+0x30/0x80
 [<c01198e6>] do_softirq+0x26/0x30
 [<c01060cb>] do_IRQ+0xfb/0x130
 [<c01045a4>] common_interrupt+0x18/0x20
 [<c036384b>] pci_bus_read_config_byte+0x4b/0x80
 [<c03f6889>] ehci_start+0x339/0x3c0
 [<c01163e2>] __call_console_drivers+0x42/0x50
 [<c01168af>] release_console_sem+0xcf/0xe0
 [<c011672c>] printk+0xfc/0x160
 [<c03e6881>] usb_register_bus+0x131/0x160
 [<c03eba90>] usb_hcd_pci_probe+0x270/0x530
 [<c03651a6>] pci_device_probe_static+0x46/0x60
 [<c03651d6>] __pci_device_probe+0x16/0x20
 [<c0365203>] pci_device_probe+0x23/0x40
 [<c038c102>] bus_match+0x32/0x60
 [<c038c216>] driver_attach+0x56/0x90
 [<c03599d2>] kobject_register+0x22/0x60
 [<c038c488>] bus_add_driver+0x88/0xa0
 [<c038c8a8>] driver_register+0x28/0x30
 [<c011672c>] printk+0xfc/0x160
 [<c03653ea>] pci_register_driver+0x2a/0x40
 [<c06a6795>] init+0x55/0x80
 [<c068a78b>] do_initcalls+0x2b/0xc0
 [<c01002d0>] init+0x0/0x170
 [<c010030a>] init+0x3a/0x170
 [<c0101fb8>] kernel_thread_helper+0x0/0x18
 [<c0101fbd>] kernel_thread_helper+0x5/0x18

handlers:
[<c03e7890>] (usb_hcd_irq+0x0/0x60)
Disabling IRQ #11
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: init command 010b09 park=3 ithresh=1 period=256 RUN
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:02.2: supports USB remote wakeup
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: nVidia Corporation nForce2 USB Controller
usb usb1: Manufacturer: Linux 2.6.7 ehci_hcd
usb usb1: SerialNumber: 0000:00:02.2
usb usb1: adding 1-0:1.0 (config #1, interface 0)
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
ohci_hcd 0000:00:02.0: reset, control = 0x600
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 11, pci mem d0ea7000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: supports USB remote wakeup
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: nVidia Corporation nForce2 USB Controller
usb usb2: Manufacturer: Linux 2.6.7 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
usb usb2: adding 2-0:1.0 (config #1, interface 0)
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
ohci_hcd 0000:00:02.0: created debug files
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: hcca frame #0016
ohci_hcd 0000:00:02.0: roothub.a 01000203 POTPGT=1 NPS NDP=3
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
ohci_hcd 0000:00:02.1: reset, control = 0x600
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 5, pci mem d0ea9000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: supports USB remote wakeup
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: nVidia Corporation nForce2 USB Controller (#2)
usb usb3: Manufacturer: Linux 2.6.7 ohci_hcd
usb usb3: SerialNumber: 0000:00:02.1
usb usb3: adding 3-0:1.0 (config #1, interface 0)
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: global over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
ohci_hcd 0000:00:02.1: created debug files
ohci_hcd 0000:00:02.1: OHCI controller state
ohci_hcd 0000:00:02.1: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.1: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.1: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.1: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.1: hcca frame #0018
ohci_hcd 0000:00:02.1: roothub.a 01000203 POTPGT=1 NPS NDP=3
ohci_hcd 0000:00:02.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [2] 0x00000100 PPS
USB Universal Host Controller Interface driver v2.2
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
parport0: cannot grant exclusive access for device parkbd
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 23
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2c /dev entries driver
i2c-core: driver dev_driver registered.
i2c_adapter i2c-0: Registered as minor 0
i2c_adapter i2c-0: registered as adapter #0
i2c_adapter i2c-1: Registered as minor 1
i2c_adapter i2c-1: registered as adapter #1
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-2: Registered as minor 2
i2c_adapter i2c-2: registered as adapter #2
i2c_adapter i2c-2: nForce2 SMBus adapter at 0x5500
i2c-parport: attaching to parport0
parport0: cannot grant exclusive access for device i2c-parport
i2c-parport: Unable to register with parport
i2c-parport: using default base 0x378
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44
2004 UTC).
no UART detected at 0x1
ALSA sound/drivers/mtpav.c:605: MTVAP port 0x378 is busy
ALSA sound/drivers/mpu401/mpu401.c:157: specify port
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49461 usecs
intel8x0: clocking to 47482
ALSA sound/pci/intel8x0.c:2822: joystick(s) found
ALSA device list:
  #0: Dummy 1
  #1: Virtual MIDI Card 1
  #2: NVidia nForce2 at 0xe3001000, irq 11
pktgen.c: v1.3: Packet Generator for packet performance testing.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 296 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
registering ipv6 mark target
NET: Registered protocol family 17
BIOS EDD facility v0.15 2004-May-17, 1 devices found
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 520k freed
Disabled Privacy Extensions on device c061a7e0(lo)
------------------------------------------
#cat /proc/devices :

Character devices:
  1 mem
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  6 lp
  7 vcs
 10 misc
 13 input
 14 sound
 29 fb
 67 coda_psdev
 81 video4linux
 89 i2c
 99 ppdev
108 ppp
116 alsa
128 ptm
136 pts
180 usb
254 dtlk

Block devices:
  2 fd
  3 ide0
  7 loop
 22 ide1
 43 nbd
 80 i2o_block
--------------------------------------
#cat /proc/interrupts :

           CPU0
  0:     686493          XT-PIC  timer
  1:       4015          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  ohci_hcd
  8:          4          XT-PIC  rtc
 11:     100000          XT-PIC  ehci_hcd, ohci_hcd, NVidia nForce2
 12:       8546          XT-PIC  i8042
 14:       1723          XT-PIC  ide0
 15:         48          XT-PIC  ide1
NMI:          0
LOC:     686454
ERR:     412539
MIS:          0
---------------------------------------
#cat /proc/iomem :

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf3ff : Video ROM
000d0000-000d17ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0052800e : Kernel code
  0052800f-00686dff : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-dfffffff : PCI Bus #02
  d8000000-dfffffff : 0000:02:00.0
    d8000000-d85fffff : vesafb
e0000000-e1ffffff : PCI Bus #02
  e0000000-e0ffffff : 0000:02:00.0
e2000000-e2ffffff : PCI Bus #01
  e2000000-e2000fff : 0000:01:09.0
e3000000-e3000fff : 0000:00:04.0
  e3000000-e3000fff : eth0
e3001000-e3001fff : 0000:00:06.0
  e3001000-e30011ff : NVidia nForce2 - AC'97
e3002000-e3002fff : 0000:00:02.0
  e3002000-e3002fff : ohci_hcd
e3003000-e3003fff : 0000:00:02.1
  e3003000-e3003fff : ohci_hcd
e3004000-e30040ff : 0000:00:02.2
  e3004000-e30040ff : ehci_hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
--------------------------------------------
#lspci output

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?)
(rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 0 (rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97
Audio Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:09.0 Modem: ALi Corporation SmartLink SmartPCI561 56K Modem
0000:02:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX
5200] (rev a1)
------------------------------------------------------------------------
#lspci -vvv :

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?)
(rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable)
	Capabilities: [40] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+
AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4
	Capabilities: [60] #08 [2001]

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 0 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [48] #08 [01e1]

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at ec00
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e3002000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at e3003000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at e3004000 (32-bit, non-prefetchable)
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e3000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at e000 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97
Audio Controler (MCP) (rev a1)
	Subsystem: Asustek Computer, Inc.: Unknown device 8095
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e400
	Region 1: I/O ports at e800 [size=128]
	Region 2: Memory at e3001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev
a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e2000000-e2ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Expansion ROM at 0000d000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if
8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:09.0 Modem: ALi Corporation SmartLink SmartPCI561 56K Modem (prog-if
00 [Generic])
	Subsystem: Smart Link Ltd.: Unknown device 5459
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e2000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at d000 [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX
5200] (rev a1) (prog-if 00 [VGA])
	Subsystem: Unknown device 1682:1351
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e0000000 (32-bit, non-prefetchable)
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+
AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
-----------------------------------------------------

