Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWCNIfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWCNIfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWCNIfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:35:36 -0500
Received: from hs-grafik.net ([80.237.205.72]:29453 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1751061AbWCNIff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:35:35 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc6-mm1 : Setting clocksource results in error
Date: Tue, 14 Mar 2006 09:35:26 +0100
User-Agent: KMail/1.9.1
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart42312931.tlXMkF0QxC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603140935.26927@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart42312931.tlXMkF0QxC
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm still fiddeling with my way to slow netbeans debugger. I just tried to=
=20
change the clocksource. That resulted in an error, but apparently worked. I=
s=20
that expected behaviour:
root@t40:/sys/devices/system/clocksource/clocksource0# l
insgesamt 0
=2Drw------- 1 root root 4,0K 2006-03-14 09:31 available_clocksource
=2Drw------- 1 root root    0 2006-03-14 09:31 current_clocksource
root@t40:/sys/devices/system/clocksource/clocksource0# cat=20
available_clocksource
acpi_pm jiffies tsc pit
root@t40:/sys/devices/system/clocksource/clocksource0# echo acpi_pm >=20
current_clocksource
=2Dsu: echo: write error: Das Argument ist ung=FCltig
root@t40:/sys/devices/system/clocksource/clocksource0# cat current_clocksou=
rce
acpi_pm
root@t40:/sys/devices/system/clocksource/clocksource0# echo tsc >=20
current_clocksource
=2Dsu: echo: write error: Das Argument ist ung=FCltig
root@t40:/sys/devices/system/clocksource/clocksource0# cat current_clocksou=
rce
tsc
Das Argument ist ung=FCltig =3D Argument is invalid.
dmesg says:
Time: acpi_pm clocksource has been installed.
Time: tsc clocksource has been installed.

regards
Alex
         =20
=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart42312931.tlXMkF0QxC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEFoBO/aHb+2190pERAuOXAJkBsO4G1npb87Ty8KflcAq1rjlAtgCghcJy
+F5FdCmsBW18MkdFWrc8sWA=
=VnTy
-----END PGP SIGNATURE-----

--nextPart42312931.tlXMkF0QxC--
