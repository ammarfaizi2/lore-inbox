Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTHYNjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 09:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTHYNjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 09:39:08 -0400
Received: from maja.beep.pl ([195.245.198.10]:268 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261825AbTHYNhy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 09:37:54 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: 2.6.0test4 bk1 and
Date: Mon, 25 Aug 2003 15:35:36 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200308251535.36686.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yesterday I've changed kernel from test3 to test4 with bk1 patch applied and 
such error appeared (and it's showning all the time):

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<cf8c1257>] acpi_processor_idle+0xe9/0x1e5 [processor]
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<cf8c1257>] acpi_processor_idle+0xe9/0x1e5 [processor]
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<cf8c1257>] acpi_processor_idle+0xe9/0x1e5 [processor]
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

This is MaxData Mbook 1000T laptop with Athlon 1800+ Mobile.
[arekm@mobarm arekm]$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:08.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
00:10.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller 
(rev 46)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] (rev 10)
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1e)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1e)
00:11.4 Bridge: VIA Technologies, Inc. VT8235 ACPI (rev 10)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
Audio Controller (rev 40)
00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 
Modem] (rev 20)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 51)
01:00.0 VGA compatible controller: S3 Inc. VT8636A [ProSavage KN133] AGP4X VGA 
Controller (TwisterK) (rev 01)

Module                  Size  Used by
binfmt_misc            11016  1 
md5                     4352  1 
ipv6                  254176  23 
uhci_hcd               32400  0 
ohci_hcd               18560  0 
ds                     15492  2 
yenta_socket           14592  0 
pcmcia_core            68960  2 ds,yenta_socket
via_rhine              22280  0 
mii                     5376  1 via_rhine
crc32                   4608  1 via_rhine
nls_iso8859_2           4736  1 
ntfs                  102124  1 
snd_pcm_oss            52644  1 
snd_mixer_oss          19712  1 snd_pcm_oss
snd_via82xx            24928  1 
snd_pcm               100772  2 snd_pcm_oss,snd_via82xx
snd_timer              26244  1 snd_pcm
snd_ac97_codec         53764  1 snd_via82xx
snd_page_alloc         12292  2 snd_via82xx,snd_pcm
snd_mpu401_uart         7808  1 snd_via82xx
snd_rawmidi            25504  1 snd_mpu401_uart
snd_seq_device          8712  1 snd_rawmidi
snd                    53988  9 
snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               9664  2 snd
hid                    65664  0 
usbmouse                5760  0 
psmouse                13832  0 
proc_intf               4224  0 
powernow_k7             6688  0 
freq_table              4612  1 powernow_k7
thermal                14224  0 
processor              15012  1 thermal
fan                     4364  0 
button                  6296  0 
battery                 9612  0 
ac                      5388  0 
capability              8324  0 
ide_cd                 40964  0 
cdrom                  35872  1 ide_cd
ehci_hcd               24452  0 
usbcore               111068  7 uhci_hcd,ohci_hcd,hid,usbmouse,ehci_hcd
ext3                  119336  1 
mbcache                 9348  1 ext3
jbd                    61592  1 ext3
via82cxxx              13600  1 [unsafe]

Config is here:
http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/kernel-ia32.config?rev=1.28.2.5.4.8

[arekm@mobarm arekm]$ cat /proc/version
Linux version 2.6.0 (builder@beton) (gcc version 3.3.1 (PLD Linux)) #1 Sun Aug 
24 21:24:47 UTC 2003

Messages catched over serial console for few cases:
1) normal boot
2) single acpi=off
3) single acpi=off pci=noacpi

#######################################################################
1) normal boot

LILO 22.5.7.2 boot:
Loading pld-2.6.0........................
BIOS data check successful
Linux version 2.6.0 (builder@beton) (gcc version 3.3.1 (PLD Linux)) #1 Sun Aug 
24 21:24:47 UTC 2003
Video mode to be used for restore is f07
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eff0000 (usable)
 BIOS-e820: 000000000eff0000 - 000000000eff8000 (ACPI data)
 BIOS-e820: 000000000eff8000 - 000000000f000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
