Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269853AbRHIQ3Z>; Thu, 9 Aug 2001 12:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269852AbRHIQ3K>; Thu, 9 Aug 2001 12:29:10 -0400
Received: from [145.254.149.62] ([145.254.149.62]:62960 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S269808AbRHIQ2y>;
	Thu, 9 Aug 2001 12:28:54 -0400
Message-ID: <3B72BA01.34D2A67F@pcsystems.de>
Date: Thu, 09 Aug 2001 18:27:45 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: multiply NULL pointer
Content-Type: multipart/mixed;
 boundary="------------738DD08108C0D11FE493C9FC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------738DD08108C0D11FE493C9FC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello!

Running a p2 400 mhz box with a 3com 3c905, with
_very_ heavy nfs traffic and disc io the following NULL
pointers were produced. I attached the whole dmesg output.
If more informations are needed, I will send them.

After every NULL pointer printed on the console
I took a new dmesg, so the one with the highest number
should be relevant.

The file PSAUX_DMESG2 shows what was still living after
DMESG2.

Sincerly,

Nico

--------------738DD08108C0D11FE493C9FC
Content-Type: text/plain; charset=us-ascii;
 name="DMESG"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMESG"

Linux version 2.4.7 (root@eiche) (gcc version 2.95.2 19991024 (release)) #4 Tue Oct 2 16:55:42 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=new ro root=801 vga=0x0301 nmi_watchdog=1
Initializing CPU#0
Detected 399.323 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 255276k/262144k available (1254k kernel code, 6484k reserved, 434k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfacd0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
ACPI: APM is already active, exiting
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV3 framebuffer ver 0.9.2a (RIVA-128, 8MB @ 0xE6000000)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169493kB/56497kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SV3064D, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 59794560 sectors (30615 MB) w/434KiB Cache, CHS=3722/255/63
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:08.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: HP        Model: HP35480A          Rev: T503
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:4): 5.000MB/s transfers (5.000MHz, offset 8)
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
Adding Swap: 205816k swap-space (priority -1)
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:0c.0
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:08.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa400,  00:60:08:50:b3:45, IRQ 10
  product code 4b4b rev 00.0 date 08-12-97
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:08.0: scatter/gather enabled. h/w checksums disabled
eth0: first available media type: MII
i2c-core.o: i2c core module
piix4.o version 2.5.5 (20010115)
i2c-core.o: adapter SMBus PIIX4 adapter at 5000 registered as adapter 0.
i2c-piix4.o: PIIX4 bus detected and initialized
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-dev.o: Registered 'SMBus PIIX4 adapter at 5000' as minor 0
i2c-isa.o version 2.5.5 (20010115)
i2c-dev.o: Registered 'ISA main adapter' as minor 1
i2c-core.o: adapter ISA main adapter registered as adapter 1.
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-core.o: I2C adapter 40000: I2C level transfers not supported
i2c-core.o: I2C adapter 50000: I2C level transfers not supported
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
c012f5e6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f5e6>]
EFLAGS: 00010286
eax: cce1ff00   ebx: 00000003   ecx: cd58b4c0   edx: 00000000
esi: cd58b4c0   edi: 00000000   ebp: c15de000   esp: c15dffa4
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 8, stackpage=c15df000)
Stack: 00000003 c01300d5 cd58b4c0 00000000 00003607 00000000 c0131d87 cd58b4c0 
       c15de000 c0244877 c15de23b 0008e000 cd58b4c0 c0131e3e 00000001 c01320a5 
       00010f00 c15f7fb0 c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c01300d5>] [<c0131d87>] [<c0131e3e>] [<c01320a5>] [<c0105454>] 

Code: 89 42 24 8b 44 24 0c c1 e0 02 bb 0c 6c 2e c0 89 c2 39 0c 1a 
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
c012f5e6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f5e6>]
EFLAGS: 00010286
eax: caf7ef00   ebx: 00000003   ecx: cd58b4c0   edx: 00000000
esi: cd58b4c0   edi: 00000000   ebp: c15e0000   esp: c15e1fa8
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 7, stackpage=c15e1000)
Stack: 00000003 c01300d5 cd58b4c0 00000000 0000422b 00000000 c0131d87 cd58b4c0 
       c15e0000 c024486e c15e023a 0008e000 cd58b4c0 c0131f95 00000000 00010f00 
       c15f7fbc c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c01300d5>] [<c0131d87>] [<c0131f95>] [<c0105454>] 

