Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbTK0Lgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 06:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbTK0Lgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 06:36:38 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:33508 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S264481AbTK0LgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 06:36:20 -0500
Date: Thu, 27 Nov 2003 12:37:07 +0100
Mime-Version: 1.0 (Apple Message framework v553)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: PROBLEM: trouble with usb mouse after suspending
From: "Titus v. d. Malsburg" <malsburg@cl.uni-heidelberg.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <08328644-20CE-11D8-AE92-003065B33FF0@cl.uni-heidelberg.de>
X-Mailer: Apple Mail (2.553)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:
trouble with usb mouse after suspending


[2.] Full description of the problem/report:
Notebook has a synaptics touchpad and a logitech usb mouse attached.  
Sending the notebook to sleep by apm --suspend and wake it afterwards 
yields the following (boot procedure is included as well): 
(/var/log/messages)

Nov 27 11:52:50 vlana syslogd 1.4.1#13: restart.
Nov 27 11:52:50 vlana kernel: klogd 1.4.1#13, log source = /proc/kmsg 
started.
Nov 27 11:52:50 vlana kernel: Cannot find map file.
Nov 27 11:52:50 vlana kernel: No module symbols loaded - kernel modules 
not enabled.
Nov 27 11:52:50 vlana kernel: Linux version 2.6.0-test10 (root@vlana) 
(gcc version 3.3.2 (Debian)) #2 Tue Nov 25 14:19:42 CET 2003
Nov 27 11:52:50 vlana kernel: BIOS-provided physical RAM map:
Nov 27 11:52:50 vlana kernel:  BIOS-e820: 0000000000000000 - 
000000000009fc00 (usable)
Nov 27 11:52:50 vlana kernel:  BIOS-e820: 000000000009fc00 - 
00000000000a0000 (reserved)
Nov 27 11:52:50 vlana kernel:  BIOS-e820: 00000000000e0000 - 
0000000000100000 (reserved)
Nov 27 11:52:50 vlana kernel:  BIOS-e820: 0000000000100000 - 
0000000007ff0000 (usable)
Nov 27 11:52:50 vlana kernel:  BIOS-e820: 0000000007ff0000 - 
0000000007ff8000 (ACPI data)
Nov 27 11:52:50 vlana kernel:  BIOS-e820: 0000000007ff8000 - 
0000000008000000 (ACPI NVS)
Nov 27 11:52:50 vlana kernel:  BIOS-e820: 00000000fec00000 - 
00000000fec01000 (reserved)
Nov 27 11:52:50 vlana kernel:  BIOS-e820: 00000000fee00000 - 
00000000fee01000 (reserved)
Nov 27 11:52:50 vlana kernel:  BIOS-e820: 00000000fffe0000 - 
0000000100000000 (reserved)
Nov 27 11:52:50 vlana kernel: 127MB LOWMEM available.
Nov 27 11:52:50 vlana kernel: On node 0 totalpages: 32752
Nov 27 11:52:50 vlana kernel:   DMA zone: 4096 pages, LIFO batch:1
Nov 27 11:52:50 vlana kernel:   Normal zone: 28656 pages, LIFO batch:6
Nov 27 11:52:50 vlana kernel:   HighMem zone: 0 pages, LIFO batch:1
Nov 27 11:52:50 vlana kernel: DMI 2.1 present.
Nov 27 11:52:50 vlana kernel: Building zonelist for node : 0
Nov 27 11:52:50 vlana kernel: Kernel command line: 
BOOT_IMAGE=Linux2.6.0 ro root=301
Nov 27 11:52:50 vlana kernel: Initializing CPU#0
Nov 27 11:52:50 vlana kernel: PID hash table entries: 512 (order 9: 
4096 bytes)
Nov 27 11:52:50 vlana kernel: Detected 228.521 MHz processor.
Nov 27 11:52:50 vlana kernel: Console: colour VGA+ 80x25
Nov 27 11:52:50 vlana kernel: Memory: 126252k/131008k available (1931k 
kernel code, 4220k reserved, 724k data, 128k init, 0k highmem)
Nov 27 11:52:50 vlana kernel: Calibrating delay loop... 1187.84 BogoMIPS
Nov 27 11:52:50 vlana kernel: Dentry cache hash table entries: 16384 
(order: 4, 65536 bytes)
Nov 27 11:52:50 vlana kernel: Inode-cache hash table entries: 8192 
(order: 3, 32768 bytes)
Nov 27 11:52:50 vlana kernel: Mount-cache hash table entries: 512 
(order: 0, 4096 bytes)
Nov 27 11:52:50 vlana kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Nov 27 11:52:50 vlana kernel: CPU: L2 cache: 256K
Nov 27 11:52:50 vlana kernel: Intel machine check architecture 
supported.
Nov 27 11:52:50 vlana kernel: Intel machine check reporting enabled on 
CPU#0.
Nov 27 11:52:50 vlana kernel: CPU: Intel Pentium III (Coppermine) 
stepping 03
Nov 27 11:52:50 vlana kernel: Enabling fast FPU save and restore... 
done.
Nov 27 11:52:50 vlana kernel: Enabling unmasked SIMD FPU exception 
support... done.
Nov 27 11:52:50 vlana kernel: Checking 'hlt' instruction... OK.
Nov 27 11:52:50 vlana kernel: POSIX conformance testing by UNIFIX
Nov 27 11:52:50 vlana kernel: NET: Registered protocol family 16
Nov 27 11:52:50 vlana kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfdba1, last bus=1
Nov 27 11:52:50 vlana kernel: PCI: Using configuration type 1
Nov 27 11:52:50 vlana kernel: mtrr: v2.0 (20020519)
Nov 27 11:52:50 vlana kernel: Linux Plug and Play Support v0.97 (c) 
Adam Belay
Nov 27 11:52:50 vlana kernel: SCSI subsystem initialized
Nov 27 11:52:50 vlana kernel: Linux Kernel Card Services
Nov 27 11:52:50 vlana kernel:   options:  [pci] [cardbus] [pm]
Nov 27 11:52:50 vlana kernel: drivers/usb/core/usb.c: registered new 
driver usbfs
Nov 27 11:52:50 vlana kernel: drivers/usb/core/usb.c: registered new 
driver hub
Nov 27 11:52:50 vlana kernel: PCI: Probing PCI hardware
Nov 27 11:52:50 vlana kernel: PCI: Probing PCI hardware (bus 00)
Nov 27 11:52:50 vlana kernel: PCI: Using IRQ router PIIX/ICH 
[8086/7110] at 0000:00:07.0
Nov 27 11:52:50 vlana kernel: PCI: IRQ 0 for device 0000:00:0a.0 
doesn't match PIRQ mask - try pci=usepirqmask
Nov 27 11:52:50 vlana kernel: PCI: IRQ 0 for device 0000:00:0a.1 
doesn't match PIRQ mask - try pci=usepirqmask
Nov 27 11:52:50 vlana kernel: Machine check exception polling timer 
started.
Nov 27 11:52:50 vlana kernel: cpufreq: Intel(R) SpeedStep(TM) for this 
chipset not (yet) available.
Nov 27 11:52:50 vlana kernel: apm: BIOS version 1.2 Flags 0x03 (Driver 
version 1.16ac)
Nov 27 11:52:50 vlana kernel: Initializing Cryptographic API
Nov 27 11:52:50 vlana kernel: Limiting direct PCI/PCI transfers.
Nov 27 11:52:50 vlana kernel: pty: 256 Unix98 ptys configured
Nov 27 11:52:50 vlana kernel: lp: driver loaded but no devices found
Nov 27 11:52:50 vlana kernel: Linux agpgart interface v0.100 (c) Dave 
Jones
Nov 27 11:52:50 vlana kernel: agpgart: Detected an Intel 440BX Chipset.
Nov 27 11:52:50 vlana kernel: agpgart: Maximum main memory to use for 
agp memory: 94M
Nov 27 11:52:50 vlana kernel: agpgart: AGP aperture is 64M @ 0xe0000000
Nov 27 11:52:50 vlana kernel: [drm] Initialized i830 1.3.2 20021108 on 
minor 0
Nov 27 11:52:50 vlana kernel: Serial: 8250/16550 driver $Revision: 1.90 
$ 8 ports, IRQ sharing disabled
Nov 27 11:52:50 vlana kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov 27 11:52:50 vlana kernel: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
Nov 27 11:52:50 vlana kernel: parport0: PC-style at 0x378 [PCSPP(,...)]
Nov 27 11:52:50 vlana kernel: lp0: using parport0 (polling).
Nov 27 11:52:50 vlana kernel: Using anticipatory io scheduler
Nov 27 11:52:50 vlana kernel: Floppy drive(s): fd0 is 1.44M
Nov 27 11:52:50 vlana kernel: FDC 0 is a post-1991 82077
Nov 27 11:52:50 vlana kernel: PPP generic driver version 2.4.2
Nov 27 11:52:50 vlana kernel: PPP Deflate Compression module registered
Nov 27 11:52:50 vlana kernel: PPP BSD Compression module registered
Nov 27 11:52:50 vlana kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Nov 27 11:52:50 vlana kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Nov 27 11:52:50 vlana kernel: PIIX4: IDE controller at PCI slot 
0000:00:07.1
Nov 27 11:52:50 vlana kernel: PIIX4: chipset revision 1
Nov 27 11:52:50 vlana kernel: PIIX4: not 100%% native mode: will probe 
irqs later
Nov 27 11:52:50 vlana kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS 
settings: hda:DMA, hdb:pio
Nov 27 11:52:50 vlana kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS 
settings: hdc:DMA, hdd:pio
Nov 27 11:52:50 vlana kernel: Losing too many ticks!
Nov 27 11:52:50 vlana kernel: TSC cannot be used as a timesource. (Are 
you running with SpeedStep?)
Nov 27 11:52:50 vlana kernel: Falling back to a sane timesource.
Nov 27 11:52:50 vlana kernel: hda: TOSHIBA MK1214GAP, ATA DISK drive
Nov 27 11:52:50 vlana kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 27 11:52:50 vlana kernel: hdc: TOSHIBA CD-ROM XM-7002B, ATAPI 
CD/DVD-ROM drive
Nov 27 11:52:50 vlana kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 27 11:52:50 vlana kernel: hda: max request size: 128KiB
Nov 27 11:52:50 vlana kernel: hda: 23579136 sectors (12072 MB), 
CHS=23392/16/63, UDMA(33)
Nov 27 11:52:50 vlana kernel:  hda: hda1 hda2 hda3
Nov 27 11:52:50 vlana kernel: hdc: ATAPI 24X CD-ROM drive, 128kB Cache, 
UDMA(33)
Nov 27 11:52:50 vlana kernel: Uniform CD-ROM driver Revision: 3.12
Nov 27 11:52:50 vlana kernel: PCI: IRQ 0 for device 0000:00:0a.0 
doesn't match PIRQ mask - try pci=usepirqmask
Nov 27 11:52:50 vlana kernel: PCI: Assigned IRQ 11 for device 
0000:00:0a.0
Nov 27 11:52:50 vlana kernel: PCI: Sharing IRQ 11 with 0000:00:0a.1
Nov 27 11:52:50 vlana kernel: Yenta: CardBus bridge found at 
0000:00:0a.0 [104c:ac1c]
Nov 27 11:52:50 vlana kernel: Yenta: Enabling burst memory read 
transactions
Nov 27 11:52:50 vlana kernel: Yenta: Using CSCINT to route CSC 
interrupts to PCI
Nov 27 11:52:50 vlana kernel: Yenta: Routing CardBus interrupts to PCI
Nov 27 11:52:50 vlana kernel: Yenta: ISA IRQ list 04b8, PCI irq11
Nov 27 11:52:50 vlana kernel: Socket status: 30000010
Nov 27 11:52:50 vlana kernel: PCI: Found IRQ 11 for device 0000:00:0a.1
Nov 27 11:52:50 vlana kernel: PCI: Sharing IRQ 11 with 0000:00:0a.0
Nov 27 11:52:50 vlana kernel: Yenta: CardBus bridge found at 
0000:00:0a.1 [104c:ac1c]
Nov 27 11:52:50 vlana kernel: Yenta: Using CSCINT to route CSC 
interrupts to PCI
Nov 27 11:52:50 vlana kernel: Yenta: Routing CardBus interrupts to PCI
Nov 27 11:52:50 vlana kernel: Yenta: ISA IRQ list 04b8, PCI irq11
Nov 27 11:52:50 vlana kernel: Socket status: 30000006
Nov 27 11:52:50 vlana kernel: drivers/usb/host/uhci-hcd.c: USB 
Universal Host Controller Interface driver v2.1
Nov 27 11:52:50 vlana kernel: PCI: Found IRQ 9 for device 0000:00:07.2
Nov 27 11:52:50 vlana kernel: uhci_hcd 0000:00:07.2: UHCI Host 
Controller
Nov 27 11:52:50 vlana kernel: uhci_hcd 0000:00:07.2: irq 9, io base 
0000e800
Nov 27 11:52:50 vlana kernel: uhci_hcd 0000:00:07.2: new USB bus 
registered, assigned bus number 1
Nov 27 11:52:50 vlana kernel: hub 1-0:1.0: USB hub found
Nov 27 11:52:50 vlana kernel: hub 1-0:1.0: 2 ports detected
Nov 27 11:52:50 vlana kernel: drivers/usb/core/usb.c: registered new 
driver usblp
Nov 27 11:52:50 vlana kernel: drivers/usb/class/usblp.c: v0.13: USB 
Printer Device Class driver
Nov 27 11:52:50 vlana kernel: Initializing USB Mass Storage driver...
Nov 27 11:52:50 vlana kernel: drivers/usb/core/usb.c: registered new 
driver usb-storage
Nov 27 11:52:50 vlana kernel: USB Mass Storage support registered.
Nov 27 11:52:50 vlana kernel: drivers/usb/core/usb.c: registered new 
driver hid
Nov 27 11:52:50 vlana kernel: drivers/usb/input/hid-core.c: v2.0:USB 
HID core driver
Nov 27 11:52:50 vlana kernel: mice: PS/2 mouse device common for all 
mice
Nov 27 11:52:50 vlana kernel: Synaptics Touchpad, model: 1
Nov 27 11:52:50 vlana kernel:  Firmware: 4.0
Nov 27 11:52:50 vlana kernel:  Sensor: 1
Nov 27 11:52:50 vlana kernel:  new absolute packet format
Nov 27 11:52:50 vlana kernel: input: SynPS/2 Synaptics TouchPad on 
isa0060/serio1
Nov 27 11:52:50 vlana kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Nov 27 11:52:50 vlana kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
Nov 27 11:52:50 vlana kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov 27 11:52:50 vlana kernel: Advanced Linux Sound Architecture Driver 
Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
Nov 27 11:52:50 vlana kernel: PCI: Found IRQ 9 for device 0000:00:09.0
Nov 27 11:52:50 vlana kernel: PCI: Sharing IRQ 9 with 0000:00:0c.0
Nov 27 11:52:50 vlana kernel: es1968: not attempting power management.
Nov 27 11:52:50 vlana kernel: es1968: clocking to 48000
Nov 27 11:52:50 vlana kernel: ALSA device list:
Nov 27 11:52:50 vlana kernel:   #0: ESS ES1978 (Maestro 2E) at 0xea00, 
irq 9
Nov 27 11:52:50 vlana kernel: NET: Registered protocol family 2
Nov 27 11:52:50 vlana kernel: IP: routing cache hash table of 512 
buckets, 4Kbytes
Nov 27 11:52:50 vlana kernel: TCP: Hash tables configured (established 
8192 bind 16384)
Nov 27 11:52:50 vlana kernel: NET: Registered protocol family 1
Nov 27 11:52:50 vlana kernel: NET: Registered protocol family 17
Nov 27 11:52:50 vlana kernel: VFS: Mounted root (ext2 filesystem) 
readonly.
Nov 27 11:52:50 vlana kernel: Freeing unused kernel memory: 128k freed
Nov 27 11:52:50 vlana kernel: Adding 979956k swap on /dev/hda2.  
Priority:-1 extents:1
Nov 27 11:52:51 vlana kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Nov 27 11:52:51 vlana kernel: cs: IO port probe 0x0800-0x08ff: clean.
Nov 27 11:52:51 vlana kernel: cs: IO port probe 0x0100-0x04ff: 
excluding 0x100-0x107 0x3c0-0x3df 0x400-0x44f 0x4d0-0x4d7
Nov 27 11:52:51 vlana kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Nov 27 11:52:51 vlana kernel: cs: memory probe 0xa0000000-0xa0ffffff: 
clean.
Nov 27 11:52:51 vlana kernel: eth0: NE2000 Compatible: io 0x300, irq 3, 
hw_addr 00:E0:98:92:E1:A0
Nov 27 11:52:52 vlana lpd[260]: restarted
Nov 27 11:53:25 vlana kernel: Synaptics Touchpad, model: 1
Nov 27 11:53:25 vlana kernel:  Firmware: 4.0
Nov 27 11:53:25 vlana kernel:  Sensor: 1
Nov 27 11:53:25 vlana kernel:  new absolute packet format
Nov 27 11:53:25 vlana kernel: hdc: start_power_step(step: 0)
Nov 27 11:53:25 vlana kernel: hdc: completing PM request, suspend
Nov 27 11:53:25 vlana kernel: hda: start_power_step(step: 0)
Nov 27 11:53:25 vlana kernel: hda: start_power_step(step: 1)
Nov 27 11:53:26 vlana kernel: hda: complete_power_step(step: 1, stat: 
50, err: 0)
Nov 27 11:53:26 vlana kernel: hda: completing PM request, suspend
Nov 27 11:53:41 vlana kernel: hub 1-0:1.0: new USB device on port 1, 
assigned address 2
Nov 27 11:53:42 vlana kernel: hda: Wakeup request inited, waiting for 
!BSY...
Nov 27 11:53:42 vlana kernel: hda: start_power_step(step: 1000)
Nov 27 11:53:42 vlana kernel: blk: queue c119b400, I/O limit 4095Mb 
(mask 0xffffffff)
Nov 27 11:53:42 vlana kernel: hda: completing PM request, resume
Nov 27 11:53:42 vlana kernel: hdc: Wakeup request inited, waiting for 
!BSY...
Nov 27 11:53:42 vlana kernel: hdc: start_power_step(step: 1000)
Nov 27 11:53:42 vlana kernel: hdc: completing PM request, resume
Nov 27 11:53:42 vlana kernel: Synaptics Touchpad, model: 1
Nov 27 11:53:42 vlana kernel:  Firmware: 4.0
Nov 27 11:53:42 vlana kernel:  Sensor: 1
Nov 27 11:53:42 vlana kernel:  new absolute packet format
Nov 27 11:53:47 vlana kernel: usb 1-1: control timeout on ep0out
Nov 27 11:53:47 vlana kernel: uhci_hcd 0000:00:07.2: Unlink after 
no-IRQ?  Different ACPI or APIC settings may help.
Nov 27 11:55:03 vlana kernel: Synaptics Touchpad, model: 1
Nov 27 11:55:03 vlana kernel:  Firmware: 4.0
Nov 27 11:55:03 vlana kernel:  Sensor: 1
Nov 27 11:55:03 vlana kernel:  new absolute packet format
Nov 27 11:55:03 vlana kernel: hdc: start_power_step(step: 0)
Nov 27 11:55:03 vlana kernel: hdc: completing PM request, suspend
Nov 27 11:55:03 vlana kernel: hda: start_power_step(step: 0)
Nov 27 11:55:03 vlana kernel: hda: start_power_step(step: 1)
Nov 27 11:55:04 vlana kernel: hda: complete_power_step(step: 1, stat: 
50, err: 0)
Nov 27 11:55:04 vlana kernel: hda: completing PM request, suspend
Nov 27 11:55:27 vlana kernel: hda: Wakeup request inited, waiting for 
!BSY...
Nov 27 11:55:27 vlana kernel: hda: start_power_step(step: 1000)
Nov 27 11:55:27 vlana kernel: blk: queue c119b400, I/O limit 4095Mb 
(mask 0xffffffff)
Nov 27 11:55:27 vlana kernel: hda: completing PM request, resume
Nov 27 11:55:27 vlana kernel: hdc: Wakeup request inited, waiting for 
!BSY...
Nov 27 11:55:27 vlana kernel: hdc: start_power_step(step: 1000)
Nov 27 11:55:27 vlana kernel: hdc: completing PM request, resume
Nov 27 11:55:27 vlana kernel: Synaptics Touchpad, model: 1
Nov 27 11:55:27 vlana kernel:  Firmware: 4.0
Nov 27 11:55:27 vlana kernel:  Sensor: 1
Nov 27 11:55:27 vlana kernel:  new absolute packet format

