Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWE3Qe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWE3Qe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWE3Qe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:34:26 -0400
Received: from moci.net4u.de ([217.7.64.195]:33701 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S932282AbWE3QeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:34:25 -0400
From: Ernst Herzberg <list-lkml@net4u.de>
Reply-To: earny@net4u.de
Organization: Net4U
To: linux-kernel@vger.kernel.org
Subject: ALPHA 2.6.17-rc5 AIC7###: does not boot
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 20870
Date: Tue, 30 May 2006 18:34:19 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200605301834.19795.list-lkml@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moinmoin.

2.6.16.18 boots and runs without problems.

2.6.17-rc5 with patch
"[PATCH] alpha: generic hweight (Re: ALPHA 2.6.17-rc5 compile error)"
http://www.ussg.iu.edu/hypermail/linux/kernel/0605.3/1559.html

hangs with 

[....]
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Ultra Wide Channel B, SCSI Id=7, 32/253 SCBs

 1:0:0:0: Attempting to queue an ABORT message
CDB:CDB: 0x12 0x12 0x0 0x0 0x0 0x0 0x0 0x0 0x24 0x24 0x0 0x0
 1:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
 1:0:0:0: Attempting to queue an ABORT message
CDB: 0x12 0x0 0x0 0x0 0x24 0x0
 1:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
[....]

dmesg (captured with netconsole and netcat, most messages are duplicated
but better than nothing)

-----
Linux version 2.6.17-rc5 (root@olga) (gcc version 3.4.6 (Gentoo 3.4.6-r1, 
ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP Tue May 30 17:48:20 CEST 2006
Linux version 2.6.17-rc5 (root@olga) (gcc version 3.4.6 (Gentoo 3.4.6-r1, 
ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP Tue May 30 17:48:20 CEST 2006
Booting on Tsunami variation DP264 using machine vector DP264 from SRM
Booting on Tsunami variation DP264 using machine vector DP264 from SRM
Major Options: SMP LEGACY_START VERBOSE_MCHECK MAGIC_SYSRQ 
Major Options: SMP LEGACY_START VERBOSE_MCHECK MAGIC_SYSRQ 
Command line: root=/dev/sdb1 
netconsole=4444@***.*.**.***/eth0,6666@***.*.**.***/
Command line: root=/dev/sdb1 
netconsole=4444@***.*.**.***/eth0,6666@***.*.**.***/
memcluster 0, usage 1, start        0, end      256
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end   130976
memcluster 1, usage 0, start      256, end   130976
memcluster 2, usage 1, start   130976, end   131072
memcluster 2, usage 1, start   130976, end   131072
memcluster 3, usage 0, start   131072, end   524282
memcluster 3, usage 0, start   131072, end   524282
memcluster 4, usage 1, start   524282, end   524288
memcluster 4, usage 1, start   524282, end   524288
freeing pages 256:384
freeing pages 256:384
freeing pages 1019:130976
freeing pages 1019:130976
freeing pages 131072:524282
freeing pages 131072:524282
reserving pages 1019:1027
reserving pages 1019:1027
4096K Bcache detected; load hit latency 20 cycles, load miss latency 105 
cycles
4096K Bcache detected; load hit latency 20 cycles, load miss latency 105 
cycles
SMP: 2 CPUs probed -- cpu_present_mask = 3
Built 1 zonelists
SMP: 2 CPUs probed -- cpu_present_mask = 3
Built 1 zonelists
Kernel command line: root=/dev/sdb1 
netconsole=4444@***.*.**.***/eth0,6666@***.*.**.***/
Kernel command line: root=/dev/sdb1 
netconsole=4444@***.*.**.***/eth0,6666@***.*.**.***/
netconsole: local port 4444
netconsole: local port 4444
netconsole: local IP ***.*.**.***
netconsole: local IP ***.*.**.***
netconsole: interface eth0
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote port 6666
netconsole: remote IP ***.*.**.***
netconsole: remote IP ***.*.**.***
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
PID hash table entries: 4096 (order: 12, 32768 bytes)
PID hash table entries: 4096 (order: 12, 32768 bytes)
Using epoch = 1980
Using epoch = 1980
Console: colour VGA+ 80x25
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Memory: 4148672k/4194256k available (3168k kernel code, 42144k reserved, 
624k data, 168k init)
Memory: 4148672k/4194256k available (3168k kernel code, 42144k reserved, 
624k data, 168k init)
Mount-cache hash table entries: 512
Mount-cache hash table entries: 512
SMP starting up secondaries.
SMP starting up secondaries.
Brought up 1 CPUs
Brought up 1 CPUs
SMP: Total of 1 processors activated (1001.25 BogoMIPS).
SMP: Total of 1 processors activated (1001.25 BogoMIPS).
migration_cost=0
migration_cost=0
NET: Registered protocol family 16
SMC37c669 Super I/O Controller found @ 0x3f0
NET: Registered protocol family 16
SMC37c669 Super I/O Controller found @ 0x3f0
Linux Plug and Play Support v0.97 (c) Adam Belay
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver usbfs
usbcore: registered new driver hub
usbcore: registered new driver hub
NET: Registered protocol family 2
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 1048576 bytes)
IP route cache hash table entries: 131072 (order: 7, 1048576 bytes)
TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
TCP reno registered
srm_env: version 0.0.5 loaded successfully
srm_env: version 0.0.5 loaded successfully
fuse init (API version 7.6)
fuse init (API version 7.6)
Initializing Cryptographic API
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
isa bounce pool size: 16 pages
Floppy drive(s): fd0 is 2.88M
FDC 0 is a post-1991 82077
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
loop: loaded (max 8 devices)
nbd: registered device at major 43
nbd: registered device at major 43
Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #17 config 1000 status 782d advertising 01e1.
tulip0:  MII transceiver #17 config 1000 status 782d advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at fffffd0209040000, 00:00:CB:53:30:85, 
IRQ 47.
eth0: Digital DS21143 Tulip rev 65 at fffffd0209040000, 00:00:CB:53:30:85, 
IRQ 47.
netconsole: device eth0 not up yet, forcing it
netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears untrustworthy, waiting 4 seconds
netconsole: carrier detect appears untrustworthy, waiting 4 seconds
eth0: Setting full-duplex based on MII#17 link partner capability of 45e1.
eth0: Setting full-duplex based on MII#17 link partner capability of 45e1.
netconsole: network logging started
netconsole: network logging started
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CY82C693: IDE controller at PCI slot 0000:00:05.1
CY82C693: IDE controller at PCI slot 0000:00:05.1
CY82C693: chipset revision 0
CY82C693: chipset revision 0
CY82C693: not 100% native mode: will probe irqs later
CY82C693: not 100% native mode: will probe irqs later
CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)
CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)
    ide0: BM-DMA at 0x8800-0x8807    ide0: BM-DMA at 0x8800-0x8807, BIOS 
settings: hda:pio, hdb:pio
, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x8808-0x880f    ide1: BM-DMA at 0x8808-0x880f, BIOS 
settings: hdc:pio, hdd:pio, BIOS settings: hdc:pio, hdd:pio

Linux version 2.6.17-rc5 (root@olga) (gcc version 3.4.6 (Gentoo 3.4.6-r1, 
ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP Tue May 30 17:48:20 CEST 2006
Booting on Tsunami variation DP264 using machine vector DP264 from SRM
Major Options: SMP LEGACY_START VERBOSE_MCHECK MAGIC_SYSRQ 
Command line: root=/dev/sdb1 
netconsole=4444@***.*.**.***/eth0,6666@***.*.**.***/
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end   130976
memcluster 2, usage 1, start   130976, end   131072
memcluster 3, usage 0, start   131072, end   524282
memcluster 4, usage 1, start   524282, end   524288
freeing pages 256:384
freeing pages 1019:130976
freeing pages 131072:524282
reserving pages 1019:1027
4096K Bcache detected; load hit latency 20 cycles, load miss latency 105 
cycles
SMP: 2 CPUs probed -- cpu_present_mask = 3
Built 1 zonelists
Kernel command line: root=/dev/sdb1 
netconsole=4444@***.*.**.***/eth0,6666@***.*.**.***/
netconsole: local port 4444
netconsole: local IP ***.*.**.***
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP ***.*.**.***
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
PID hash table entries: 4096 (order: 12, 32768 bytes)
Using epoch = 1980
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Memory: 4148672k/4194256k available (3168k kernel code, 42144k reserved, 
624k data, 168k init)
Mount-cache hash table entries: 512
SMP starting up secondaries.
Brought up 1 CPUs
SMP: Total of 1 processors activated (1001.25 BogoMIPS).
migration_cost=0
NET: Registered protocol family 16
SMC37c669 Super I/O Controller found @ 0x3f0
hda: CD-950E/TKU, hda: CD-950E/TKU, ATAPI ATAPI CD/DVD-ROMCD/DVD-ROM drive
 drive
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 1048576 bytes)
TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
srm_env: version 0.0.5 loaded successfully
fuse init (API version 7.6)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
rtc: ARC console epoch (1980) detected
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
isa bounce pool size: 16 pages
Floppy drive(s): fd0 is 2.88M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
nbd: registered device at major 43
Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #17 config 1000 status 782d advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at fffffd0209040000, 00:00:CB:53:30:85, 
IRQ 47.
netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears untrustworthy, waiting 4 seconds
eth0: Setting full-duplex based on MII#17 link partner capability of 45e1.
netconsole: network logging started
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CY82C693: IDE controller at PCI slot 0000:00:05.1
CY82C693: chipset revision 0
CY82C693: not 100% native mode: will probe irqs later
CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)
    ide0: BM-DMA at 0x8800-0x8807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x8808-0x880f, BIOS settings: hdc:pio, hdd:pio
hda: CD-950E/TKU, ATAPI CD/DVD-ROMide0 at 0x1f0-0x1f7,0x3f6 on irq 14ide0 
at 0x1f0-0x1f7,0x3f6 on irq 14

 drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPIhda: ATAPI 52X 52X CD-ROM CD-ROM drive drive, 128kB Cache, 128kB 
Cache

Uniform CD-ROM driver Revision: 3.20
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
ide-floppy driver 0.99.newide
hda: ATAPI 52X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7895 Ultra SCSI adapter>
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Ultra Wide Channel A, SCSI Id=7, 32/253 SCBs
        aic7895C: Ultra Wide Channel A, SCSI Id=7, 32/253 SCBs


scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Ultra Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor:   Vendor: IIBBMM            Model:   Model: 
DDDYDYSS--TT3369695500NN          Rev:   Rev: SS9966HH

  Type:   Direct-Access       Type:   Direct-Access                      
ANSI SCSI revision: 03                 ANSI SCSI revision: 03

scsi0:A:1:0: scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
Tagged Queuing enabled.  Depth 253
 target0:0:1: Beginning Domain Validation
 target0:0:1: Beginning Domain Validation
 target0:0:1: wide asynchronous
 target0:0:1: wide asynchronous
 target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
 target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: Ending Domain Validation
 target0:0:1: Ending Domain Validation
  Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
 target0:0:1: Beginning Domain Validation
 target0:0:1: wide asynchronous
 target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: Ending Domain Validation
  Vendor:   Vendor: IIBBMM           Model:    Model: 
DDNNEESS--330099117700WW          Rev:   Rev: SSA3A300

  Type:   Direct-Access       Type:   Direct-Access                      
ANSI SCSI revision: 03                 ANSI SCSI revision: 03

scsi0:A:6:0: scsi0:A:6:0: Tagged Queuing enabled.  Depth 253
Tagged Queuing enabled.  Depth 253
 target0:0:6: Beginning Domain Validation
 target0:0:6: Beginning Domain Validation
 target0:0:6: wide asynchronous
 target0:0:6: wide asynchronous
 target0:0:6: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
 target0:0:6: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Ending Domain Validation
 target0:0:6: Ending Domain Validation
  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 253
 target0:0:6: Beginning Domain Validation
 target0:0:6: wide asynchronous
 target0:0:6: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Ending Domain Validation
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7895 Ultra SCSI adapter>
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Ultra Wide Channel B, SCSI Id=7, 32/253 SCBs
        aic7895C: Ultra Wide Channel B, SCSI Id=7, 32/253 SCBs


scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Ultra Wide Channel B, SCSI Id=7, 32/253 SCBs

 1:0:0:0: Attempting to queue an ABORT message
 1:0:0:0: Attempting to queue an ABORT message
CDB:CDB: 0x12 0x12 0x0 0x0 0x0 0x0 0x0 0x0 0x24 0x24 0x0 0x0

 1:0:0:0: Command already completed
 1:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
aic7xxx_abort returns 0x2002
 1:0:0:0: Attempting to queue an ABORT message
CDB: 0x12 0x0 0x0 0x0 0x24 0x0
 1:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
 1:0:0:0: Attempting to queue an ABORT message
 1:0:0:0: Attempting to queue an ABORT message
CDB:CDB: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0

 1:0:0:0: Command already completed
 1:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
aic7xxx_abort returns 0x2002
 1:0:0:0: Attempting to queue a TARGET RESET message
 1:0:0:0: Attempting to queue a TARGET RESET message
CDB:CDB: 0x12 0x12 0x0 0x0 0x0 0x0 0x0 0x24 0x0 0x24 0x0 0x0

 1:0:0:0: Command not found
 1:0:0:0: Command not found
aic7xxx_dev_reset returns 0x2002
aic7xxx_dev_reset returns 0x2002
 1:0:0:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
 1:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
 1:0:0:0: Attempting to queue a TARGET RESET message
CDB: 0x12 0x0 0x0 0x0 0x24 0x0
 1:0:0:0: Command not found
aic7xxx_dev_reset returns 0x2002
 1:0:0:0: Attempting to queue an ABORT message
 1:0:0:0: Attempting to queue an ABORT message
CDB:CDB: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0

 1:0:0:0: Command already completed
 1:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
aic7xxx_abort returns 0x2002
 1:0:0:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
 1:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
 1:0:0:0: Attempting to queue an ABORT message
 1:0:0:0: Attempting to queue an ABORT message
CDB:CDB: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0

 1:0:0:0: Command already completed
 1:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
aic7xxx_abort returns 0x2002
 1:0:0:0: scsi: Device offlined - not ready after error recovery
 1:0:0:0: scsi: Device offlined - not ready after error recovery
 1:0:0:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
 1:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
 1:0:0:0: scsi: Device offlined - not ready after error recovery
 1:0:1:0: Attempting to queue an ABORT message
 1:0:1:0: Attempting to queue an ABORT message
CDB:CDB: 0x12 0x12 0x0 0x0 0x0 0x0 0x0 0x0 0x24 0x24 0x0 0x0

 1:0:1:0: Command already completed
 1:0:1:0: Command already completed
aic7xxx_abort returns 0x2002
aic7xxx_abort returns 0x2002
 1:0:1:0: Attempting to queue an ABORT message
CDB: 0x12 0x0 0x0 0x0 0x24 0x0
 1:0:1:0: Command already completed
aic7xxx_abort returns 0x2002
 1:0:1:0: Attempting to queue an ABORT message
 1:0:1:0: Attempting to queue an ABORT message
CDB:CDB: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0

 1:0:1:0: Command already completed
 1:0:1:0: Command already completed
aic7xxx_abort returns 0x2002
aic7xxx_abort returns 0x2002
 1:0:1:0: Attempting to queue a TARGET RESET message
 1:0:1:0: Attempting to queue a TARGET RESET message
CDB:CDB: 0x12 0x12 0x0 0x0 0x0 0x0 0x0 0x0 0x24 0x24 0x0 0x0

 1:0:1:0: Command not found
 1:0:1:0: Command not found
aic7xxx_dev_reset returns 0x2002
aic7xxx_dev_reset returns 0x2002
 1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
 1:0:1:0: Command already completed
aic7xxx_abort returns 0x2002
 1:0:1:0: Attempting to queue a TARGET RESET message
CDB: 0x12 0x0 0x0 0x0 0x24 0x0
 1:0:1:0: Command not found
aic7xxx_dev_reset returns 0x2002
 1:0:1:0: Attempting to queue an ABORT message
 1:0:1:0: Attempting to queue an ABORT message
CDB:CDB: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0

 1:0:1:0: Command already completed
 1:0:1:0: Command already completed
aic7xxx_abort returns 0x2002
aic7xxx_abort returns 0x2002
 1:0:1:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
 1:0:1:0: Command already completed
aic7xxx_abort returns 0x2002
[....repeated forever....]