Code: 89 42 24 8b 44 24 0c c1 e0 02 bb 0c 6c 2e c0 89 c2 39 0c 1a 
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
c012f5e6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f5e6>]
EFLAGS: 00010282
eax: cc574e40   ebx: 00000003   ecx: cd58b4c0   edx: 00000000
esi: cd58b4c0   edi: 00000000   ebp: cf532000   esp: cf533e80
ds: 0018   es: 0018   ss: 0018
Process rpc.nfsd (pid: 225, stackpage=cf533000)
Stack: 00000003 c01300d5 cd58b4c0 00000000 000084ae 00000000 c0131d87 cd58b4c0 
       cc574e40 00001000 00000001 00000000 cd58b4c0 c0131e22 00000000 c0130014 
       00000001 c0130c9d 00000301 00001000 c3205260 00013000 00000000 cc574e40 
Call Trace: [<c01300d5>] [<c0131d87>] [<c0131e22>] [<c0130014>] [<c0130c9d>] [<c01311e0>] [<c016c496>] 
       [<c0169a20>] [<c0123a60>] [<c012e4cb>] [<c0106ae7>] 

Code: 89 42 24 8b 44 24 0c c1 e0 02 bb 0c 6c 2e c0 89 c2 39 0c 1a 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010013
eax: cd58b508   ebx: 00000000   ecx: 00000001   edx: cd58b50c
esi: cd58b508   edi: fffffff8   ebp: cd297ef4   esp: cd297ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 1928, stackpage=cd297000)
Stack: cd58b4c0 cd58b508 000109a1 cd58b50c 00000001 00000282 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8ac 00000000 00004da0 40092d30 
       00000000 cd296000 00000004 c0110034 bffff87c c411f009 cffe463c cd296000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010013
eax: cd58b508   ebx: 00000000   ecx: 00000001   edx: cd58b50c
esi: cd58b508   edi: fffffff8   ebp: cd297ef4   esp: cd297ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 1929, stackpage=cd297000)
Stack: cd58b4c0 cd58b508 0001099f cd58b50c 00000001 00000282 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8ac 00000000 000049e0 40092d30 
       00000000 cd296000 00000004 c0110034 bffff87c c411f009 cffe463c cd296000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 

--------------738DD08108C0D11FE493C9FC
Content-Type: text/plain; charset=us-ascii;
 name="DMESG2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMESG2"

