Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136683AbREJOd5>; Thu, 10 May 2001 10:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136684AbREJOds>; Thu, 10 May 2001 10:33:48 -0400
Received: from mail.myrealbox.com ([192.108.102.201]:40797 "EHLO myrealbox.com")
	by vger.kernel.org with ESMTP id <S136683AbREJOdj>;
	Thu, 10 May 2001 10:33:39 -0400
Message-ID: <3AFAA807.C5EDE58F@ntplx.net>
Date: Thu, 10 May 2001 10:39:04 -0400
From: Ben Bridgwater <bennyb@ntplx.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Doug Ledford <dledford@redhat.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine
In-Reply-To: <E14xUbS-0002Op-00@the-village.bc.nu> <3AF96164.40F73A9@redhat.com> <3AF96271.81C27F57@mandrakesoft.com> <3AF9661B.1707F5E3@redhat.com> <3AF96811.3C6C196D@mandrakesoft.com> <3AF96B39.7C7888F4@redhat.com> <3AF96D99.AB18CB4F@mandrakesoft.com> <3AF97DE0.3C6455A6@ntplx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Bridgwater wrote:

> Jeff Garzik wrote:
>
> >
> > Setting DEBUG to 1 in arch/i386/kernel/pci-i386.h gives you lots of
> > info, including PIRQ debug data.
>
> I can try this tonite with 2.4.4 if this is going to be useful.
>

Well, I don't know how useful this is going to be, since the kernel booted
successfully....

This is a plain 2.4.4 tarball, compiled with gcc 2.95.3

The relevant parts of the kernel configuration are:
- no SMP
- no UP APIC
- new aic7xxxx
- aic7xxx built into kernel (not a module)

It was late so I didn't run any real tests on it, but at least it booted and the
aic7xxx/hard drive seemed happy. I didn't test the SCSI CD, which I'll do tonite, as
well as trying some other options to try to reproduce the Mandrake 8.0 install and
boot problems. The boot here isn't totally clean since I was booting with a 2.2 root
and old modultils so it couldn't find my modules (just sound and bttv).

If this is a PCI bug (whether PIRQ table or kernel) then should old/new aic7xxx make a
difference? I'll try the old one tonite.

Any suggestions as to what might be worth trying to reproduce it?

Ben

