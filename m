Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313167AbSDTTID>; Sat, 20 Apr 2002 15:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314664AbSDTTIC>; Sat, 20 Apr 2002 15:08:02 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:59396 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313167AbSDTTH7>; Sat, 20 Apr 2002 15:07:59 -0400
Subject: 2.4.19-pre7-ac1 breaks my USB mouse
From: Thomas Hood <jdthood@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RoHZauOR17zTpjbq5bw1"
Message-Id: <1019328673.873.5.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.3 
Date: 20 Apr 2002 15:10:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RoHZauOR17zTpjbq5bw1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

(Repeat, with additional information)

I just upgraded from 2.4.19-pre5 to 2.4.19-pre7-ac1 and now my
Logitech TrackMan Marble Wheel USB pointing device no longer=20
works.  This despite the fact that the syslog looks OK (see below).

The problem also afflicts 2.4.19-pre7-ac2.

I didn't have this problem with 2.4.19-pre5 or 2.4.19-pre2-ac4.

Machine: ThinkPad 600X

.config
----------------------------------------------------
http://panopticon.csustan.edu/thood/config-2.4.19-pre7-ac2

lsmod
----------------------------------------------------
Module                  Size  Used by    Not tainted
ds                      6496   2=20
yenta_socket            8704   2=20
pcmcia_core            35392   0  [ds yenta_socket]
parport_pc             22120   1  (autoclean)
lp                      6528   0  (autoclean)
parport                24608   1  (autoclean) [parport_pc lp]
hid                     8576   0  (autoclean) (unused)
mousedev                3808   1=20
input                   3328   0  [mousedev]
usb-uhci               20996   0  (unused)
usbcore                54784   1  [hid usb-uhci]
floppy                 45248   0  (autoclean)
serial                 42144   0  (autoclean)
ide-cd                 26944   0  (autoclean)
cdrom                  28928   0  (autoclean) [ide-cd]
rtc                     5916   0  (autoclean)

proc/ioports
----------------------------------------------------
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : Lucent Microelectronics WinModem 56k
03bc-03be : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
04d0-04d1 : PnPBIOS PNP0c02
0cf8-0cff : PCI conf1
15e0-15ef : PnPBIOS PNP0c02
4000-401f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  4000-401f : usb-uhci
4400-44ff : Lucent Microelectronics WinModem 56k
4800-48ff : PCI CardBus #02
4c00-4cff : PCI CardBus #02
5000-50ff : PCI CardBus #05
5400-54ff : PCI CardBus #05
d000-dfff : PCI Bus #01
ef00-ef3f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
efa0-efbf : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
fcf0-fcff : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  fcf0-fcf7 : ide0
  fcf8-fcff : ide1

proc/interrupts
----------------------------------------------------
           CPU0      =20
  0:      23600          XT-PIC  timer
  1:        328          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          3          XT-PIC  rtc
 10:          0          XT-PIC  Texas Instruments PCI1450
 11:         22          XT-PIC  usb-uhci, Texas Instruments PCI1450 (#2)
 14:      22962          XT-PIC  ide0
NMI:          0=20
ERR:          0

lspci
----------------------------------------------------
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:03.0 Communication controller: Lucent Microelectronics WinModem 56k (rev=
 01)
00:06.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalCle=
ar SoundFusion Audio Accelerator] (rev 01)
00:07.0 Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 03)
01:00.0 VGA compatible controller: Neomagic Corporation NM2360 [MagicMedia =
256ZX]