Linux version 2.4.7 (root@eiche) (gcc version 2.95.2 19991024 (release)) #4 Tue Oct 2 16:55:42 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=new ro root=801 vga=0x0301 nmi_watchdog=1
Initializing CPU#0
Detected 399.322 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 255276k/262144k available (1254k kernel code, 6484k reserved, 434k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfacd0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
ACPI: APM is already active, exiting
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV3 framebuffer ver 0.9.2a (RIVA-128, 8MB @ 0xE6000000)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169493kB/56497kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SV3064D, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 59794560 sectors (30615 MB) w/434KiB Cache, CHS=3722/255/63
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:08.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: HP        Model: HP35480A          Rev: T503
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:4): 5.000MB/s transfers (5.000MHz, offset 8)
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
Adding Swap: 205816k swap-space (priority -1)
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:01) ...
reiserfs: replayed 23 transactions in 9 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:03) ...
reiserfs: replayed 23 transactions in 4 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:0c.0
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:08.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa400,  00:60:08:50:b3:45, IRQ 10
  product code 4b4b rev 00.0 date 08-12-97
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:08.0: scatter/gather enabled. h/w checksums disabled
eth0: first available media type: MII
nmap uses obsolete (PF_INET,SOCK_PACKET)
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00002f8f   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c15de000   esp: c15dffc4
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 8, stackpage=c15df000)
Stack: c15de000 c0244877 c15de23b 0008e000 00000000 c0131e3e 00000001 c01320a5 
       00010f00 c15f7fb0 c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c0131e3e>] [<c01320a5>] [<c0105454>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00004216   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c15e0000   esp: c15e1fc8
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 7, stackpage=c15e1000)
Stack: c15e0000 c024486e c15e023a 0008e000 00000000 c0131f95 00000000 00010f00 
       c15f7fbc c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c0131f95>] [<c0105454>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 

--------------738DD08108C0D11FE493C9FC
Content-Type: text/plain; charset=us-ascii;
 name="DMESG3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMESG3"

Linux version 2.4.7 (root@eiche) (gcc version 2.95.2 19991024 (release)) #4 Tue Oct 2 16:55:42 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=new ro root=801 vga=0x0301 nmi_watchdog=1
Initializing CPU#0
Detected 399.322 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 255276k/262144k available (1254k kernel code, 6484k reserved, 434k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfacd0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
ACPI: APM is already active, exiting
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV3 framebuffer ver 0.9.2a (RIVA-128, 8MB @ 0xE6000000)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169493kB/56497kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SV3064D, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 59794560 sectors (30615 MB) w/434KiB Cache, CHS=3722/255/63
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:08.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: HP        Model: HP35480A          Rev: T503
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:4): 5.000MB/s transfers (5.000MHz, offset 8)
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
Adding Swap: 205816k swap-space (priority -1)
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:01) ...
reiserfs: replayed 23 transactions in 9 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:03) ...
reiserfs: replayed 23 transactions in 4 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:0c.0
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:08.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa400,  00:60:08:50:b3:45, IRQ 10
  product code 4b4b rev 00.0 date 08-12-97
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:08.0: scatter/gather enabled. h/w checksums disabled
eth0: first available media type: MII
nmap uses obsolete (PF_INET,SOCK_PACKET)
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00002f8f   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c15de000   esp: c15dffc4
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 8, stackpage=c15df000)
Stack: c15de000 c0244877 c15de23b 0008e000 00000000 c0131e3e 00000001 c01320a5 
       00010f00 c15f7fb0 c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c0131e3e>] [<c01320a5>] [<c0105454>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00004216   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c15e0000   esp: c15e1fc8
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 7, stackpage=c15e1000)
Stack: c15e0000 c024486e c15e023a 0008e000 00000000 c0131f95 00000000 00010f00 
       c15f7fbc c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c0131f95>] [<c0105454>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00008373   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: cc21e000   esp: cc21fea0
ds: 0018   es: 0018   ss: 0018
Process rpc.nfsd (pid: 450, stackpage=cc21f000)
Stack: c69a7da0 00001000 00000001 00000000 00000000 c0131e22 00000000 c0130014 
       00000001 c0130c9d 00000301 00001000 cb9bb7e0 003b7000 00000000 c69a7da0 
       00001000 c01311e0 cb9bb7e0 c117c29c 00000000 00001000 00001000 c117c29c 
Call Trace: [<c0131e22>] [<c0130014>] [<c0130c9d>] [<c01311e0>] [<c016c496>] [<c0169a20>] [<c0123a60>] 
       [<c012e4cb>] [<c0106ae7>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 

--------------738DD08108C0D11FE493C9FC
Content-Type: text/plain; charset=us-ascii;
 name="DMESG4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMESG4"

Linux version 2.4.7 (root@eiche) (gcc version 2.95.2 19991024 (release)) #4 Tue Oct 2 16:55:42 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=new ro root=801 vga=0x0301 nmi_watchdog=1
Initializing CPU#0
Detected 399.322 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 255276k/262144k available (1254k kernel code, 6484k reserved, 434k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfacd0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
ACPI: APM is already active, exiting
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV3 framebuffer ver 0.9.2a (RIVA-128, 8MB @ 0xE6000000)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169493kB/56497kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SV3064D, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 59794560 sectors (30615 MB) w/434KiB Cache, CHS=3722/255/63
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:08.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: HP        Model: HP35480A          Rev: T503
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:4): 5.000MB/s transfers (5.000MHz, offset 8)
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
Adding Swap: 205816k swap-space (priority -1)
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:01) ...
reiserfs: replayed 23 transactions in 9 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:03) ...
reiserfs: replayed 23 transactions in 4 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:0c.0
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:08.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa400,  00:60:08:50:b3:45, IRQ 10
  product code 4b4b rev 00.0 date 08-12-97
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:08.0: scatter/gather enabled. h/w checksums disabled
eth0: first available media type: MII
nmap uses obsolete (PF_INET,SOCK_PACKET)
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00002f8f   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c15de000   esp: c15dffc4
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 8, stackpage=c15df000)
Stack: c15de000 c0244877 c15de23b 0008e000 00000000 c0131e3e 00000001 c01320a5 
       00010f00 c15f7fb0 c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c0131e3e>] [<c01320a5>] [<c0105454>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00004216   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c15e0000   esp: c15e1fc8
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 7, stackpage=c15e1000)
Stack: c15e0000 c024486e c15e023a 0008e000 00000000 c0131f95 00000000 00010f00 
       c15f7fbc c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c0131f95>] [<c0105454>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00008373   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: cc21e000   esp: cc21fea0
ds: 0018   es: 0018   ss: 0018
Process rpc.nfsd (pid: 450, stackpage=cc21f000)
Stack: c69a7da0 00001000 00000001 00000000 00000000 c0131e22 00000000 c0130014 
       00000001 c0130c9d 00000301 00001000 cb9bb7e0 003b7000 00000000 c69a7da0 
       00001000 c01311e0 cb9bb7e0 c117c29c 00000000 00001000 00001000 c117c29c 
Call Trace: [<c0131e22>] [<c0130014>] [<c0130c9d>] [<c01311e0>] [<c016c496>] [<c0169a20>] [<c0123a60>] 
       [<c012e4cb>] [<c0106ae7>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c8dcdef4   esp: c8dcded8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 505, stackpage=c8dcd000)
Stack: cb6753a0 cb6753e8 000106e7 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 0000fda0 40092d30 
       00000000 c8dcc000 00000004 c0110034 bffff88c cc7f5009 ced60c7c c8dcc000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 

--------------738DD08108C0D11FE493C9FC
Content-Type: text/plain; charset=us-ascii;
 name="DMESG5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMESG5"

Linux version 2.4.7 (root@eiche) (gcc version 2.95.2 19991024 (release)) #4 Tue Oct 2 16:55:42 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=new ro root=801 vga=0x0301 nmi_watchdog=1
Initializing CPU#0
Detected 399.322 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 255276k/262144k available (1254k kernel code, 6484k reserved, 434k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfacd0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
ACPI: APM is already active, exiting
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV3 framebuffer ver 0.9.2a (RIVA-128, 8MB @ 0xE6000000)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169493kB/56497kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SV3064D, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 59794560 sectors (30615 MB) w/434KiB Cache, CHS=3722/255/63
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:08.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: HP        Model: HP35480A          Rev: T503
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:4): 5.000MB/s transfers (5.000MHz, offset 8)
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
Adding Swap: 205816k swap-space (priority -1)
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:01) ...
reiserfs: replayed 23 transactions in 9 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:03) ...
reiserfs: replayed 23 transactions in 4 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:0c.0
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:08.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa400,  00:60:08:50:b3:45, IRQ 10
  product code 4b4b rev 00.0 date 08-12-97
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:08.0: scatter/gather enabled. h/w checksums disabled
eth0: first available media type: MII
nmap uses obsolete (PF_INET,SOCK_PACKET)
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00002f8f   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c15de000   esp: c15dffc4
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 8, stackpage=c15df000)
Stack: c15de000 c0244877 c15de23b 0008e000 00000000 c0131e3e 00000001 c01320a5 
       00010f00 c15f7fb0 c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c0131e3e>] [<c01320a5>] [<c0105454>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00004216   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c15e0000   esp: c15e1fc8
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 7, stackpage=c15e1000)
Stack: c15e0000 c024486e c15e023a 0008e000 00000000 c0131f95 00000000 00010f00 
       c15f7fbc c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c0131f95>] [<c0105454>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00008373   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: cc21e000   esp: cc21fea0
ds: 0018   es: 0018   ss: 0018
Process rpc.nfsd (pid: 450, stackpage=cc21f000)
Stack: c69a7da0 00001000 00000001 00000000 00000000 c0131e22 00000000 c0130014 
       00000001 c0130c9d 00000301 00001000 cb9bb7e0 003b7000 00000000 c69a7da0 
       00001000 c01311e0 cb9bb7e0 c117c29c 00000000 00001000 00001000 c117c29c 
Call Trace: [<c0131e22>] [<c0130014>] [<c0130c9d>] [<c01311e0>] [<c016c496>] [<c0169a20>] [<c0123a60>] 
       [<c012e4cb>] [<c0106ae7>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c8dcdef4   esp: c8dcded8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 505, stackpage=c8dcd000)
Stack: cb6753a0 cb6753e8 000106e7 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 0000fda0 40092d30 
       00000000 c8dcc000 00000004 c0110034 bffff88c cc7f5009 ced60c7c c8dcc000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 511, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106f1 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 00001ca0 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 512, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106ed cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 000011e0 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 513, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106f3 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 00001ba0 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 514, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106f3 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 00001a60 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 515, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106ed cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 000018a0 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 

--------------738DD08108C0D11FE493C9FC
Content-Type: text/plain; charset=us-ascii;
 name="NULLPOINTER"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="NULLPOINTER"

Linux version 2.4.7 (root@eiche) (gcc version 2.95.2 19991024 (release)) #4 Tue Oct 2 16:55:42 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=new ro root=801 vga=0x0301 nmi_watchdog=1
Initializing CPU#0
Detected 399.323 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 255276k/262144k available (1254k kernel code, 6484k reserved, 434k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfacd0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
ACPI: APM is already active, exiting
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV3 framebuffer ver 0.9.2a (RIVA-128, 8MB @ 0xE6000000)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169493kB/56497kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SV3064D, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 59794560 sectors (30615 MB) w/434KiB Cache, CHS=3722/255/63
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:08.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: HP        Model: HP35480A          Rev: T503
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:4): 5.000MB/s transfers (5.000MHz, offset 8)
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
Adding Swap: 205816k swap-space (priority -1)
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:0c.0
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:08.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa400,  00:60:08:50:b3:45, IRQ 10
  product code 4b4b rev 00.0 date 08-12-97
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:08.0: scatter/gather enabled. h/w checksums disabled
eth0: first available media type: MII
i2c-core.o: i2c core module
piix4.o version 2.5.5 (20010115)
i2c-core.o: adapter SMBus PIIX4 adapter at 5000 registered as adapter 0.
i2c-piix4.o: PIIX4 bus detected and initialized
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-dev.o: Registered 'SMBus PIIX4 adapter at 5000' as minor 0
i2c-isa.o version 2.5.5 (20010115)
i2c-dev.o: Registered 'ISA main adapter' as minor 1
i2c-core.o: adapter ISA main adapter registered as adapter 1.
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-core.o: I2C adapter 40000: I2C level transfers not supported
i2c-core.o: I2C adapter 50000: I2C level transfers not supported
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
c012f5e6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f5e6>]
EFLAGS: 00010286
eax: cce1ff00   ebx: 00000003   ecx: cd58b4c0   edx: 00000000
esi: cd58b4c0   edi: 00000000   ebp: c15de000   esp: c15dffa4
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 8, stackpage=c15df000)
Stack: 00000003 c01300d5 cd58b4c0 00000000 00003607 00000000 c0131d87 cd58b4c0 
       c15de000 c0244877 c15de23b 0008e000 cd58b4c0 c0131e3e 00000001 c01320a5 
       00010f00 c15f7fb0 c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c01300d5>] [<c0131d87>] [<c0131e3e>] [<c01320a5>] [<c0105454>] 

