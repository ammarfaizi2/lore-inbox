Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVEZLXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVEZLXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 07:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVEZLXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 07:23:06 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:7125 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261309AbVEZLWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 07:22:35 -0400
Message-ID: <4295B16E.5010400@snacksy.com>
Date: Thu, 26 May 2005 13:22:22 +0200
From: jan malstrom <xanon@snacksy.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OOPS] snd_intel8x0m
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oopses right after loading as module

2.6.12-rc4-mm2 ran fine



Unable to handle kernel paging request at virtual address 00008050
c042ca7c
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c042ca7c>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282   (2.6.12-rc5-mm1)
eax: 00007fac   ebx: da89f0c0   ecx: db4e7b40   edx: c042ca70
esi: daf1eb18   edi: daf1eb18   ebp: db00ff1c   esp: db00ff1c
ds: 007b   es: 007b   ss: 0068
Stack: db00ff38 c014ca7e daf1eb18 da89f0c0 df3e9898 daf1eb18 df0d3280 
db00ff54
        c014e272 daf1eb18 000800fb da89f0c0 fffffff8 00000000 db00ff6c 
c014e29f
        df0d3280 daf1eb18 b760e000 b7606000 db00ff98 c014e65d df0d3280 
daf1eb18
Call Trace:
  [<c0103e6f>] show_stack+0x7f/0xa0
  [<c0104017>] show_registers+0x157/0x1c0
  [<c0104208>] die+0xc8/0x140
  [<c0116ba9>] do_page_fault+0x349/0x6cd
  [<c0103abf>] error_code+0x4f/0x54
  [<c014ca7e>] remove_vm_struct+0x6e/0x70
  [<c014e272>] unmap_vma+0x62/0x70
  [<c014e29f>] unmap_vma_list+0x1f/0x30
  [<c014e65d>] do_munmap+0x10d/0x150
  [<c014e6e3>] sys_munmap+0x43/0x70
  [<c0103039>] syscall_call+0x7/0xb
Code: 89 e5 8b 45 08 8b 40 50 8b 40 60 ff 80 a4 00 00 00 5d c3 8d b6 
00 00 00 00 8d bf 00 00 00 00 55 89 e5 8b 45 08 8b 40 50 8b 40 60 <ff> 
88 a4 00 00 00 5d c3 51 52 e8 95 4c 0a 00 5a 59 e9 d2 bd ff


 >>EIP; c042ca7c <snd_pcm_mmap_data_close+c/14>   <=====

 >>ebx; da89f0c0 <pg0+1a1ec0c0/3f94b400>
 >>ecx; db4e7b40 <pg0+1ae34b40/3f94b400>
 >>edx; c042ca70 <snd_pcm_mmap_data_close+0/14>
 >>esi; daf1eb18 <pg0+1a86bb18/3f94b400>
 >>edi; daf1eb18 <pg0+1a86bb18/3f94b400>
 >>ebp; db00ff1c <pg0+1a95cf1c/3f94b400>
 >>esp; db00ff1c <pg0+1a95cf1c/3f94b400>

Trace; c0103e6f <show_stack+7f/a0>
Trace; c0104017 <show_registers+157/1c0>
Trace; c0104208 <die+c8/140>
Trace; c0116ba9 <do_page_fault+349/6cd>
Trace; c0103abf <error_code+4f/54>
Trace; c014ca7e <remove_vm_struct+6e/70>
Trace; c014e272 <unmap_vma+62/70>
Trace; c014e29f <unmap_vma_list+1f/30>
Trace; c014e65d <do_munmap+10d/150>
Trace; c014e6e3 <sys_munmap+43/70>
Trace; c0103039 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c042ca51 <snd_pcm_mmap_data_open+1/20>
00000000 <_EIP>:
Code;  c042ca51 <snd_pcm_mmap_data_open+1/20>
    0:   89 e5                     mov    %esp,%ebp
Code;  c042ca53 <snd_pcm_mmap_data_open+3/20>
    2:   8b 45 08                  mov    0x8(%ebp),%eax
Code;  c042ca56 <snd_pcm_mmap_data_open+6/20>
    5:   8b 40 50                  mov    0x50(%eax),%eax
Code;  c042ca59 <snd_pcm_mmap_data_open+9/20>
    8:   8b 40 60                  mov    0x60(%eax),%eax
Code;  c042ca5c <snd_pcm_mmap_data_open+c/20>
    b:   ff 80 a4 00 00 00         incl   0xa4(%eax)