After this procedure the attached usb mouse seems to be dead.  See 
/proc/bus/usb/devices before suspend:

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test10 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:07.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c00c Rev= 6.20
S:  Manufacturer=Logitech
S:  Product=USB Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

And afterwards:

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test10 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:07.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 0.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 0 #Cfgs=  0
P:  Vendor=0000 ProdID=0000 Rev= 0.00

When I tried this under XFree86 I observed tow different behaviours:

1) XFree seemed to be freezed totally
2)
  * USB mouse didn't work
  * Touchpad worked
  * anything else seemed to work fine


[3.] Keywords (i.e., modules, networking, kernel):
usb, mouse, synaptics touchpad


[4.] Kernel version (from /proc/version):
Linux version 2.6.0-test10 (root@vlana) (gcc version 3.3.2 (Debian)) #2 
Tue Nov 25 14:19:42 CET 2003


[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)


[6.] A small shell script or example program which triggers the
      problem (if possible)


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 228.521
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse
bogomips	: 1187.84


[7.3.] Module information (from /proc/modules):
(empty)

[7.4.] Loaded driver and hardware information (/proc/ioports, 
/proc/iomem)
ioports:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0300-031f : pcnet_cs
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03e8-03ef : serial
03f6-03f6 : ide0
03f8-03ff : serial
0400-043f : 0000:00:07.3
0440-045f : 0000:00:07.3
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #06
4c00-4cff : PCI CardBus #06
b000-cfff : PCI Bus #01
   c800-c8ff : 0000:01:00.0