May 10 01:34:15 localhost syslog: syslogd startup succeeded
May 10 01:34:15 localhost kernel: klogd 1.3-3, log source = /proc/kmsg started.
May 10 01:34:15 localhost kernel: Inspecting /boot/System.map-2.4.4-pci-debug
May 10 01:34:15 localhost syslog: klogd startup succeeded
May 10 01:34:15 localhost identd[361]: started
May 10 01:34:15 localhost identd: identd startup succeeded
May 10 01:34:15 localhost kernel: Loaded 15341 symbols from
/boot/System.map-2.4.4-pci-debug.
May 10 01:34:15 localhost kernel: Symbols match kernel version 2.4.4.
May 10 01:34:15 localhost kernel: No module symbols loaded.
May 10 01:34:15 localhost kernel: Linux version 2.4.4-pci-debug
(benb@localhost.localdomain) (gcc version 2.95.3 19991030 (prerelease)) #1 Thu May 10
00:39:34 EDT 2001
May 10 01:34:15 localhost kernel: BIOS-provided physical RAM map:
May 10 01:34:15 localhost kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00
(usable)
May 10 01:34:15 localhost kernel:  BIOS-e820: 0000000000100000 - 0000000004000000
(usable)
May 10 01:34:15 localhost kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000
(reserved)
May 10 01:34:15 localhost kernel: On node 0 totalpages: 16384
May 10 01:34:15 localhost kernel: zone(0): 4096 pages.
May 10 01:34:15 localhost kernel: zone(1): 12288 pages.
May 10 01:34:15 localhost kernel: zone(2): 0 pages.
May 10 01:34:15 localhost kernel: Kernel command line: mem=65536K  root=/dev/sdb5
May 10 01:34:16 localhost kernel: Initializing CPU#0
May 10 01:34:16 localhost kernel: Detected 265.913 MHz processor.
May 10 01:34:16 localhost kernel: Console: colour VGA+ 80x25
May 10 01:34:16 localhost kernel: Calibrating delay loop... 530.84 BogoMIPS
May 10 01:34:16 localhost kernel: Memory: 61896k/65536k available (1251k kernel code,
3252k reserved, 498k data, 180k init, 0k highmem)
May 10 01:34:16 localhost atd: atd startup succeeded
May 10 01:34:16 localhost kernel: Dentry-cache hash table entries: 8192 (order: 4,
65536 bytes)
May 10 01:34:16 localhost kernel: Buffer-cache hash table entries: 4096 (order: 2,
16384 bytes)
May 10 01:34:16 localhost kernel: Page-cache hash table entries: 16384 (order: 4,
65536 bytes)
May 10 01:34:16 localhost kernel: Inode-cache hash table entries: 4096 (order: 3,
32768 bytes)
May 10 01:34:16 localhost kernel: CPU: Before vendor init, caps: 0080f9ff 00000000
00000000, vendor = 0
May 10 01:34:16 localhost kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 10 01:34:16 localhost kernel: CPU: L2 cache: 512K
May 10 01:34:16 localhost kernel: Intel machine check architecture supported.
May 10 01:34:16 localhost kernel: Intel machine check reporting enabled on CPU#0.
May 10 01:34:16 localhost kernel: CPU: After vendor init, caps: 0080f9ff 00000000
00000000 00000000
May 10 01:34:16 localhost kernel: CPU: After generic, caps: 0080f9ff 00000000 00000000
00000000
May 10 01:34:16 localhost kernel: CPU: Common caps: 0080f9ff 00000000 00000000
00000000
May 10 01:34:16 localhost kernel: CPU: Intel Pentium II (Klamath) stepping 03
May 10 01:34:16 localhost kernel: Checking 'hlt' instruction... OK.
May 10 01:33:28 localhost rc.sysinit: Mounting proc filesystem succeeded
May 10 01:34:16 localhost kernel: POSIX conformance testing by UNIFIX
May 10 01:33:28 localhost sysctl: error: 'net.ipv4.ip_always_defrag' is an unknown key

May 10 01:34:16 localhost kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
May 10 01:33:28 localhost sysctl: error: 'kernel.sysrq' is an unknown key
May 10 01:34:16 localhost kernel: mtrr: detected mtrr type: Intel
May 10 01:33:28 localhost sysctl: error: 'net.ipv4.tcp_timestamp' is an unknown key
May 10 01:34:16 localhost kernel: PCI: BIOS32 Service Directory structure at
0xc00fd9e0
May 10 01:33:28 localhost sysctl: error: 'net.ipv4.tcp_syncookies' is an unknown key
May 10 01:34:16 localhost kernel: PCI: BIOS32 Service Directory entry at 0xfd9f0
May 10 01:33:28 localhost rc.sysinit: Configuring kernel parameters succeeded
May 10 01:33:28 localhost date: Thu May 10 01:33:28 EDT 2001
May 10 01:33:28 localhost rc.sysinit: Setting clock  (localtime): Thu May 10 01:33:28
EDT 2001 succeeded
May 10 01:34:16 localhost kernel: PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=00
May 10 01:34:16 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0xfda11, last
bus=0
May 10 01:33:28 localhost rc.sysinit: Loading default keymap succeeded
May 10 01:33:28 localhost rc.sysinit: Activating swap partitions succeeded
May 10 01:34:16 localhost kernel: PCI: Using configuration type 1
May 10 01:34:16 localhost kernel: PCI: Probing PCI hardware
May 10 01:33:28 localhost rc.sysinit: Setting hostname localhost.localdomain succeeded

