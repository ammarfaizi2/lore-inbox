Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbRFYCfv>; Sun, 24 Jun 2001 22:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbRFYCfc>; Sun, 24 Jun 2001 22:35:32 -0400
Received: from mx3.techline.com ([209.191.180.16]:51982 "EHLO mx3.techline.com")
	by vger.kernel.org with ESMTP id <S265853AbRFYCfS>;
	Sun, 24 Jun 2001 22:35:18 -0400
Message-ID: <3B36A34A.4AD6B6CA@techline.com>
Date: Sun, 24 Jun 2001 19:34:50 -0700
From: Stewart Andreason <sandreas@techline.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux-2.2.19 bugs: scsi hosts:0 and bsd_comp not found
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Originator: Stewart Andreason <sandreas@techline.com>
Synopsis: upgrade from 2.2.16 to 2.2.19 results in 2 failures:

Unable to find Adaptec or SCSI CDrom drive
Unable to load PPP compression module

______________clip from successful 2.2.16 boot
detected 1 controller(s)
aha152x0: vital data: PORTBASE=0x340, IRQ=11, SCSI ID=0,
reconnect=enabled, pari
ty=enabled, synchronous=disabled, delay=100, extended
translation=disabled
aha152x: trying software interrupt, ok.
scsi0 : Adaptec 152x SCSI driver; $Revision: 1.7 $
scsi : 1 host.
  Vendor: IBM       Model: CDRM00101     !D  Rev: 3041
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
scsi : detected 1 SCSI generic 1 SCSI cdrom total.
Uniform CD-ROM driver Revision: 3.09
____________[snip]
PPP BSD Compression module registered
______________________end clip from 2.2.16

__________________________
Linux version 2.2.19 (root@Roxy) (gcc version 2.95.3 20010315 (release))
#1 Sun Jun 24 09:52:06 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0009f000 @ 00000000 (usable)
 BIOS-e820: 03ef0000 @ 00100000 (usable)
Detected 449243 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 894.56 BogoMIPS
Memory: 62916k/65472k available (1156k kernel code, 412k reserved, 940k
data, 48
k init)
Dentry hash table entries: 8192 (order 4, 64k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
512K L2 cache (4 way)
CPU: L2 Cache: 512K
CPU: Intel Pentium III (Katmai) stepping 03
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfb3b0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 65536 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5
parport0: PC-style at 0x378 [SPP,PS2,EPP]
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
<Sound Blaster 16 (4.11)> at 0x220 irq 5 dma 1,5
<MPU-401 1.5U Midi interface #1> at 0x330 irq 9 dma 0
<Sound Blaster 16> at 0x300 irq 5 dma 0
<Yamaha OPL3> at 0x388
js: Joystick driver v1.2.15 (c) 1999 Vojtech Pavlik <vojtech@suse.cz>
loop: registered device at major 7
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: ST38410A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ST38410A, 8223MB w/512kB Cache, CHS=1048/255/63, UDMA
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
scsi : 0 hosts.
scsi : detected total.
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of
California
PPP line discipline registered.
PPP BSD Compression module registered
PPP Deflate Compression module registered
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
SLIP linefill/keepalive option.
3c59x.c 18Feb01 Donald Becker and others
http://www.scyld.com/network/vortex.htm
l
eth0: 3Com 3c905B Cyclone 100baseTx at 0xe400,  00:50:da:77:55:a2, IRQ 3
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 7849.
  Enabling bus-master transmits and whole-frame receives.
Partition check:
 hda: hda1 < hda5 hda6 hda7 hda8 hda9 > hda2 hda3
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 48k freed
INIT: version 2.76 booting
Adding Swap: 265032k swap-space (priority -1)
/etc/rc.d/rc.S: Testing filesystem status: Read-only file system
Parallelizing fsck version 1.15 (18-Jul-1999)
/dev/hda5: clean, 6814/26104 files, 58193/104391 blocks
/dev/hda9: clean, 139883/1605632 files, 1087371/1604484 blocks
Remounting root device with read-write enabled.
/dev/hda5 on / type ext2 (rw)
/dev/hda9 on /usr type ext2 (rw)
/dev/hda2 on /mnt/pcdos type msdos (rw,noexec,nodev,umask=0000)
/dev/hda7 on /mnt/vol5 type msdos (rw,noexec,nodev,umask=0000)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /proc type proc (rw)
Updating module dependencies for Linux 2.2.19:
can't locate module bsd_comp
Setting up IP spoofing protection...done.
Activating SYN cookies... done.
Setting up IPchains... done.
INIT: Entering runlevel: 3
Going multiuser...
Configuring eth0 as 192.168.0.103...
eth0: Initial media type Autonegotiate.
eth0: MII #24 status 7849, link partner capability 0000, setting
half-duplex.
Disabling IPv4 packet forwarding...
Disabling rp_filter...
Mounting remote file systems...
Starting daemons:  syslogd klogd inetd named lpd
_______________________end of 2.2.19 boot clip.

[2.2.16] /proc> cat version
Linux version 2.2.16 (root@Roxy) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #5 Wed Apr 11 20:09:50 PDT 2001

[2.2.16] /proc> cat cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 449.239
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr xmm
bogomips        : 894.57

[2.2.16] /proc> cat modules
bsd_comp                3820   0 (unused)

[2.2.16] /proc> cat scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IBM      Model: CDRM00101     !D Rev: 3041
  Type:   CD-ROM                           ANSI SCSI revision: 02
______________________
[2.2.19] /proc> cat version (see above in boot clip)
[2.2.19] /proc> cat cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 449.239
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr xmm
bogomips        : 894.56

[2.2.19] /proc> cat modules

[2.2.19] /proc> cat scsi/scsi
Attached devices: none
___________________

Notes: copied .config files from 2.2.16 to 2.2.19 to be idential.
2nd note: also tried newer compiler gcc-2.95.3 on 2.2.16: no effect.
also, the bsd_comp.o file can be found in:
/usr/src/linux/drivers/net/
-rw-r--r--   1 root        30335 Mar 25 08:31 bsd_comp.c
-rw-r--r--   1 root         5680 Jun 24 09:53 bsd_comp.o
but wasn't installed or copied to /lib/modules/2.2.19/
so the second part of this report is minor.

Unable to use 2.2.19 kernel. Please advise.

Thanks,
Stewart
