Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292554AbSCCMAq>; Sun, 3 Mar 2002 07:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSCCMAh>; Sun, 3 Mar 2002 07:00:37 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:37131 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S292554AbSCCMAX>; Sun, 3 Mar 2002 07:00:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Stephen Mollett <molletts@yahoo.com>
Organization: Total lack thereof
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: Handling of bogus PCI bus numbering
Date: Sun, 3 Mar 2002 12:01:27 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203021613320.392-100000@chaos.tp1.ruhr-uni-bochum.de>
In-Reply-To: <Pine.LNX.4.44.0203021613320.392-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hUf6-000LLG-0U@anchor-post-30.mail.demon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 Mar 2002 15:15, Kai Germaschewski wrote:
> On Sat, 2 Mar 2002, Stephen Mollett wrote:
>> I've got an IBM Thinkpad 240 and the BIOS incorrectly assigns bus number
>> 0 to the CardBus ...
> Could you replace "#undef DEBUG" with "#define DEBUG" in drivers/pci/pci.c
> and arch/i386/kernel/pci-i386.h, rebuild the kernel and send "dmesg"
> output after rebooting/inserting the card?

Here's the full output. The card was inserted immediately after the boot 
completed - the insertion shows up as the last line of the messages.

Stephen

Linux version 2.4.17-pcidebug (root@rodin) (gcc version 2.95.3 20010315 
(release)) #6 Sun Mar 3 11:26:37 GMT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bfffc00 (ACPI data)
 BIOS-e820: 000000000bfffc00 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 49136
zone(0): 4096 pages.
zone(1): 45040 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Kernel command line: BOOT_IMAGE=Linux-Backup ro root=302
Initializing CPU#0
Detected 298.650 MHz processor.
Console: colour VGA+ 80x30
Calibrating delay loop... 596.37 BogoMIPS
Memory: 191648k/196544k available (829k kernel code, 4508k reserved, 195k 
data, 188k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 0a
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: BIOS32 Service Directory structure at 0xc00f6b30
PCI: BIOS32 Service Directory entry at 0xfd7c0
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=00
PCI: PCI BIOS revision 2.10 entry at 0xfd9e5, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [8086/7192] 000600 00
Found 00:38 [8086/7110] 000680 00
Found 00:39 [8086/7111] 000101 00
PCI: IDE base address fixup for 00:07.1
Found 00:3a [8086/7112] 000c03 00
Found 00:3b [8086/7113] 000680 00
Found 00:48 [10c8/0004] 000300 00
Found 00:50 [104c/ac1e] 000607 02
Found 00:58 [125d/1969] 000401 00
Found 00:60 [11c1/0449] 000780 00
Fixups for bus 00
PCI: Scanning for ghost devices on bus 0
Scanning behind PCI bridge 00:0a.0, config 010000, pass 0
Scanning behind PCI bridge 00:0a.0, config 010000, pass 1
Bus scan for 00 returning with max=01
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdf60
00:00 slot=00 0:60/def8 1:61/def8 2:62/def8 3:63/def8
00:07 slot=00 0:60/def8 1:61/def8 2:62/def8 3:63/8eb8
00:09 slot=00 0:00/def8 1:00/def8 2:00/def8 3:00/def8
00:0a slot=00 0:61/8eb8 1:00/def8 2:00/def8 3:00/def8
00:0b slot=00 0:62/8eb8 1:00/def8 2:00/def8 3:00/def8
00:0c slot=00 0:63/8eb8 1:00/def8 2:00/def8 3:00/def8
PCI: Attempting to find IRQ router for 8086:122e
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: IRQ fixup
00:09.0: ignoring bogus IRQ 255
IRQ for 00:09.0:0 -> not routed
PCI: Allocating resources
PCI: Resource f8000000-fbffffff (f=1208, d=0, p=0)
PCI: Resource 00001040-0000104f (f=101, d=0, p=0)
PCI: Resource 00001060-0000107f (f=101, d=0, p=0)
PCI: Resource f5000000-f5ffffff (f=1208, d=0, p=0)
PCI: Resource f4000000-f41fffff (f=200, d=0, p=0)
PCI: Resource f4200000-f42fffff (f=200, d=0, p=0)
PCI: Resource 00001000-0000103f (f=101, d=0, p=0)
PCI: Resource 00001090-0000109f (f=101, d=0, p=0)
PCI: Resource 00001080-0000108f (f=101, d=0, p=0)
PCI: Resource 000010a4-000010a7 (f=105, d=0, p=0)
PCI: Resource 000010a0-000010a3 (f=101, d=0, p=0)
PCI: Resource f4300000-f43000ff (f=200, d=0, p=0)
PCI: Resource 000010a8-000010af (f=109, d=0, p=0)
PCI: Resource 00001400-000014ff (f=101, d=0, p=0)
PCI: Sorting device list...
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
Starting kswapd
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1040-0x1047, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1048-0x104f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DBCA-206480, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 12685680 sectors (6495 MB) w/420KiB Cache, CHS=789/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:02) ...
Using tea hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 188k freed
reiserfs: checking transaction log (device 03:03) ...
Using tea hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:04) ...
Using tea hash to sort names
ReiserFS version 3.6.25
Real Time Clock Driver v1.10e
Linux PCMCIA Card Services 3.1.31
  kernel build: 2.4.17-pcidebug #6 Sun Mar 3 11:26:37 GMT 2002
  options:  [pci] [cardbus] [apm] [pnp]
PnP: PNP BIOS installation structure at 0xc00f6b80
PnP: PNP BIOS version 1.0, entry at f0000:8440, dseg at 400
Intel ISA/PCI/CardBus PCIC probe:
IRQ for 00:0a.0:0 -> PIRQ 61, mask 8eb8, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 00:0a.0
  TI 1211 rev 00 PCI-to-CardBus at slot 00:0a, mem 0x10000000
    host opts [0]: [ring] [pci + serial irq] [pci irq 11] [lat 168/176] [bus 
0/1]
    ISA irqs (scanned) = 5,15 PCI status changes
parport0: PC-style at 0x3bc (0x7bc), irq 7, using FIFO 
[PCSPP,TRISTATE,COMPAT,ECP]
lp0: using parport0 (interrupt-driven).
lp0: compatibility mode
lp0: compatibility mode
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
cs: cb_alloc(bus 0): vendor 0x8086, device 0x7192