Code;  c042ca62 <snd_pcm_mmap_data_open+12/20>
   11:   5d                        pop    %ebp
Code;  c042ca63 <snd_pcm_mmap_data_open+13/20>
   12:   c3                        ret
Code;  c042ca64 <snd_pcm_mmap_data_open+14/20>
   13:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c042ca6a <snd_pcm_mmap_data_open+1a/20>
   19:   8d bf 00 00 00 00         lea    0x0(%edi),%edi
Code;  c042ca70 <snd_pcm_mmap_data_close+0/14>
   1f:   55                        push   %ebp
Code;  c042ca71 <snd_pcm_mmap_data_close+1/14>
   20:   89 e5                     mov    %esp,%ebp
Code;  c042ca73 <snd_pcm_mmap_data_close+3/14>
   22:   8b 45 08                  mov    0x8(%ebp),%eax
Code;  c042ca76 <snd_pcm_mmap_data_close+6/14>
   25:   8b 40 50                  mov    0x50(%eax),%eax
Code;  c042ca79 <snd_pcm_mmap_data_close+9/14>
   28:   8b 40 60                  mov    0x60(%eax),%eax

This decode from eip onwards should be reliable

Code;  c042ca7c <snd_pcm_mmap_data_close+c/14>
00000000 <_EIP>:
Code;  c042ca7c <snd_pcm_mmap_data_close+c/14>   <=====
    0:   ff 88 a4 00 00 00         decl   0xa4(%eax)   <=====
Code;  c042ca82 <snd_pcm_mmap_data_close+12/14>
    6:   5d                        pop    %ebp
Code;  c042ca83 <snd_pcm_mmap_data_close+13/14>
    7:   c3                        ret
Code;  c042ca84 <.text.lock.pcm_native+0/1ac>
    8:   51                        push   %ecx
Code;  c042ca85 <.text.lock.pcm_native+1/1ac>
    9:   52                        push   %edx
Code;  c042ca86 <.text.lock.pcm_native+2/1ac>
    a:   e8 95 4c 0a 00            call   a4ca4 <_EIP+0xa4ca4>
Code;  c042ca8b <.text.lock.pcm_native+7/1ac>
    f:   5a                        pop    %edx
Code;  c042ca8c <.text.lock.pcm_native+8/1ac>
   10:   59                        pop    %ecx
Code;  c042ca8d <.text.lock.pcm_native+9/1ac>
   11:   e9                        .byte 0xe9
Code;  c042ca8e <.text.lock.pcm_native+a/1ac>
   12:   d2                        .byte 0xd2
Code;  c042ca8f <.text.lock.pcm_native+b/1ac>
   13:   bd                        .byte 0xbd
Code;  c042ca90 <.text.lock.pcm_native+c/1ac>
   14:   ff                        .byte 0xff


