Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSHBTdV>; Fri, 2 Aug 2002 15:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSHBTdV>; Fri, 2 Aug 2002 15:33:21 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:526 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S316886AbSHBTdU>;
	Fri, 2 Aug 2002 15:33:20 -0400
Date: Fri, 2 Aug 2002 21:36:10 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 sparc ipv6 over ipv4 broken ?
Message-ID: <20020802193610.GB30824@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i am having trouble to get a ipv6 over ipv4 tunnel to work
on a linux/sparc with a vanilla 2.4.18 kernel - It seems
there is something broken. The same setup works on i386.=20

wise:~# ip -V  =20
ip utility, iproute2-ss010824
wise:~# ip tunnel add sit1 mode sit
ioctl: Invalid argument
wise:~# dmesg | grep IPv6
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver

strace gets to this point:
[...]
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) =3D 3
ioctl(3, 0x89f1, 0xeffffb98)            =3D -1 EINVAL (Invalid argument)
dup(2)                                  =3D 4
[...]

After trying around a bit this showed up:

sys32_ioctl(ip:379): Unknown cmd fd(3) cmd(000089f3) arg(effffb88)
sys32_ioctl(ip:382): Unknown cmd fd(3) cmd(000089f3) arg(effffb88)

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9St8qUaz2rXW+gJcRAoEPAJ9uAqDGIPViH15clz1a/OJzTgldUQCghDQv
XF2o1Mzqzwkf5R9oNheG+gY=
=RxPC
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