e800-e81f : 0000:00:07.2
   e800-e81f : uhci_hcd
ea00-eaff : 0000:00:09.0
   ea00-eaff : ESS Maestro
ec00-ecff : 0000:00:0c.0
ee00-ee07 : 0000:00:0c.0
ffa0-ffaf : 0000:00:07.1
   ffa0-ffa7 : ide0
   ffa8-ffaf : ide1

iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
   00100000-002e2e92 : Kernel code
   002e2e93-00397ebf : Kernel data
07ff0000-07ff7fff : ACPI Tables
07ff8000-07ffffff : ACPI Non-volatile Storage
10000000-10000fff : 0000:00:0a.0
   10000000-10000fff : yenta_socket
10001000-10001fff : 0000:00:0a.1
   10001000-10001fff : yenta_socket
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
a0000000-a0000fff : card services
e0000000-e3ffffff : 0000:00:00.0
fca00000-feafffff : PCI Bus #01
   fd000000-fdffffff : 0000:01:00.0
   feaff000-feafffff : 0000:01:00.0
febfff00-febfffff : 0000:00:0c.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ff900000-ff9fffff : PCI Bus #01
fffe0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- 
FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000b000-0000cfff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: ff900000-ff9fffff
	BridgeCtl: Parity+ SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at e800 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E 
