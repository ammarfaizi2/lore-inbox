Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVJYXwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVJYXwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 19:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVJYXwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 19:52:22 -0400
Received: from mail03.solnet.ch ([212.101.4.137]:56778 "EHLO mail03.solnet.ch")
	by vger.kernel.org with ESMTP id S932488AbVJYXwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 19:52:21 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.14-rc5-mm1 - ide-cs, pcmcia ioctl
Date: Wed, 26 Oct 2005 01:49:20 +0200
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051024014838.0dd491bb.akpm@osdl.org>
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?iso-8859-1?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/?=
 =?iso-8859-1?q?iPOv8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B?=
 =?iso-8859-1?q?2=7Cl6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?iso-8859-1?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?iso-8859-1?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5121774.s8Wk7TYnXH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510260149.21376.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5121774.s8Wk7TYnXH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Monday 24 October 2005 10:48, Andrew Morton a =E9crit=A0:
 | - A number of tty drivers still won't compile.

after disabling jsm, i finally build once again a mm-kernel successfully!

booting the fresh kernel26mm, i ran into a problem with ide-cs:

info while booting / start of hotplug:
Oct 26 01:02:28 localhost kernel: [17179579.008000] Yenta: CardBus bridge f=
ound at 0000:02:00.1 [1014:0185]
Oct 26 01:02:28 localhost kernel: [17179579.160000] Yenta: ISA IRQ mask 0x0=
4b8, PCI irq 11
Oct 26 01:02:28 localhost kernel: [17179579.184000] Socket status: 30000006
Oct 26 01:02:28 localhost kernel: [17179579.208000] pcmcia: parent PCI brid=
ge I/O window: 0x4000 - 0x8fff
Oct 26 01:02:28 localhost kernel: [17179579.232000] cs: IO port probe 0x400=
0-0x8fff: clean.
Oct 26 01:02:28 localhost kernel: [17179579.256000] pcmcia: parent PCI brid=
ge Memory window: 0xd0200000 - 0xdfffffff
Oct 26 01:02:28 localhost kernel: [17179579.280000] pcmcia: parent PCI brid=
ge Memory window: 0xf0000000 - 0xf80fffff

when i plug in the pcmcia-compact-flash adapter into the laptop:
Oct 26 01:05:10 localhost kernel: [17179767.840000] cs: memory probe 0xf000=
0000-0xf80fffff: excluding 0xf0000000-0xf87fffff
Oct 26 01:05:11 localhost kernel: [17179767.924000] ide_cs: Unknown symbol =
cs_error
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_deregister_client
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_get_first_tuple
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_unregister_driver
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_get_tuple_data
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_get_next_tuple
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_register_client
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_get_configuration_info
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_request_io
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_request_configuration
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_release_configuration
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_parse_tuple
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_release_io
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_register_driver
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_release_irq
Oct 26 01:05:11 localhost kernel: [17179767.928000] ide_cs: Unknown symbol =
pcmcia_request_irq
Oct 26 01:05:11 localhost kernel: [17179768.176000] Probing IDE interface i=
de2...
Oct 26 01:05:11 localhost kernel: [17179768.464000] hde: 1024MB Flash Card,=
 CFA DISK drive
Oct 26 01:05:12 localhost kernel: [17179769.136000] ide2 at 0x4100-0x4107,0=
x410e on irq 3
Oct 26 01:05:12 localhost kernel: [17179769.136000] hde: max request size: =
128KiB
Oct 26 01:05:12 localhost kernel: [17179769.136000] hde: 2001888 sectors (1=
024 MB) w/1KiB Cache, CHS=3D1986/16/63
Oct 26 01:05:12 localhost kernel: [17179769.136000] hde: cache flushes not =
supported
Oct 26 01:05:12 localhost kernel: [17179769.140000]  hde: hde1
Oct 26 01:05:12 localhost kernel: [17179769.148000] ide-cs: hde: Vcc =3D 3.=
3, Vpp =3D 0.0
Oct 26 01:05:12 localhost kernel: [17179769.260000]  hde: hde1
Oct 26 01:05:12 localhost kernel: [17179769.292000]  hde: hde1
Oct 26 01:05:12 localhost kernel: [17179769.300000]  hde: hde1
Oct 26 01:05:12 localhost kernel: [17179769.440000]  hde: hde1
Oct 26 01:05:12 localhost kernel: [17179769.532000]  hde: hde1
Oct 26 01:05:12 localhost kernel: [17179769.720000]  hde: hde1
Oct 26 01:05:12 localhost kernel: [17179769.868000]  hde: hde1
Oct 26 01:05:13 localhost kernel: [17179770.016000]  hde: hde1
=2E..

and it repeats this untill i either power off the machine or take=20
out the pcmcia compact flash addapter (what results in a freeze=20
of everything (unfortunately no log output and no sysrq working=20
(probably because keyboard also not working)), so powering off is anyway=20
the only option)=20

as a semi-professional photographer, i depend on a working ide-cs device.=20
the last kernel it worked is some months old... until now i never=20
checked and now i discovered this break.=20

i use pcmciautils 010

if you need more information, i will try to help wherever i can to help to=
=20
make ide-cs work again.

greetings,
Damir

=2D-=20
If a man has talent and cannot use it, he has failed.
		-- Thomas Wolfe

--nextPart5121774.s8Wk7TYnXH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDXsSBPABWKV6NProRAokQAKCGRhRyAAWXSguWDtIpj8dFHf0XWQCgvUb3
L/qr7DQxYarVjxOoiF4Gkac=
=HOAY
-----END PGP SIGNATURE-----

--nextPart5121774.s8Wk7TYnXH--