/var/log/syslog from boot
----------------------------------------------------
Apr 20 14:35:18 thanatos syslogd 1.4.1#10: restart.
Apr 20 14:35:18 thanatos kernel: klogd 1.4.1#10, log source =3D /proc/kmsg =
started.
Apr 20 14:35:18 thanatos kernel: Inspecting /boot/System.map-2.4.19-pre7-ac=
2
Apr 20 14:35:19 thanatos kernel: Loaded 14138 symbols from /boot/System.map=
-2.4.19-pre7-ac2.
Apr 20 14:35:19 thanatos kernel: Symbols match kernel version 2.4.19.
Apr 20 14:35:19 thanatos kernel: Loaded 216 symbols from 10 modules.
Apr 20 14:35:19 thanatos kernel: Linux version 2.4.19-pre7-ac2 (jdthood@tha=
natos) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Sat Apr 20 08:3=
7:40 EDT 2002
Apr 20 14:35:19 thanatos kernel: BIOS-provided physical RAM map:
Apr 20 14:35:19 thanatos kernel:  BIOS-e820: 0000000000000000 - 00000000000=
9fc00 (usable)
Apr 20 14:35:19 thanatos kernel:  BIOS-e820: 000000000009fc00 - 00000000000=
a0000 (reserved)
Apr 20 14:35:19 thanatos kernel:  BIOS-e820: 00000000000f0000 - 00000000001=
00000 (reserved)
Apr 20 14:35:19 thanatos kernel:  BIOS-e820: 0000000000100000 - 0000000007f=
d0000 (usable)
Apr 20 14:35:19 thanatos kernel:  BIOS-e820: 0000000007fd0000 - 0000000007f=
df000 (ACPI data)
Apr 20 14:35:19 thanatos kernel:  BIOS-e820: 0000000007fdf000 - 0000000007f=
e0000 (ACPI NVS)
Apr 20 14:35:19 thanatos kernel:  BIOS-e820: 0000000007fe0000 - 00000000080=
00000 (reserved)
Apr 20 14:35:19 thanatos kernel:  BIOS-e820: 00000000fffe0000 - 00000001000=
00000 (reserved)
Apr 20 14:35:19 thanatos kernel: user-defined physical RAM map:
Apr 20 14:35:19 thanatos kernel:  user: 0000000000000000 - 000000000009fc00=
 (usable)
Apr 20 14:35:19 thanatos kernel:  user: 000000000009fc00 - 00000000000a0000=
 (reserved)
Apr 20 14:35:19 thanatos kernel:  user: 00000000000f0000 - 0000000000100000=
 (reserved)
Apr 20 14:35:19 thanatos kernel:  user: 0000000000100000 - 0000000007fd0000=
 (usable)
Apr 20 14:35:19 thanatos kernel:  user: 0000000007fd0000 - 0000000007fdf000=
 (ACPI data)
Apr 20 14:35:19 thanatos kernel:  user: 0000000007fdf000 - 0000000007fe0000=
 (ACPI NVS)
Apr 20 14:35:19 thanatos kernel:  user: 0000000007fe0000 - 0000000008000000=
 (reserved)
Apr 20 14:35:19 thanatos kernel:  user: 00000000fffe0000 - 0000000100000000=
 (reserved)
