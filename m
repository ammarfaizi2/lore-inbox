Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTJUTkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTJUTkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:40:45 -0400
Received: from mout1.freenet.de ([194.97.50.132]:43228 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S263288AbTJUTkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:40:42 -0400
Date: Tue, 21 Oct 2003 21:41:43 +0200
From: Jens Kubieziel <linux-kernel@kubieziel.de>
To: linux-kernel@vger.kernel.org
Subject: [test8] Oops after trying to access USB-device /dev/sda
Message-ID: <20031021194143.GI1133@kubieziel.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
Organisation: Qbi's Welt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

after plugging in an USB stick and a 'mount /dev/sda1 /mnt/stick'
2.6.0-test8-kernel oopses.

My machine is a AMD Athlon 1 GHZ with a 2.6.0-test8-kernel compiled with
gcc 3.3.2. You can find the whole .config at
http://www.kubieziel.de/tmp/config.

I assume that this are the relevant lines from syslog (The whole usb-part
is available at http://www.kubieziel.de/tmp/syslog-errors):

Oct 21 21:09:35 QBI050102 kernel: sda: asking for cache data failed
Oct 21 21:09:35 QBI050102 kernel: sda: assuming drive cache: write
through
Oct 21 21:09:35 QBI050102 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000284
Oct 21 21:09:35 QBI050102 kernel: printing eip:
Oct 21 21:09:35 QBI050102 kernel: e08a0ded
Oct 21 21:09:35 QBI050102 kernel: *pde =3D 00000000
Oct 21 21:09:35 QBI050102 kernel: Oops: 0000 [#1]
Oct 21 21:09:35 QBI050102 kernel: CPU:    0
Oct 21 21:09:35 QBI050102 kernel: EIP:    0060:[<e08a0ded>]    Not
tainted
Oct 21 21:09:35 QBI050102 kernel: EFLAGS: 00010282
Oct 21 21:09:35 QBI050102 kernel: eax: e08b62e0   ebx: 00000000   ecx:
e08b62e4   edx: e08b62e0
Oct 21 21:09:35 QBI050102 kernel: esi: 00000000   edi: df8fbb00   ebp:
dffe178c   esp: df8db9f8
Oct 21 21:09:35 QBI050102 kernel: ds: 007b   es: 007b   ss: 0068
Oct 21 21:09:35 QBI050102 kernel: Process khubd (pid: 98,
threadinfo=3Ddf8da000 task=3Ddfb4cd40)
Oct 21 21:09:35 QBI050102 kernel: Stack: e08b62e0 df8da000 00000000
e089c402 00000000 ca1f9c00 df8da000 e089c3c0=20
Oct 21 21:09:35 QBI050102 kernel: dffe1740 e089ecc0 c0154a5c dffe178c
df8dbb28 00000001 df8dba5c c0118927=20
Oct 21 21:09:35 QBI050102 kernel: c151cc80 dffe174c df8dba64 00000000
dffe1740 00000001 df8dbb28 ca1f9c00=20
Oct 21 21:09:35 QBI050102 kernel: Call Trace: [<e089c402>]  [<e089c3c0>]
[<c0154a5c>]  [<c0118927>]  [<c0154b3d>]  [<c017c66f>]  [<c0208e9a>]
[<c0208e20>]  [<c0208e30>]  [<e089d7c5>]  [<c017d87a>]  [<c0201eaf>]
[<c0201f2f>]  [<c020212b>]  [<c0200e41>]  [<e08a86ed>]  [<e08a715d>]
[<e08a7354>]  [<e08a7bb1>]  [<e08a7caa>]  [<e08a7da1>]  [<e08a7e0f>]
[<e08ef20f>]  [<e08840e9>]  [<c0201eaf>]  [<c0201f2f>]  [<c020212b>]
[<c0200e41>]  [<e088ba08>]  [<e0885260>]  [<e0887906>]  [<e0887e0d>]
[<e0887efd>]  [<c0109272>]  [<c0119780>]  [<e0887ed0>]  [<c0107275>]=20
Oct 21 21:09:35 QBI050102 kernel: Code: 8b 83 84 02 00 00 a8 02 0f 85 97
00 00 00 8b 43 10 be 01 00=20

--=20
Jens Kubieziel                                   http://www.kubieziel.de
Gravity:
	What you get when you eat too much and too fast.

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lYv3Vm02LO4Jd+gRAjbfAKCzrEs18kt5OJPHje/hvJHOaks57QCgplhm
h1tZeuLVL7fPwRCfcHCIdT8=
=XCNE
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
