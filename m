Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTFQG0B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 02:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbTFQG0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 02:26:00 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.27]:36558 "EHLO
	mwinf0404.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264582AbTFQGZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 02:25:52 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: jfontain@free.fr, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 / IDE lost interrupt / ServerWorks problem
Date: Tue, 17 Jun 2003 08:39:43 +0200
User-Agent: KMail/1.5.9
References: <1055763075.3eedaa83b19c8@imp.free.fr>
In-Reply-To: <1055763075.3eedaa83b19c8@imp.free.fr>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ver7+zf16c/xe5u"
Message-Id: <200306170839.43695.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ver7+zf16c/xe5u
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> I just upgraded from a 2.4.20 to 2.4.21 but had to revert due to the
> following errors:
>  hdd: dma_timer_expiry: dma status == 0x60
>  hdd: timeout waiting for DMA
>  hdd: lost interrupt

I've been seeing the same problem with 2.4.21.  I've attached my 2.4.21 log
(with email + firewall reports removed).

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
00:07.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
00:0a.0 USB Controller: VIA Technologies, Inc. USB (rev 04)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]

hdparm /dev/hdb

/dev/hdb:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 59582/16/63, sectors = 60058656, start = 0

Ciao,

Duncan.

--Boundary-00=_ver7+zf16c/xe5u
Content-Type: text/plain;
  charset="iso-8859-1";
  name="syslog-2.4.21"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog-2.4.21"