Apr 20 14:35:19 thanatos kernel: 127MB LOWMEM available.
Apr 20 14:35:19 thanatos kernel: On node 0 totalpages: 32720
Apr 20 14:35:19 thanatos kernel: zone(0): 4096 pages.
Apr 20 14:35:19 thanatos kernel: zone(1): 28624 pages.
Apr 20 14:35:19 thanatos kernel: zone(2): 0 pages.
Apr 20 14:35:19 thanatos kernel: IBM machine detected. Enabling interrupts =
during APM calls.
Apr 20 14:35:19 thanatos kernel: Kernel command line: mem=3D130496K root=3D=
/dev/hda5 ro
Apr 20 14:35:19 thanatos kernel: Initializing CPU#0
Apr 20 14:35:19 thanatos kernel: Detected 498.275 MHz processor.
Apr 20 14:35:19 thanatos kernel: Console: colour VGA+ 80x25
Apr 20 14:35:19 thanatos kernel: Calibrating delay loop... 992.87 BogoMIPS
Apr 20 14:35:19 thanatos kernel: Memory: 127324k/130880k available (861k ke=
rnel code, 3168k reserved, 228k data, 204k init, 0k highmem)
Apr 20 14:35:19 thanatos kernel: Dentry cache hash table entries: 16384 (or=
der: 5, 131072 bytes)
Apr 20 14:35:19 thanatos kernel: Inode cache hash table entries: 8192 (orde=
r: 4, 65536 bytes)
Apr 20 14:35:19 thanatos kernel: Mount cache hash table entries: 2048 (orde=
r: 2, 16384 bytes)
Apr 20 14:35:19 thanatos kernel: Buffer cache hash table entries: 4096 (ord=
er: 2, 16384 bytes)
Apr 20 14:35:19 thanatos kernel: Page-cache hash table entries: 32768 (orde=
r: 5, 131072 bytes)
Apr 20 14:35:19 thanatos kernel: CPU: Before vendor init, caps: 0383f9ff 00=
000000 00000000, vendor =3D 0
Apr 20 14:35:19 thanatos kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Apr 20 14:35:19 thanatos kernel: CPU: L2 cache: 256K
Apr 20 14:35:19 thanatos kernel: CPU: After vendor init, caps: 0383f9ff 000=
00000 00000000 00000000
Apr 20 14:35:19 thanatos kernel: Intel machine check architecture supported=
.
Apr 20 14:35:19 thanatos kernel: Intel machine check reporting enabled on C=
PU#0.
Apr 20 14:35:19 thanatos kernel: CPU:     After generic, caps: 0383f9ff 000=
00000 00000000 00000000
Apr 20 14:35:19 thanatos kernel: CPU:             Common caps: 0383f9ff 000=
00000 00000000 00000000
Apr 20 14:35:19 thanatos kernel: CPU: Intel Pentium III (Coppermine) steppi=
ng 03
Apr 20 14:35:19 thanatos kernel: Enabling fast FPU save and restore... done=
.
Apr 20 14:35:19 thanatos kernel: Enabling unmasked SIMD FPU exception suppo=
rt... done.
Apr 20 14:35:19 thanatos kernel: Checking 'hlt' instruction... OK.
Apr 20 14:35:19 thanatos kernel: POSIX conformance testing by UNIFIX
Apr 20 14:35:19 thanatos kernel: mtrr: v1.40 (20010327) Richard Gooch (rgoo=
ch@atnf.csiro.au)
Apr 20 14:35:19 thanatos kernel: mtrr: detected mtrr type: Intel
Apr 20 14:35:19 thanatos kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd8=
80, last bus=3D7
Apr 20 14:35:19 thanatos kernel: PCI: Using configuration type 1
Apr 20 14:35:19 thanatos kernel: PCI: Probing PCI hardware
Apr 20 14:35:19 thanatos kernel: PCI: Using IRQ router PIIX [8086/7110] at =
00:07.0
Apr 20 14:35:19 thanatos kernel: Limiting direct PCI/PCI transfers.
Apr 20 14:35:19 thanatos kernel: PnPBIOS: Found PnP BIOS installation struc=
ture at 0xc00fe700
Apr 20 14:35:19 thanatos kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf00=
00:0xe724, dseg 0xf0000
Apr 20 14:35:19 thanatos kernel: PnPBIOS: 18 nodes reported by PnP BIOS; 18=
 recorded by driver
Apr 20 14:35:19 thanatos kernel: PnPBIOS: PNP0c02: ioport range 0x4d0-0x4d1=
 has been reserved
