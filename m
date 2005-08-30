Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVH3MAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVH3MAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 08:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVH3MAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 08:00:12 -0400
Received: from www.nuit.ca ([66.11.160.83]:43465 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S1751391AbVH3MAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 08:00:11 -0400
Date: Tue, 30 Aug 2005 07:59:51 -0400
From: "SR, ESC" <simon@nuit.ca>
To: linux-kernel@vger.kernel.org
Subject: OOPS in 2.6.13: jfsCommit
Message-ID: <20050830115950.GA8764@pylon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
X-GPG-KeyServer: hkp://subkeys.pgp.net
X-Operating-System: Debian GNU/Linux
User-Agent: mutt-ng devel-r316 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hi,

i encountered an OOPS during boot here. dropped the machine into xmon
even. during boot, i got what's in the attached file
(kernel_bug_2.6.13_jfsCommit).

the machine is:

cat /proc/cpuinfo
processor       : 0
cpu             : 740/750
temperature     : 33-37 C (uncalibrated)
clock           : 195MHz
revision        : 2.2 (pvr 0008 0202)
bogomips        : 602.11
machine         : Power Macintosh
motherboard     : AAPL,9500 MacRISC
detected as     : 16 (PowerMac 9500/9600)
pmac flags      : 00000000
memory          : 512MB
pmac-generation : OldWorld


0000:00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (r=
ev 03)
0000:00:0e.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 0=
3)
0000:00:0f.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro=
 (rev dc)
0000:00:10.0 ff00: Apple Computer Inc. Grand Central I/O (rev 02)
0000:01:00.0 Memory controller: Adaptec AIC-7815 RAID+Memory Controller IC =
(rev 02)
0000:01:04.0 SCSI storage controller: Adaptec 78902
0001:02:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (r=
ev 03)
0001:02:0e.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev =
20)


PLEASE CC: ME, thanks.

--=20
 http://www.nuit.ca/ http://home.earthlink.net/~wodensharrow/hah.html   ,''=
`.   http://www.debian.org/
 http://simonraven.nuit.ca/ http://www.antiracistaction.ca/             : :=
' :  Debian GNU/Linux
 http://pentangle.nuit.ca/ezine/vol_x/x0305.html                        '
                                                                          `-

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="kernel_bug_2.6.13_jfsCommit"
Content-Transfer-Encoding: quoted-printable

kernel BUG in generic_delete_inode at fs/inode.c:1055!
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C008A6C4 LR: C008A6B8 SP: DFFD3F20 REGS: dffd3e70 TRAP: 0700    Not ta=
inted
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D c0bbe070[60] 'jfsCommit' THREAD: dffd2000
Last syscall: -1=20
GPR00: 00000010 DFFD3F20 C0BBE070 C0517438 00000003 00000001 DFFD3EF8 DF5DA=
200=20
GPR08: C0700000 C0517000 9E370001 C03FF43C 39AD3E35 DEADBEEF 003F0000 DEADB=
EEF=20
GPR16: 00000000 DEADBEEF DEADBEEF 007A94B8 007A94B8 C03B0000 C03B0000 C04D0=
000=20
GPR24: 00000010 00000000 00000001 DEA41C88 E1000EC4 CA12B360 C00FC520 CA12B=
360=20
NIP [c008a6c4] generic_delete_inode+0x114/0x1b0
LR [c008a6b8] generic_delete_inode+0x108/0x1b0
Call trace:
 [c0089998] iput+0x98/0xc0
 [c011ffc4] txUpdateMap+0x254/0x320
 [c01205b8] jfs_lazycommit+0x178/0x280
 [c0007224] kernel_thread+0x44/0x60

--opJtzjQTFsWo+cga--

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQGVAwUBQxRKNWqIeuJxHfCXAQLyfwv7Bm5cCkBXsr1xIhxOBfX/3mdDdk5QYCaP
aqPTng10YE1zqT2nQao+NkuNIy9+hjejNhp0lAesSLvpKW5Oqfn7uMaMNXpfNO/Z
qMaEmgYKw60nBFe4zV3cnWG0iMTmnd1SWeiMEbslLBv4TA4+q05NKY5/i6Y7i+t3
wjqUwFNeweH460Emk02rJ9AAhkltVVPzFo+Sy6UIKOHzOgnDbRxxz+ow62vF/rUZ
1SZOaz3i1R1TYuUU0yXE9qNJnMxapN6eiBkDH7vl3+/NpxfEKgImcIYq/3AanSNg
WU+6T9LoXq+Py78ibYdhx8bC6biajNbRAgt12Bj/B4HfWVuJxI2Q9FYEhd5aqbPt
4lz96Np3hkvcmUb/7D+4jJrSQnll5xQPwXKLRt6dyyL3emPX3N/mv21dmsopSDfR
S+XKmYl9TlRgnj5EzDfAWFH3ifCfIh+Ae/YZyqds6hgoouTYLrPSwGQw1qW3UtXz
L0sBZfe4AhA1kwNpHVSaQlzEGiCwGoi5
=gyWa
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