239MB LOWMEM available.
On node 0 totalpages: 61424
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57328 pages, LIFO batch:13
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fa580
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x0eff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x0eff0030
ACPI: BOOT (v001 AMIINT VIA_K7   0x00000009 MSFT 0x00000097) @ 0x0eff00c0
ACPI: DSDT (v001    VIA TwisterK 0x00001000 INTL 0x02002024) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=pld-2.6.0 ro root=303 console=ttyS0,57600n81 
console=tty0
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1533.164 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 3022.84 BogoMIPS
Memory: 239828k/245696k available (1567k kernel code, 5172k reserved, 630k 
data, 136k init, 0k highmem)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP 1800+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb51, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Embedded Controller [EC0] (gpe 5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 9 10 11 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 9 *10 11 14 15)
ACPI: Power Resource [FN10] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f77f0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x681b, dseg 0xf0000
PnPBIOS: Unknown tag '0x82', length '22'.
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Via IRQ fixup for 0000:00:11.3, from 10 to 11
PCI: Via IRQ fixup for 0000:00:11.2, from 10 to 11
PCI: Via IRQ fixup for 0000:00:11.5, from 10 to 11
PCI: Via IRQ fixup for 0000:00:11.6, from 10 to 11
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
w83877f_wdt: WDT driver for W83877F initialised. timeout=30 sec (nowayout=0)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ÿttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: TOSHIBA MK3021GAS, ATA DISK drive
hdc: Samsung CD-RW/DVD-ROM SN-324B, ATAPI CD/DVD-ROM drive
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB), CHS=58140/16/63
 /dev/ide/host0/bus0/target0/lun0:<3>bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

 p1 p2 p3
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.0.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 193k freed
VFS: Mounted root (romfs filesystem) readonly.
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
ide0: I/O resource 0x3F6-0x3F6 not free.
hda: ERROR, PORTS ALREADY IN USE
register_blkdev: cannot get major 3 for ide0
ide1: I/O resource 0x376-0x376 not free.
hdc: ERROR, PORTS ALREADY IN USE
register_blkdev: cannot get major 22 for ide1
Module via82cxxx cannot be unloaded due to unsafe usage in 
include/linux/module.h:483
Journalled Block Device driver loaded
bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

kjournald starting.  Commit interval 5 seconds
bad: scheduling while atomic!
Call Trace:
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<cf82fffa>] kjournald+0x21a/0x240 [jbd]
 [<c011e560>] autoremove_wake_function+0x0/0x50
 [<c015798f>] sys_read+0x3f/0x60
 [<c011e560>] autoremove_wake_function+0x0/0x50
 [<c010b186>] ret_from_fork+0x6/0x14
 [<cf82fde0>] kjournald+0x0/0x240 [jbd]
 [<cf82fdc0>] commit_timeout+0x0/0x10 [jbd]
 [<cf82fde0>] kjournald+0x0/0x240 [jbd]
 [<c0109259>] kernel_thread_helper+0x5/0xc

EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Trying to move old root to /initrd ... <3>bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 136k freed
bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

##########################################################################
2) single acpi=off

I have only few last lines of this

nuch of ,,scheduling while atomic'' and at end
Unable to handle kernel paging request at virtual address 08050298
 printing eip:
