Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129454AbRBCUjI>; Sat, 3 Feb 2001 15:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRBCUi6>; Sat, 3 Feb 2001 15:38:58 -0500
Received: from mail.mbi-berlin.de ([194.95.11.12]:909 "EHLO mail.mbi-berlin.de")
	by vger.kernel.org with ESMTP id <S129454AbRBCUio>;
	Sat, 3 Feb 2001 15:38:44 -0500
Message-ID: <3A7C6B82.6C567930@informatik.hu-berlin.de>
Date: Sat, 03 Feb 2001 21:35:14 +0100
From: Viktor Rosenfeld <rosenfel@informatik.hu-berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Subject: Re: [BUG?] ISA-PnP and 3c509 NIC won't work together
In-Reply-To: <3A7C45E4.15C470A3@informatik.hu-berlin.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Victor,
> 
> Can you respond to your recently-sent linux-kernel e-mail, and provide
> the output of 'dmesg' after all your experiments?  'dmesg' program
> displays the kernel logging buffer, and should give us much additional
> information.

Of course, here it comes.  BTW, ISA-PnP left out and 3c509 compiled as
module won't do it either.  I get the same error message about parm_io. 
As you can see, only when I have ISA-PnP left out and 3c509 compiled-in,
the NIC is recognized.


- Kernel 2.4.1 with ISA-PnP and 3c509 compiled-in:
Linux version 2.4.1 (root@bart) (gcc version 2.95.2 20000220 (Debian
GNU/Linux)) #1 Sam Feb 3 19:41:16 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root=802 mem=256M apm=on
devfs=nomount
Initializing CPU#0
Detected 333.351 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 665.19 BogoMIPS
Memory: 255788k/262144k available (858k kernel code, 5968k reserved,
350k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfaec0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
  got res[10000000:13ffffff] for resource 0 of S3 Inc. 86c968 [Vision
968 VRAM] rev 0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: Card 'TERRATEC SOUNDSYSTEM BASE 1'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.1 present.
30 structures occupying 806 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 01/25/99
Board Vendor: Gigabyte Technology Co. Ltd..
Board Name: i440BX-W977.
Board Version:  .
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169928kB/56642kB, 512 slots per queue
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 11, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875E detected 
sym53c875E-0: rev 0x26 on pci bus 0 device 11 function 0 irq 11
sym53c875E-0: ID 7, Fast-20, Parity Checking
sym53c875E-0: on-chip RAM at 0xed000000
sym53c875E-0: restart (scsi reset).
sym53c875E-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c875E-0-<8,0>: tagged command queue depth set to 8
Detected scsi disk sda at scsi0, channel 0, id 8, lun 0
sym53c875E-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875E-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875E-0-<8,0>: wide: wide=1 chg=0.
sym53c875E-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875E-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875E-0-<8,0>: wide: wide=1 chg=0.
sym53c875E-0-<8,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<8,0>: sync msg in: 1-3-1-c-10.
sym53c875E-0-<8,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=16 fak=0
chg=0.
sym53c875E-0-<8,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 /dev/scsi/host0/bus0/target8/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sym53c875E-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 11 for device 00:07.2
PCI: The same IRQ used for device 00:0b.0
uhci.c: USB UHCI at I/O 0xe000, IRQ 11
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 263144k swap-space (priority -1)
Real Time Clock Driver v1.10d


- Kernel 2.4.1 with ISA-PnP compiled-in and 3c509 compiled as module:
Linux version 2.4.1 (root@bart) (gcc version 2.95.2 20000220 (Debian
GNU/Linux)) #1 Sam Feb 3 20:00:58 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=802 mem=256M apm=on
devfs=nomount
Initializing CPU#0
Detected 333.352 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 665.19 BogoMIPS
Memory: 255796k/262144k available (853k kernel code, 5960k reserved,
348k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfaec0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
  got res[10000000:13ffffff] for resource 0 of S3 Inc. 86c968 [Vision
968 VRAM] rev 0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: Card 'TERRATEC SOUNDSYSTEM BASE 1'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.1 present.
30 structures occupying 806 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 01/25/99
Board Vendor: Gigabyte Technology Co. Ltd..
Board Name: i440BX-W977.
Board Version:  .
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169933kB/56644kB, 512 slots per queue
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 11, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875E detected 
sym53c875E-0: rev 0x26 on pci bus 0 device 11 function 0 irq 11
sym53c875E-0: ID 7, Fast-20, Parity Checking
sym53c875E-0: on-chip RAM at 0xed000000
sym53c875E-0: restart (scsi reset).
sym53c875E-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c875E-0-<8,0>: tagged command queue depth set to 8
Detected scsi disk sda at scsi0, channel 0, id 8, lun 0
sym53c875E-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875E-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875E-0-<8,0>: wide: wide=1 chg=0.
sym53c875E-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875E-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875E-0-<8,0>: wide: wide=1 chg=0.
sym53c875E-0-<8,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<8,0>: sync msg in: 1-3-1-c-10.
sym53c875E-0-<8,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=16 fak=0
chg=0.
sym53c875E-0-<8,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 /dev/scsi/host0/bus0/target8/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sym53c875E-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 11 for device 00:07.2
PCI: The same IRQ used for device 00:0b.0
uhci.c: USB UHCI at I/O 0xe000, IRQ 11
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 263144k swap-space (priority -1)
Real Time Clock Driver v1.10d

(after `modprobe 3c509`)
nothing (error message)


- Kernel 2.4.1 with ISA-PnP and 3c509 compiled as modules:
Linux version 2.4.1 (root@bart) (gcc version 2.95.2 20000220 (Debian
GNU/Linux)) #1 Sam Feb 3 20:19:11 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=802 mem=256M apm=on
devfs=nomount
Initializing CPU#0
Detected 333.351 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 665.19 BogoMIPS
Memory: 255824k/262144k available (838k kernel code, 5932k reserved,
343k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfaec0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
  got res[10000000:13ffffff] for resource 0 of S3 Inc. 86c968 [Vision
968 VRAM] rev 0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.1 present.
30 structures occupying 806 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 01/25/99
Board Vendor: Gigabyte Technology Co. Ltd..
Board Name: i440BX-W977.
Board Version:  .
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169957kB/56652kB, 512 slots per queue
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 11, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875E detected 
sym53c875E-0: rev 0x26 on pci bus 0 device 11 function 0 irq 11
sym53c875E-0: ID 7, Fast-20, Parity Checking
sym53c875E-0: on-chip RAM at 0xed000000
sym53c875E-0: restart (scsi reset).
sym53c875E-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c875E-0-<8,0>: tagged command queue depth set to 8
Detected scsi disk sda at scsi0, channel 0, id 8, lun 0
sym53c875E-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875E-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875E-0-<8,0>: wide: wide=1 chg=0.
sym53c875E-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875E-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875E-0-<8,0>: wide: wide=1 chg=0.
sym53c875E-0-<8,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<8,0>: sync msg in: 1-3-1-c-10.
sym53c875E-0-<8,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=16 fak=0
chg=0.
sym53c875E-0-<8,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 /dev/scsi/host0/bus0/target8/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sym53c875E-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 11 for device 00:07.2
PCI: The same IRQ used for device 00:0b.0
uhci.c: USB UHCI at I/O 0xe000, IRQ 11
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 263144k swap-space (priority -1)
Real Time Clock Driver v1.10d

(after `insmod /lib/modules/2.4.1/.../3c509.o`)
nothing (error message)

(after `modprobe 3c509`)
isapnp: Scanning for Pnp cards...
isapnp: Card 'TERRATEC SOUNDSYSTEM BASE 1'
isapnp: 1 Plug & Play card detected total

plus error message

- Kernel 2.4.1 with ISA-PnP left out and 3c509 compiled as module:
Linux version 2.4.1 (root@bart) (gcc version 2.95.2 20000220 (Debian
GNU/Linux)) #1 Sam Feb 3 20:33:57 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=802 mem=256M apm=on
devfs=nomount
Initializing CPU#0
Detected 333.351 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 665.19 BogoMIPS
Memory: 255824k/262144k available (838k kernel code, 5932k reserved,
343k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfaec0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
  got res[10000000:13ffffff] for resource 0 of S3 Inc. 86c968 [Vision
968 VRAM] rev 0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.1 present.
30 structures occupying 806 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 01/25/99
Board Vendor: Gigabyte Technology Co. Ltd..
Board Name: i440BX-W977.
Board Version:  .
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169957kB/56652kB, 512 slots per queue
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 11, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875E detected 
sym53c875E-0: rev 0x26 on pci bus 0 device 11 function 0 irq 11
sym53c875E-0: ID 7, Fast-20, Parity Checking
sym53c875E-0: on-chip RAM at 0xed000000
sym53c875E-0: restart (scsi reset).
sym53c875E-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c875E-0-<8,0>: tagged command queue depth set to 8
Detected scsi disk sda at scsi0, channel 0, id 8, lun 0
sym53c875E-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875E-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875E-0-<8,0>: wide: wide=1 chg=0.
sym53c875E-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875E-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875E-0-<8,0>: wide: wide=1 chg=0.
sym53c875E-0-<8,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<8,0>: sync msg in: 1-3-1-c-10.
sym53c875E-0-<8,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=16 fak=0
chg=0.
sym53c875E-0-<8,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 /dev/scsi/host0/bus0/target8/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sym53c875E-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 11 for device 00:07.2
PCI: The same IRQ used for device 00:0b.0
uhci.c: USB UHCI at I/O 0xe000, IRQ 11
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 263144k swap-space (priority -1)
Real Time Clock Driver v1.10d

(after modprobe 3c509)
nothing


- Kernel 2.4.1 with ISA-PnP left out and 3c509 compiled-in:
Linux version 2.4.1 (root@bart) (gcc version 2.95.2 20000220 (Debian
GNU/Linux)) #1 Sam Feb 3 21:13:46 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=802 mem=256M apm=on
devfs=nomount
Initializing CPU#0
Detected 333.351 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 665.19 BogoMIPS
Memory: 255816k/262144k available (841k kernel code, 5940k reserved,
344k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfaec0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
  got res[10000000:13ffffff] for resource 0 of S3 Inc. 86c968 [Vision
968 VRAM] rev 0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.1 present.
30 structures occupying 806 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 01/25/99
Board Vendor: Gigabyte Technology Co. Ltd..
Board Name: i440BX-W977.
Board Version:  .
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169952kB/56650kB, 512 slots per queue
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eth0: 3c509 at 0x210, BNC port, address  00 60 8c c1 da da, IRQ 3.
3c509.c:1.16 (2.2) 2/3/98 becker@cesdis.gsfc.nasa.gov.
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 11, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875E detected 
sym53c875E-0: rev 0x26 on pci bus 0 device 11 function 0 irq 11
sym53c875E-0: ID 7, Fast-20, Parity Checking
sym53c875E-0: on-chip RAM at 0xed000000
sym53c875E-0: restart (scsi reset).
sym53c875E-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c875E-0-<8,0>: tagged command queue depth set to 8
Detected scsi disk sda at scsi0, channel 0, id 8, lun 0
sym53c875E-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875E-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875E-0-<8,0>: wide: wide=1 chg=0.
sym53c875E-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875E-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875E-0-<8,0>: wide: wide=1 chg=0.
sym53c875E-0-<8,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<8,0>: sync msg in: 1-3-1-c-10.
sym53c875E-0-<8,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=16 fak=0
chg=0.
sym53c875E-0-<8,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 /dev/scsi/host0/bus0/target8/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sym53c875E-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sym53c875E-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875E-0-<1,0>: sync msg in: 1-3-1-c-f.
sym53c875E-0-<1,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0
chg=0.
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 11 for device 00:07.2
PCI: The same IRQ used for device 00:0b.0
uhci.c: USB UHCI at I/O 0xe000, IRQ 11
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 263144k swap-space (priority -1)
eth0: Setting Rx mode to 1 addresses.
Real Time Clock Driver v1.10d


HTH,
Viktor
-- 
Viktor Rosenfeld
WWW: http://www.informatik.hu-berlin.de/~rosenfel/
Geek Code (3.1):
  GCS/SS d-@ s+: a20 C++@ UL++$ P+ L+++ E--- W++ N++ o? K? !W O? M? V?
  PS++@ PE+(-) Y+ P?(+++) t+ 5+ X- R? !tv b+ DI+ D- G e>+++ h-- r- !y+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