May 10 01:33:28 localhost fsck: /dev/sdb5: clean, 115438/384000 files, 503703/767095
blocks
May 10 01:34:16 localhost kernel: PCI: IDE base address fixup for 00:07.1
May 10 01:34:16 localhost kernel: PCI: Scanning for ghost devices on bus 0
May 10 01:34:16 localhost kernel: PCI: IRQ init
May 10 01:34:16 localhost kernel: PCI: IRQ fixup
May 10 01:34:16 localhost kernel: PCI: Allocating resources
May 10 01:34:16 localhost kernel: PCI: Resource 0000ffa0-0000ffaf (f=101, d=0, p=0)
May 10 01:34:16 localhost kernel: PCI: Resource 0000ff80-0000ff9f (f=101, d=0, p=0)
May 10 01:34:16 localhost kernel: PCI: Resource ffbec000-ffbeffff (f=200, d=0, p=0)
May 10 01:34:16 localhost kernel: PCI: Resource ff000000-ff7fffff (f=1208, d=0, p=0)
May 10 01:34:16 localhost kernel: PCI: Resource ffbea000-ffbeafff (f=1208, d=0, p=0)
May 10 01:34:16 localhost kernel: PCI: Resource 0000fc00-0000fcff (f=101, d=0, p=0)
May 10 01:34:16 localhost kernel: PCI: Resource ffbeb000-ffbebfff (f=200, d=0, p=0)
May 10 01:34:16 localhost kernel: PCI: Sorting device list...
May 10 01:33:28 localhost rc.sysinit: Checking root filesystem succeeded
May 10 01:34:16 localhost kernel: Limiting direct PCI/PCI transfers.
May 10 01:33:28 localhost isapnp: Board 1 has Identity 5a 80 86 00 01 20 00 a8 65:
YMH0020 Serial No 2156265473 [checksum 5a]
May 10 01:34:16 localhost crond: crond startup succeeded
May 10 01:34:16 localhost kernel: Activating ISA DMA hang workarounds.
May 10 01:33:28 localhost isapnp: Board 2 has Identity 13 70 30 04 7c 32 10 a2 11:
DMB1032 Serial No 1882195068 [checksum 13]
May 10 01:34:16 localhost kernel: isapnp: Scanning for PnP cards...
May 10 01:33:28 localhost isapnp: YMH0020/2156265473[0]{OPL3-SA2 Sound Chip }: Ports
0x220 0x530 0x388 0x330 0x370; IRQ5 DMA0 DMA1 --- Enabled OK
May 10 01:34:16 localhost kernel: isapnp: Card 'OPL3-SA2 Sound Chip'
May 10 01:33:28 localhost isapnp: YMH0020/2156265473[1]{OPL3-SA2 Sound Chip }: Port
0x201; --- Enabled OK
May 10 01:34:16 localhost irmanager: executing: '/sbin/modprobe irda'
May 10 01:33:28 localhost rc.sysinit: Setting up ISA PNP devices succeeded
May 10 01:33:28 localhost rc.sysinit: Remounting root filesystem in read-write mode
succeeded
May 10 01:34:16 localhost kernel: isapnp: Card 'Creative Modem Blaster Flash56
DI5601-1'
May 10 01:34:17 localhost kernel: isapnp: 2 Plug & Play cards detected total
May 10 01:34:17 localhost kernel: Linux NET4.0 for Linux 2.4
May 10 01:33:28 localhost : Loading module:
May 10 01:33:28 localhost fsck: /dev/sdb6 was not cleanly unmounted, check forced.
May 10 01:34:00 localhost fsck: /dev/sdb6: 77093/384000 files (0.1% non-contiguous),
231577/767095 blocks
May 10 01:34:00 localhost fsck: /dev/sda5: clean, 6570/66264 files, 126796/265041
blocks
May 10 01:34:00 localhost fsck: /dev/sda6: clean, 55580/241664 files, 894479/963868
blocks
May 10 01:34:00 localhost fsck: /dev/sda8: clean, 1131/66264 files, 144120/265041
blocks
May 10 01:34:17 localhost kernel: Based upon Swansea University Computer Society
NET3.039
May 10 01:34:17 localhost kernel: Starting kswapd v1.8
May 10 01:34:17 localhost kernel: pty: 256 Unix98 ptys configured
May 10 01:34:17 localhost kernel: block: queued sectors max/low 41058kB/13686kB, 128
slots per queue
May 10 01:34:00 localhost fsck: /dev/sda7: clean, 37841/132600 files, 491503/530113
blocks
May 10 01:34:00 localhost rc.sysinit: Checking filesystems succeeded
May 10 01:34:00 localhost mount: mount: mount point /root-8.0 does not exist
May 10 01:34:01 localhost rc.sysinit: Mounting local filesystems failed
May 10 01:34:01 localhost rc.sysinit: Checking loopback filesystems succeeded
May 10 01:34:01 localhost mount: mount: mount point /root-8.0 does not exist
May 10 01:34:01 localhost rc.sysinit: Mounting loopback filesystems failed
May 10 01:34:01 localhost rc.sysinit: Turning on user and group quotas for local
filesystems succeeded
May 10 01:34:01 localhost rc.sysinit: Enabling swap space succeeded
May 10 01:34:17 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
May 10 01:34:17 localhost irmanager: + modprobe: Can't locate module irda
May 10 01:34:17 localhost irmanager: Trying to load module irda exited with status 255