Apr 20 14:35:19 thanatos kernel: PnPBIOS: PNP0c02: ioport range 0x15e0-0x15=
ef has been reserved
Apr 20 14:35:19 thanatos kernel: PnPBIOS: PNP0c02: ioport range 0xef00-0xef=
af could not be reserved
Apr 20 14:35:19 thanatos kernel: Linux NET4.0 for Linux 2.4
Apr 20 14:35:19 thanatos kernel: Based upon Swansea University Computer Soc=
iety NET3.039
Apr 20 14:35:19 thanatos kernel: Initializing RT netlink socket
Apr 20 14:35:19 thanatos kernel: apm: BIOS version 1.2 Flags 0x03 (Driver v=
ersion 1.16)
Apr 20 14:35:19 thanatos kernel: Starting kswapd
Apr 20 14:35:19 thanatos kernel: Journalled Block Device driver loaded
Apr 20 14:35:19 thanatos kernel: devfs: v1.12 (20020219) Richard Gooch (rgo=
och@atnf.csiro.au)
Apr 20 14:35:19 thanatos kernel: devfs: devfs_debug: 0x0
Apr 20 14:35:19 thanatos kernel: devfs: boot_options: 0x1
Apr 20 14:35:19 thanatos kernel: pty: 256 Unix98 ptys configured
Apr 20 14:35:19 thanatos kernel: block: 240 slots per queue, batch=3D60
Apr 20 14:35:19 thanatos kernel: Uniform Multi-Platform E-IDE driver Revisi=
on: 6.31
Apr 20 14:35:19 thanatos kernel: ide: Assuming 33MHz system bus speed for P=
IO modes; override with idebus=3Dxx
Apr 20 14:35:19 thanatos kernel: PIIX4: IDE controller on PCI bus 00 dev 39
Apr 20 14:35:19 thanatos kernel: PIIX4: chipset revision 1
Apr 20 14:35:19 thanatos kernel: PIIX4: not 100%% native mode: will probe i=
rqs later
Apr 20 14:35:19 thanatos kernel:     ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS se=
ttings: hda:DMA, hdb:pio
Apr 20 14:35:19 thanatos kernel:     ide1: BM-DMA at 0xfcf8-0xfcff, BIOS se=
ttings: hdc:pio, hdd:pio
Apr 20 14:35:19 thanatos kernel: hda: IBM-DJSA-220, ATA DISK drive
Apr 20 14:35:19 thanatos kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr 20 14:35:19 thanatos kernel: hda: 23572080 sectors (12069 MB) w/1874KiB=
 Cache, CHS=3D1559/240/63, UDMA(33)
