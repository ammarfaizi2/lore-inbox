Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBUXZG>; Wed, 21 Feb 2001 18:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129181AbRBUXY4>; Wed, 21 Feb 2001 18:24:56 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:16267 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129170AbRBUXYq>; Wed, 21 Feb 2001 18:24:46 -0500
Date: Wed, 21 Feb 2001 17:34:39 -0500
From: "Michael B. Allen" <mballen@erols.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.2.17 Lockup and ATA-66/100 forced bit set (WARNING)
Message-ID: <20010221173439.A3178@angus.foo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've enabled the higher performance features for my ATA drive by getting
2.2.17, applying Andre Hendrick's IDE patch, adding:

  append="idebus=66 ide0=ata66"

to lilo.conf. I was told that Alan's patches from here:

  ftp.kernel.org/pub/linux/kernel/people/alan

should be used. Is this true if I used Andre's patch? Is the warning
message in my bootlog anything to worry about? The board is an ABIT KT7A
w/ KT133A chipset.

Also, the machine locked up once (hard, couldn't connect via network). I
am using the Matrox G450 beta driver with XF 4.0.2 though. Maybe that
was the cause?

Thanks,
Mike

syslogd 1.3-3: restart.
syslog: syslogd startup succeeded
kernel: klogd 1.3-3, log source = /proc/kmsg started.
syslog: klogd startup succeeded
kernel: Inspecting /boot/System.map
kernel: Loaded 6567 symbols from /boot/System.map.
kernel: Symbols match kernel version 2.2.17.
kernel: No module symbols loaded.
kernel: Linux version 2.2.17 (root@nano) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 Wed Feb 21 02:33:48 EST 2001 
kernel: Detected 900061 kHz processor. 
kernel: ide_setup: idebus=66 
kernel: ide_setup: ide0=ata66 
kernel: Console: colour VGA+ 80x25 

I thought the BogoMIPS sort of went along with the CPU MHz?

kernel: Calibrating delay loop... 1795.69 BogoMIPS 
kernel: Memory: 257852k/262080k available (976k kernel code, 412k reserved, 2796k data, 44k init) 
kernel: Dentry hash table entries: 32768 (order 6, 256k) 
kernel: Buffer cache hash table entries: 262144 (order 8, 1024k) 
kernel: Page cache hash table entries: 65536 (order 6, 256k) 
kernel: CPU: L1 I Cache: 64K  L1 D Cache: 64K 
kernel: CPU: L2 Cache: 256K 
kernel: CPU: AMD Athlon(tm) Processor stepping 02 
kernel: Checking 386/387 coupling... OK, FPU using exception 16 error reporting. 
kernel: Checking 'hlt' instruction... OK. 
kernel: POSIX conformance testing by UNIFIX 
kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb430 
kernel: PCI: Using configuration type 1 
kernel: PCI: Probing PCI hardware 
kernel: Linux NET4.0 for Linux 2.2 
kernel: Based upon Swansea University Computer Society NET3.039 
kernel: NET4: Unix domain sockets 1.0 for Linux NET4.0. 
kernel: NET4: Linux TCP/IP 1.0 for NET4.0 
kernel: IP Protocols: ICMP, UDP, TCP 
kernel: TCP: Hash tables configured (ehash 262144 bhash 65536) 
kernel: Starting kswapd v 1.5  
kernel: Detected PS/2 Mouse Port. 
kernel: Serial driver version 4.27 with no serial options enabled 
kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A 
kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A 
kernel: pty: 256 Unix98 ptys configured 
kernel: Uniform Multi-Platform E-IDE driver Revision: 6.30 
kernel: ide: Assuming 66MHz system bus speed for PIO modes 
kernel: VP_IDE: IDE controller on PCI bus 00 dev 39 
kernel: VP_IDE: chipset revision 6 
kernel: VP_IDE: not 100% native mode: will probe irqs later 

This is what I'm worried about right here:

kernel: VP_IDE: ATA-66/100 forced bit set (WARNING)!! 
kernel:     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio 
kernel:     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio 
kernel: hda: IBM-DTLA-307030, ATA DISK drive 
kernel: hdc: PLEXTOR CD-R PX-W1210A, ATAPI CDROM drive 
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
kernel: ide1 at 0x170-0x177,0x376 on irq 15 
kernel: hda: IBM-DTLA-307030, 29314MB w/1916kB Cache, CHS=3737/255/63, UDMA(100) 
kernel: Floppy drive(s): fd0 is 1.44M 
kernel: FDC 0 is a post-1991 82077 

And why do I have 8 cdroms?

kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices 
kernel: scsi : 1 host. 
kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.07 
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0 
kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.07 
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
kernel: Detected scsi CD-ROM sr1 at scsi0, channel 0, id 0, lun 1 
kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.07 
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
kernel: Detected scsi CD-ROM sr2 at scsi0, channel 0, id 0, lun 2 
kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.07 
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
kernel: Detected scsi CD-ROM sr3 at scsi0, channel 0, id 0, lun 3 
kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.07 
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
kernel: Detected scsi CD-ROM sr4 at scsi0, channel 0, id 0, lun 4 
kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.07 
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
kernel: Detected scsi CD-ROM sr5 at scsi0, channel 0, id 0, lun 5 
kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.07 
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
kernel: Detected scsi CD-ROM sr6 at scsi0, channel 0, id 0, lun 6 
kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.07 
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
kernel: Detected scsi CD-ROM sr7 at scsi0, channel 0, id 0, lun 7 
kernel: scsi : detected 8 SCSI generics 8 SCSI cdroms total. 
kernel: sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray 
kernel: Uniform CD-ROM driver Revision: 3.11 
kernel: sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray 
kernel: sr2: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray 
kernel: sr3: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray 
kernel: sr4: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray 
kernel: sr5: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray 
kernel: sr6: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray 
kernel: sr7: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray 
kernel: 3c59x.c 16Aug00 Donald Becker and others http://www.scyld.com/network/vortex.html 
kernel: eth0: 3Com 3c905C Tornado at 0xec00,  00:01:02:cf:5f:18, IRQ 11 
kernel:   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface. 
kernel:   MII transceiver found at address 24, status 782d. 
kernel:   Enabling bus-master transmits and whole-frame receives. 
kernel: Partition check: 
kernel:  hda: hda1 hda2 
kernel: VFS: Mounted root (ext2 filesystem) readonly. 
kernel: Freeing unused kernel memory: 44k freed 
kernel: Adding Swap: 136544k swap-space (priority -1) 
identd: identd startup succeeded
atd: atd startup succeeded
crond: crond startup succeeded
inet: inetd startup succeeded
lpd: lpd startup succeeded
lpd[457]: restarted
rc.sysinit: Mounting proc filesystem succeeded 
sysctl: net.ipv4.ip_forward = 0 
sysctl: net.ipv4.conf.all.rp_filter = 1 
sysctl: net.ipv4.ip_always_defrag = 0 

Here's another little error?

sysctl: error: 'kernel.sysrq' is an unknown key 
rc.sysinit: Configuring kernel parameters succeeded 
date: Wed Feb 21 17:38:31 EST 2001 
rc.sysinit: Setting clock : Wed Feb 21 17:38:31 EST 2001 succeeded 
rc.sysinit: Loading default keymap succeeded 
rc.sysinit: Activating swap partitions succeeded 
succeeded 
fsck: /dev/hda1: clean, 62090/788704 files, 279756/1574362 blocks 
rc.sysinit: Checking root filesystem succeeded 
rc.sysinit: Remounting root filesystem in read-write mode succeeded 
rc.sysinit: Finding module dependencies succeeded 
rc.sysinit: Checking filesystems succeeded 
rc.sysinit: Mounting local filesystems succeeded 
rc.sysinit: Turning on user and group quotas for local filesystems succeeded 
rc.sysinit: Enabling swap space succeeded 
init: Entering runlevel: 5 
sysctl: net.ipv4.ip_forward = 0 
sysctl: net.ipv4.conf.all.rp_filter = 1 
sysctl: net.ipv4.ip_always_defrag = 0 

Mmm, here's that sysctl stuff again?

sysctl: error: 'kernel.sysrq' is an unknown key 
network: Setting network parameters succeeded 

Err, I have lot's of errors!

ifup: SIOCADDRT: Network is unreachable 
network: Bringing up interface lo succeeded 
network: Bringing up interface eth0 succeeded 
portmap: portmap startup succeeded 
nfslock: rpc.lockd startup succeeded 
nfslock: rpc.statd startup succeeded 
random: Initializing random number generator succeeded 
netfs: Mounting other filesystems succeeded 
keytable: Loading keymap: 
keytable: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
keytable: Loading system font: 
rc: Starting keytable succeeded
sendmail: sendmail startup succeeded
PAM_pwdb[533]: (gdm) session opened for user miallen by (uid=0)
gdm[533]: gdm_slave_session_start: miallen on :0
PAM_pwdb[615]: (su) session opened for user root by miallen(uid=500)

-- 
signature pending