May 10 01:34:17 localhost irmanager: executing: 'echo 1 >
/proc/sys/net/irda/discovery'
May 10 01:34:17 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
May 10 01:34:02 localhost mandrake_everytime: Building Window Manager Sessions
succeeded
May 10 01:34:02 localhost sshdu[152]: log: Server listening on port 1. <30>May 10
01:34:02 sshdu[152]: log: Generating 768 bit RSA key.
May 10 01:34:02 localhost init: Entering runlevel: 5
May 10 01:34:13 localhost kudzu:  succeeded
May 10 01:34:13 localhost modprobe: modprobe: Can't locate module opl3sa2
May 10 01:34:13 localhost sound: Loading sound module (opl3sa2) failed
May 10 01:34:13 localhost modprobe: modprobe: Can't locate module opl3
May 10 01:34:17 localhost irmanager: Setting discovery to 1 exited with status 1
May 10 01:34:17 localhost irmanager: executing: 'echo localhost >
/proc/sys/net/irda/devname'
May 10 01:34:17 localhost kernel: PIIX3: IDE controller on PCI bus 00 dev 39
May 10 01:34:17 localhost kernel: PIIX3: chipset revision 0
May 10 01:34:17 localhost irmanager: Setting devname to localhost exited with status 1

May 10 01:34:17 localhost modprobe: modprobe: Can't locate module char-major-9
May 10 01:34:17 localhost irmanager: sh: /proc/sys/net/irda/discovery: No such file or
directory
May 10 01:34:13 localhost sound: Loading midi module (opl3) failed
May 10 01:34:17 localhost kernel: PIIX3: not 100% native mode: will probe irqs later
May 10 01:34:17 localhost kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings:
hda:pio, hdb:pio
May 10 01:34:17 localhost kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings:
hdc:pio, hdd:pio
May 10 01:34:17 localhost kernel: Floppy drive(s): fd0 is 1.44M
May 10 01:34:17 localhost kernel: FDC 0 is a National Semiconductor PC87306
May 10 01:34:17 localhost kernel: Serial driver version 5.05a (2001-03-20) with
MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
May 10 01:34:17 localhost kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
May 10 01:34:17 localhost irmanager: sh: /proc/sys/net/irda/devname: No such file or
directory
May 10 01:34:17 localhost irda: irmanager startup succeeded
May 10 01:34:14 localhost sysctl: error: 'net.ipv4.ip_always_defrag' is an unknown key