Apr 20 14:35:19 thanatos kernel: Partition check:
Apr 20 14:35:19 thanatos kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p=
3 p4 < p5 p6 p7 >
Apr 20 14:35:19 thanatos kernel: RAMDISK driver initialized: 16 RAM disks o=
f 4096K size 1024 blocksize
Apr 20 14:35:19 thanatos kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Apr 20 14:35:19 thanatos kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Apr 20 14:35:19 thanatos kernel: IP: routing cache hash table of 512 bucket=
s, 4Kbytes
Apr 20 14:35:19 thanatos kernel: TCP: Hash tables configured (established 8=
192 bind 8192)
Apr 20 14:35:19 thanatos kernel: NET4: Unix domain sockets 1.0/SMP for Linu=
x NET4.0.
Apr 20 14:35:19 thanatos kernel: kjournald starting.  Commit interval 5 sec=
onds
Apr 20 14:35:19 thanatos kernel: EXT3-fs: mounted filesystem with ordered d=
ata mode.
Apr 20 14:35:19 thanatos kernel: VFS: Mounted root (ext3 filesystem) readon=
ly.
Apr 20 14:35:19 thanatos kernel: Mounted devfs on /dev
Apr 20 14:35:19 thanatos kernel: Freeing unused kernel memory: 204k freed
Apr 20 14:35:19 thanatos kernel: Adding Swap: 514040k swap-space (priority =
-1)
Apr 20 14:35:19 thanatos kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,=
5), internal journal
Apr 20 14:35:19 thanatos kernel: Real Time Clock Driver v1.10e
Apr 20 14:35:19 thanatos kernel: Serial driver version 5.05c (2001-07-08) w=
ith MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Apr 20 14:35:19 thanatos kernel: ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
Apr 20 14:35:19 thanatos kernel: inserting floppy driver for 2.4.19-pre7-ac=
2
Apr 20 14:35:19 thanatos kernel: Floppy drive(s): fd0 is 1.44M
Apr 20 14:35:19 thanatos kernel: FDC 0 is a National Semiconductor PC87306
Apr 20 14:35:19 thanatos kernel: kjournald starting.  Commit interval 5 sec=
onds
Apr 20 14:35:19 thanatos kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,=
7), internal journal
Apr 20 14:35:19 thanatos kernel: EXT3-fs: mounted filesystem with ordered d=
ata mode.
Apr 20 14:35:19 thanatos kernel: usb.c: registered new driver usbdevfs
Apr 20 14:35:19 thanatos kernel: usb.c: registered new driver hub
Apr 20 14:35:19 thanatos kernel: usb-uhci.c: $Revision: 1.275 $ time 14:22:=
05 Apr 20 2002
Apr 20 14:35:19 thanatos kernel: usb-uhci.c: High bandwidth mode enabled
Apr 20 14:35:19 thanatos kernel: PCI: Found IRQ 11 for device 00:07.2
Apr 20 14:35:19 thanatos kernel: usb-uhci.c: USB UHCI at I/O 0x4000, IRQ 11
Apr 20 14:35:19 thanatos kernel: usb-uhci.c: Detected 2 ports
Apr 20 14:35:19 thanatos kernel: usb.c: new USB bus registered, assigned bu=
s number 1
Apr 20 14:35:19 thanatos kernel: hub.c: USB hub found
Apr 20 14:35:19 thanatos kernel: hub.c: 2 ports detected
Apr 20 14:35:19 thanatos kernel: usb-uhci.c: v1.275:USB Universal Host Cont=
roller Interface driver
Apr 20 14:35:19 thanatos kernel: mice: PS/2 mouse device common for all mic=
e
Apr 20 14:35:19 thanatos kernel: hub.c: USB new device connect on bus1/1, a=
ssigned device number 2
Apr 20 14:35:19 thanatos kernel: usb.c: USB device 2 (vend/prod 0x46d/0xc40=
1) is not claimed by any active driver.
Apr 20 14:35:19 thanatos kernel: usb.c: registered new driver hid
Apr 20 14:35:19 thanatos kernel: hiddev0: USB HID v1.00 Mouse [Logitech USB=
-PS/2 Trackball] on usb1:2.0
Apr 20 14:35:19 thanatos kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pa=
vlik <vojtech@suse.cz>
Apr 20 14:35:19 thanatos kernel: hid-core.c: USB HID support drivers
Apr 20 14:35:19 thanatos named[226]: starting (/etc/bind/named.conf).  name=
d 8.3.1-REL-NOESW Fri Feb 15 23:51:36 MST 2002 ^Ilamont@whatone:/usr/local/=
src/Packages/bind/bind-8.3.1/src/bin/named
Apr 20 14:35:19 thanatos named[226]: hint zone "" (IN) loaded (serial 0)
Apr 20 14:35:19 thanatos named[226]: master zone "localhost" (IN) loaded (s=
erial 1)
Apr 20 14:35:19 thanatos named[226]: master zone "127.in-addr.arpa" (IN) lo=
aded (serial 1)
Apr 20 14:35:19 thanatos named[226]: master zone "0.in-addr.arpa" (IN) load=
ed (serial 1)
Apr 20 14:35:19 thanatos named[226]: master zone "255.in-addr.arpa" (IN) lo=
aded (serial 1)
Apr 20 14:35:19 thanatos named[226]: listening on [127.0.0.1].53 (lo)
Apr 20 14:35:19 thanatos named[226]: Forwarding source address is [0.0.0.0]=
.1024
Apr 20 14:35:19 thanatos named[228]: Ready to answer queries.
Apr 20 14:35:19 thanatos named[228]: sysquery: sendto([162.33.160.100].53):=
 Network is unreachable
