Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270567AbRHNLbT>; Tue, 14 Aug 2001 07:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270568AbRHNLbK>; Tue, 14 Aug 2001 07:31:10 -0400
Received: from iaehv.iae.nl ([212.61.26.35]:13580 "HELO iaehv.iae.nl")
	by vger.kernel.org with SMTP id <S270567AbRHNLaz>;
	Tue, 14 Aug 2001 07:30:55 -0400
Date: Tue, 14 Aug 2001 13:31:07 +0200 (CEST)
From: Ime Smits <ime@iaehv.iae.nl>
To: linux-kernel@vger.kernel.org
Subject: Camino 2 (82815/82820) v2.4.x eth/sound related lockups
Message-ID: <Pine.BSF.4.05.10108141301230.92637-100000@iaehv.iae.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experiencing hard lockups on my Intel Camino 2/Celeron 550  
box with onboard sound/video/ethernet. Another box with the same
configuration has the same problems, so I think I can rule out
hardware problems.

I think this might be related to the eepro100 problem discussed
here last week as I see the same messages in syslog, but it
doesn't lockup when using eth alone. But as soon as I start xmms
and listen to a network stream - or just anything else that
uses /dev/dsp, it locks up hard within 5 minutes most of the
time - without writing anything anywhere.

Funny things in syslog include:

kernel: mtrr: base(0xe8000000) is not aligned on a
size(0x4b0000) boundary
kernel: eepro100: wait_for_cmd_done timeout!

Anybody any clues where to start looking?

Thanks,

Ime

--

uname -a:

Linux bigbird 2.4.8-ac2 #8 Mon Aug 13 19:47:33 CEST 2001 i686
unknown


Initialisation stuff from dmesg:

Loaded 17335 symbols from /boot/System.map-2.4.8-ac2.
Symbols match kernel version 2.4.8.
No module symbols loaded.
Linux version 2.4.8-ac2 (root@bigbird) (gcc
version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #6 Mon Aug 13
16:37:27 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ff00000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 65280
zone(0): 4096 pages.
zone(1): 61184 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=305
BOOT_FILE=/boot/vmlinuz
Initializing CPU#0
Detected 795.464 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1585.97 BogoMIPS
Memory: 253936k/261120k available (1551k kernel code, 6796k
reserved, 414k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb21, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
PnP: PNP BIOS installation structure at 0xc00f6290
PnP: PNP BIOS version 1.0, entry at f0000:52b4, dseg at f0000
PnP: 14 devices detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
...
Real Time Clock Driver v1.10d
Non-volatile memory driver v1.1
i810_rng: cannot disable RNG, aborting
i810_rng hardware driver 0.9.6 loaded
block: queued sectors max/low 168504kB/56168kB, 512 slots per
queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override
with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA,
hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA,
hdd:pio
...
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V.
Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 01:08.0
eth0: Intel Corporation 82801BA(M) Ethernet, 00:10:DC:9E:56:AD,
IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
PPP generic driver version 2.4.1
...
agpgart: AGP aperture is 64M @ 0xe8000000
Intel 810 + AC97 Audio, version 0.03, 16:41:50 Aug 13 2001
PCI: Found IRQ 11 for device 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH2 found at IO 0xd800 and 0xdc00, IRQ 11
ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices
AD1881A)
i810_audio: setting clocking to 24060
NET4: Linux TCP/IP 1.0 for NET4.0
----

lspci:
----
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host
Bridge and Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82815 CGC
[Chipset Graphics Controller]  (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2)
Chipset PCI (rev 02)
00:1f.0 ISA bridge: Intel Corporation 82820 820 (Camino 2)
Chipset ISA Bridge (ICH2) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82820 820 (Camino 2)
Chipset IDE U100 (rev 02)
00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2)
Chipset USB (Hub A) (rev 02)
00:1f.3 SMBus: Intel Corporation 82820 820 (Camino 2) Chipset
SMBus (rev 02)
00:1f.4 USB Controller: Intel Corporation 82820 820 (Camino 2)
Chipset USB (Hub B) (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation: Unknown
device 2445 (rev 02)
01:02.0 FireWire (IEEE 1394): Texas Instruments: Unknown device
8020
01:08.0 Ethernet controller: Intel Corporation 82820 820 (Camino
2) Chipset Ethernet (rev 01)
----




