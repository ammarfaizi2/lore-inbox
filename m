Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVGOLnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVGOLnb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVGOLna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:43:30 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:50636 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261442AbVGOLnW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:43:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YzCAawmTHq/dzasphEkXvw8vfmeQA+Aj2EqR4m3PTjyHpT+iSdg3/HQEpJF+QjpvF4zBM3eMSbUN3xr44gF26qcLWXOokNHL29loTHO2LHSZO7VlPImPDKtPMRUPO6KvP1cZ7DGQwyn0JfF+GVUEBYdR09ysje6kj4guCMpElG8=
Message-ID: <105c793f0507150443b1e8359@mail.gmail.com>
Date: Fri, 15 Jul 2005 07:43:21 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: PS/2 Keyboard is dead after resume.
Cc: linux-kernel@vger.kernel.org,
       suspend2-users <suspend2-users@lists.suspend2.net>
In-Reply-To: <200507150024.46293.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <105c793f0507141935403fc828@mail.gmail.com>
	 <200507150024.46293.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> Could you try doing:
> 
>         echo 1 > /sys/modules/i8042/parameters/debug
> 
> before suspending and the post your dmesg, please? Maybe we see something
> there.
Here you go:

12) *0, disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *15, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs *21)
ACPI: PCI Interrupt Link [ALKC] (IRQs *22)
ACPI: PCI Interrupt Link [ALKD] (IRQs *23), disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1121412889.356:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (29 C)
lp: driver loaded but no devices found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKC] -> GSI 10 (level,
low) -> IRQ 10
eth0: RealTek RTL8139 at 0xc400, 00:30:1b:3d:91:ee, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
eth1: Lite-On PNIC-II rev 37 at 0001c000, 00:C0:F0:70:43:C6, IRQ 11.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.0
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKA] -> GSI 12 (level,
low) -> IRQ 12
PCI: Via IRQ fixup for 0000:00:0f.0, from 255 to 12
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.0
    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IBM-DTLA-307015, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: WDC WD102BA, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 29336832 sectors (15020 MB) w/1916KiB Cache, CHS=29104/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2
