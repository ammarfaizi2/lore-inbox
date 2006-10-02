Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965426AbWJBVnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965426AbWJBVnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965424AbWJBVnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:43:11 -0400
Received: from smtp11.poczta.interia.pl ([80.48.65.11]:32684 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S965419AbWJBVnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:43:06 -0400
Message-ID: <452188DA.6090000@interia.pl>
Date: Mon, 02 Oct 2006 23:47:06 +0200
From: =?UTF-8?B?QXJrYWRpdXN6IEphxYJvd2llYw==?= <ajalowiec@interia.pl>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org,
       linux-usb-users@lists.sourceforge.net, stern@rowland.harvard.edu
Subject: Re: [Linux-usb-users] PROBLEM: Kernel 2.6.x freeze
References: <20060930141455.29fdadef@localhost>	<Pine.LNX.4.44L0.0609301131190.7052-100000@netrider.rowland.org> <20061001161020.20e941c6@localhost>
In-Reply-To: <20061001161020.20e941c6@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EMID: c9fbcacc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> Another crazy theory (based on my horrible experience with a
> defective memory module):
>   
I don't know, but I think this theory is possibly :(

> There is an hard to trigger single bit error not detected by memtest
> near (physical) memory address 6b79f00(ESP) (where the EIP has been
> retrived causing the Oops).
>
> In this case the physical address (at Kb 110055) can be skipped with
> "memmap=1K$110055K" kernel boot option.
>   
I add to kernel command line this option and I boot my computer.  dmesg 
show me this:

Linux version 2.6.18 (root@darkstar) (gcc version 3.3.6) #1 Wed Sep 27 
08:19:45 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 61424 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 VIAP4X                                ) @ 0x000f62d0
ACPI: RSDT (v001 VIAP4X AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
ACPI: FADT (v001 VIAP4X AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
ACPI: DSDT (v001 VIAP4X AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 10000000 (gap: 06b7a000:f9486000)
Detected 2200.142 MHz processor.
Built 1 zonelists.  Total pages: 65520
Kernel command line: root=/dev/hda5 vga=791 memmap=1K$110055K
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256220k/262080k available (1923k kernel code, 5364k reserved, 
806k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4403.02 BogoMIPS 
(lpj=2201512)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: bfebf9ff 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU: After all inits, caps: bfebf9ff 00000000 00000000 00000080 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Celeron(R) CPU 2.20GHz stepping 07
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0a28)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb290, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by vt8235 PM
PCI quirk: region 0500-050f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: e4000000-e5ffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
fuse init (API version 7.7)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xd0000000, mapped to 0xd0880000, using 3072k, 
total 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:e700
vesafb: pmi: set display start = c00ce745, set palette = c00ce7ca
vesafb: pmi: ports = b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 c803 
c903 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI: Thermal Zone [THRM] (46 C)
ipmi message handler version 39.0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 7777K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SAMSUNG SV4012H, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: JLMS XJ-HD165H, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
ACPI: (supports S0 S3 S4<6>Time: acpi_pm clocksource has been installed.
 S5)
input: AT Translated Set 2 keyboard as /class/input/input0
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: replayed 14 transactions in 0 seconds
ReiserFS: hda5: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 156k freed
Adding 265032k swap on /dev/hda6.  Priority:-1 extents:1 across:265032k
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_conntrack version 2.4 (2047 buckets, 16376 max) - 224 bytes per conntrack
via-rhine.c:v1.10-LK1.4.1 July-24-2006 Written by Donald Becker
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
eth0: VIA Rhine II at 0x1ec00, 00:e0:4c:8e:49:95, IRQ 11.
eth0: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:11.5 to 64
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 11 (level, 
low) -> IRQ 11
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: irq 11, io mem 0xe6010000
ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 11, io base 0x0000d400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 3 (level, low) 
-> IRQ 3
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 3, io base 0x0000d800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 5 (level, low) 
-> IRQ 5
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 5, io base 0x0000dc00
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
[ueagle-atm] driver ueagle 1.3 loaded
usb 2-1: [ueagle-atm] ADSL device founded vid (0X1110) pid (0X9021) : 
Eagle II
usb 2-1: reset full speed USB device using uhci_hcd and address 2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA P4M266x/P4N266 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
usb 2-1: [ueagle-atm] using iso mode
usbcore: registered new driver ueagle-atm
usb 2-1: [ueagle-atm] (re)booting started
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
usb 2-1: [ueagle-atm] modem operational
usb 2-1: [ueagle-atm] ATU-R firmware version : 44e2ea17


I was waiting about  one hour and I have another oops. I copy oops 
handy. [ I don't have a digital camera and I don't know person who wont 
to me lend. Sorry !!!]

BUG: unable to handle kernel paging request at virtual address 000f9edf
printing epip
*pde=00000000
Ops: 0002 [#1]
Modules linked in: ppp_deflate zlib_deflate bsd_comp pppoatm ipv6 
partport_pc partport snd_pcm_oss snd_mixer_oss via_agp agpgart uagle_atm 
usbatm uhci_hcd ehci_hcd usbcore i2c_viapro i2c_core snd_via82xx 
snd_ac97.codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc 
snd_mpu_401_uart snd_rawmidi ipt_LOG snd_seq_device snd xt_limit 
soundcore via_rhine mii xt_tcpudp xt_state iptables_filter nls_iso8859-2 
nls_cp852 ip_contract_irc ip_contract_ftp xt_contract ip_contract 
iptables x_tables
CPU: 0
EIP: 0060: [<d0d18140>] Not tainted VLI
EFLAGS: 00010083 (2.6.18 #1)
EIP is at uhci_result_isochronous+0x4f/0x131 [uhci_hcd]
eax: 000f9edf ebx: cf7b3600 edx:000f9edf edx:ceedfed0
esi:cf7b3600 edi:cba5c2a0 epb:ceedfed0 esp:c03adef8
ds:007b es:007b ss:0068

Process swapper (pid:0,ti=c03ac000 task=c03530a0 task.ti=c03ac000)
Stack: cf15e3a0 cba5c330 ce2caac0 ceedfed0 cf7b3600 ce2caac0 00000001 
ceedfed0
d0d185d1 c03adfa4 ceedfed0 cf7b3600 00000001 c03adfa4 d0d1884b 00000246
00000000 00000000 ceedfe00 d0d192ad ceedfed0 c03adfa4 ceedfe00 00000000

Call Trace:
[<d0d185d1>] uhci_scan_qh+0x28/0x174 [uhci_hcd]
[<d0d18846>] uhci_scan_schedule+0x72/0xec [uhci_hcd]
[<d0d192ad>] uhci_hcd_irq+0x27/0x4e [usbcore]
[<c012c4c4>] handle_IRQ_event+0x21/0x47
[<c012c545>]_do_IRQ+0x5b/0xa2
[<c0104106>] do_IRQ+0x40/04d
[<c0102c4a>] common_interrupt+0x1a/0x20
[<c021dfd1>] acpi_processor_idle+0x1c4/0x2c3
[<c01010c4>] cpu_idle+0x3f/0x5b
[<c03ae63b>] start_kernel+0x197/0x199

Code 83 ed 14 39 c2 89 6c 24 04 0f 84 f3 00 00 00 8b 46 3c 8b 54 24 0c 
3b 42 70 78 0a b8 8d ff ff ff e9 e0 00 00 00 89 c1 8b 6c 24 0c <00> 20 
7b 0f 00 00 00 00 69 7f e0 ff 00 00 00 00 00 20 7b 0f 14

EIP:[<cd0d18140>] uhci_result_isochronous+0x4f/0x131
[uhci_hcd] SS:ESP 0068:c03adef8
<0> Kernel panic - not syncing: Fatal excepition in interrupt

I run "objdump -d drivers/usb/host/uhci-hcd.o" and post the portion of 
the output for: uhci_result_isochronous

000010f1 <uhci_result_isochronous>:
    10f1:    55                       push   %ebp
    10f2:    57                       push   %edi
    10f3:    56                       push   %esi
    10f4:    53                       push   %ebx
    10f5:    83 ec 10                 sub    $0x10,%esp
    10f8:    89 44 24 0c              mov    %eax,0xc(%esp)
    10fc:    89 54 24 08              mov    %edx,0x8(%esp)
    1100:    8b 42 04                 mov    0x4(%edx),%eax
    1103:    89 04 24                 mov    %eax,(%esp)
    1106:    8b 50 10                 mov    0x10(%eax),%edx
    1109:    8b 70 0c                 mov    0xc(%eax),%esi
    110c:    83 c0 10                 add    $0x10,%eax
    110f:    8d 7a ec                 lea    0xffffffec(%edx),%edi
    1112:    8b 6f 14                 mov    0x14(%edi),%ebp
    1115:    83 ed 14                 sub    $0x14,%ebp
    1118:    39 c2                    cmp    %eax,%edx
    111a:    89 6c 24 04              mov    %ebp,0x4(%esp)
    111e:    0f 84 f3 00 00 00        je     1217 
<uhci_result_isochronous+0x126>
    1124:    8b 46 3c                 mov    0x3c(%esi),%eax
    1127:    8b 54 24 0c              mov    0xc(%esp),%edx
    112b:    3b 42 70                 cmp    0x70(%edx),%eax
    112e:    78 0a                    js     113a 
<uhci_result_isochronous+0x49>
    1130:    b8 8d ff ff ff           mov    $0xffffff8d,%eax
    1135:    e9 e0 00 00 00           jmp    121a 
<uhci_result_isochronous+0x129>
    113a:    89 c1                    mov    %eax,%ecx
    113c:    8b 6c 24 0c              mov    0xc(%esp),%ebp
    1140:    81 e1 ff 03 00 00        and    $0x3ff,%ecx
    1146:    8b 45 58                 mov    0x58(%ebp),%eax
    1149:    8b 1c 88                 mov    (%eax,%ecx,4),%ebx
    114c:    85 db                    test   %ebx,%ebx
    114e:    74 35                    je     1185 
<uhci_result_isochronous+0x94>
    1150:    8b 43 24                 mov    0x24(%ebx),%eax
    1153:    8b 55 54                 mov    0x54(%ebp),%edx
    1156:    8b 40 e0                 mov    0xffffffe0(%eax),%eax
    1159:    89 04 8a                 mov    %eax,(%edx,%ecx,4)
    115c:    8b 45 58                 mov    0x58(%ebp),%eax
    115f:    8d 6b 20                 lea    0x20(%ebx),%ebp
    1162:    c7 04 88 00 00 00 00     movl   $0x0,(%eax,%ecx,4)
    1169:    39 6b 20                 cmp    %ebp,0x20(%ebx)
    116c:    74 17                    je     1185 
<uhci_result_isochronous+0x94>
    116e:    8b 43 24                 mov    0x24(%ebx),%eax
    1171:    8b 48 04                 mov    0x4(%eax),%ecx
    1174:    8b 10                    mov    (%eax),%edx
    1176:    89 11                    mov    %edx,(%ecx)
    1178:    89 4a 04                 mov    %ecx,0x4(%edx)
    117b:    89 00                    mov    %eax,(%eax)
    117d:    39 6b 20                 cmp    %ebp,0x20(%ebx)
    1180:    89 40 04                 mov    %eax,0x4(%eax)
    1183:    75 e9                    jne    116e 
<uhci_result_isochronous+0x7d>
    1185:    8b 5f 04                 mov    0x4(%edi),%ebx
    1188:    f7 c3 00 00 80 00        test   $0x800000,%ebx
    118e:    b9 ee ff ff ff           mov    $0xffffffee,%ecx
    1193:    75 3d                    jne    11d2 
<uhci_result_isochronous+0xe1>
    1195:    8b 44 24 08              mov    0x8(%esp),%eax
    1199:    8b 50 20                 mov    0x20(%eax),%edx
    119c:    89 d8                    mov    %ebx,%eax
    119e:    c1 ea 07                 shr    $0x7,%edx
    11a1:    25 00 00 f6 00           and    $0xf60000,%eax
    11a6:    83 f2 01                 xor    $0x1,%edx
    11a9:    83 e2 01                 and    $0x1,%edx
    11ac:    e8 fc f5 ff ff           call   7ad <uhci_map_status>
    11b1:    89 c1                    mov    %eax,%ecx
    11b3:    8b 54 24 08              mov    0x8(%esp),%edx
    11b7:    8d 43 01                 lea    0x1(%ebx),%eax
    11ba:    25 ff 07 00 00           and    $0x7ff,%eax
    11bf:    01 42 38                 add    %eax,0x38(%edx)
    11c2:    85 c9                    test   %ecx,%ecx
    11c4:    8b 56 2c                 mov    0x2c(%esi),%edx
    11c7:    89 42 08                 mov    %eax,0x8(%edx)
    11ca:    8b 46 2c                 mov    0x2c(%esi),%eax
    11cd:    89 48 0c                 mov    %ecx,0xc(%eax)
    11d0:    74 0a                    je     11dc 
<uhci_result_isochronous+0xeb>
    11d2:    8b 6c 24 08              mov    0x8(%esp),%ebp
    11d6:    ff 45 50                 incl   0x50(%ebp)
    11d9:    89 4e 40                 mov    %ecx,0x40(%esi)
    11dc:    89 f8                    mov    %edi,%eax
    11de:    e8 71 ef ff ff           call   154 <uhci_remove_td_from_urbp>
    11e3:    89 fa                    mov    %edi,%edx
    11e5:    8b 44 24 0c              mov    0xc(%esp),%eax
    11e9:    e8 e6 ee ff ff           call   d4 <uhci_free_td>
    11ee:    83 46 2c 10              addl   $0x10,0x2c(%esi)
    11f2:    8b 46 38                 mov    0x38(%esi),%eax
    11f5:    01 46 3c                 add    %eax,0x3c(%esi)
    11f8:    8b 7c 24 04              mov    0x4(%esp),%edi
    11fc:    8b 47 14                 mov    0x14(%edi),%eax
    11ff:    8d 57 14                 lea    0x14(%edi),%edx
    1202:    83 e8 14                 sub    $0x14,%eax
    1205:    89 44 24 04              mov    %eax,0x4(%esp)
    1209:    8b 04 24                 mov    (%esp),%eax
    120c:    83 c0 10                 add    $0x10,%eax
    120f:    39 c2                    cmp    %eax,%edx
    1211:    0f 85 0d ff ff ff        jne    1124 
<uhci_result_isochronous+0x33>
    1217:    8b 46 40                 mov    0x40(%esi),%eax
    121a:    83 c4 10                 add    $0x10,%esp
    121d:    5b                       pop    %ebx
    121e:    5e                       pop    %esi
    121f:    5f                       pop    %edi
    1220:    5d                       pop    %ebp
    1221:    c3                       ret    



----------------------------------------------------------------------
Jestes kierowca? To poczytaj! >>> http://link.interia.pl/f199e