-------------------------------------------------------------------------------------
Linux version 2.6.12-rc5-mm1 (root@hades) (gcc version 3.3.6 (Debian 
1:3.3.6-5)) #45 Thu May 26 12:52:56 CEST 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001ffd0000 (usable)
  BIOS-e820: 000000001ffd0000 - 000000001fff0c00 (reserved)
  BIOS-e820: 000000001fff0c00 - 000000001fffc000 (ACPI NVS)
  BIOS-e820: 000000001fffc000 - 0000000020000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131024
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 126928 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f6560
ACPI: RSDT (v001 HP     CPQ0860  0x20040520 CPQ  0x00000001) @ 0x1fff0c84
ACPI: FADT (v002 HP     CPQ0860  0x00000002 CPQ  0x00000001) @ 0x1fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000e) @ 0x1fff5c3c
ACPI: DSDT (v001 HP       nx7000 0x00010000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 20000000 (gap: 20000000:e0000000)
Built 1 zonelists
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01401000)
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=Linux ro root=301 nmi_watchdog=1 
splash=silent
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1395.688 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 512764k/524096k available (3913k kernel code, 10776k reserved, 
1354k data, 188k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
Calibrating delay using timer specific routine.. 2792.51 BogoMIPS 
(lpj=1396259)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 
0000018000000000 00000000
CPU: After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000 
00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 
00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c20)
softlockup thread 0 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C046] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C046] segment is 0
ACPI: Assume root bridge [\_SB_.C046] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.C046._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C046.C047._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C046.C058._PRT]
ACPI: Embedded Controller [C0EA] (gpe 28)
ACPI: Power Resource [C18D] (on)
ACPI: Power Resource [C195] (on)
ACPI: Power Resource [C19C] (on)
ACPI: Power Resource [C1A6] (on)
ACPI: PCI Interrupt Link [C0C2] (IRQs 5 *10)
ACPI: PCI Interrupt Link [C0C3] (IRQs 5 *10)
ACPI: PCI Interrupt Link [C0C4] (IRQs *5 10)
ACPI: PCI Interrupt Link [C0C5] (IRQs *5 10)
ACPI: PCI Interrupt Link [C0C6] (IRQs 5 10) *0, disabled.
ACPI: PCI Interrupt Link [C0C7] (IRQs 5 10) *11
ACPI: PCI Interrupt Link [C0C8] (IRQs 5 10) *0, disabled.
ACPI: PCI Interrupt Link [C0C9] (IRQs *5 10)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post 
a report
inotify device minor=63
NTFS driver 2.1.23-WIP [Flags: R/W].
SGI XFS with no debug enabled
Initializing Cryptographic API
ACPI: AC Adapter [C134] (on-line)
ACPI: Battery Slot [C11F] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [C1BE]
ACPI: Lid Switch [C136]
ACPI: Video Device [C0D0] (multi-head: yes  rom: no  post: no)
Disabling BM access before entering C3
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
cn_fork is registered
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [C0C3] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
NET: Registered protocol family 24
8139too Fast Ethernet driver 0.9.27
8139too: pci dev 0000:02:01.0 (id 10ec:8139 rev 20) is an enhanced 
8139C+ chip
8139too: Use the "8139cp" driver for improved performance and stability.
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
8139too: 0000:02:01.0: unknown chip version, assuming RTL-8139
8139too: 0000:02:01.0: TxConfig = 0x74800000
eth0: RealTek RTL8139 at 0x2000, 00:02:3f:65:86:5c, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [C0C4] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0C4] -> GSI 5 (level, 
low) -> IRQ5
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x4c40-0x4c47, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x4c48-0x4c4f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK4021GAS, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SD-R2312, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
  hda: hda1 hda2
ide-disk: probe of 1.0 failed with error 1
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [C0C2] enabled at IRQ 10
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10] 
MMIO=[90200000-902007ff]  Max Packet=[2048]
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C4] -> GSI 5 (level, 
low) -> IRQ5
Yenta: CardBus bridge found at 0000:02:04.0 [0e11:0860]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:04.0, mfunc 0x001c1112, devctl 0x44
Yenta: ISA IRQ mask 0x0000, PCI irq 5
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
cs: IO port probe 0x2000-0x2fff: clean.
pcmcia: parent PCI bridge Memory window: 0x90000000 - 0x903fffff
ACPI: PCI Interrupt Link [C0C9] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [C0C9] -> GSI 5 (level, 
low) -> IRQ5
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) 
USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 5, io mem 0xa0000000
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 10, io base 0x000048c0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [C0C5] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0C5] -> GSI 5 (level, 
low) -> IRQ5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 5, io base 0x000048e0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0C4] -> GSI 5 (level, 
low) -> IRQ5
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 5, io base 0x00004c00
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb 2-2: new low speed USB device using uhci_hcd and address 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:1d.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.2
wbsd: Copyright(c) Pierre Ossman
mmc0: W83L51xD id 7112 at 0x248 irq 6 dma 2
Advanced Linux Sound Architecture Driver Version 1.0.9rc3  (Thu Mar 24 
10:33:392005 UTC).
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
input: AT Translated Set 2 keyboard on isa0060/serio0
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f39380016aa]
Synaptics Touchpad, model: 1
  Firmware: 5.9
  Sensor: 35
  new absolute packet format
  Touchpad has extended capability bits
  -> multifinger detection
  -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
intel8x0_measure_ac97_clock: measured 49391 usecs
intel8x0: clocking to 48000
ALSA device list:
   #0: Intel 82801DB-ICH4 with AD1981B at 0xa0200000, irq 10
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4094 buckets, 32752 max) - 208 bytes per 
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Testing NMI watchdog ... CPU#0: NMI appears to be stuck!
ACPI wakeup devices:
C058 C1AD C1A3 C1A4 C0AC C0B3 C0B4 C0B5 C0E7 C136
ACPI: (supports S0 S3 S4 S4bios S5)
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first 
block 18,max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: replayed 7 transactions in 0 seconds
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 188k freed
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

-------------------------------------------------------------------------------------
#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

