Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRC3JYJ>; Fri, 30 Mar 2001 04:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131254AbRC3JXu>; Fri, 30 Mar 2001 04:23:50 -0500
Received: from smtp-out.hamburg.pop.de ([195.222.210.86]:45062 "EHLO
	smtp-out.hamburg.pop.de") by vger.kernel.org with ESMTP
	id <S131248AbRC3JXi>; Fri, 30 Mar 2001 04:23:38 -0500
From: Michael Reincke <reincke.m@stn-atlas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <15044.20590.382735.327893@pcew80.atlas.de>
Date: Fri, 30 Mar 2001 11:22:54 +0200
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.3: SCSI-CD-Drive not recognized
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With linux kernel version 2.4.3 my SCSI CDROM-drive isn't longer recognized.  With
kernel version 2.4.2 all work fine.  The kernel configuration didn't changed.
I tried the following combination of Kernel sources and aic7xxx-drivers:

kernel      aic7xxx
2.4.2       5.2.0/5.2.1   worked
2.4.2-ac28  6.1.8         worked
2.4.3       6.1.5/6.1.8   didn't work


here is the output from kernel boot (2.4.3/ 6.1.8):

Mar 30 09:44:35 pcew80 Linux version 2.4.3 (root@pcew80) (gcc version 2.95.3 20010315 (Debian release)) #1 Fri Mar 30 09:24:22 CEST 2001
Mar 30 09:44:35 pcew80 BIOS-provided physical RAM map:
Mar 30 09:44:35 pcew80 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Mar 30 09:44:35 pcew80 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Mar 30 09:44:35 pcew80 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Mar 30 09:44:35 pcew80 BIOS-e820: 0000000000100000 - 0000000017ffd000 (usable)
Mar 30 09:44:35 pcew80 BIOS-e820: 0000000017ffd000 - 0000000017fff000 (ACPI data)
Mar 30 09:44:35 pcew80 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
Mar 30 09:44:35 pcew80 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Mar 30 09:44:35 pcew80 On node 0 totalpages: 98301
Mar 30 09:44:35 pcew80 zone(0): 4096 pages.
Mar 30 09:44:35 pcew80 zone(1): 94205 pages.
Mar 30 09:44:35 pcew80 zone(2): 0 pages.
Mar 30 09:44:35 pcew80 Kernel command line: BOOT_IMAGE=l ro root=801 ramdisk=0
Mar 30 09:44:35 pcew80 Initializing CPU#0
Mar 30 09:44:35 pcew80 Detected 334.096 MHz processor.
Mar 30 09:44:35 pcew80 Console: colour VGA+ 80x50
Mar 30 09:44:35 pcew80 Calibrating delay loop... 666.82 BogoMIPS
Mar 30 09:44:35 pcew80 Memory: 385012k/393204k available (762k kernel code, 7804k reserved, 246k data, 44k init, 0k highmem)
Mar 30 09:44:35 pcew80 Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mar 30 09:44:35 pcew80 Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mar 30 09:44:35 pcew80 Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mar 30 09:44:35 pcew80 Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mar 30 09:44:35 pcew80 VFS: Diskquotas version dquot_6.4.0 initialized
Mar 30 09:44:35 pcew80 CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
Mar 30 09:44:35 pcew80 CPU: L1 I cache: 16K, L1 D cache: 16K
Mar 30 09:44:35 pcew80 CPU: L2 cache: 512K
Mar 30 09:44:35 pcew80 Intel machine check architecture supported.
Mar 30 09:44:35 pcew80 Intel machine check reporting enabled on CPU#0.
Mar 30 09:44:35 pcew80 CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
Mar 30 09:44:35 pcew80 CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
Mar 30 09:44:35 pcew80 CPU: Common caps: 0183f9ff 00000000 00000000 00000000
Mar 30 09:44:35 pcew80 CPU: Intel Pentium II (Deschutes) stepping 01
Mar 30 09:44:35 pcew80 Enabling fast FPU save and restore... done.
Mar 30 09:44:35 pcew80 Checking 'hlt' instruction... OK.
Mar 30 09:44:35 pcew80 POSIX conformance testing by UNIFIX
Mar 30 09:44:35 pcew80 mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
Mar 30 09:44:35 pcew80 mtrr: detected mtrr type: Intel
Mar 30 09:44:35 pcew80 PCI: PCI BIOS revision 2.10 entry at 0xf0750, last bus=1
Mar 30 09:44:35 pcew80 PCI: Using configuration type 1
Mar 30 09:44:35 pcew80 PCI: Probing PCI hardware
Mar 30 09:44:35 pcew80 Unknown bridge resource 0: assuming transparent
Mar 30 09:44:35 pcew80 PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Mar 30 09:44:35 pcew80 Limiting direct PCI/PCI transfers.
Mar 30 09:44:35 pcew80 Linux NET4.0 for Linux 2.4
Mar 30 09:44:35 pcew80 Based upon Swansea University Computer Society NET3.039
Mar 30 09:44:35 pcew80 Initializing RT netlink socket
Mar 30 09:44:35 pcew80 Starting kswapd v1.8
Mar 30 09:44:35 pcew80 pty: 256 Unix98 ptys configured
Mar 30 09:44:35 pcew80 block: queued sectors max/low 255645kB/124573kB, 768 slots per queue
Mar 30 09:44:35 pcew80 Real Time Clock Driver v1.10d
Mar 30 09:44:35 pcew80 SCSI subsystem driver Revision: 1.00
Mar 30 09:44:35 pcew80 request_module[scsi_hostadapter]: Root fs not mounted
Mar 30 09:44:35 pcew80 PCI: Found IRQ 10 for device 00:0b.0
Mar 30 09:44:35 pcew80 scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.8
Mar 30 09:44:35 pcew80 <Adaptec 2940A Ultra SCSI adapter>
Mar 30 09:44:35 pcew80 aic7860: Single Channel A, SCSI Id=7, 3/255 SCBs
Mar 30 09:44:35 pcew80 
Mar 30 09:44:35 pcew80 Vendor: IBM       Model: DDRS-34560        Rev: S71D
Mar 30 09:44:35 pcew80 Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 30 09:44:35 pcew80 Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Mar 30 09:44:35 pcew80 (scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
Mar 30 09:44:35 pcew80 Vendor: IBM       Model: DDRS-34560        Rev: S71D
Mar 30 09:44:35 pcew80 Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 30 09:44:35 pcew80 Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
Mar 30 09:44:35 pcew80 (scsi0:A:1): 20.000MB/s transfers (20.000MHz, offset 15)
Mar 30 09:44:35 pcew80 Vendor: IBM       Model: DDRS-34560        Rev: S97B
Mar 30 09:44:35 pcew80 Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 30 09:44:35 pcew80 Detected scsi disk sdc at scsi0, channel 0, id 3, lun 0
Mar 30 09:44:35 pcew80 (scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 15)
Mar 30 09:44:35 pcew80 Vendor: HP        Model: C1537A            Rev: L812
Mar 30 09:44:35 pcew80 Type:   Sequential-Access                  ANSI SCSI revision: 02
Mar 30 09:44:35 pcew80 (scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 15)
Mar 30 09:44:35 pcew80 scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
Mar 30 09:44:35 pcew80 scsi0:0:1:0: Tagged Queuing enabled.  Depth 253
Mar 30 09:44:35 pcew80 scsi0:0:3:0: Tagged Queuing enabled.  Depth 253
Mar 30 09:44:35 pcew80 SCSI device sda: 8925000 512-byte hdwr sectors (4570 MB)
Mar 30 09:44:35 pcew80 Partition check:
Mar 30 09:44:35 pcew80 sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
Mar 30 09:44:35 pcew80 SCSI device sdb: 8925000 512-byte hdwr sectors (4570 MB)
Mar 30 09:44:35 pcew80 sdb: sdb1
Mar 30 09:44:35 pcew80 SCSI device sdc: 8925000 512-byte hdwr sectors (4570 MB)
Mar 30 09:44:35 pcew80 sdc: sdc1
Mar 30 09:44:35 pcew80 NET4: Linux TCP/IP 1.0 for NET4.0



here is the output from kernel boot (2.4.2-ac28/ 6.1.8):

Mar 30 09:53:30 pcew80 Linux version 2.4.2-ac28 (root@pcew80) (gcc version 2.95.3 20010315 (Debian release)) #1 Thu Mar 29 13:02:56 CEST 2001
Mar 30 09:53:30 pcew80 BIOS-provided physical RAM map:
Mar 30 09:53:30 pcew80 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Mar 30 09:53:30 pcew80 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Mar 30 09:53:30 pcew80 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Mar 30 09:53:30 pcew80 BIOS-e820: 0000000000100000 - 0000000017ffd000 (usable)
Mar 30 09:53:30 pcew80 BIOS-e820: 0000000017ffd000 - 0000000017fff000 (ACPI data)
Mar 30 09:53:30 pcew80 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
Mar 30 09:53:30 pcew80 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Mar 30 09:53:30 pcew80 On node 0 totalpages: 98301
Mar 30 09:53:30 pcew80 zone(0): 4096 pages.
Mar 30 09:53:30 pcew80 zone(1): 94205 pages.
Mar 30 09:53:30 pcew80 zone(2): 0 pages.
Mar 30 09:53:30 pcew80 Local APIC disabled by BIOS -- reenabling.
Mar 30 09:53:30 pcew80 Found and enabled local APIC!
Mar 30 09:53:30 pcew80 Kernel command line: BOOT_IMAGE=l ro root=801 ramdisk=0
Mar 30 09:53:30 pcew80 Initializing CPU#0
Mar 30 09:53:30 pcew80 Detected 334.099 MHz processor.
Mar 30 09:53:30 pcew80 Console: colour VGA+ 80x50
Mar 30 09:53:30 pcew80 Calibrating delay loop... 666.82 BogoMIPS
Mar 30 09:53:30 pcew80 Memory: 385048k/393204k available (762k kernel code, 7768k reserved, 198k data, 52k init, 0k highmem)
Mar 30 09:53:30 pcew80 Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mar 30 09:53:30 pcew80 Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mar 30 09:53:30 pcew80 Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mar 30 09:53:30 pcew80 Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mar 30 09:53:30 pcew80 VFS: Diskquotas version dquot_6.5.0 initialized
Mar 30 09:53:30 pcew80 CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
Mar 30 09:53:30 pcew80 CPU: L1 I cache: 16K, L1 D cache: 16K
Mar 30 09:53:30 pcew80 CPU: L2 cache: 512K
Mar 30 09:53:30 pcew80 Intel machine check architecture supported.
Mar 30 09:53:30 pcew80 Intel machine check reporting enabled on CPU#0.
Mar 30 09:53:30 pcew80 CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Mar 30 09:53:30 pcew80 CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
Mar 30 09:53:30 pcew80 CPU: Common caps: 0183fbff 00000000 00000000 00000000
Mar 30 09:53:30 pcew80 CPU: Intel Pentium II (Deschutes) stepping 01
Mar 30 09:53:30 pcew80 Enabling fast FPU save and restore... done.
Mar 30 09:53:30 pcew80 Checking 'hlt' instruction... OK.
Mar 30 09:53:30 pcew80 POSIX conformance testing by UNIFIX
Mar 30 09:53:30 pcew80 enabled ExtINT on CPU#0
Mar 30 09:53:30 pcew80 ESR value before enabling vector: 00000040
Mar 30 09:53:30 pcew80 ESR value after enabling vector: 00000000
Mar 30 09:53:30 pcew80 Using local APIC timer interrupts.
Mar 30 09:53:30 pcew80 calibrating APIC timer ...
Mar 30 09:53:30 pcew80 ..... CPU clock speed is 334.1116 MHz.
Mar 30 09:53:30 pcew80 ..... host bus clock speed is 66.8220 MHz.
Mar 30 09:53:30 pcew80 cpu: 0, clocks: 668220, slice: 334110
Mar 30 09:53:30 pcew80 CPU0<T0:668208,T1:334096,D:2,S:334110,C:668220>
Mar 30 09:53:30 pcew80 mtrr: v1.39 (20010312) Richard Gooch (rgooch@atnf.csiro.au)
Mar 30 09:53:30 pcew80 mtrr: detected mtrr type: Intel
Mar 30 09:53:30 pcew80 PCI: PCI BIOS revision 2.10 entry at 0xf0750, last bus=1
Mar 30 09:53:30 pcew80 PCI: Using configuration type 1
Mar 30 09:53:30 pcew80 PCI: Probing PCI hardware
Mar 30 09:53:30 pcew80 Unknown bridge resource 0: assuming transparent
Mar 30 09:53:30 pcew80 PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Mar 30 09:53:30 pcew80 Limiting direct PCI/PCI transfers.
Mar 30 09:53:30 pcew80 Linux NET4.0 for Linux 2.4
Mar 30 09:53:30 pcew80 Based upon Swansea University Computer Society NET3.039
Mar 30 09:53:30 pcew80 Initializing RT netlink socket
Mar 30 09:53:30 pcew80 Starting kswapd v1.8
Mar 30 09:53:30 pcew80 pty: 256 Unix98 ptys configured
Mar 30 09:53:30 pcew80 block: queued sectors max/low 255669kB/124597kB, 768 slots per queue
Mar 30 09:53:30 pcew80 Real Time Clock Driver v1.10d
Mar 30 09:53:30 pcew80 SCSI subsystem driver Revision: 1.00
Mar 30 09:53:30 pcew80 request_module[scsi_hostadapter]: Root fs not mounted
Mar 30 09:53:30 pcew80 PCI: Found IRQ 10 for device 00:0b.0
Mar 30 09:53:30 pcew80 scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.8
Mar 30 09:53:30 pcew80 <Adaptec 2940A Ultra SCSI adapter>
Mar 30 09:53:30 pcew80 aic7860: Single Channel A, SCSI Id=7, 3/255 SCBs
Mar 30 09:53:30 pcew80 
Mar 30 09:53:30 pcew80 Vendor: IBM       Model: DDRS-34560        Rev: S71D
Mar 30 09:53:30 pcew80 Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 30 09:53:30 pcew80 (scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
Mar 30 09:53:30 pcew80 Vendor: IBM       Model: DDRS-34560        Rev: S71D
Mar 30 09:53:30 pcew80 Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 30 09:53:30 pcew80 (scsi0:A:1): 20.000MB/s transfers (20.000MHz, offset 15)
Mar 30 09:53:30 pcew80 Vendor: TOSHIBA   Model: CD-ROM XM-6201TA  Rev: 1030
Mar 30 09:53:30 pcew80 Type:   CD-ROM                             ANSI SCSI revision: 02
Mar 30 09:53:30 pcew80 (scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
Mar 30 09:53:30 pcew80 Vendor: IBM       Model: DDRS-34560        Rev: S97B
Mar 30 09:53:30 pcew80 Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 30 09:53:30 pcew80 (scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 15)
Mar 30 09:53:30 pcew80 Vendor: HP        Model: C1537A            Rev: L812
Mar 30 09:53:30 pcew80 Type:   Sequential-Access                  ANSI SCSI revision: 02
Mar 30 09:53:30 pcew80 (scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 15)
Mar 30 09:53:30 pcew80 scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
Mar 30 09:53:30 pcew80 scsi0:0:1:0: Tagged Queuing enabled.  Depth 253
Mar 30 09:53:30 pcew80 scsi0:0:3:0: Tagged Queuing enabled.  Depth 253
Mar 30 09:53:30 pcew80 Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Mar 30 09:53:30 pcew80 Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Mar 30 09:53:30 pcew80 Attached scsi disk sdc at scsi0, channel 0, id 3, lun 0
Mar 30 09:53:30 pcew80 SCSI device sda: 8925000 512-byte hdwr sectors (4570 MB)
Mar 30 09:53:30 pcew80 Partition check:
Mar 30 09:53:30 pcew80 sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
Mar 30 09:53:30 pcew80 SCSI device sdb: 8925000 512-byte hdwr sectors (4570 MB)
Mar 30 09:53:30 pcew80 sdb: sdb1
Mar 30 09:53:30 pcew80 SCSI device sdc: 8925000 512-byte hdwr sectors (4570 MB)
Mar 30 09:53:30 pcew80 sdc: sdc1
Mar 30 09:53:30 pcew80 NET4: Linux TCP/IP 1.0 for NET4.0
Mar 30 09:53:30 pcew80 IP Protocols: ICMP, UDP, TCP
Mar 30 09:53:30 pcew80 IP: routing cache hash table of 4096 buckets, 32Kbytes
Mar 30 09:53:30 pcew80 TCP: Hash tables configured (established 32768 bind 32768)

-- 
Michael Reincke

STN ATLAS Elektronik GmbH, Bremen (Germany)
E-mail : reincke.m@stn-atlas.de |  mail: Sebaldsbrücker Heerstr 235    
phone  : +49-421-457-1606	|        28305 Bremen                  
fax    : +49-421-457-3913       |

