Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVCYK4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVCYK4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 05:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVCYK4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 05:56:05 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:48277 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S261598AbVCYKzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 05:55:20 -0500
Message-ID: <4243EE2A.30008@arcor.de>
Date: Fri, 25 Mar 2005 11:55:38 +0100
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 3com wol and nfs root trouble
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD382BFF11B3ECDABCE84601C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD382BFF11B3ECDABCE84601C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

I have a 3com 905c card and have following issues with it:

a) wake on lan doesn't work. I figured out that this must be activated via
module parameter. As I need the driver compiled in (see down) I patched the
drvier to enable wol. I see the difference that now my switch shows that the
card is online after the machine has been shut-down. good, But nevertheless I
cannot wake up the machine. I tried via wakeonlan (in fli4l router) and
etherwake. The mainboard is fairly old but I had a realtek card in and here it
worked. I don't have acpi enabled. Is it needed for 3com? As I said it worked
with realtek and using "ethtool -s eth0 wol g" to enable wol. Unfortunately
3com driver doesn't support ethtool. (Yes, the wol cable should be correctly
connected and I didn't change anything about wol in bios.)

b) I put the 3com card in as I needed pxe for booting the machine form
network. That's why I compiled the driver into kernel. I didn't want to mess
with an initrd... (is there a way to give module parameters as klernel boot
parameter to drivers?) My old realtek didn't have a boot rom... So booting and
all works but I have one issue:

As / is a nfs root, it breaks as soon as I use gentoo's net.eth0 / net.lo
script to ifconfig eth0. It seems the root nfs gets lost, as the system can't
find any files anymore. I worked around this as I properly set up dhcp and let
the kernel configure eth0 correctly and removed the net.eth0 script.

Again, with the realtek card the script didn't break. (I had no pxe boot on
this, but a nfs root. 3com also breaks with local boot, nfs root.)


0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 03)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 41)
0000:00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
0000:00:09.0 Network controller: Techsan Electronics Co Ltd B2C2 FlexCopII DVB
chip / Technisat SkyStar2 DVB card (rev 01)
0000:00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 78)
0000:00:0b.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood
Plus DVD Decoder (rev 01)
0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
86C326 5598/6326 (rev c3)


Linux version 2.6.11 (root@tachyon) (gcc-Version 3.4.3-20050110 (Gentoo Linux
3.4.3.20050110-r1, ssp-3.4.3.20050110-0, pie-8.7.7)) #7 Fri Mar 25 11:27:49
CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28656 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Allocating PCI resources starting at 08000000 (gap: 08000000:f7ff0000)
Built 1 zonelists
Kernel command line: nfsroot=192.168.0.1:/diskless/htpc ip=dhcp root=/dev/nfs
dvb_shutdown_timeout=0 elevator=cfq
Initializing CPU#0
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 501.221 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 125820k/131008k available (2294k kernel code, 4672k reserved, 848k
data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 987.13 BogoMIPS (lpj=493568)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 008021bf 808029bf 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 008021bf 808029bf 00000000 00000000 00000000
00000000 00000000
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After all inits, caps: 008021bf 808029bf 00000000 00000002 00000000
00000000 00000000
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc100
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc128, dseg 0xf0000
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
PCI: Using IRQ router VIA [1106/0586] at 0000:00:07.0
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS with large block numbers, no debug enabled
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
loop: loaded (max 8 devices)
PCI: setting IRQ 10 as level-triggered
PCI: Assigned IRQ 10 for device 0000:00:0a.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0a.0: 3Com PCI 3c905C Tornado at 0x7000. Vers LK1.1.19
PCI: Found IRQ 10 for device 0000:00:09.0
IRQ routing conflict for 0000:00:09.0, have irq 12, want irq 10
drivers/media/dvb/b2c2/skystar2.c: FlexCopII(rev.130) chip found
drivers/media/dvb/b2c2/skystar2.c: the chip has 6 hardware filters
DVB: registering new adapter (SkyStar2).
i2c_readbytes: i2c read error (addr 0a, err == -121)
DVB: registering frontend 0 (Zarlink VP310 DVB-S)...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: Enabling device 0000:00:07.1 (0000 -> 0001)
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci0000:00:07.1
VP_IDE: neither IDE port enabled (BIOS)
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
I2O subsystem v$Rev$
i2o: max drivers = 8
I2O Configuration OSM v$Rev$
I2O ProcFS OSM v$Rev$
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
PCI: Found IRQ 10 for device 0000:00:0a.0
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.0.1, my address is 192.168.0.3
IP-Config: Complete:
      device=eth0, addr=192.168.0.3, mask=255.255.255.0, gw=192.168.0.100,
     host=192.168.0.3, domain=lan, nis-domain=(none),
     bootserver=192.168.0.1, rootserver=192.168.0.1, rootpath=
Looking up port of RPC 100003/2 on 192.168.0.1
Looking up port of RPC 100005/1 on 192.168.0.1
VFS: Mounted root (nfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 136k freed
lirc_dev: IR Remote Control driver registered, at major 61
lirc_serial: auto-detected active high receiver
lirc_dev: lirc_register_plugin:sample_rate: 0
flexcop_i2c_func
flexcop_i2c_func
flexcop_i2c_func
PCI: Found IRQ 11 for device 0000:00:0b.0
em8300: EM8300 8300 (rev 1) bus: 0, devfn: 88, irq: 11, memory: 0xe4400000.
em8300: mapped-memory at 0xc8980000
em8300_main.o: Chip revision: 2
adv717x.o: ADV7175A chip detected
adv717x.o: Configuring for PAL 60
adv717x.o: Configuring for PAL
em8300_audio.o: Analog audio enabled
em8300: Microcode version 0x29 loaded

--
Prakash Punnoor

formerly known as Prakash K. Cheemplavam

--------------enigD382BFF11B3ECDABCE84601C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCQ+4qxU2n/+9+t5gRAqO6AKCCLa51GbeaKHfQNhy12ZGn1nECdACdFZ0A
5HjHF9TbNiP2PpKD0Inmny8=
=x/SR
-----END PGP SIGNATURE-----

--------------enigD382BFF11B3ECDABCE84601C--
