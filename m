Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274823AbRIUUoT>; Fri, 21 Sep 2001 16:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274824AbRIUUoC>; Fri, 21 Sep 2001 16:44:02 -0400
Received: from pop.timesn.com ([216.30.51.65]:40702 "EHLO srvaus02.timesn.com")
	by vger.kernel.org with ESMTP id <S274823AbRIUUn4>;
	Fri, 21 Sep 2001 16:43:56 -0400
Message-ID: <3BABA9F4.3677E423@timesn.com>
Date: Fri, 21 Sep 2001 15:58:28 -0500
From: Ray Bryant <raybry@timesn.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: gibbs@FreeBSD.org, linux-kernel@vger.kernel.org
Subject: AIC-7XXX driver problems with 2.4.9 and L440GX+
Content-Type: multipart/mixed;
 boundary="------------F9DD254A424A24A309CBBBF2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F9DD254A424A24A309CBBBF2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The AIC-7XXX version 6.2.1 driver hangs at startup under 2.4.x  (we've
tried
2.4.2-2 (RH 7.1), 2.4.5, and 2.4.9).
The complete boot output is attached; the interesting parts are 
as follows:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/255 SCBs
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 8195
scsi0:0:0:0: Attempting to queue a TARGET RESET message
aic7xxx_dev_reset returns 8195
Recovery SCB completes
scsi0:0:0:0: Attempting to queue an ABORT message
ahc_intr: HOST_MSG_LOOP bad phase 0x0
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi: device set offline - not ready or command retry failed after bus
reset: host 0 channel 0 id 0 lun 0
<output snipped>

These same machines worked fine with 2.2.18 from www.kernel.org and
2.2.19 from RedHat.  Any suggestions?

Machine is an Intel L440GX+ 700 MHZ PIII 2GB RAM
Adapter is Adaptec AIX-7896 Bios level is v2.20.S1B1
Disks are QUANTUM ATLS TY09TL 
Machine bios is Phoenix 4.0 Release 6.0

-- 
----------------------------------------------------------- 
  Ray Bryant,  Linux Performance Analyst, Times N Systems
   1908 Kramer Lane, Bldg. B, Suite P, Austin, TX 78758
              512-977-5366, raybry@timesn.com
-----------------------------------------------------------
--------------F9DD254A424A24A309CBBBF2
Content-Type: text/plain; charset=us-ascii;
 name="boot.bad"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.bad"

Linux version 2.4.9 (raybry@raybry_lnx) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)) #3 Fri Sep 21 14:55:21 CDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007f7f0000 (usable)
 BIOS-e820: 000000007f7f0000 - 000000007f7ffc00 (ACPI data)
 BIOS-e820: 000000007f7ffc00 - 000000007f800000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2.4.9 ro root=806 console=ttyS0,9600 console=tty0
Initializing CPU#0
Detected 696.982 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1389.36 BogoMIPS
Memory: 899436k/917504k available (1425k kernel code, 17680k reserved, 555k data, 212k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU serial number disabled.
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfdab0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:12.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 91
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2860-0x2867, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2868-0x286f, BIOS settings: hdc:DMA, hdd:pio
hdc: TOSHIBA CD-ROM XM-6702B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Assigned IRQ 10 for device 00:0e.0
PCI: Sharing IRQ 10 with 00:12.2
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:D0:B7:A9:AF:18, IRQ 10.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Intel 440GX chipset
agpgart: AGP aperture is 64M @ 0xf4000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on Intel 440GX @ 0xf4000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 1
SCSI subsystem driver Revision: 1.00
PCI: Assigned IRQ 11 for device 00:0c.0
PCI: Sharing IRQ 11 with 00:0c.1
PCI: Found IRQ 11 for device 00:0c.1
PCI: Sharing IRQ 11 with 00:0c.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/255 SCBs
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 8195
scsi0:0:0:0: Attempting to queue a TARGET RESET message
aic7xxx_dev_reset returns 8195
Recovery SCB completes
scsi0:0:0:0: Attempting to queue an ABORT message
ahc_intr: HOST_MSG_LOOP bad phase 0x0
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 0 lun 0
scsi0:0:1:0: Attempting to queue an ABORT message
scsi0:0:1:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:1:0: Attempting to queue an ABORT message
scsi0:0:1:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:1:0: Attempting to queue a TARGET RESET message
aic7xxx_dev_reset returns 8195
Recovery SCB completes
scsi0:0:1:0: Attempting to queue an ABORT message
ahc_intr: HOST_MSG_LOOP bad phase 0x0
scsi0:0:1:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 1 lun 0
scsi0:0:2:0: Attempting to queue an ABORT message
scsi0:0:2:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:2:0: Attempting to queue an ABORT message
scsi0:0:2:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:2:0: Attempting to queue a TARGET RESET message
aic7xxx_dev_reset returns 8195
Recovery SCB completes
scsi0:0:2:0: Attempting to queue an ABORT message
ahc_intr: HOST_MSG_LOOP bad phase 0x0
scsi0:0:2:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 2 lun 0
scsi0:0:3:0: Attempting to queue an ABORT message
scsi0:0:3:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:3:0: Attempting to queue an ABORT message
scsi0:0:3:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:3:0: Attempting to queue a TARGET RESET message
scsi0:0:3:0: Is not an active device
aic7xxx_dev_reset returns 8194
scsi0:0:3:0: Attempting to queue an ABORT message
scsi0:0:3:0: Command already completed
aic7xxx_abort returns 8194

--------------F9DD254A424A24A309CBBBF2--