Apr 20 14:35:19 thanatos rpc.statd[231]: Version 1.0 Starting
Apr 20 14:35:20 thanatos anacron[237]: Anacron 2.3 started on 2002-04-20
Apr 20 14:35:20 thanatos anacron[237]: Normal exit (0 jobs run)
Apr 20 14:35:20 thanatos apmd[241]: Version: apmd 3.0.2, driver 1.16, APM B=
IOS 1.2
Apr 20 14:35:20 thanatos apmd[241]: apmd_call_proxy: Executing proxy: '/etc=
/apm/apmd_proxy' 'start'
Apr 20 14:35:21 thanatos apmd[241]: apmd_call_proxy: + 000-debug start  zzz=
-debug start =20
Apr 20 14:35:23 thanatos apmd[241]: Battery: 99%, not charging, ? to empty
Apr 20 14:35:25 thanatos kernel: parport0: PC-style at 0x3bc (0x7bc) [PCSPP=
,TRISTATE]
Apr 20 14:35:25 thanatos kernel: parport0: irq 7 detected
Apr 20 14:35:25 thanatos kernel: lp0: using parport0 (polling).
Apr 20 14:35:27 thanatos kernel: Linux Kernel Card Services 3.1.22
Apr 20 14:35:27 thanatos kernel:   options:  [pci] [cardbus] [pm]
Apr 20 14:35:27 thanatos kernel: PCI: Found IRQ 10 for device 00:02.0
Apr 20 14:35:27 thanatos kernel: PCI: Sharing IRQ 10 with 00:06.0
Apr 20 14:35:27 thanatos kernel: PCI: Sharing IRQ 10 with 01:00.0
Apr 20 14:35:27 thanatos kernel: PCI: Found IRQ 11 for device 00:02.1
Apr 20 14:35:28 thanatos kernel: Yenta IRQ list 02b8, PCI irq10
Apr 20 14:35:28 thanatos kernel: Socket status: 30000006
Apr 20 14:35:28 thanatos kernel: Yenta IRQ list 02b8, PCI irq11
Apr 20 14:35:28 thanatos kernel: Socket status: 30000006
Apr 20 14:35:28 thanatos cardmgr[333]: starting, version is 3.1.33
Apr 20 14:35:29 thanatos cardmgr[333]: watching 2 sockets
Apr 20 14:35:29 thanatos cardmgr[333]: Card Services release does not match
Apr 20 14:35:29 thanatos kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Apr 20 14:35:29 thanatos kernel: cs: IO port probe 0x0800-0x08ff: clean.
Apr 20 14:35:29 thanatos kernel: cs: IO port probe 0x0100-0x04ff: excluding=
 0x170-0x177 0x370-0x377
Apr 20 14:35:29 thanatos kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Apr 20 14:35:43 thanatos postfix/postfix-script: starting the Postfix mail =
system
Apr 20 14:35:44 thanatos postfix/master[497]: daemon started
Apr 20 14:35:48 thanatos xfs: ignoring font path element /usr/lib/X11/fonts=
/CID (unreadable)=20
Apr 20 14:35:48 thanatos whereami[525]: Line State     : Script=20
Apr 20 14:35:48 thanatos whereami[525]: ---- ----------:-------------------=
---------------------------------=20
Apr 20 14:35:48 thanatos whereami[525]:   15 looking   : set DEBUGWHEREAMI =
1=20
Apr 20 14:35:48 thanatos whereami[525]:   16 looking   : default unknown=20
Apr 20 14:35:48 thanatos whereami[525]:   17 looking   : testmii eth0 lan=20
Apr 20 14:35:49 thanatos whereami[525]:   18 looking   : always testpci Luc=
ent bogus1=20
Apr 20 14:35:49 thanatos whereami[525]: ****************> Test successful -=
 adding locations: bogus1=20
Apr 20 14:35:49 thanatos whereami[525]:   19 success   : always testpci CMD=
 docked,office=20
Apr 20 14:35:49 thanatos whereami[525]:   28 else      : testmodule   orino=
co_cs      wlan=20
Apr 20 14:35:49 thanatos whereami[525]: Continuing at bogus1=20
Apr 20 14:35:50 thanatos /usr/sbin/cron[566]: (CRON) INFO (pidfile fd =3D 3=
)
Apr 20 14:35:50 thanatos /usr/sbin/cron[567]: (CRON) STARTUP (fork ok)
Apr 20 14:35:51 thanatos /usr/sbin/cron[567]: (CRON) INFO (Running @reboot =
jobs)
Apr 20 14:38:01 thanatos /USR/SBIN/CRON[682]: (mail) CMD (  if [ -x /usr/sb=
in/exim -a -f /etc/exim.conf ]; then /usr/sbin/exim -q >/dev/null 2>&1; fi)

--=-RoHZauOR17zTpjbq5bw1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8wbihJnAhHStZL6ERApfUAJ9xwz89OjFmPNei751b2o9tLHOpqQCfaKBq
OIM2DT+KhYRUxA/Y7jtRaxQ=
=wYIg
-----END PGP SIGNATURE-----

--=-RoHZauOR17zTpjbq5bw1--



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

