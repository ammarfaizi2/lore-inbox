Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUHXLfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUHXLfn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 07:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUHXLfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 07:35:43 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:28932 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267515AbUHXLfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 07:35:03 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.6.9-rc1 oopses when bringing up eth0
Date: Tue, 24 Aug 2004 13:35:07 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rfyKBKcl1KRczvS"
Message-Id: <200408241335.07243.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_rfyKBKcl1KRczvS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi!

2.6.9-rc1 oopses during boot when trying to bring up the network. It seems 
this oops is related to IPv6 and CONFIG_PREEMPT as can be seen in the 
attached "dmesg" output.

Any ideas?

Thanks!

--Boundary-00=_rfyKBKcl1KRczvS
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.9-rc1 (root@glass.felipe-alfaro.com) (gcc version 3.4.1 2=
0040815 (Red Hat 3.4.1-9)) #1 Tue Aug 24 13:27:44 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 NEC                                       ) @ 0x000fb550
ACPI: RSDT (v001    NEC ND000020 0x00000001 MSFT 0x00000097) @ 0x0fff0000
ACPI: FADT (v001    NEC ND000020 0x00000001 MSFT 0x00000097) @ 0x0fff0030
ACPI: BOOT (v001    NEC ND000020 0x00000001 MSFT 0x00000097) @ 0x0fff00b0
ACPI: DSDT (v001    NEC ND000020 0x00000001 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Built 1 zonelists
Kernel command line: ro root=3D/dev/hda2 resume=3D/dev/hda3 ide-delay=3D2 i=
de2=3Dnoprobe ide3=3Dnoprobe ide4=3Dnoprobe ide5=3Dnoprobe 2
ide_setup: ide-delay=3D2 : Delay set to 2ms
ide_setup: ide2=3Dnoprobe
ide_setup: ide3=3Dnoprobe
ide_setup: ide4=3Dnoprobe
ide_setup: ide5=3Dnoprobe
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 697.214 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255580k/262080k available (2103k kernel code, 5752k reserved, 861k =
data, 116k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1384.44 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        0383f9ff 00000000 00000000 00000040
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [NRTH] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.NRTH._PRT]
ACPI: Embedded Controller [EC0] (gpe 9)
ACPI: Power Resource [PUSB] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 10) *0
ACPI: PCI Interrupt Link [LNKB] (IRQs 5) *0
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 10) *0
ACPI: PCI Interrupt Link [LNKD] (IRQs 9) *0
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:0c.1[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0c.2[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
get_random_bytes called before random driver initialization
Simple Boot Flag at 0x7e set to 0x1
SGI XFS with large block numbers, no debug enabled
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Power Button (CM) [PRB1]
ACPI: Lid Switch [LID0]
ACPI: Fan [FANC] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (64 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 256M @ 0xe0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23BA-20, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8185, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=3D38760/16/63, UDMA(3=
3)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices:=20
MDM0 PRB1 LID0=20
XFS mounting filesystem hda2
Ending clean XFS mount for filesystem: hda2
VFS: Mounted root (xfs filesystem) readonly.
=46reeing unused kernel memory: 116k freed
Adding 289160k swap on /dev/hda3.  Priority:-1 extents:1
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
XFS mounting filesystem hda4
Ending clean XFS mount for filesystem: hda4
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:07.2: irq 9, io base 0000ef80
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using address 2
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse=AE Explorer] o=
n usb-0000:00:07.2-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usb 1-2: new full speed USB device using address 3
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 5 (level, low) -> IRQ 5
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:00:0c.0 [1033:80b6]
yenta 0000:00:0c.0: Preassigned resource 3 busy, reconfiguring...
Yenta: ISA IRQ mask 0x0898, PCI irq 10
Socket status: 30000006
ACPI: PCI interrupt 0000:00:0c.1[B] -> GSI 5 (level, low) -> IRQ 5
Yenta: CardBus bridge found at 0000:00:0c.1 [1033:80b6]
yenta 0000:00:0c.1: Preassigned resource 2 busy, reconfiguring...
yenta 0000:00:0c.1: Preassigned resource 3 busy, reconfiguring...
Yenta: ISA IRQ mask 0x0898, PCI irq 5
Socket status: 30000068
PCI: Enabling device 0000:06:00.0 (0000 -> 0003)
ACPI: PCI interrupt 0000:06:00.0[A] -> GSI 5 (level, low) -> IRQ 5
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:06:00.0: 3Com PCI 3CCFE575CT Tornado CardBus at 0x4400. Vers LK1.1.19
PCI: Setting latency timer of device 0000:06:00.0 to 64
ip_tables: (C) 2000-2002 Netfilter core team
Unable to handle kernel NULL pointer dereference at virtual address 000000ec
 printing eip:
c02eb77b
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT=20
Modules linked in: iptable_filter ip_tables 3c59x yenta_socket pcmcia_core =
snd_mixer_oss snd_ymfpci snd_ac97_codec snd_pcm snd_opl3_lib snd_timer snd_=
hwdep snd_page_alloc snd_mpu401_uart snd_rawmidi snd soundcore usbhid uhci_=
hcd usbcore
CPU:    0
EIP:    0060:[<c02eb77b>]    Not tainted VLI
EFLAGS: 00010202   (2.6.9-rc1)=20
EIP is at ipv6_get_hoplimit+0x1b/0x70
eax: 00000000   ebx: 00200200   ecx: cecf1cac   edx: cecf0000
esi: 00000040   edi: cee389bc   ebp: cecf1bb8   esp: cecf1bac
ds: 007b   es: 007b   ss: 0068
Process ip (pid: 1386, threadinfo=3Dcecf0000 task=3Dcf9fb730)
Stack: 00000000 00200200 00000000 cecf1bfc c02ebc1b 00000000 cf2c5aa4 cfc50=
f90=20
       cf7087b0 00000000 00001000 00000000 00000000 cee38900 cecf1cac cffc1=
600=20
       cecf1c10 cecf1cac cecf1c10 cffc1600 cecf1c6c c02ecf34 cecf1c10 cffc1=
600=20
Call Trace:
 [<c010566f>] show_stack+0x7f/0xa0
 [<c0105806>] show_registers+0x156/0x1d0
 [<c01059f3>] die+0xb3/0x150
 [<c0113086>] do_page_fault+0x3c6/0x5d0
 [<c0105305>] error_code+0x2d/0x38
 [<c02ebc1b>] ip6_route_add+0x44b/0x660
 [<c02ecf34>] inet6_rtm_newroute+0x44/0x60
 [<c0293872>] rtnetlink_rcv+0x232/0x3a0
 [<c0298e0a>] netlink_data_ready+0x5a/0x70
 [<c0298471>] netlink_sendskb+0x31/0x60
 [<c0298aa4>] netlink_sendmsg+0x224/0x2f0
 [<c0282447>] sock_sendmsg+0x97/0xd0
 [<c0283f16>] sys_sendmsg+0x166/0x2a0
 [<c0284494>] sys_socketcall+0x234/0x240
 [<c0105109>] sysenter_past_esp+0x52/0x71
Code: dc 0f 02 00 eb cb 8d 76 00 8d bc 27 00 00 00 00 55 ba 00 e0 ff ff 89 =
e5 56 53 83 ec 04 8b 35 04 86 38 c0 21 e2 ff 42 14 8b 45 08 <8b> 98 ec 00 0=
0 00 85 db 74 03 ff 43 58 ff 4a 14 8b 42 08 a8 08=20
 <6>note: ip[1386] exited with preempt_count 1
spurious 8259A interrupt: IRQ7.

--Boundary-00=_rfyKBKcl1KRczvS--
