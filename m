Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVKHMNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVKHMNQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVKHMNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:13:16 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:2533 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S964886AbVKHMNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:13:15 -0500
Date: Tue, 8 Nov 2005 13:13:18 +0100
From: Sander <sander@humilis.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1 libata pata_via
Message-ID: <20051108121318.GB23549@favonius>
Reply-To: sander@humilis.net
References: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net>
X-Uptime: 09:07:12 up 20:33, 17 users,  load average: 1.00, 1.45, 2.95
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On a Via Epia MII 10k running 2.6.14-mm1 I can't seem to fdisk or dd
/dev/sde or /dev/sdf. I can mount /dev/sde1, which is a small partition
for /boot, and 'ls /boot' lists the kernels.

I forgot to write down the errors fdisk and dd generate. I did create
the nodes in /dev/ with MAKEDEV.

The two pata disks are master and slave. I might try them on separate
channels later (especially if you want me to :-)

/dev/sd[a-d] are sata disks.

dmesg and lspci -v:


	[cut]
[42949375.120000] libata version 1.12 loaded.
[42949375.120000] sata_promise 0000:00:14.0: version 1.02
[42949375.120000] ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LNKB] -> GSI 12 (level, low) -> IRQ 12
[42949375.140000] ata1: SATA max UDMA/133 cmd 0xF8804200 ctl 0xF8804238 bmdma 0x0 irq 12
[42949375.140000] ata2: SATA max UDMA/133 cmd 0xF8804280 ctl 0xF88042B8 bmdma 0x0 irq 12
[42949375.140000] ata3: SATA max UDMA/133 cmd 0xF8804300 ctl 0xF8804338 bmdma 0x0 irq 12
[42949375.140000] ata4: SATA max UDMA/133 cmd 0xF8804380 ctl 0xF88043B8 bmdma 0x0 irq 12
[42949375.220000] input: AT Translated Set 2 keyboard as /class/input/input0
[42949375.530000] ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043 88:407f
[42949375.530000] ata1: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[42949375.530000] ata1: dev 0 configured for UDMA/133
[42949375.530000] scsi0 : sata_promise
[42949375.920000] ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043 88:407f
[42949375.920000] ata2: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[42949375.920000] ata2: dev 0 configured for UDMA/133
[42949375.920000] scsi1 : sata_promise
[42949376.310000] ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043 88:407f
[42949376.310000] ata3: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[42949376.310000] ata3: dev 0 configured for UDMA/133
[42949376.310000] scsi2 : sata_promise
[42949376.700000] ata4: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043 88:407f
[42949376.700000] ata4: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[42949376.700000] ata4: dev 0 configured for UDMA/133
[42949376.700000] scsi3 : sata_promise
[42949376.700000]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[42949376.700000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[42949376.700000]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[42949376.700000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[42949376.700000]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[42949376.700000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[42949376.700000]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[42949376.700000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[42949376.700000] ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
[42949376.700000] PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 5
[42949376.700000] ata5: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xCC00 irq 14
[42949376.860000] ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:047f
[42949376.860000] ata5: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
[42949376.860000] ata5: dev 1 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:047f
[42949376.860000] ata5: dev 1 ATA-7, max UDMA/133, 490234752 sectors: LBA48
[42949376.860000] ata5: dev 0 configured for UDMA/100
[42949376.860000] ata5: dev 1 configured for UDMA/100
[42949376.860000] scsi4 : pata_via
[42949376.860000]   Vendor: ATA       Model: Maxtor 6Y200P0    Rev: YAR4
[42949376.860000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[42949376.860000]   Vendor: ATA       Model: Maxtor 7Y250P0    Rev: YAR4
[42949376.860000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[42949376.860000] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xCC08 irq 15
[42949377.030000] ATA: abnormal status 0xFF on port 0x177
[42949377.030000] ata6: disabling port
[42949377.030000] scsi5 : pata_via
[42949377.030000] SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
[42949377.030000] SCSI device sda: drive cache: write back
[42949377.030000] SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
[42949377.030000] SCSI device sda: drive cache: write back
[42949377.030000]  sda: sda1 sda2
[42949377.050000] sd 0:0:0:0: Attached scsi disk sda
[42949377.050000] SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
[42949377.050000] SCSI device sdb: drive cache: write back
[42949377.050000] SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
[42949377.050000] SCSI device sdb: drive cache: write back
[42949377.050000]  sdb: sdb1 sdb2
[42949377.070000] sd 1:0:0:0: Attached scsi disk sdb
[42949377.070000] SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
[42949377.070000] SCSI device sdc: drive cache: write back
[42949377.070000] SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
[42949377.070000] SCSI device sdc: drive cache: write back
[42949377.070000]  sdc: sdc1 sdc2
[42949377.090000] sd 2:0:0:0: Attached scsi disk sdc
[42949377.090000] SCSI device sdd: 586114704 512-byte hdwr sectors (300091 MB)
[42949377.090000] SCSI device sdd: drive cache: write back
[42949377.090000] SCSI device sdd: 586114704 512-byte hdwr sectors (300091 MB)
[42949377.090000] SCSI device sdd: drive cache: write back
[42949377.090000]  sdd: sdd1 sdd2
[42949377.110000] sd 3:0:0:0: Attached scsi disk sdd
[42949377.110000] SCSI device sde: 398297088 512-byte hdwr sectors (203928 MB)
[42949377.110000] SCSI device sde: drive cache: write back
[42949377.110000] SCSI device sde: 398297088 512-byte hdwr sectors (203928 MB)
[42949377.110000] SCSI device sde: drive cache: write back
[42949377.110000]  sde: sde1 sde2
[42949377.130000] sd 4:0:0:0: Attached scsi disk sde
[42949377.130000] SCSI device sdf: 490234752 512-byte hdwr sectors (251000 MB)
[42949377.130000] SCSI device sdf: drive cache: write back
[42949377.130000] SCSI device sdf: 490234752 512-byte hdwr sectors (251000 MB)
[42949377.130000] SCSI device sdf: drive cache: write back
[42949377.130000]  sdf:<3>ata5: command error, drv_stat 0x51 host_stat 0x64
[42949377.210000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949377.210000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949377.210000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949377.280000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949377.280000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949377.280000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949377.280000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949377.360000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949377.360000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949377.360000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949377.360000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949377.430000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949377.430000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949377.430000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949377.430000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949377.510000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949377.510000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949377.510000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949377.510000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949377.510000] sd 4:0:1:0: SCSI error: return code = 0x8000002
[42949377.510000] sdf: Current: sense key: Aborted Command
[42949377.510000]     Additional sense: Scsi parity error
[42949377.510000] Info fld=0x0
[42949377.510000] end_request: I/O error, dev sdf, sector 0
[42949377.510000] Buffer I/O error on device sdf, logical block 0
[42949377.580000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949377.580000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949377.580000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949377.580000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949377.660000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949377.660000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949377.660000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949377.660000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949377.730000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949377.730000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949377.730000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949377.730000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949377.810000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949377.810000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949377.810000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949377.810000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949377.880000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949377.880000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949377.880000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949377.880000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949377.880000] sd 4:0:1:0: SCSI error: return code = 0x8000002
[42949377.880000] sdf: Current: sense key: Aborted Command
[42949377.880000]     Additional sense: Scsi parity error
[42949377.880000] Info fld=0x0
[42949377.880000] end_request: I/O error, dev sdf, sector 0
[42949377.880000] Buffer I/O error on device sdf, logical block 0
[42949377.880000]  unable to read partition table
[42949377.880000] sd 4:0:1:0: Attached scsi disk sdf
[42949377.880000] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
[42949377.880000] Yenta: CardBus bridge found at 0000:00:0a.0 [1106:aa01]
[42949378.020000] Yenta: ISA IRQ mask 0x0c08, PCI irq 5
[42949378.020000] Socket status: 30000006
[42949378.280000] ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKB] -> GSI 12 (level, low) -> IRQ 12
[42949378.280000] Yenta: CardBus bridge found at 0000:00:0a.1 [1106:aa01]
[42949378.420000] Yenta: ISA IRQ mask 0x0c08, PCI irq 12
[42949378.420000] Socket status: 30000006
[42949378.680000] DLM (built Nov  8 2005 11:23:33) installed
[42949378.680000] md: linear personality registered as nr 1
[42949378.680000] md: raid0 personality registered as nr 2
[42949378.680000] md: raid1 personality registered as nr 3
[42949378.680000] md: raid10 personality registered as nr 9
[42949378.680000] md: raid5 personality registered as nr 4
[42949378.680000] raid5: automatically using best checksumming function: pIII_sse
[42949378.730000]    pIII_sse  :  2684.000 MB/sec
[42949378.730000] raid5: using function: pIII_sse (2684.000 MB/sec)
[42949378.900000] raid6: int32x1    166 MB/s
[42949379.070000] raid6: int32x2    200 MB/s
[42949379.240000] raid6: int32x4    182 MB/s
[42949379.410000] raid6: int32x8    135 MB/s
[42949379.580000] raid6: mmxx1      418 MB/s
[42949379.750000] raid6: mmxx2      588 MB/s
[42949379.920000] raid6: sse1x1     362 MB/s
[42949380.090000] raid6: sse1x2     555 MB/s
[42949380.090000] raid6: using algorithm sse1x2 (555 MB/s)
[42949380.090000] md: raid6 personality registered as nr 8
[42949380.090000] md: multipath personality registered as nr 7
[42949380.090000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[42949380.090000] md: bitmap version 4.39
[42949380.090000] NET: Registered protocol family 2
[42949380.190000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[42949380.190000] TCP established hash table entries: 131072 (order: 7, 524288 bytes)
[42949380.190000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[42949380.190000] TCP: Hash tables configured (established 131072 bind 65536)
[42949380.190000] TCP reno registered
[42949380.190000] TCP bic registered
[42949380.190000] Initializing IPsec netlink socket
[42949380.190000] NET: Registered protocol family 1
[42949380.190000] NET: Registered protocol family 10
[42949380.190000] Disabled Privacy Extensions on device c03d6100(lo)
[42949380.190000] IPv6 over IPv4 tunneling driver
[42949380.190000] NET: Registered protocol family 17
[42949380.250000] SCTP: Hash tables configured (established 65536 bind 65536)
[42949380.250000] Using IPI Shortcut mode
[42949380.250000] ACPI wakeup devices: 
[42949380.250000] PCI0 USB0 USB1 USB2 USB3 USB4 USB5 USB6 LAN0 AC97 MC97 UAR1 
[42949380.250000] ACPI: (supports S0 S1 S3 S4 S5)
[42949380.250000] md: Autodetecting RAID arrays.
[42949380.340000] md: autorun ...
[42949380.340000] md: considering sdd1 ...
[42949380.340000] md:  adding sdd1 ...
[42949380.340000] md:  adding sdc1 ...
[42949380.340000] md:  adding sdb1 ...
[42949380.340000] md:  adding sda1 ...
[42949380.340000] md: created md0
[42949380.340000] md: bind<sda1>
[42949380.340000] md: bind<sdb1>
[42949380.340000] md: bind<sdc1>
[42949380.340000] md: bind<sdd1>
[42949380.340000] md: running: <sdd1><sdc1><sdb1><sda1>
[42949380.340000] raid1: raid set md0 active with 4 out of 4 mirrors
[42949380.340000] md: ... autorun DONE.
[42949380.350000] VFS: Mounted root (ext2 filesystem) readonly.
[42949380.350000] Freeing unused kernel memory: 168k freed
[42949381.600000] EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
[42949384.390000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[42949452.690000] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[42949452.860000] spurious 8259A interrupt: IRQ7.
[42949463.620000] eth0: no IPv6 routers present
[42949589.450000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949589.450000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949589.450000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949589.450000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949589.520000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949589.520000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949589.520000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949589.520000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949589.590000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949589.590000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949589.590000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949589.590000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949589.650000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949589.650000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949589.650000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949589.650000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949589.700000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949589.700000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949589.700000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949589.700000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949589.700000] sd 4:0:0:0: SCSI error: return code = 0x8000002
[42949589.700000] sde: Current: sense key: Aborted Command
[42949589.700000]     Additional sense: Scsi parity error
[42949589.700000] Info fld=0x0
[42949589.700000] end_request: I/O error, dev sde, sector 0
[42949589.700000] Buffer I/O error on device sde, logical block 0
[42949593.730000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949593.730000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949593.730000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949593.730000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949593.810000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949593.810000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949593.810000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949593.810000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949593.880000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949593.880000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949593.880000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949593.880000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949593.960000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949593.960000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949593.960000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949593.960000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.030000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.030000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.030000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.030000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.030000] sd 4:0:1:0: SCSI error: return code = 0x8000002
[42949594.030000] sdf: Current: sense key: Aborted Command
[42949594.030000]     Additional sense: Scsi parity error
[42949594.030000] Info fld=0x0
[42949594.030000] end_request: I/O error, dev sdf, sector 0
[42949594.030000] Buffer I/O error on device sdf, logical block 0
[42949594.110000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.110000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.110000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.110000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.180000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.180000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.180000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.180000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.260000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.260000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.260000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.260000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.330000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.330000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.330000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.330000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.410000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.410000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.410000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.410000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.410000] sd 4:0:1:0: SCSI error: return code = 0x8000002
[42949594.410000] sdf: Current: sense key: Aborted Command
[42949594.410000]     Additional sense: Scsi parity error
[42949594.410000] Info fld=0x8
[42949594.410000] end_request: I/O error, dev sdf, sector 8
[42949594.410000] Buffer I/O error on device sdf, logical block 1
[42949594.480000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.480000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.480000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.480000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.560000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.560000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.560000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.560000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.630000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.630000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.630000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.630000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.710000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.710000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.710000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.710000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.780000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.780000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.780000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.780000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.780000] sd 4:0:1:0: SCSI error: return code = 0x8000002
[42949594.780000] sdf: Current: sense key: Aborted Command
[42949594.780000]     Additional sense: Scsi parity error
[42949594.780000] Info fld=0x10
[42949594.780000] end_request: I/O error, dev sdf, sector 16
[42949594.780000] Buffer I/O error on device sdf, logical block 2
[42949594.860000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.860000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.860000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.860000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949594.930000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949594.930000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949594.930000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949594.930000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949595.010000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949595.010000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949595.010000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949595.010000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949595.080000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949595.080000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949595.080000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949595.080000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949595.160000] ata5: command error, drv_stat 0x51 host_stat 0x64
[42949595.160000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
[42949595.160000] ata5: status=0x51 { DriveReady SeekComplete Error }
[42949595.160000] ata5: error=0x84 { DriveStatusError BadCRC }
[42949595.160000] sd 4:0:1:0: SCSI error: return code = 0x8000002
[42949595.160000] sdf: Current: sense key: Aborted Command
[42949595.160000]     Additional sense: Scsi parity error
[42949595.160000] Info fld=0x0
[42949595.160000] end_request: I/O error, dev sdf, sector 0
[42949595.160000] Buffer I/O error on device sdf, logical block 0



0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8623 [Apollo CLE266]
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, 66MHz, medium devsel, latency 8
	Memory at e7000000 (32-bit, prefetchable) [size=4M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e0000000-e3ffffff
	Capabilities: [80] Power Management version 2

0000:00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, medium devsel, latency 168, IRQ 5
	Memory at e742b000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 40000000-41fff000 (prefetchable)
	Memory window 1: 42000000-43fff000
	I/O window 0: 00001000-00001fff
	I/O window 1: 00002000-00002fff
	16-bit legacy interface ports at 0001

0000:00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, medium devsel, latency 168, IRQ 12
	Memory at e7423000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 44000000-45fff000 (prefetchable)
	Memory window 1: 46000000-47fff000
	I/O window 0: 00003000-00003fff
	I/O window 1: 00004000-00004fff
	16-bit legacy interface ports at 0001

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at c000 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, medium devsel, latency 32, IRQ 7
	I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Flags: bus master, medium devsel, latency 32, IRQ 9
	Memory at e7428000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc.: Unknown device aa01
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at cc00 [size=16]
	Capabilities: [c0] Power Management version 2

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
	Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet Controller on VT8235
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d400 [size=256]
	Memory at e7429000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

0000:00:14.0 Mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
	Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
	Flags: bus master, 66MHz, medium devsel, latency 96, IRQ 12
	I/O ports at d800 [size=64]
	I/O ports at dc00 [size=16]
	I/O ports at e000 [size=128]
	Memory at e742a000 (32-bit, non-prefetchable) [size=4K]
	Memory at e7400000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at 48000000 [disabled] [size=16K]
	Capabilities: [60] Power Management version 2

0000:01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8623 [Apollo CLE266] integrated CastleRock graphics (rev 03) (prog-if 00 [VGA])
	Subsystem: VIA Technologies, Inc. VT8623 [Apollo CLE266] integrated CastleRock graphics
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 5
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at e5000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [70] AGP version 2.0

-- 
Humilis IT Services and Solutions
http://www.humilis.net
