Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbUKQVyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbUKQVyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbUKQVjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:39:44 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:10884 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S262623AbUKQVir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:38:47 -0500
Date: Wed, 17 Nov 2004 22:38:43 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Packet capturing, iptables and eth0 vs. dummy0
Message-ID: <20041117213843.GV31538@sunbeam.de.gnumonks.org>
References: <20041117203033.GA7907@DervishD>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="15k5Fuw+yLfT1d9X"
Content-Disposition: inline
In-Reply-To: <20041117203033.GA7907@DervishD>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: -4.7 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--15k5Fuw+yLfT1d9X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2004 at 09:30:33PM +0100, DervishD wrote:
>     Hi all :)

Hi!

please send netfilter/iptables related questions to the respective
lists:
	netfilter@lists.netfilter.org (for user questions)
	netfilter-devel@lists.netfilter.org (for development issues)

>     I've noticed that, no matter what filtering is iptables doing,
> tcpdump gets all packets from interface eth0 as seen in the bus,=20

This is correct.  iptables is a IPv4 packet filter.  It is part of the
IPv4 stack.  tcpdump uses PF_PACKET which attaches right above the
NIC driver, therefore you capture packets way before they enter the IPv4
stack.

>     Ra=FAl N=FA=F1ez de Arenas Coronado
--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--15k5Fuw+yLfT1d9X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBm8TjXaXGVTD0i/8RAgyNAJ0Xl5Ed/pc30H44m736yBO3DdP1FQCgtUT2
OUjZ7DKkGZhgSOYBk+PlJhk=
=2MNf
-----END PGP SIGNATURE-----

--15k5Fuw+yLfT1d9X--