Code: 89 42 24 8b 44 24 0c c1 e0 02 bb 0c 6c 2e c0 89 c2 39 0c 1a 
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
c012f5e6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f5e6>]
EFLAGS: 00010286
eax: caf7ef00   ebx: 00000003   ecx: cd58b4c0   edx: 00000000
esi: cd58b4c0   edi: 00000000   ebp: c15e0000   esp: c15e1fa8
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 7, stackpage=c15e1000)
Stack: 00000003 c01300d5 cd58b4c0 00000000 0000422b 00000000 c0131d87 cd58b4c0 
       c15e0000 c024486e c15e023a 0008e000 cd58b4c0 c0131f95 00000000 00010f00 
       c15f7fbc c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c01300d5>] [<c0131d87>] [<c0131f95>] [<c0105454>] 

Code: 89 42 24 8b 44 24 0c c1 e0 02 bb 0c 6c 2e c0 89 c2 39 0c 1a 
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
c012f5e6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f5e6>]
EFLAGS: 00010282
eax: cc574e40   ebx: 00000003   ecx: cd58b4c0   edx: 00000000
esi: cd58b4c0   edi: 00000000   ebp: cf532000   esp: cf533e80
ds: 0018   es: 0018   ss: 0018
Process rpc.nfsd (pid: 225, stackpage=cf533000)
Stack: 00000003 c01300d5 cd58b4c0 00000000 000084ae 00000000 c0131d87 cd58b4c0 
       cc574e40 00001000 00000001 00000000 cd58b4c0 c0131e22 00000000 c0130014 
       00000001 c0130c9d 00000301 00001000 c3205260 00013000 00000000 cc574e40 
