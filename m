Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUCBWjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbUCBWh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:37:58 -0500
Received: from grendel.firewall.com ([66.28.58.176]:747 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S262262AbUCBWg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:36:28 -0500
Date: Tue, 2 Mar 2004 23:36:16 +0100
From: Marek Habersack <grendel@caudium.net>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] with 2.4.25 - same on several machines
Message-ID: <20040302223616.GA1439@thanes.org>
Reply-To: grendel@caudium.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

  The machines are the same hardware (PIII, 512MB RAM, IDE, ext3 on /, xfs
on the other partitions, 512MB of swap). Four machines oopsed with the same
oopses:

Mar  1 17:47:24 colo19 kernel: Unable to handle kernel NULL pointer derefer=
ence at virtual address 00000008
Mar  1 17:47:24 colo19 kernel:  printing eip:
Mar  1 17:47:24 colo19 kernel: c01d0d6b
Mar  1 17:47:24 colo19 kernel: *pde =3D 00000000
Mar  1 17:47:24 colo19 kernel: Oops: 0000
Mar  1 17:47:24 colo19 kernel: CPU:    0
Mar  1 17:47:24 colo19 kernel: EIP:    0010:[fput+27/288]    Not tainted
Mar  1 17:47:24 colo19 kernel: EFLAGS: 00010292
Mar  1 17:47:24 colo19 kernel: eax: 57405660   ebx: 57405660   ecx: 00000079
edx: 57405660
Mar  1 17:47:24 colo19 kernel: esi: 00000000   edi: fffffff7   ebp: 00000000
esp: dc75ff7c
Mar  1 17:47:24 colo19 kernel: ds: 0018   es: 0018   ss: 0018
Mar  1 17:47:24 colo19 kernel: Process apache (pid: 2873, stackpage=3Ddc75f=
000)
Mar  1 17:47:24 colo19 kernel: Stack: 00000018 00000018 dc75e000 57405660 f=
ffffff7 000000b2 c01d0077 d9e6b0c0=20
Mar  1 17:47:24 colo19 kernel:        080ed9c4 00000296 00000000 c01b187b d=
c75ffb0 dc75e000 00000013 081dec1e=20
Mar  1 17:47:24 colo19 kernel:        bffffc18 c01a04d3 00000079 081deb6c 0=
00000b2 00000013 081dec1e bffffc18=20
Mar  1 17:47:24 colo19 kernel: Call Trace:    [sys_write+247/320] [sys_time=
+27/96] [system_call+51/64] [handle_signal+315/
336]
Mar  1 17:47:24 colo19 kernel:=20
Mar  1 17:47:24 colo19 kernel: Code: 8b 7d 08 ff 48 14 0f 94 c0 84 c0 75 18=
 8b 5c 24 08 8b 74 24=20

followed by

Mar  1 17:47:24 colo19 kernel:  <1>Unable to handle kernel paging request a=
t virtual address 000051b3
Mar  1 17:47:24 colo19 kernel:  printing eip:
Mar  1 17:47:24 colo19 kernel: c01cf497
Mar  1 17:47:24 colo19 kernel: *pde =3D 00000000
Mar  1 17:47:24 colo19 kernel: Oops: 0000
Mar  1 17:47:24 colo19 kernel: CPU:    0
Mar  1 17:47:24 colo19 kernel: EIP:    0010:[filp_close+23/128]    Not tain=
ted
Mar  1 17:47:24 colo19 kernel: EFLAGS: 00010286
Mar  1 17:47:24 colo19 kernel: eax: dd3bb000   ebx: 0000519f   ecx: 0000000=
0 edx: 0000519f
Mar  1 17:47:24 colo19 kernel: esi: dd3fc8a0   edi: dd3fc8a0   ebp: 0000000=
4 esp: dc75fe28
Mar  1 17:47:24 colo19 kernel: ds: 0018   es: 0018   ss: 0018
Mar  1 17:47:24 colo19 kernel: Process apache (pid: 2873, stackpage=3Ddc75f=
000)
Mar  1 17:47:24 colo19 kernel: Stack: dc859660 dd3fc8a0 000000ff 00000078 d=
d3fc8a0 c01b0284 0000519f dd3fc8a0=20
Mar  1 17:47:24 colo19 kernel:        c1706ee0 dc76a5a0 dc75e000 0000000b c=
01b0977 dd3fc8a0 0000000b dc75ff48=20
Mar  1 17:47:24 colo19 kernel:        dc76a5a0 c1706efc 00000008 c01a0bc3 0=
000000b c03d25e5 00000000 00000000=20
Mar  1 17:47:24 colo19 kernel: Call Trace:    [put_files_struct+100/208] [d=
o_exit+183/640] [die+115/128] [do_page_fault+861/1454] [do_page_fault+552/1=
454]
Mar  1 17:47:24 colo19 kernel:   [inet_sendmsg+66/80] [sock_sendmsg+116/176=
] [do_page_fault+0/1454] [error_code+52/64] [fput+27/288] [sys_write+247/32=
0]
Mar  1 17:47:24 colo19 kernel:   [sys_time+27/96] [system_call+51/64] [hand=
le_signal+315/336]
Mar  1 17:47:24 colo19 kernel:=20
Mar  1 17:47:24 colo19 kernel: Code: 8b 43 14 85 c0 74 52 8b 43 10 31 ff 85=
 c0 74 07 8b 50 24 85=20

The processes in all cases were different (a shell script, lsof, apache).
The kernels are patched with grsec2 and libsata, but it doesn't seem to be
relevant in this case. Could anybody shed some light on it? If necessary, I
will post the machine configs and all the information needed to diagnose.

tia,

marek

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARQxgq3909GIf5uoRAiHbAJ9KNmxOVyHOxG3jmJKDrCkvH/6qkwCfdaCG
6+awzcZaqA7jsLCF+/7Nugo=
=3Ew0
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
