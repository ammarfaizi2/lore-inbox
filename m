Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130355AbRARI66>; Thu, 18 Jan 2001 03:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131471AbRARI6t>; Thu, 18 Jan 2001 03:58:49 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:11174 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S130355AbRARI6e>; Thu, 18 Jan 2001 03:58:34 -0500
Date: Thu, 18 Jan 2001 09:58:10 +0100
From: Petr Matula <pem@informatics.muni.cz>
To: Duncan Laurie <duncan@virtualwire.org>
Cc: linux-kernel@vger.kernel.org, randy.dunlap@intel.com,
        torvalds@transmeta.com, pem@informatics.muni.cz
Subject: Re: int. assignment on SMP + ServerWorks chipset
Message-ID: <20010118095810.A13218780@aisa.fi.muni.cz>
In-Reply-To: <3A64F7E2.30807@virtualwire.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A64F7E2.30807@virtualwire.org>; from duncan@virtualwire.org on Tue, Jan 16, 2001 at 06:39:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 16, 2001 at 06:39:46PM -0700, Duncan Laurie wrote:
> There may be bogus data in the PIRQ table as well, which is why this
> explicitly routes the interrupt & sets the ELCR.  If you enable DEBUG
> in pci-i386.h and re-send the dmesg output I will look it over.
I tied your patch. dmesg output si attached.

Without this patch the smp kernel crashes when my USB printer is detected.
With this patch only a USB Hub is detected but not the printer. It seems to
be stable.

Petr

---------------------------------------------------------------
 Petr Matula                                    pem@fi.muni.cz
                                    http://www.fi.muni.cz/~pem
---------------------------------------------------------------

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Description: dmesg
Content-Disposition: attachment; filename=duncan

    31
 01 003 03  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  1    1    0   1   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  1    1    0   1   0    1    1    89
 01 003 03  1    1    0   1   0    1    1    91
 02 003 03  1    1    0   1   0    1    1    99
 03 003 03  1    1    0   1   0    1    1    A1
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 0
IRQ17 -> 1
IRQ18 -> 2
IRQ19 -> 3
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 666.5365 MHz.
..... host bus clock speed is 133.3070 MHz.
cpu: 0, clocks: 1333070, slice: 444356
CPU0<T0:1333056,T1:888688,D:12,S:444356,C:1333070>
cpu: 1, clocks: 1333070, slice: 444356
CPU1<T0:1333056,T1:444336,D:8,S:444356,C:1333070>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: BIOS32 Service Directory structure at 0xc00f6b80
PCI: BIOS32 Service Directory entry at 0xfd98e
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfdb57, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ServerWorks host bridge: secondary bus 00
PCI: ServerWorks host bridge: secondary bus 01
PCI: Scanning for ghost devices on bus 1
PCI: IDE base address fixup for 00:0f.1
PCI: Scanning for ghost devices on bus 0
PCI: IRQ init
PCI: IRQ fixup
PCI->APIC IRQ transform: (B1,I4,P0) -> 16
PCI->APIC IRQ transform: (B1,I4,P1) -> 17
PCI->APIC IRQ transform: (B0,I2,P0) -> 19
PCI->APIC IRQ transform: (B0,I3,P0) -> 18
PCI->APIC IRQ transform: (B0,I15,P0) -> 9
PCI: Allocating resources
PCI: Resource 00005800-000058ff (f=101, d=0, p=0)
PCI: Resource fd000000-fd000fff (f=204, d=0, p=0)
PCI: Resource 00006000-000060ff (f=101, d=0, p=0)
PCI: Resource fd001000-fd001fff (f=204, d=0, p=0)
PCI: Resource fc000000-fcffffff (f=1208, d=0, p=0)
PCI: Resource 00005000-000050ff (f=101, d=0, p=0)
PCI: Resource fb100000-fb100fff (f=200, d=0, p=0)
PCI: Resource fb101000-fb101fff (f=200, d=0, p=0)
PCI: Resource 00005400-0000543f (f=101, d=0, p=0)
PCI: Resource fb000000-fb0fffff (f=200, d=0, p=0)
PCI: Resource 00005440-0000544f (f=101, d=0, p=0)
PCI: Resource fb102000-fb102fff (f=200, d=0, p=0)
PCI: Sorting device list...
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.3 present.
51 structures occupying 1651 bytes.
DMI table at 0x000EF5A0.
BIOS Vendor: Intel Corporation
BIOS Version: STL20.86B.0017.P01.0011291152
BIOS Release: 11/29/2000
System Vendor: Intel.
Product Name: STL2.
Version  .
Serial Number  .
Board Vendor: Intel.
Board Name: STL2.
Board Version: A28808-301.
Asset Tag: 0000000000000000.
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP(,...)]
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
hd0: C/H/S=22505/247/228 from BIOS ignored
hda: IBM-DPTA-372730, ATA DISK drive
hdb: NEC CD-ROM DRIVE:282, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 53464320 sectors (27374 MB) w/1961KiB Cache, CHS=53040/16/63
hdb: ATAPI 40X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: [PTBL] [3328/255/63] hda1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.35 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:B6:58:CB, IRQ 18.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 1/4/0
(scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
(scsi1) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 1/4/1
(scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
(scsi0:0:0:0) Synchronous at 160.0 Mbyte/sec, offset 63.
  Vendor: SEAGATE   Model: ST318404LW        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 >
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xc8806000, IRQ 9
usb-ohci.c: usb-00:0f.2, PCI device 1166:0220 (ServerWorks)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
usb.c: registered new driver usblp
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding Swap: 489940k swap-space (priority -1)
nfs warning: mount version older than kernel

--PEIAKu/WMn1b1Hv9--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