Call Trace: [<c01300d5>] [<c0131d87>] [<c0131e22>] [<c0130014>] [<c0130c9d>] [<c01311e0>] [<c016c496>] 
       [<c0169a20>] [<c0123a60>] [<c012e4cb>] [<c0106ae7>] 

Code: 89 42 24 8b 44 24 0c c1 e0 02 bb 0c 6c 2e c0 89 c2 39 0c 1a 

--------------738DD08108C0D11FE493C9FC
Content-Type: text/plain; charset=us-ascii;
 name="PSAUX_DMESG2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PSAUX_DMESG2"

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.2  0.0   344  192 ?        S    Oct06   0:04 init [2] 
root         2  0.0  0.0     0    0 ?        SW   Oct06   0:00 [keventd]
root         3 30.4  0.0     0    0 ?        SW   Oct06   8:47 [kapm-idled]
root         4  0.0  0.0     0    0 ?        SWN  Oct06   0:00 [ksoftirqd_CPU0]
root         5  0.1  0.0     0    0 ?        SW   Oct06   0:02 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   Oct06   0:00 [kreclaimd]
root         7  0.1  0.0     0    0 ?        Z    Oct06   0:01 [bdflush <defunct>]
root         8  0.0  0.0     0    0 ?        Z    Oct06   0:01 [kupdated <defunct>]
root         9  0.0  0.0     0    0 ?        SW   Oct06   0:00 [scsi_eh_0]
root        10  0.0  0.0     0    0 ?        SW   Oct06   0:00 [kjournald]
root        37  0.0  0.0     0    0 ?        SW   Oct06   0:00 [kjournald]
root        38  0.0  0.0     0    0 ?        SW   Oct06   0:00 [kreiserfsd]
root        39  0.0  0.0     0    0 ?        SW   Oct06   0:00 [kjournald]
bin        150  0.0  0.2  1272  528 ?        S    Oct06   0:00 /sbin/portmap
root       168  0.0  0.2  1308  656 ?        S    Oct06   0:00 /usr/sbin/syslogd
root       172  0.0  0.2  1324  584 ?        S    Oct06   0:00 /usr/sbin/klogd -c 1
lp         261  0.0  0.3  1788  828 ?        S    Oct06   0:00 lpd Waiting  
root       286  0.0  0.3  2320  996 ?        S    Oct06   0:00 /usr/sbin/sshd
root       307  0.0  0.5  2424 1472 vc/1     S    Oct06   0:00 -bash
root       308  0.0  0.5  2424 1472 vc/2     S    Oct06   0:01 -bash
root       309  0.0  0.5  2424 1460 vc/3     S    Oct06   0:00 -bash
root       310  0.0  0.2  1232  516 vc/4     S    Oct06   0:00 /sbin/agetty vc/4 57600
root       311  0.0  0.2  1232  516 vc/5     S    Oct06   0:00 /sbin/agetty vc/5 57600
root       312  0.0  0.2  1232  516 vc/6     S    Oct06   0:00 /sbin/agetty vc/6 57600
root       407  0.0  0.5  2408 1284 ?        S    Oct06   0:00 /usr/sbin/sshd
root       408  0.0  0.5  2440 1480 pts/0    S    Oct06   0:00 -bash
root       416  0.0  0.5  2408 1284 ?        S    Oct06   0:00 /usr/sbin/sshd
root       417  0.0  0.5  2440 1484 pts/1    S    Oct06   0:00 -bash
root       447  0.0  0.3  1760  860 ?        S    Oct06   0:00 /usr/sbin/rpc.mountd
root       450 37.0  0.4  2116 1220 ?        S<   Oct06   1:11 /usr/sbin/rpc.nfsd
root       454  2.5  0.5  2212 1396 vc/1     S    Oct06   0:03 top
root       457  0.0  0.4  2992 1244 vc/2     R    00:00   0:00 ps xau

--------------738DD08108C0D11FE493C9FC--

