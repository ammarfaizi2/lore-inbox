Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTDRLXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 07:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTDRLXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 07:23:20 -0400
Received: from c186012.adsl.hansenet.de ([213.39.186.12]:36680 "HELO
	schottelius.net") by vger.kernel.org with SMTP id S263024AbTDRLXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 07:23:19 -0400
Date: Thu, 17 Apr 2003 11:34:32 +0200
From: Nico Schottelius <schottelius@wdt.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: unloading bridge fails [2.5.67]
Message-ID: <20030417093432.GB266@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.5.67
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Using plain 2.5.67:

flapp:~ # brctl addbr br0
flapp:~ # brctl addif br0 eth0
flapp:~ # ifconfig br0 23.23.23.23 up
flapp:~ # brctl delif br0 eth0
flapp:~ # ifconfig br0 down

until here it works fine, but now

flapp:~ # brctl delbr br0

simply hangs.=20

flapp:~ # killall -9 brctl
does not kill it.
After some Minutes the keyboard stops working, only the mouse (ps2)
keeps on working. Later the screen gets shifted left or right.
SysRq like all other keyboard actions do not work.

flapp:~ # dmesg=20
[...]
device eth0 left promiscuous mode
unregister_netdevice: waiting for br0 to become free. Usage count =3D 2
unregister_netdevice: waiting for br0 to become free. Usage count =3D 2
unregister_netdevice: waiting for br0 to become free. Usage count =3D 2
unregister_netdevice: waiting for br0 to become free. Usage count =3D 2
unregister_netdevice: waiting for br0 to become free. Usage count =3D 2
[...repeated many times...]

This does not happen, when I don't activate the bridge (i don't issue
ifconfig br0 up).

Anyone know why ? HowTo solve ?

Nico

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+nnUntnlUggLJsX0RArLLAJ9HYYbxM5hop3Ag9YhOiDS+WkyGPQCfWiaR
1ekHceNys4ZwzIt2J5q374g=
=EpzH
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
