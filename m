Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbSK3N5w>; Sat, 30 Nov 2002 08:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbSK3N5w>; Sat, 30 Nov 2002 08:57:52 -0500
Received: from 174-121-ADSL.red.retevision.es ([80.224.121.174]:23748 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S267248AbSK3N5q>; Sat, 30 Nov 2002 08:57:46 -0500
Date: Sat, 30 Nov 2002 15:05:09 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: Dmitri <dmitri@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Message-ID: <20021130140509.GB15565@jerry.marcet.dyndns.org>
References: <20021130064910.GD15426@jerry.marcet.dyndns.org> <1038640133.1590.69.camel@usb.networkfab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <1038640133.1590.69.camel@usb.networkfab.com>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.5.47-ac6 i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Dmitri <dmitri@users.sourceforge.net> [021130 08:11]:
=20
>> I have the problem without leaving it a few hours, but when I do it gets
>> definitely worse. Last vmstat output I quoted here showed around 256MB
>> swapped. A few hours later - the computer had been sitting idle, only
>> the mail server for three users was running which poses no overhead at
>> all -, the entire 512MB SWAP space was used. Why, I don't know.

>As I saw the thread today, I started looking at it myself, on RH's
> 2.4.18-18.8.0. By now I have:

> 1  0  0 432892  23828  44648 407208   0   0     0    24  780   879  95   =
5   0
>         =3D=3D=3D=3D=3D=3D

>However, top says:

>  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
> 1450 dmitri    15   0  546M 178M 16212 S     1.1 23.6  21:50 pan

>I close pan, and what a change!

> 3  0  0 432664  20720  44748 410260  88   0   392    20  710   925  95   =
4   1
> 1  0  0  46316 197172  44760 409684  40   0    40   160  782  1177  88  1=
2   0

>So you probably still have some process which is eating your memory. And
>once you find it, restart it:

>  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
> 3994 dmitri    15   0 15044  14M  6152 S     0.9  1.9   0:00 pan

This is not the problem in my case. It happens without any app getting
out of control in memory consumption, although with some kernel - don't
remember which one it was right now - X tend to show this, even killing
all the apps running. The only way to get back to normal memory usage
was re-starting the X server.


--=20
Javier Marcet <jmarcet@pobox.com>

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3oxZUACgkQx/ptJkB7frxbhgCcDWCK8r9mqe3WiO9UURKExNYD
Pa0AnREnq5yME90sVE3q7kLqZGuUVUoy
=ejk/
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