hdc: max request size: 128KiB
hdc: 20028960 sectors (10254 MB) w/2048KiB Cache, CHS=19870/16/63, UDMA(66)
hdc: cache flushes not supported
 hdc: hdc1
ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [LNKC] -> GSI 10 (level,
low) -> IRQ 10
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 10, io mem 0xee043000
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 12 (level,
low) -> IRQ 12
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 12, io base 0x0000d000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [LNKA] -> GSI 12 (level,
low) -> IRQ 12
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (#2)
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 12, io base 0x0000d400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (#3)
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 11, io base 0x0000d800
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (#4)
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 11, io base 0x0000dc00
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
mice: PS/2 mouse device common for all mice
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (3967 buckets, 31736 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
Software Suspend Core.
Software Suspend Compression Driver loading.
Software Suspend Encryption Driver loading.
Software Suspend Swap Writer loading.
Software Suspend FileWriter loading.
ACPI wakeup devices: 
SLPB PCI0 USB0 USB1 USB2 USB6 USB7 USB8 USB9 UAR1 LPT1 
ACPI: (supports S0 S1 S4 S5)
Resume block device is defe0ba0.
Software Suspend 2.1.9.9: Swapwriter: Signature found.
Software Suspend 2.1.9.9: Suspending enabled.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 156k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
input: AT Translated Set 2 keyboard on isa0060/serio0
Adding 1951856k swap on /dev/hda1.  Priority:-1 extents:1
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
eth1: no IPv6 routers present
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, KBD, 1) [113165]
drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, KBD, 1) [113205]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, KBD, 1) [113282]
drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, KBD, 1) [113322]
drivers/input/serio/i8042.c: 0e <- i8042 (interrupt, KBD, 1) [113544]
drivers/input/serio/i8042.c: 8e <- i8042 (interrupt, KBD, 1) [113582]
drivers/input/serio/i8042.c: 0e <- i8042 (interrupt, KBD, 1) [113653]
drivers/input/serio/i8042.c: 8e <- i8042 (interrupt, KBD, 1) [113717]
drivers/input/serio/i8042.c: 13 <- i8042 (interrupt, KBD, 1) [113798]
drivers/input/serio/i8042.c: 93 <- i8042 (interrupt, KBD, 1) [113912]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, KBD, 1) [113929]
drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, KBD, 1) [113975]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, KBD, 1) [114023]
drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, KBD, 1) [114113]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, KBD, 1) [114140]
drivers/input/serio/i8042.c: 94 <- i8042 (interrupt, KBD, 1) [114236]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [114352]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, KBD, 1) [114482]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, KBD, 1) [114559]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, KBD, 1) [114644]
drivers/input/serio/i8042.c: 2d <- i8042 (interrupt, KBD, 1) [114773]
drivers/input/serio/i8042.c: ad <- i8042 (interrupt, KBD, 1) [114859]
drivers/input/serio/i8042.c: 26 <- i8042 (interrupt, KBD, 1) [114864]
drivers/input/serio/i8042.c: a6 <- i8042 (interrupt, KBD, 1) [114958]
drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, KBD, 1) [114970]
drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, KBD, 1) [115051]
drivers/input/serio/i8042.c: 06 <- i8042 (interrupt, KBD, 1) [115298]
drivers/input/serio/i8042.c: 86 <- i8042 (interrupt, KBD, 1) [115397]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, KBD, 1) [115440]
drivers/input/serio/i8042.c: 82 <- i8042 (interrupt, KBD, 1) [115494]
drivers/input/serio/i8042.c: 09 <- i8042 (interrupt, KBD, 1) [115543]
drivers/input/serio/i8042.c: 89 <- i8042 (interrupt, KBD, 1) [115636]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, KBD, 1) [115645]
drivers/input/serio/i8042.c: 82 <- i8042 (interrupt, KBD, 1) [115706]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [115787]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, KBD, 1) [115876]
drivers/input/serio/i8042.c: 23 <- i8042 (interrupt, KBD, 1) [116475]
drivers/input/serio/i8042.c: a3 <- i8042 (interrupt, KBD, 1) [116570]
drivers/input/serio/i8042.c: 17 <- i8042 (interrupt, KBD, 1) [116580]
drivers/input/serio/i8042.c: 97 <- i8042 (interrupt, KBD, 1) [116656]
drivers/input/serio/i8042.c: 30 <- i8042 (interrupt, KBD, 1) [116726]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, KBD, 1) [116794]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, KBD, 1) [116848]
drivers/input/serio/i8042.c: 13 <- i8042 (interrupt, KBD, 1) [116866]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, KBD, 1) [116893]
drivers/input/serio/i8042.c: 93 <- i8042 (interrupt, KBD, 1) [116933]
drivers/input/serio/i8042.c: 31 <- i8042 (interrupt, KBD, 1) [117035]
drivers/input/serio/i8042.c: 1e <- i8042 (interrupt, KBD, 1) [117100]
drivers/input/serio/i8042.c: b1 <- i8042 (interrupt, KBD, 1) [117127]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, KBD, 1) [117174]
drivers/input/serio/i8042.c: 9e <- i8042 (interrupt, KBD, 1) [117217]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, KBD, 1) [117241]
drivers/input/serio/i8042.c: 94 <- i8042 (interrupt, KBD, 1) [117305]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, KBD, 1) [117361]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [117486]
Resume block device is defe0860.
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, KBD, 1) [117557]
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Resume block device is defe0860.
Software Suspend 2.1.9.9: Initiating a software suspend cycle.
Resume block device is defe0860.
Software Suspend 2.1.9.9: Swapwriter: Signature found.
Software Suspend 2.1.9.9: Suspending enabled.
20%...40%...60%...80%...100%...done.
drivers/input/serio/i8042.c: 60 -> i8042 (command) [119932]
drivers/input/serio/i8042.c: 65 -> i8042 (parameter) [119932]
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKA] -> GSI 12 (level,
low) -> IRQ 12
PCI: Via IRQ fixup for 0000:00:0f.0, from 255 to 12
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 12 (level,
low) -> IRQ 12
ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [LNKA] -> GSI 12 (level,
low) -> IRQ 12
ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [LNKC] -> GSI 10 (level,
low) -> IRQ 10
ehci_hcd 0000:00:10.4: USB 2.0 restarted, EHCI 1.00, driver 10 Dec 2004
drivers/input/serio/i8042.c: 60 -> i8042 (command) [154857]
drivers/input/serio/i8042.c: 65 -> i8042 (parameter) [154857]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [154857]
drivers/input/serio/i8042.c: 65 -> i8042 (parameter) [154857]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [154857]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [154857]
drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [154857]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154860]
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, KBD, 1) [154861]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, KBD, 1) [154862]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [154862]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154865]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [154865]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154867]
drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [154867]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154870]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [154870]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154873]
drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [154873]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154876]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [154876]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154879]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [154879]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154881]
20%...40%...60%...80%...100%...done.
drivers/input/serio/i8042.c: 60 -> i8042 (command) [155414]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [155414]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [155414]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [155414]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [155417]
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
might be trying access hardware directly.
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, KBD, 1) [155418]
Please include the following information in bug reports:
- SUSPEND core   : 2.1.9.9
- Kernel Version : 2.6.12.2
- Compiler vers. : 3.3
- Attempt number : 1
- Pageset sizes  : 4186 (4186 low) and 6726 (6726 low).
- Parameters     : 0 32 0 1 0 5
- Calculations   : Image size: 11117. Ram to suspend: 2240.
- Limits         : 126960 pages RAM. Initial boot: 123843.
- Overall expected compression percentage: 0.
- Compressor lzf enabled.
  Compressed 44695552 bytes into 19230393 (56 percent compression).
- Swapwriter active.
  Swap available for image: 487964 pages.
- Filewriter inactive.
- Preemptive kernel.
- Max extents used: 4
- I/O speed: Write 78 MB/s, Read 52 MB/s.
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, KBD, 1) [155419]
Resume block device is defe0860.
Real Time Clock Driver v1.12
drivers/input/serio/i8042.c: d4 -> i8042 (command) [155614]
drivers/input/serio/i8042.c: ed -> i8042 (parameter) [155614]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [155616]
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
might be trying access hardware directly.
drivers/input/serio/i8042.c: 60 -> i8042 (command) [155814]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [155814]

Thanks.

-Andy
