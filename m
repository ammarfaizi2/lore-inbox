Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbRETGsz>; Sun, 20 May 2001 02:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261467AbRETGsg>; Sun, 20 May 2001 02:48:36 -0400
Received: from syncopation-01.iinet.net.au ([203.59.24.37]:18080 "HELO
	syncopation-01.iinet.net.au") by vger.kernel.org with SMTP
	id <S261413AbRETGsb>; Sun, 20 May 2001 02:48:31 -0400
Date: Sun, 20 May 2001 14:47:05 +0800
From: Steven Cook <sven@harshbutfair.org>
To: linux-kernel@vger.kernel.org
Subject: [polynomial-c@gmx.de: Re: SCSI CD problems]
Message-ID: <20010520144705.A534@madcow.harshbutfair.org>
Reply-To: rattenhasser@tuxforum.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
X-SysInfo: Linux madcow.harshbutfair.org 2.4.4 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Poly <polynomial-c@gmx.de> -----

From: Poly <polynomial-c@gmx.de>
Reply-To: rattenhasser@tuxforum.com
To: sven@harshbutfair.org
Subject: Re: SCSI CD problems
Date: Sat, 19 May 2001 18:11:14 +0200

Hi,

I'm not at the kernel-mailinglist so maybe you can forward this message to 
them.

I have read your message you posted to the Linux-kernel mailinglist about 
your SCSI problems. 
Since my last motherboard-change (from EPoX EP-8KTA+/Thunderbird-B 850 to 
EPoX EP-8KTA3/Thunderbird-C 1000) I have experienced nearly the same problems 
as you have on my SuSE Linux 7.1 distribution. 
I have two SCSI-controllers, one is a Dawicontrol DC-2976UW (sym53c875e) and 
the other is a Dawicontrol DC-2980U2W (sym53c895). The 2976UW hosts three 
CD-ROM devices, a Plextor PX-40TS, a Plextor PX-W124TS and a Yamaha CRW4416S. 
The DC-2980U2W hosts three IBM (DDRS-34560D, DNES-309170W, DDYS-T09170N) 
harddrives.
The problem appears in unregularly times when transferring some data over 
the SCSI-busses (it doesn't matter which SCSI-Bus is used). You can make the 
errors appearing more often, when you transfer a big amount of small files. 
By the way: I have  n e v e r  experienced data corruption or anything like 
that (maybe because I'm using ReiserFS). Only all SCSI devices hang sometimes 
for about 10-20 seconds.
The following appears in /var/log/messages after any SCSI-hang-up (this 
should be seen as an example of how the errormessages look like, they are not 
always exactly the same of course):

May 19 05:45:50 Troll kernel: scsi : aborting command due to timeout : pid 
0, scsi1, channel 0, id 1, lun 0 0x28 00 00 68 19 a6 00 00 08 00
May 19 05:45:50 Troll kernel: sym53c8xx_abort: pid=0 serial_number=14280 
serial_number_at_timeout=14280
May 19 05:45:53 Troll kernel: SCSI host 1 abort (pid 0) timed out - resetting
May 19 05:45:53 Troll kernel: SCSI bus is being reset for host 1 channel 0.
May 19 05:45:53 Troll kernel: sym53c8xx_reset: pid=0 reset_flags=2 
serial_number=14280 serial_number_at_timeout=14280
May 19 05:45:54 Troll kernel: sym53c895-1-<1,*>: FAST-40 WIDE SCSI 80.0 MB/s 
(25.0 ns, offset 15)
May 19 05:46:05 Troll kernel: sym53c895-1-<5,*>: FAST-40 WIDE SCSI 80.0 MB/s 
(25.0 ns, offset 31)
May 19 05:46:21 Troll kernel: sym53c895-1-<2,*>: FAST-40 WIDE SCSI 80.0 MB/s 
(25.0 ns, offset 30)

When I first recognized that kind of error I tried several kernels (2.2.18; 
2.2.19; 2.4.0 to 2.4.4) but with each kernel the error appears again. 
After a while of testing around to find the reason for these hang-ups I found 
out, that it was caused by KDE-2.1.1 when it was running. Having a session 
with another windowmanager (fvwm2) or running on the console and transferring 
datas did not cause any SCSI-errors. So burning CDs for me only works if I 
have KDE2 not running.

Attatched to this mail are the output of dmesg and lspci -v. If somebody 
needs more information, just send me an e-mail.

I hope my mail helps a little and everybody can understand my bad english ;-)

bye

Lars Wendler
Content-Description: textfile
Linux version 2.4.4 (root@Troll) (gcc version 2.95.2 19991024 (release)) #1 Don Mai 3 05:42:45 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=lin-2.4.4 ro root=806 BOOT_FILE=/boot/2.4.4-knl_02 reboot=warm mem=256M init 2
Initializing CPU#0
Detected 1002.306 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1998.84 BogoMIPS
Memory: 255408k/262144k available (1122k kernel code, 6348k reserved, 397k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb3f0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA PCI latency patch.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP(,...)]
parport_pc: Via 686A parallel port: io=0x378
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
block: queued sectors max/low 169698kB/56566kB, 512 slots per queue
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Linux Tulip driver version 0.9.14e (April 20, 2001)
PCI: Found IRQ 10 for device 00:08.0
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
00:08.0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0xdc00, 00:C0:F0:4D:9F:36, IRQ 10.
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0a.0
sym53c8xx: at PCI bus 0, device 10, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected 
PCI: Found IRQ 15 for device 00:09.0
sym53c8xx: at PCI bus 0, device 9, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c895 detected 
sym53c875-0: rev 0x26 on pci bus 0 device 10 function 0 irq 11
sym53c875-0: ID 7, Fast-20, Parity Checking
sym53c895-1: rev 0x1 on pci bus 0 device 9 function 0 irq 15
sym53c895-1: ID 7, Fast-40, Parity Checking
scsi0 : sym53c8xx-1.7.3a-20010304
scsi1 : sym53c8xx-1.7.3a-20010304
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.04
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W124TS  Rev: 1.07
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0j
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DDYS-T09170N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi1, channel 0, id 1, lun 0
Detected scsi disk sdb at scsi1, channel 0, id 2, lun 0
Detected scsi disk sdc at scsi1, channel 0, id 5, lun 0
sym53c895-1-<1,*>: FAST-40 WIDE SCSI 80.0 MB/s (25.0 ns, offset 15)
SCSI device sda: 8925000 512-byte hdwr sectors (4570 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 >
sym53c895-1-<2,*>: FAST-40 WIDE SCSI 80.0 MB/s (25.0 ns, offset 30)
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
 sdb: sdb1 sdb2 sdb3
sym53c895-1-<5,*>: FAST-40 WIDE SCSI 80.0 MB/s (25.0 ns, offset 31)
SCSI device sdc: 17916240 512-byte hdwr sectors (9173 MB)
 sdc: sdc1 sdc2
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Detected scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
Detected scsi CD-ROM sr2 at scsi0, channel 0, id 6, lun 0
sym53c875-0-<3,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 15)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
sym53c875-0-<4,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
sym53c875-0-<6,*>: FAST-10 SCSI 8.0 MB/s (125.0 ns, offset 16)
sr2: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (2048 buckets, 16384 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux IPX 0.46 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
fatfs: bogus cluster size
reiserfs: checking transaction log (device 08:06) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 144544k swap-space (priority -1)
MSDOS FS: Using codepage 850
reiserfs: checking transaction log (device 08:13) ...
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
MSDOS FS: Using codepage 850
reiserfs: checking transaction log (device 08:22) ...
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
Creative EMU10K1 PCI Audio Driver, version 0.7, 05:47:35 May  3 2001
PCI: Found IRQ 5 for device 00:0d.0
PCI: The same IRQ used for device 00:07.2
PCI: The same IRQ used for device 00:0b.0
PCI: The same IRQ used for device 00:0b.1
emu10k1: EMU10K1 rev 8 model 0x8040 found, IO at 0xe800-0xe81f, IRQ 5
VFS: Disk change detected on device sr(11,1)
ISO 9660 Extensions: Microsoft Joliet Level 1
ISOFS: changing to secondary root

Content-Description: textfile
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Flags: bus master, medium devsel, latency 8
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d6000000-d7ffffff
	Prefetchable memory behind bridge: d4000000-d5ffffff
	Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Flags: medium devsel
	Capabilities: [68] Power Management version 2

00:08.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Kingston Technologies: Unknown device 0001
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at dc00 [size=128]
	Memory at d9000000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:09.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c895 (rev 01)
	Subsystem: Unknown device dc93:2980
	Flags: bus master, medium devsel, latency 134, IRQ 15
	I/O ports at e000 [size=256]
	Memory at d9001000 (32-bit, non-prefetchable) [size=256]
	Memory at d9002000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0a.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 26)
	Subsystem: Symbios Logic Inc. (formerly NCR): Unknown device 1000
	Flags: bus master, medium devsel, latency 134, IRQ 11
	I/O ports at e400 [size=256]
	Memory at d9003000 (32-bit, non-prefetchable) [size=256]
	Memory at d9004000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 1

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at d9005000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at d9006000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
	Subsystem: Creative Labs CT4760 SBLive!
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at e800 [size=32]
	Capabilities: [dc] Power Management version 1

00:0d.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at ec00 [size=8]
	Capabilities: [dc] Power Management version 1

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev 11) (prog-if 00 [VGA])
	Subsystem: Diamond Multimedia Systems Viper V770 Ultra
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
	Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d4000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
	Capabilities: [44] AGP version 2.0



----- End forwarded message -----