kernel: Linux version 2.4.21-rc8 (root@baldrick) (gcc version 3.2.3 (Debian)) #2 Sun Jun 15 14:12:47 CEST 2003
kernel: BIOS-provided physical RAM map:
kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
kernel:  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
kernel:  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
kernel: 511MB LOWMEM available.
kernel: found SMP MP-table at 000fb930
kernel: hm, page 000fb000 reserved twice.
kernel: hm, page 000fc000 reserved twice.
kernel: hm, page 000f6000 reserved twice.
kernel: hm, page 000f7000 reserved twice.
kernel: On node 0 totalpages: 131056
kernel: zone(0): 4096 pages.
kernel: zone(1): 126960 pages.
kernel: zone(2): 0 pages.
kernel: Intel MultiProcessor Specification v1.4
kernel:     Virtual Wire compatibility mode.
kernel: OEM ID: VIA      Product ID: VT5440B      APIC at: 0xFEE00000
kernel: Processor #0 Pentium(tm) Pro APIC version 17
kernel: I/O APIC #2 Version 3 at 0xFEC00000.
kernel: Enabling APIC mode: Flat.^IUsing 1 I/O APICs
kernel: Processors: 1
kernel: Kernel command line: root=/dev/hda2 ro nmi_watchdog=1
kernel: Initializing CPU#0
kernel: Detected 1733.438 MHz processor.
kernel: Console: colour VGA+ 80x25
kernel: Calibrating delay loop... 3460.30 BogoMIPS
kernel: Memory: 516288k/524224k available (1152k kernel code, 7548k reserved, 421k data, 92k init, 0k highmem)
kernel: Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
kernel: Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
kernel: Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
kernel: CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 2003d22f
kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
kernel: CPU: L2 Cache: 256K (64 bytes/line)
kernel: Intel machine check architecture supported.
kernel: Intel machine check reporting enabled on CPU#0.
kernel: CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
kernel: CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
kernel: CPU: AMD Athlon(tm) XP 2100+ stepping 01
kernel: Enabling fast FPU save and restore... done.
kernel: Enabling unmasked SIMD FPU exception support... done.
kernel: Checking 'hlt' instruction... OK.
ptal-mlcd: SYSLOG at ExMgr.cpp:701, dev=<mlc:usb:PSC_750xi>, pid=967, e=2         ptal-mlcd successfully initialized. 
kernel: POSIX conformance testing by UNIFIX
kernel: enabled ExtINT on CPU#0
kernel: ESR value before enabling vector: 00000080
kernel: ESR value after enabling vector: 00000000
kernel: ENABLING IO-APIC IRQs
kernel: Setting 2 in the phys_id_present_map
ptal-printd: ptal-printd(mlc:usb:PSC_750xi) successfully initialized using /var/run/ptal-printd/mlc_usb_PSC_750xi*. 
kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
kernel: init IO_APIC IRQs
kernel:  IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-19, 2-20, 2-23 not connected.
kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
kernel: activating NMI Watchdog ... done.
kernel: testing NMI watchdog ... OK.
kernel: number of MP IRQ sources: 24.
usb.agent: ... no modules for USB product 0/0/204
usb.agent: ... no modules for USB product 0/0/0
last message repeated 3 times
kernel: number of IO-APIC #2 registers: 24.
insmod: insmod: a module named speedtch already exists
modem_run[1067]: modem_run version 1.2-beta1 started by root uid 0 
insmod: insmod: a module named speedtch already exists
kernel: testing the IO APIC.......................
insmod: insmod: insmod /lib/modules/2.4.21-rc8/kernel/drivers/usb/speedtch.o failed
insmod: insmod: insmod /lib/modules/2.4.21-rc8/kernel/drivers/usb/speedtch.o failed
kernel: 
kernel: IO APIC #2......
kernel: .... register #00: 02000000
kernel: .......    : physical APIC id: 02
kernel: .......    : Delivery Type: 0
kernel: .......    : LTS          : 0
kernel: .... register #01: 00178003
kernel: .......     : max redirection entries: 0017
kernel: .......     : PRQ implemented: 1
kernel: .......     : IO APIC version: 0003
kernel: .... IRQ redirection table:
kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
kernel:  00 000 00  1    0    0   0   0    0    0    00
insmod: insmod: insmod speedtch failed
insmod: insmod: insmod speedtch failed
kernel:  01 001 01  0    0    0   0   0    1    1    39
usb.agent: ... can't load module speedtch
usb.agent: ... can't load module speedtch
kernel:  02 001 01  0    0    0   0   0    1    1    31
modem_run[1074]: modem_run version 1.2-beta1 started by root uid 0 
modem_run[1077]: modem_run version 1.2-beta1 started by root uid 0 
kernel:  03 001 01  0    0    0   0   0    1    1    41
modem_run[1074]: Another program/driver is already accessing the modem (interface 2 cannot be claimed)... 
modem_run[1077]: Another program/driver is already accessing the modem (interface 2 cannot be claimed)... 
kernel:  04 001 01  0    0    0   0   0    1    1    49
kernel:  05 000 00  1    0    0   0   0    0    0    00
kernel:  06 001 01  0    0    0   0   0    1    1    51
kernel:  07 001 01  0    0    0   0   0    1    1    59
kernel:  08 001 01  0    0    0   0   0    1    1    61
kernel:  09 001 01  0    0    0   0   0    1    1    69
kernel:  0a 000 00  1    0    0   0   0    0    0    00
kernel:  0b 000 00  1    0    0   0   0    0    0    00
kernel:  0c 001 01  0    0    0   0   0    1    1    71
kernel:  0d 001 01  0    0    0   0   0    1    1    79
kernel:  0e 001 01  0    0    0   0   0    1    1    81
kernel:  0f 001 01  0    0    0   0   0    1    1    89
kernel:  10 001 01  1    1    0   1   0    1    1    91
kernel:  11 001 01  1    1    0   1   0    1    1    99
kernel:  12 001 01  1    1    0   1   0    1    1    A1
kernel:  13 000 00  1    0    0   0   0    0    0    00
kernel:  14 000 00  1    0    0   0   0    0    0    00
kernel:  15 001 01  1    1    0   1   0    1    1    A9
kernel:  16 001 01  1    1    0   1   0    1    1    B1
kernel:  17 000 00  1    0    0   0   0    0    0    00
kernel: IRQ to pin mappings:
kernel: IRQ0 -> 0:2
kernel: IRQ1 -> 0:1
kernel: IRQ3 -> 0:3
kernel: IRQ4 -> 0:4
kernel: IRQ6 -> 0:6
kernel: IRQ7 -> 0:7
kernel: IRQ8 -> 0:8
kernel: IRQ9 -> 0:9
kernel: IRQ12 -> 0:12
kernel: IRQ13 -> 0:13
kernel: IRQ14 -> 0:14
kernel: IRQ15 -> 0:15
kernel: IRQ16 -> 0:16
kernel: IRQ17 -> 0:17
kernel: IRQ18 -> 0:18
kernel: IRQ21 -> 0:21
kernel: IRQ22 -> 0:22
kernel: .................................... done.
kernel: Using local APIC timer interrupts.
kernel: calibrating APIC timer ...
kernel: ..... CPU clock speed is 1733.4693 MHz.
kernel: ..... host bus clock speed is 266.6876 MHz.
kernel: cpu: 0, clocks: 2666876, slice: 1333438
kernel: CPU0<T0:2666864,T1:1333424,D:2,S:1333438,C:2666876>
kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
kernel: mtrr: detected mtrr type: Intel
kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
kernel: PCI: Using configuration type 1
kernel: PCI: Probing PCI hardware
kernel: PCI: Using IRQ router default [1106/3177] at 00:11.0
kernel: PCI->APIC IRQ transform: (B0,I5,P0) -> 16
kernel: PCI->APIC IRQ transform: (B0,I6,P0) -> 17
kernel: PCI->APIC IRQ transform: (B0,I6,P0) -> 17
kernel: PCI->APIC IRQ transform: (B0,I7,P0) -> 18
kernel: PCI->APIC IRQ transform: (B0,I10,P0) -> 17
kernel: PCI->APIC IRQ transform: (B0,I16,P0) -> 21
kernel: PCI->APIC IRQ transform: (B0,I16,P1) -> 21
kernel: PCI->APIC IRQ transform: (B0,I16,P2) -> 21
kernel: PCI->APIC IRQ transform: (B0,I16,P3) -> 21
kernel: PCI->APIC IRQ transform: (B0,I17,P0) -> 22
kernel: PCI->APIC IRQ transform: (B0,I17,P2) -> 22
kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
kernel: PCI: Via IRQ fixup for 00:0a.0, from 10 to 1
kernel: PCI: Via IRQ fixup for 00:10.1, from 10 to 5
kernel: PCI: Via IRQ fixup for 00:10.0, from 11 to 5
kernel: Linux NET4.0 for Linux 2.4
kernel: Based upon Swansea University Computer Society NET3.039
kernel: Initializing RT netlink socket
kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
kernel: Starting kswapd
kernel: Journalled Block Device driver loaded
kernel: pty: 256 Unix98 ptys configured
kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
kernel: HDLC line discipline: version $Revision: 3.3 $, maxframe=4096
kernel: N_HDLC line discipline registered.
kernel: Floppy drive(s): fd0 is 1.44M
kernel: FDC 0 is a post-1991 82077
kernel: loop: loaded (max 8 devices)
kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
kernel: agpgart: Maximum main memory to use for agp memory: 439M
kernel: agpgart: Detected Via Apollo Pro KT266 chipset
kernel: agpgart: AGP aperture is 128M @ 0xe0000000
kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kernel: VP_IDE: IDE controller at PCI slot 00:11.1
kernel: VP_IDE: chipset revision 6
kernel: VP_IDE: not 100%% native mode: will probe irqs later
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
kernel:     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
kernel: hda: ST320423A, ATA DISK drive
kernel: hdb: Maxtor 6E030L0, ATA DISK drive
kernel: blk: queue c02ccfc0, I/O limit 4095Mb (mask 0xffffffff)
kernel: blk: queue c02cd0fc, I/O limit 4095Mb (mask 0xffffffff)
kernel: hdc: TOSHIBA DVD-ROM SD-M1402, ATAPI CD/DVD-ROM drive
kernel: hdd: LG CD-RW CED-8080B, ATAPI CD/DVD-ROM drive
kernel: hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: set_drive_speed_status: error=0x04
kernel: ide1: Drive 0 didn't accept speed setting. Oh, well.
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: ide1 at 0x170-0x177,0x376 on irq 15
kernel: hda: attached ide-disk driver.
kernel: hda: host protected area => 1
kernel: hda: 40011300 sectors (20486 MB) w/512KiB Cache, CHS=2490/255/63, UDMA(66)
kernel: hdb: attached ide-disk driver.
kernel: hdb: host protected area => 1
kernel: hdb: 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=3738/255/63, UDMA(133)
kernel: Partition check:
kernel:  hda: hda1 hda2 hda3
kernel:  hdb: hdb1
kernel: usb.c: registered new driver usbdevfs
kernel: usb.c: registered new driver hub
kernel: mice: PS/2 mouse device common for all mice
kernel: NET4: Linux TCP/IP 1.0 for NET4.0
kernel: IP Protocols: ICMP, UDP, TCP, IGMP
kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
kernel: TCP: Hash tables configured (established 32768 bind 65536)
kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kernel: kjournald starting.  Commit interval 5 seconds
kernel: EXT3-fs: mounted filesystem with ordered data mode.
kernel: VFS: Mounted root (ext3 filesystem) readonly.
kernel: Freeing unused kernel memory: 92k freed
kernel: Adding Swap: 498004k swap-space (priority -1)
kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
kernel: Real Time Clock Driver v1.10e
kernel: 8139too Fast Ethernet driver 0.9.26
kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xe086ef00, 00:50:22:b1:41:10, IRQ 16
kernel: eth0:  Identified 8139 chip type 'RTL-8139C'
kernel: kjournald starting.  Commit interval 5 seconds
kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,65), internal journal
kernel: EXT3-fs: mounted filesystem with ordered data mode.
kernel: ehci-hcd 00:10.3: VIA Technologies, Inc. USB 2.0
kernel: ehci-hcd 00:10.3: irq 21, pci mem e0888e00
kernel: usb.c: new USB bus registered, assigned bus number 1
kernel: PCI: 00:10.3 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
kernel: PCI: 00:10.3 PCI cache line size corrected to 64.
kernel: ehci-hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
kernel: hub.c: USB hub found
kernel: hub.c: 6 ports detected
kernel: hub.c: port 5 over-current change
kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
kernel: uhci.c: USB UHCI at I/O 0xe800, IRQ 17
kernel: usb.c: new USB bus registered, assigned bus number 2
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: uhci.c: USB UHCI at I/O 0xe400, IRQ 21
kernel: usb.c: new USB bus registered, assigned bus number 3
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: uhci.c: USB UHCI at I/O 0xe000, IRQ 21
kernel: usb.c: new USB bus registered, assigned bus number 4
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: uhci.c: USB UHCI at I/O 0xdc00, IRQ 21
kernel: hub.c: port 6 over-current change
kernel: usb.c: new USB bus registered, assigned bus number 5
kernel: hub.c: USB hub found
root: spamd starting 
kernel: hub.c: 2 ports detected
kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
kernel: hub.c: new USB device 00:10.2-2, assigned address 2
kernel: usb.c: USB device 2 (vend/prod 0x6b9/0x4061) is not claimed by any active driver.
kernel: ip_tables: (C) 2000-2002 Netfilter core team
kernel: ip_conntrack version 2.1 (4095 buckets, 32760 max) - 292 bytes per conntrack
kernel: blk: queue c02ccfc0, I/O limit 4095Mb (mask 0xffffffff)
kernel: blk: queue c02cd0fc, I/O limit 4095Mb (mask 0xffffffff)
kernel: hdc: attached ide-cdrom driver.
kernel: hdc: ATAPI 40X DVD-ROM drive, 128kB Cache, (U)DMA
kernel: Uniform CD-ROM driver Revision: 3.12
kernel: hdd: attached ide-cdrom driver.
kernel: hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
kernel: usb.c: registered new driver speedtch
kernel: usb_control/bulk_msg: timeout
kernel: usbdevfs: USBDEVFS_BULK failed dev 2 ep 0x85 len 512 ret -110
kernel: PCI: Setting latency timer of device 00:11.5 to 64
kernel: usb.c: registered new driver snd-usb-audio
modprobe: modprobe: Can't locate module snd-card-3
last message repeated 2 times
anacron[1111]: Anacron 2.3 started on 2003-06-16
anacron[1111]: Normal exit (0 jobs run)
automount[1148]: starting automounter version 4.0.0, path = /var/autofs/misc, maptype = file, mapname = /etc/auto.misc
automount[1148]: Map argc = 1
automount[1148]: Map argv[0] = /etc/auto.misc
automount[1148]: mount(bind): bind_works = 1 
automount[1148]: using kernel protocol version 4
automount[1148]: using timeout 10 seconds; freq 3 secs
modprobe: modprobe: Can't locate module char-major-6
last message repeated 14 times
ptal-mlcd: ERROR at ExMgr.cpp:2485, dev=<mlc:usb:PSC_750xi@/dev/usb/lp9>, pid=967, e=19         Couldn't find device: exhausted all possible device nodes! 
modem_run[1067]: ADSL synchronization has been obtained 
modem_run[1067]: ADSL line is up (1216 kbit/s down | 160 kbit/s up) 
kernel: usbdevfs: process 1082 (modem_run) did not claim interface 0 before use
xfs: ignoring font path element /usr/lib/X11/fonts/cyrillic/ (unreadable) 
xfs: ignoring font path element /usr/lib/X11/fonts/CID (unreadable) 
pppd[1255]: Plugin pppoatm.so loaded.
kernel: CSLIP: code copyright 1989 Regents of the University of California
kernel: PPP generic driver version 2.4.2
pppd[1255]: PPPoATM plugin_init
pppd[1255]: PPPoATM setdevname - remove unwanted options
pppd[1255]: PPPoATM setdevname_pppoatm - SUCCESS:8.35
pppd[1299]: pppd 2.4.1 started by root, uid 0
kernel: atm_connect (TX: cl 1,bw 0-0,sdu 16386; RX: cl 1,bw 0-0,sdu 1502,AAL 5)
pppd[1299]: Using interface ppp0
pppd[1299]: Connect: ppp0 <--> 8.35
ntpd[1321]: ntpd 4.1.1b@1.829 Sun Dec 29 22:42:05 UTC 2002 (2)
ntpd[1321]: signal_no_reset: signal 13 had flags 4000000
ntpd[1321]: precision = 10 usec
ntpd[1321]: kernel time discipline status 0040
/usr/sbin/cron[1329]: (CRON) INFO (pidfile fd = 3)
/usr/sbin/cron[1330]: (CRON) STARTUP (fork ok)
ntpd[1321]: sendto(193.55.10.112): Network is unreachable
/usr/sbin/cron[1330]: (CRON) INFO (Skipping @reboot jobs -- not system startup)
pppd[1299]: kernel does not support PPP filtering
pppd[1299]: local  IP address 80.11.150.147
pppd[1299]: remote IP address 193.253.160.3
pppd[1299]: primary   DNS address 193.252.19.3
pppd[1299]: secondary DNS address 193.252.19.4
modprobe: modprobe: Can't locate module char-major-226
last message repeated 3 times
kernel: [drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 128MB
kernel: [drm] Initialized radeon 1.1.1 20010405 on minor 0
modprobe: modprobe: Can't locate module snd-card-3
modprobe: modprobe: Can't locate module snd-card-3
ntpd[1321]: Connection re-established to 193.55.10.112
ntpd[1321]: time set -5.723634 s
ntpd[1321]: synchronisation lost
kernel: hdb: dma_timer_expiry: dma status == 0x64
kernel: hdb: lost interrupt
kernel: hdb: dma_intr: bad DMA status (dma_stat=70)
kernel: hdb: dma_intr: status=0x50 { DriveReady SeekComplete }
kernel: 

--Boundary-00=_ver7+zf16c/xe5u--
