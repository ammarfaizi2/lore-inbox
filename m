Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272025AbRIIPsR>; Sun, 9 Sep 2001 11:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272028AbRIIPsI>; Sun, 9 Sep 2001 11:48:08 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:59521 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S272025AbRIIPrs>; Sun, 9 Sep 2001 11:47:48 -0400
Date: Sun, 9 Sep 2001 10:48:02 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: Stefan Hoffmeister <lkml.2001@econos.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
Message-ID: <20010909104802.A8339@draal.physics.wisc.edu>
In-Reply-To: <vd0npt0uvlo2kmicu14cs3culd8pck94eu@4ax.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <vd0npt0uvlo2kmicu14cs3culd8pck94eu@4ax.com>; from lkml.2001@econos.de on Sun, Sep 09, 2001 at 04:58:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

You have a dead hard drive.

One of mine does this because my girlfriend dropped the laptop.

You should see the same messages with kernel 2.2.

Stefan Hoffmeister [lkml.2001@econos.de] wrote:
>=20
> Hi,
>=20
> on an Omnibook 800CT (Pentium "Classic" 133, 48 MB) notebook with docking
> station, running on AC power, I notice sporadic kernel log entries of the
> form
>=20
>     hda: read_intr: status=3D0x59=20
>           { DriveReady SeekComplete DataRequest Error }
>     hda: read_intr: error=3D0x04=20
>           { DriveStatusError }
>=20
> These entries, AFAIR, have only appeared since I started experimenting
> with kernels 2.4.7.SuSE-1 and 2.2.19.SuSE-14 on that system - AFAIR, I
> never saw that with a 2.2.16 kernel. (I figure the diagnostics were only
> added post-2.2.16?)
>=20
> Below is a little "timeline" of how this has shown up - I'd almost be
> prepared to bet that the rexecd invocation triggered this. At the end of
> my message is the complete output of dmesg.
>=20
> >From staring a bit at the source code of drivers/ide/hd.c, it is not
> evident whether this message is something I should worry about or not?
> IBMs drive fitness test does not report any problems.
>=20
> I figure that lack of IDE DMA support combined with APM (with the disk
> running continuously and not sleeping) might be a problem?
>=20
> FWIW, the kernel option CONFIG_IDEDISK_MULTI_MODE is selected - but it
> seems to be meant to address a different set of issues ("set_multmode").
>=20
> TIA!
> Stefan
>=20
> **************
>=20
> Sep 10 10:25:03 xxxxx rpc.statd[572]: Version 0.3.1 Starting
> Sep 10 10:25:03 xxxxx kernel: svc: unknown version (3)
> Sep 10 10:30:00 xxxxx kernel: hda: read_intr: status=3D0x59 { DriveReady
> SeekComplete DataRequest Error }
> Sep 10 10:30:00 xxxxx kernel: hda: read_intr: error=3D0x04 {
> DriveStatusError }
> Sep 10 10:30:00 xxxxx kernel: hda: read_intr: status=3D0x59 { DriveReady
> SeekComplete DataRequest Error }
> Sep 10 10:30:00 xxxxx kernel: hda: read_intr: error=3D0x04 {
> DriveStatusError }
> Sep 10 10:30:01 xxxxx kernel: hda: read_intr: status=3D0x59 { DriveReady
> SeekComplete DataRequest Error }
> Sep 10 10:30:01 xxxxx kernel: hda: read_intr: error=3D0x04 {
> DriveStatusError }
> Sep 10 10:30:01 xxxxx kernel: hda: read_intr: status=3D0x59 { DriveReady
> SeekComplete DataRequest Error }
> Sep 10 10:30:01 xxxxx kernel: hda: read_intr: error=3D0x04 {
> DriveStatusError }
> Sep 10 10:30:01 xxxxx kernel: ide0: reset: success
> Sep 10 10:32:03 xxxxx in.rexecd[717]: connect from yyy.yyy.yyy.yyy
> (yyy.yyy.yyy.yyy)
> Sep 10 10:32:52 xxxxx in.rexecd[718]: connect from yyy.yyy.yyy.yyy
> (yyy.yyy.yyy.yyy)
> Sep 10 10:32:57 xxxxx in.rexecd[719]: connect from yyy.yyy.yyy.yyy
> (yyy.yyy.yyy.yyy)
>=20
> ***********************************************************
>=20
> Linux version 2.4.7 (me@xxxxx) (gcc version 2.95.3 20010315 (SuSE)) #2 Mon
> Sep 10 06:01:44 CEST 2001
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000003000000 (usable)
>  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
> On node 0 totalpages: 12288
> zone(0): 4096 pages.
> zone(1): 8192 pages.
> zone(2): 0 pages.
> Kernel command line: auto BOOT_IMAGE=3D247 ro root=3D303 BOOT_FILE=3D/boo=
t/bz247
> Initializing CPU#0
> Detected 131.729 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 262.14 BogoMIPS
> Memory: 46168k/49152k available (1003k kernel code, 2596k reserved, 363k
> data, 188k init, 0k highmem)
> Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
> Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
> CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor =3D 0
> Intel Pentium with F0 0F bug - workaround enabled.
> Intel old style machine check architecture supported.
> Intel old style machine check reporting enabled on CPU#0.
> CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
> CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
> CPU:             Common caps: 000001bf 00000000 00000000 00000000
> CPU: Intel Pentium 75 - 200 stepping 0c
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: none
> PCI: PCI BIOS revision 2.10 entry at 0xeef92, last bus=3D1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Using IRQ router VLSI 82C534 [1004/0102] at 00:01.0
>   got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1130
>   got res[10001000:10001fff] for resource 0 of Texas Instruments PCI1130
> (#2)
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
> Starting kswapd v1.8
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI ISAPNP enabled
> block: queued sectors max/low 30557kB/10185kB, 128 slots per queue
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=3Dxx
> hda: IBM-DARA-206000, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: 11733120 sectors (6007 MB) w/418KiB Cache, CHS=3D776/240/63
> Partition check:
>  hda: hda1 hda2 hda3
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a National Semiconductor PC87306
> eepro100.c:v1.09j-t 9/29/99 Donald Becker
> http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
> eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
> <saw@saw.sw.com.sg> and others
> PCI: Found IRQ 15 for device 01:06.0
> eth0: OEM i82557/i82558 10/100 Ethernet, 00:08:C7:99:D9:94, IRQ 15.
>   Receiver lock-up bug exists -- enabling work-around.
>   Board assembly 702536-006, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>   General self-test: passed.
>   Serial sub-system self-test: passed.
>   Internal registers self-test: passed.
>   ROM checksum self-test: passed (0x24c9f043).
>   Receiver lock-up workaround activated.
> Linux Kernel Card Services 3.1.22
>   options:  [pci] [cardbus] [pm]
> PCI: Assigned IRQ 5 for device 00:04.0
> PCI: Assigned IRQ 9 for device 00:04.1
> Intel PCIC probe: not found.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 4096 bind 4096)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Yenta IRQ list 0a98, PCI irq5
> Socket status: 30000010
> Yenta IRQ list 0898, PCI irq9
> Socket status: 30000006
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 188k freed
> Adding Swap: 309952k swap-space (priority -1)
> ip_conntrack (384 buckets, 3072 max)
> cs: IO port probe 0x0c00-0x0cff: clean.
> cs: IO port probe 0x0800-0x08ff: excluding 0x8e0-0x8e7
> cs: IO port probe 0x0100-0x04ff: clean.
> cs: IO port probe 0x0a00-0x0aff: clean.
> cs: memory probe 0xa0000000-0xa0ffffff: clean.
> eth1: 3Com 3c589, io 0x300, irq 3, hw_addr 00:60:97:8A:C8:EB
>   8K FIFO split 5:3 Rx:Tx, auto xcvr
> svc: unknown version (3)
> hda: read_intr: status=3D0x59 { DriveReady SeekComplete DataRequest Error=
 }
> hda: read_intr: error=3D0x04 { DriveStatusError }
> hda: read_intr: status=3D0x59 { DriveReady SeekComplete DataRequest Error=
 }
> hda: read_intr: error=3D0x04 { DriveStatusError }
> hda: read_intr: status=3D0x59 { DriveReady SeekComplete DataRequest Error=
 }
> hda: read_intr: error=3D0x04 { DriveStatusError }
> hda: read_intr: status=3D0x59 { DriveReady SeekComplete DataRequest Error=
 }
> hda: read_intr: error=3D0x04 { DriveStatusError }
> ide0: reset: success
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjubjzIACgkQjwioWRGe9K0tPACgskdiUxqwj0dcMaEgG6xE5rus
4mkAnizgpeOf8DMj5MBLlTYdp/QoDYdT
=27Tb
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