0804a61a
*pde = 0edc6067
*pte = 0edb8065
Oops: 0007 [#1]
CPU:    0
EIP:    0073:[<0804a61a>]    Not tainted
EFLAGS: 00010206
EIP is at 0x804a61a
eax: 08050298   ebx: 00000011   ecx: bffffb40   edx: 00000000
esi: bffffb40   edi: bffffac0   ebp: bffffce8   esp: bffffa10
ds: 007b   es: 007b   ss: 007b
Process init (pid: 1, threadinfo=cefa2000 task=cefa1880)
 <0>Kernel panic: Attempted to kill init!
 <0>MCE: The hardware reports a non fatal, correctable incident occurred on 
CPU.Bank 0: 9e15400000004cd6

############################################################################
3) single acpi=off pci=noacpi
LILO 22.5.7.2 boot: pld         pld-2.6.0 singlr       e acpi=off pci=noacpi
Loading pld-2.6.0........................
BIOS data check successful
Linux version 2.6.0 (builder@beton) (gcc version 3.3.1 (PLD Linux)) #1 Sun Aug 
24 21:24:47 UTC 2003
Video mode to be used for restore is f07
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eff0000 (usable)
 BIOS-e820: 000000000eff0000 - 000000000eff8000 (ACPI data)
 BIOS-e820: 000000000eff8000 - 000000000f000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
239MB LOWMEM available.
On node 0 totalpages: 61424
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57328 pages, LIFO batch:13
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=pld-2.6.0 ro root=303 console=ttyS0,57600n81 
console=tty0 single acpi=off pci=noacpi
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1532.796 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 3022.84 BogoMIPS
Memory: 239828k/245696k available (1567k kernel code, 5172k reserved, 630k 
data, 136k init, 0k highmem)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP 1800+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb51, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030813
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f77f0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x681b, dseg 0xf0000
PnPBIOS: Unknown tag '0x82', length '22'.
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/8231] at 0000:00:11.0
PCI: IRQ 0 for device 0000:00:08.0 doesn't match PIRQ mask - try 
pci=usepirqmask
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Applying VIA southbridge workaround.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
w83877f_wdt: WDT driver for W83877F initialised. timeout=30 sec (nowayout=0)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ÿttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: TOSHIBA MK3021GAS, ATA DISK drive
hdc: Samsung CD-RW/DVD-ROM SN-324B, ATAPI CD/DVD-ROM drive
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB), CHS=58140/16/63
 /dev/ide/host0/bus0/target0/lun0:<3>bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

 p1 p2 p3
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.0.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 193k freed
VFS: Mounted root (romfs filesystem) readonly.
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
ide0: I/O resource 0x3F6-0x3F6 not free.
hda: ERROR, PORTS ALREADY IN USE
register_blkdev: cannot get major 3 for ide0
ide1: I/O resource 0x376-0x376 not free.
hdc: ERROR, PORTS ALREADY IN USE
register_blkdev: cannot get major 22 for ide1
Module via82cxxx cannot be unloaded due to unsafe usage in 
include/linux/module.h:483
Journalled Block Device driver loaded
bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

kjournald starting.  Commit interval 5 seconds
bad: scheduling while atomic!
Call Trace:
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<cf826ffa>] kjournald+0x21a/0x240 [jbd]
 [<c011e560>] autoremove_wake_function+0x0/0x50
 [<c015798f>] sys_read+0x3f/0x60
 [<c011e560>] autoremove_wake_function+0x0/0x50
 [<c010b186>] ret_from_fork+0x6/0x14
 [<cf826de0>] kjournald+0x0/0x240 [jbd]
 [<cf826dc0>] commit_timeout+0x0/0x10 [jbd]
 [<cf826de0>] kjournald+0x0/0x240 [jbd]
 [<c0109259>] kernel_thread_helper+0x5/0xc

EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Trying to move old root to /initrd ... <3>bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 136k freed
bad: scheduling while atomic!
Call Trace:
 [<c0105000>] _stext+0x0/0x60
 [<c011ccd0>] schedule+0x3b0/0x3c0
 [<c0105000>] _stext+0x0/0x60
 [<c0105000>] _stext+0x0/0x60
 [<c01090eb>] cpu_idle+0x3b/0x40
 [<c0328734>] start_kernel+0x184/0x1b0
 [<c0328480>] unknown_bootoption+0x0/0x100

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

