Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWIJRI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWIJRI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWIJRI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:08:56 -0400
Received: from cable-static-233-101.eblcom.ch ([213.188.233.101]:64786 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932310AbWIJRIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:08:54 -0400
Date: Sun, 10 Sep 2006 19:08:37 +0200
From: Nico Schottelius <nico-kernel20060910@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17.13 Uninitialized variable / printf timing
Message-ID: <20060910170837.GA18697@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel20060910@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.17.6-hydrogenium
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

When booting 2.6.17.13 on my Geode, kprintf enabled with timing output,
it looks a bit strange (the first 24 lines):

---------------------------------------------------------------------------=
-----

  Booting 'Zwerg - 2.6.17.13'
               =20
root (hd0,1)   =20
 Filesystem type is jfs, partition type 0x83
kernel /usr/src/linux-2.6.17.13/arch/i386/boot/bzImage root=3D/dev/hda2
console=3Dt
tyS0,38400     =20
   [Linux-bzImage, setup=3D0x1400, size=3D0x10afff]
               =20
[42949372.960000] Linux version 2.6.17.13-zwerg (root@buche) (gcc
version 4.1.2 20060613 (prerelease) (Debian 4.1.1-5)) #1 Sun Sep 10
16:15:23 UTC 2006
[42949372.960000] BIOS-provided physical RAM map:
[42949372.960000]  BIOS-e820: 0000000000000000 - 000000000009fc00
(usable)
[42949372.960000]  BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
[42949372.960000]  BIOS-e820: 00000000000f0000 - 0000000000100000
(reserved)
[42949372.960000]  BIOS-e820: 0000000000100000 - 0000000008000000
(usable)
[42949372.960000]  BIOS-e820: 00000000fff0000 - 0000000100000000
(reserved)
[42949372.960000] 128MB LOWMEM available.
[42949372.960000] DMI not present or invalid.
[42949372.960000] ACPI: Unable to locate RSDP
[42949372.960000] Allocating PCI resources starting at 10000000 (gap:
08000000:f7f00000)
[42949372.960000] Built 1 zonelists
[42949372.960000] Kernel command line: root=3D/dev/hda2
console=3DttyS0,38400
[42949372.960000] No local APIC present or hardware disabled
[42949372.960000] Initializing CPU#0
[42949372.960000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[    0.000000] Detected 266.663 MHz processor.
[   20.718339] Using tsc for high-res timesource
[   20.718638] Console: colour dummy device 80x25
[   21.045363] Dentry cache hash table entries: 16384 (order: 4, 65536
bytes)
[   21.067257] Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)
[   21.129713] Memory: 127256k/131072k available 333k kernel code, 3420k
reserved, 498k data, 124k init, 0k highmem)
[   21.161087] Checking if this processor honours the WP bit even in
supervisor mode... Ok.
[   21.328007] Calibrating delay using timer specific routine.. 534.16
BogoMIPS (lpj=3D2670830)
[   21.353474] Mount-cache hash table entries: 512
[   21.368758] CPU: NSC Unknown stepping 01
[   21.380743] Checking 'hlt' instruction... OK.
[   21.394059] SMP alternatives: switching to UP code
[   21.408503] Freeing SMP alternatives: 0k freed
[...]
---------------------------------------------------------------------------=
-----

Just wanted to ask whether this is ...
   a) wanted
   b) not yet seen
   c) nothing one should care about

Nico

--=20
``...if there's one thing about Linux users, they're do-ers, not whiners.''
(A quotation of Andy Patrizio I completely agree with)

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUBRQRGlLOTBMvCUbrlAQLYfg/+Mq06bYizlUPZedAGagfdUbZ+dzhm5ReL
wPmlCZzRuj3rRe/feale/xzRzx4WZZI/7rC2+MIBnGqOommfXdcq8uj+hzBTEtc6
0baXe/y2PlZD4qPRDb9FsnxjIUTgj9d8kdyBVkcckdPjshvTZfZQXloBreJv3ASS
EcFkXqjF4ueaS3SqBGcjyF2cChNLSv+8MlMaHUVpORJnm2+eXDxcyT7Yzn2aYHDD
4frG18Je1XHd097uf/Oi25xAhuZ5EDESHWIBznJ8hpX1D5oF2m8vwq2M6Ob+lvlU
Q67Jsr/oP/IyUIGt30si/Q+ij/Cc5zRSvsQtZemuOQHkQxW92K5x7vbEOypgHxMs
XVi+j4++JIMYYwTSkmWLUGAANM2i2ySPF6cxE/tQcJX1DQwxRR0KkdSWa6QhGir2
6XmkPyWU2q7363Zch4DUa4Bbz4lIA3vuzyZL9DgBNWWA5kHlVcReY5yGh2kiAFaP
s2s6tlfRCPSiIHAmDd+rbdSJbmDoEMxbQD8F7IDtAxt8ZoAnlMHrbGF3X44HZR61
xaU3xD/AH4YLXzZ4CNAtFOt+blDTqTbsVQbFViU9hoq5oAvTHvZEb6iRsOOnktm6
yWGCUtt0Kbmiuex5GtqRmKzqI7MJaz95DTDfiujLn6Y/4PN9krdRVI5CGD2/cBwB
Sl59hwu5WHM=
=o4/d
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