May 10 01:34:14 localhost sysctl: error: 'kernel.sysrq' is an unknown key
May 10 01:34:14 localhost sysctl: error: 'net.ipv4.tcp_timestamp' is an unknown key
May 10 01:34:14 localhost sysctl: error: 'net.ipv4.tcp_syncookies' is an unknown key
May 10 01:34:17 localhost kernel: ttyS00 at port 0x03f8 (irq = 4) is a 16550A
May 10 01:34:14 localhost network: Setting network parameters succeeded
May 10 01:34:17 localhost kernel: SCSI subsystem driver Revision: 1.00
May 10 01:34:14 localhost network: Bringing up interface lo succeeded
May 10 01:34:17 localhost kernel: request_module[scsi_hostadapter]: Root fs not
mounted
May 10 01:34:17 localhost inet: inetd startup succeeded
May 10 01:34:17 localhost kernel: request_module[scsi_hostadapter]: Root fs not
mounted
May 10 01:34:17 localhost kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA
DRIVER, Rev 6.1.5
May 10 01:34:17 localhost kernel:         <Adaptec 2940 Ultra SCSI adapter>
May 10 01:34:17 localhost kernel:         aic7880: Wide Channel A, SCSI Id=7, 16/255
SCBs
May 10 01:34:17 localhost kernel:
May 10 01:34:17 localhost kernel: (scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset
8, 16bit)
May 10 01:34:14 localhost random: Initializing random number generator succeeded
May 10 01:34:15 localhost mount: mount: mount point /root-8.0 does not exist
May 10 01:34:17 localhost kernel:   Vendor: WDIGTL    Model: WDE4360-1807A2    Rev:
1.70
May 10 01:34:17 localhost kernel:   Type:   Direct-Access                      ANSI
SCSI revision: 02
May 10 01:34:15 localhost netfs: Mounting other filesystems failed
May 10 01:34:17 localhost kernel: Detected scsi disk sda at scsi0, channel 0, id 0,
lun 0
May 10 01:34:17 localhost kernel: (scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset
8, 16bit)
May 10 01:34:17 localhost kernel:   Vendor: WDIGTL    Model: WDE18310 ULTRA3   Rev:
1.30
May 10 01:34:17 localhost kernel:   Type:   Direct-Access                      ANSI
SCSI revision: 03
May 10 01:34:17 localhost kernel: Detected scsi disk sdb at scsi0, channel 0, id 1,
lun 0
May 10 01:34:17 localhost lpd[435]: restarted
May 10 01:34:17 localhost lpd: lpd startup succeeded
May 10 01:34:17 localhost kernel: (scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset
15)
May 10 01:34:17 localhost kernel:   Vendor: NEC       Model: CD-ROM DRIVE:462  Rev:
1.14
May 10 01:34:17 localhost kernel:   Type:   CD-ROM                             ANSI
SCSI revision: 02
May 10 01:34:17 localhost kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 5,
lun 0
May 10 01:34:17 localhost kernel: scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
May 10 01:34:17 localhost kernel: scsi0:0:1:0: Tagged Queuing enabled.  Depth 253
May 10 01:34:17 localhost kernel: sr0: scsi-1 drive
May 10 01:34:17 localhost kernel: Uniform CD-ROM driver Revision: 3.12
May 10 01:34:17 localhost kernel: SCSI device sda: 8388314 512-byte hdwr sectors (4295
MB)
May 10 01:34:17 localhost kernel: Partition check:
May 10 01:34:17 localhost kernel:  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
May 10 01:34:17 localhost kernel: SCSI device sdb: 35761710 512-byte hdwr sectors
(18310 MB)
May 10 01:34:17 localhost kernel:  sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 sdb9 >
May 10 01:34:17 localhost kernel: Linux PCMCIA Card Services 3.1.22
May 10 01:34:17 localhost kernel:   options:  [pci] [cardbus] [pm]