(rev 10)
	Subsystem: ESS Technology: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at ea00 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Texas Instruments PCI1225
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Texas Instruments PCI1225
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.0 Communication controller: Lucent Microelectronics WinModem 56k 
(rev 01)
	Subsystem: AMBIT Microsystem Corp.: Unknown device 0440
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at febfff00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at ee00 [size=8]
	Region 2: I/O ports at ec00 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro 
AGP-133 (rev dc) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage LT Pro AGP 2X
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size: 0x04 (16 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at c800 [size=256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- 
FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
(does not exist)

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

The message that showd up in /var(log/messages when XFree freezed 
totally:
Nov 26 22:26:27 vlana kernel: Synaptics driver lost sync at 1st byte

This showed up in all my terminal emulators after the suspend process:
vlana kernel: Bank 1: e2000000000000f1

/proc/bus/input/devices:
I: Bus=0011 Vendor=0002 Product=0007 Version=0000
N: Name="SynPS/2 Synaptics TouchPad"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0
B: EV=b
B: KEY=6420 0 670000 0 0 0 0 0 0 0 0
B: ABS=11000003

I: Bus=0011 Vendor=0001 Product=0002 Version=ab02
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd
B: EV=120003
B: KEY=4 2200000 c061f9 fbc9d621 efdfffdf ffefffff ffffffff fffffffe
B: LED=7

/proc/bus/input/handlers:
N: Number=0 Name=kbd
N: Number=1 Name=mousedev Minor=32

[X.] Other notes, patches, fixes, workarounds:
I'm no kernel hacker => ...


I hope this report helps you somehow.

As I'm not on the mailing list please CC me for comments / questions!

Regards,
	Titus von der Malsburg

___
Blaise Pascal: "I apologize for this long letter. I didn't have the 
time to  make it any shorter."

