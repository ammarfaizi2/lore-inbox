Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVDHAdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVDHAdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVDHAdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:33:19 -0400
Received: from ns.schottelius.org ([213.146.113.242]:19731 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S262636AbVDHAdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:33:04 -0400
Date: Fri, 8 Apr 2005 02:35:09 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Florian Attenberger <valdyn@onlinehome.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PMTU, MSS and "fragmentation needed" problem with linux?
Message-ID: <20050408003509.GH5211@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Florian Attenberger <valdyn@onlinehome.de>,
	linux-kernel@vger.kernel.org
References: <20050407122217.GE5211@schottelius.org> <42556ED5.9080709@onlinehome.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline
In-Reply-To: <42556ED5.9080709@onlinehome.de>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for the hints Florian, but still there are open questions:

Florian Attenberger [Thu, Apr 07, 2005 at 07:33:09PM +0200]:
> [...]
> # [From the kernel help:
> #
> #    This option adds a `TCPMSS' target, which allows you to alter the
> #    MSS value of TCP SYN packets, to control the maximum size for that
> #    connection (usually limiting it to your outgoing interface's MTU
> #    minus 40).

The MTU is 1460 or 1492 in tested cases. This means on ppp0, TCPMSS
should be 1420 or maximum of 1452. Why do I see 1460 on the interface?

> #    This is used to overcome criminally braindead ISPs or servers which
> #    block ICMP Fragmentation Needed packets.=20

That's clear to me, there are sites out there, debatting that problem.
But:

- Should not _my_ Linux-router tell _my_ client that the mtu choosen
  is too big?
- On the tested connections _all_ icmp types were allowed (disabled iptable=
s)
- As far as I can see, the routers between the two hosts
  don't drop the generated icmp-packets

The first of the questions was the reason I choosed this ML, because I
was wondering why my client does not get the DF-Bit-set, but frag-needed
icmp-message from the linux-router.

Or did I unterstand the technique wrong?

Greetings,

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iQIVAwUBQlXRu7OTBMvCUbrlAQI+ew/5ARL6AhMQPRxt2Y1IT3vnAbUnnIGFbAgD
548N1Za2NrFMSWKP/HBnBmiKA8iZVSG1wX9gfftuJSc5EvRcMaZdqtSOl+PtbiJ4
w38AMoRxRSU99PBaEFi+uGroAUlC1IlhephObBfxfYJjtsNL4FmCyxKsEeQBvEsv
NKxKp2uGKuWkKTViFXTJkq62/erynL7vB8qRtodorga9peFAgue39vKpQ89iQhAC
YSdgaBR6dCF8K9QBwpKezl5+J6fmLuOLlXgRzWbPeo/A5uN0ZcxAm0xk4ehdl2rZ
dodwN4u0USQwTnaIgnadexR5gEf2XyA0zmIGk+bYJ0iTU/TENEGCJ4kxtkXeuDtv
gIIztibYLTpyPS4JvV55MCgOkzpX9e7atzQIXDjt4esLNKu92MYIR/eTpq4t8U3z
OuHDanllvxG+I5UFi3NiYzWGLITBDTEcrhkJEFxsyh7R3t+L+eR0GyG6IDqOxb77
5mXHnHdGcudj0Ainm+X/VN+GL9bYEscGu7WfBPCNrrdagXBqSiNABSLMy9lr1SXo
/A4FRYQBlGezOXvpDQK93450m/Z6shfEOu2tn4BTjDAEtQZbYYxrByFaOSy7xeR9
Lqndr26hJtG9ZHkZx7rN4CYNklIPHB1krPyuDQPgwQE06Vl8xTLE3TPcd5jTOc2Z
zMArtjXwm94=
=lO4p
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
