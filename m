Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272502AbTHKKPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 06:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272503AbTHKKPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 06:15:45 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:34432 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S272502AbTHKKPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 06:15:31 -0400
Date: Mon, 11 Aug 2003 12:15:23 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: ak@suse.de
Cc: kwijibo@zianet.com, Dave Jones <davej@redhat.com>, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org
Subject: Re: Machine check expection panic
Message-ID: <20030811101522.GA8080@vana.vc.cvut.cz>
References: <3F3182B5.3040301@zianet.com.suse.lists.linux.kernel> <20030807002722.GA3579@suse.de.suse.lists.linux.kernel> <p73ekzynuxt.fsf@oldwotan.suse.de> <3F35FE5B.7060003@zianet.com> <20030810130752.GB586@wotan.suse.de> <3F36B341.7@zianet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F36B341.7@zianet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 03:04:01PM -0600, kwijibo@zianet.com wrote:
> Out of curiosity I decided to try this on some other Athlon
> systems I have.  I tried it on a dual Athlon MP 2400(2GHz)
> system with a Tyan 2462 motherboard.  Also I tried it on a
> single Athlon XP 1800 with a Asus A7V motherboard.  They
> both booted fine with the 2.6.0-test2 kernel and the machine
> exception code in it.  So I am thinking either it is something
> with the older CPU's or the CPU is actually borked.  Like I said
> though I have been using those 1.2GHz processors for a long time
> with no problems.

Out of curiosity, I never got MCE on my system at home (last kernel
before one below was 2.6.0-test2, and it did not complain for
different kernels at least since November 2001), yet after recent MCE 
changes I got during fsck:

MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 0: f65980000000baff

System booted these 2.4.x kernels which are supposed to contain
off by one fix, without complaints (first number = no. of boots):

8 Linux version 2.4.20-30 (root@ppc) (gcc version 3.3 (Debian))
1 Linux version 2.4.20-4GB-athlon (root@Athlon.suse.de) (gcc version 3.3 20030226 (prerelease) (SuSE Linux))
4 Linux version 2.4.20-sp (root@ppc) (gcc version 3.3 (Debian))
1 Linux version 2.4.21-0.11mdk (quintela@bi.mandrakesoft.com) (gcc version 3.2.2 (Mandrake Linux 9.1 3.2.2-2mdk))
2 Linux version 2.4.21-0.11mdksecure (quintela@bi.mandrakesoft.com) (gcc version 3.2.2 (Mandrake Linux 9.1 3.2.2-2mdk))
2 Linux version 2.4.21-0.13mdk (quintela@bi.mandrakesoft.com) (gcc version 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
4 Linux version 2.4.21-pre7 (root@ppc) (gcc version 3.2.3 20030331 (Debian prerelease))

Any idea what's going wrong?
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1009.064
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1986.56


Linux version 2.6.0-test3-c1149 (root@ppc) (gcc version 3.3.1 (Debian)) #1 SMP Sun Aug 10 19:42:22 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131052
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126956 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ASUS                       ) @ 0x000f6a90
ACPI: RSDT (v001 ASUS   A7V      12336.12337) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7V      12336.12337) @ 0x1ffec080
ACPI: BOOT (v001 ASUS   A7V      12336.12337) @ 0x1ffec040
ACPI: DSDT (v001   ASUS A7V      00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=2105 video=matrox:vesa:0x117,fv:85 video=matroxfb:vesa:0x117,fv:85 nmi_watchdog=1 devfs=nomount
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1009.064 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1986.56 BogoMIPS
Memory: 514556k/524208k available (2195k kernel code, 8856k reserved, 672k data, 364k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: AMD Athlon(tm) Processor stepping 02
per-CPU timeslice cutoff: 731.16 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
testing NMI watchdog ... OK.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1008.0833 MHz.
..... host bus clock speed is 201.0766 MHz.
Starting migration thread for cpu 0
CPUS done 2
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
matroxfb: Matrox G450 detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x16bpp (virtual: 1024x8190)
matroxfb: framebuffer at 0xCE000000, mapped to 0xe080f000, size 33554432
Console: switching to colour frame buffer device 128x48
fb0: MATROX frame buffer device
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA MK6409MAV, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x8400-0x8407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8408-0x840f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD1200BB-00CAA1, ATA DISK drive
ide2 at 0x9800-0x9807,0x9402 on irq 10
hdh: WDC WD1200BB-00CAA1, ATA DISK drive
ide3 at 0x9000-0x9007,0x8802 on irq 10
hdc: max request size: 128KiB
hdc: 12685680 sectors (6495 MB), CHS=13424/15/63, UDMA(33)
 /dev/ide/host0/bus1/target0/lun0: p1
hde: max request size: 128KiB
hde: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
hdh: max request size: 128KiB
hdh: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host2/bus1/target1/lun0: p1 p2 < p5 p6 >
hda: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
matroxfb_crtc2: secondary head of fb0 was registered as fb1
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:04.2: UHCI Host Controller
uhci-hcd 0000:00:04.2: irq 9, io base 0000d400
uhci-hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 0000:00:04.3: UHCI Host Controller
uhci-hcd 0000:00:04.3: irq 9, io base 0000d000
uhci-hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver module version 2.7.0 (20021208)
oprofile: using NMI interrupt.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 21845)
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 3 devices found
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 364k freed
hub 2-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 2, assigned address 2
hub 2-2:0: USB hub found
hub 2-2:0: 4 ports detected
Adding 1951856k swap on /dev/hde6.  Priority:-1 extents:1
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 0: f65980000000baff
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xa000, IRQ 10, 00:C0:26:30:B0:2D.
